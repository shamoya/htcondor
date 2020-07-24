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
#include "condor_crypt_blowfish.h"
#include "condor_debug.h"

#ifdef HAVE_EXT_OPENSSL

bool Condor_Crypt_Blowfish :: encrypt(Condor_Crypto_State *cs,
                                      const unsigned char *  input,
                                      int              input_len, 
                                      unsigned char *& output, 
                                      int&             output_len)
{
#if !defined(SKIP_AUTHENTICATION)
    output_len = input_len;

    output = (unsigned char *) malloc(output_len);

    if (output) {
        // Now, encrypt
        BF_cfb64_encrypt(input, output, output_len, (BF_KEY*)cs->method_key_data, cs->ivec, &cs->num, BF_ENCRYPT);
        return true;
    }
    else {
        return false;
    }
#else
	return true;
#endif
}

bool Condor_Crypt_Blowfish :: decrypt(Condor_Crypto_State *cs,
                                      const unsigned char *  input,
                                      int              input_len, 
                                      unsigned char *& output, 
                                      int&             output_len)
{
#if !defined(SKIP_AUTHENTICATION)
    output_len = input_len;

    output = (unsigned char *) malloc(output_len);

    if (output) {
        // Now, encrypt
        BF_cfb64_encrypt(input, output, output_len, (BF_KEY*)cs->method_key_data, cs->ivec, &cs->num, BF_DECRYPT);
        return true;
    }
    else {
        return false;
    }
#else
	return true;
#endif
}

#endif /*HAVE_EXT_OPENSSL*/
