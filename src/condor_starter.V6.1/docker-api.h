#ifndef _CONDOR_DOCKER_API_H
#define _CONDOR_DOCKER_API_H

#include <string>
#include "condor_arglist.h"


class DockerAPI {
	public:

		/**
		 * Runs command in the Docker identified by imageID.  The container
		 * will be named name.  The command will run in the given
		 * environment with the given arguments.  If directory is non-empty,
		 * it will be mapped into the container and the command run there
		 * [TODO].
		 *
		 * If run() succeeds, the containerID will be set to the Docker GUID,
		 * and the pid set to a process which will terminate when the instance
		 * does.  The error will be unchanged.
		 *
		 * If run() fails, it will return a negative number [TODO: and set
		 * error to ....]
		 *
		 * @param name 			If empty, Docker will generate a random name.  [FIXME]
		 * @param imageID		For now, must be the GUID.
		 * @param command		...
		 * @param arguments		...
		 * @param environment	...
		 * @param directory		...
		 * @param containerID	On success, will be set to the container's GUID.  Otherwise, unchagned.
		 * @param pid			On success, will be set to the PID of a process which will terminate when the container does.  Otherwise, unchanged.
		 * @param childFDs		The redirected std[in|out|err] FDs.
		 * @param error			On success, unchanged.  Otherwise, [TODO].
		 * @return 				0 on success, negative otherwise.
		 */
		static int run(	const std::string & name,
						const std::string & imageID,
						const std::string & command,
						const ArgList & arguments,
						const Env & environment,
						const std::string & directory,
						std::string & containerID,
						int & pid,
						int * childFDs,
						CondorError & error );

		/**
		 * Releases the disk space (but not the image) associated with
		 * the given container.
		 *
		 * @param containerID	The Docker GUID.
		 * @param error			....
		 * @return				0 on success, negative otherwise.
		 */
		static int rm( const std::string & containerID, CondorError & err );

		/**
		 * Sends the given signal to the specified container's primary process.
		 *
		 * @param containerID	The Docker GUID.
		 * @param signal		The signal to send.
		 * @param error			....
		 * @return				0 on success, negative otherwise.
		 */
		static int kill( const std::string & containerID, int signal, CondorError & err );

		// Only available in Docker 1.1 or later.
		static int pause( const std::string & containerID, CondorError & err );

		// Only available in Docker 1.1 or later.
		static int unpause( const std::string & containerID, CondorError & err );

		/**
		 * Obtains the docker-inspect values State.Running and State.ExitCode.
		 *
		 * @param containerID	The Docker GUID.
		 * @param isRunning		On success, will be set to State.Running.  Otherwise, unchanged.
		 * @param exitCode		On success, will be set to State.ExitCode.  Otherwise, unchanged.
		 * @param error			....
		 * @return				0 on success, negative otherwise.
		 */
		static int getStatus( const std::string & containerID, bool isRunning, int & result, CondorError & err );

		/**
		 * Attempts to detect the presence of a working Docker installation.
		 *
		 * @param error			....
		 * @return				0 on success, negative otherwise.
		 */
		static int detect( CondorError & err );

		/**
		 * Obtains the configured DOCKER's version string.
		 *
		 * @param version		On success, will be set to the version string.  Otherwise, unchanged.
		 * @param error			....
		 * @return				0 on success, negative otherwise.
		 */
		static int version( std::string & version, CondorError & err );
};

#endif /* _CONDOR_DOCKER_API_H */
