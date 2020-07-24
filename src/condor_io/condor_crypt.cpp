/***************************************************************
 *
 * Copyright (C) 1990-2007, Condor Team, Computer Sciences Department,
 * University of Wisconsin-Madison, WI.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you
 * may not use this file except in compliance with the License.  You may
 * obtain a copy of the License at
 * 
 *    http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 ***************************************************************/


#include "condor_common.h"
#include "condor_crypt.h"
#include "condor_md.h"
#include "condor_random_num.h"
#ifdef HAVE_EXT_OPENSSL
#include <openssl/rand.h>              // SSLeay rand function
#endif
#include "condor_debug.h"


Condor_Crypto_State::Condor_Crypto_State(Protocol proto, KeyInfo &key) {

    // store key (includes: protocol, len, data, duration)
    keyInfo_ = key;

    // zero everything;
    additional_len = 0;
    additional = NULL;
    ivec_len = 0;
    ivec = NULL;
    method_key_data_len = 0;
    method_key_data = NULL;

    // there should probably be a static function in each crypto object to do
    // these conversions so that the state object doesn't need any specifc
    // method manipulation here.

#if !defined(SKIP_AUTHENTICATION)
    switch(proto) {
        case CONDOR_3DES: {
            // triple des requires a key of 8 x 3 = 24 bytes
            // so pad the key out to at least 24 bytes if needed
            unsigned char * keyData = keyInfo_.getPaddedKeyData(24);
            ASSERT(keyData);

            const int des_ks = sizeof(DES_key_schedule);
            method_key_data_len = 3*des_ks;
            method_key_data = (unsigned char*)malloc(method_key_data_len);
            DES_set_key((DES_cblock *)  keyData    , (DES_key_schedule*)(method_key_data));
            DES_set_key((DES_cblock *) (keyData+8) , (DES_key_schedule*)(method_key_data + des_ks));
            DES_set_key((DES_cblock *) (keyData+16), (DES_key_schedule*)(method_key_data + 2*des_ks));

            free(keyData);

            ivec_len = 8;
            ivec = (unsigned char*)malloc(ivec_len);
            break;
        }
        case CONDOR_BLOWFISH: {
            const int bf_ks = sizeof(BF_KEY);
            method_key_data_len = bf_ks;
            method_key_data = (unsigned char*)malloc(method_key_data_len);
            BF_set_key((BF_KEY*)method_key_data, keyInfo_.getKeyLength(), keyInfo_.getKeyData());

            ivec_len = 8;
            ivec = (unsigned char*)malloc(ivec_len);
            break;
        }
        default:
            dprintf(D_ALWAYS, "WARNING: Initialized crypto state for unknown proto %i.\n", proto);
            break;
    }
#endif
    // zero ivec and num
    reset();

}

Condor_Crypto_State::~Condor_Crypto_State() {
    if(ivec) free(ivec);
    if(additional) free(additional);
    if(method_key_data) free(method_key_data);
    // need to free key data
    dprintf(D_ALWAYS, "ZKM: FREE() CRYPTO DATA\n");
}

void Condor_Crypto_State::reset() {
    dprintf(D_ALWAYS, "ZKM: reset state (ivec and num)\n");

    if(ivec) {
	bzero(ivec, ivec_len);
    }
   
    num = 0;
}

int Condor_Crypt_Base :: encryptedSize(int inputLength, int blockSize)
{
#ifdef HAVE_EXT_OPENSSL
    int size = inputLength % blockSize;
    return (inputLength + ((size == 0) ? blockSize : (blockSize - size)));
#else
    return -1;
#endif
}

unsigned char * Condor_Crypt_Base :: randomKey(int length)
{
    unsigned char * key = (unsigned char *)(malloc(length));

	memset(key, 0, length);

#ifdef HAVE_EXT_OPENSSL
	static bool already_seeded = false;
    int size = 128;
    if( ! already_seeded ) {
        unsigned char * buf = (unsigned char *) malloc(size);
        ASSERT(buf);
		// Note that RAND_seed does not seed, but rather simply
		// adds entropy to the pool that is initialized with /dev/urandom
		// (actually, this could potentially help in the case where HTCondor
		// is running on a system without /dev/urandom; seems ... unlikely for
		// Linux!).
		//
		// As this only helps the pool, we are OK with calling the 'insecure'
		// variant here.
		for (int i = 0; i < size; i++) {
			buf[i] = get_random_int_insecure() & 0xFF;
		}

        RAND_seed(buf, size);
        free(buf);
		already_seeded = true;
    }

    RAND_bytes(key, length);
#else
    // use condor_util_lib/get_random.c
    int r, s, size = sizeof(r);
    unsigned char * tmp = key;
    for (s = 0; s < length; s+=size, tmp+=size) {
        r = get_random_int_insecure();
        memcpy(tmp, &r, size);
    }
    if (length > s) {
        r = get_random_int_insecure();
        memcpy(tmp, &r, length - s);
    }
#endif
    return key;
}

char *Condor_Crypt_Base::randomHexKey(int length)
{
	unsigned char *bytes = randomKey(length);
	char *hex = (char *)malloc(length*2+1);
	ASSERT( hex );
	int i;
	for(i=0; i<length; i++) {
		sprintf(hex+i*2,"%02x",bytes[i]);
	}
	free(bytes);
	return hex;
}

unsigned char * Condor_Crypt_Base :: oneWayHashKey(const char * initialKey)
{
#ifdef HAVE_EXT_OPENSSL
    return Condor_MD_MAC::computeOnce((const unsigned char *)initialKey, strlen(initialKey));
#else 
    return NULL;
#endif
}
