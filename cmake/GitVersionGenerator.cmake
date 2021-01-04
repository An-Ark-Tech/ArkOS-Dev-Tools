# - Returns a version string from Git
#
# These functions force a re-configure on each git commit so that you can
# trust the values of the variables in your build system.
#
#  get_git_head_revision(<refspecvar> <hashvar> [<additional arguments to git describe> ...])
#
# Returns the refspec and sha hash of the current head revision
#
#  generate_version(<var> [<additional arguments to git describe> ...])
#
# Returns the results of git describe on the source tree, and adjusting
# the output so that it tests false if an error occurs.
#
# Requires CMake 2.6 or newer (uses the 'function' command)


if(__get_git_revision_description)
	return()
endif()
set(__get_git_revision_description YES)

# We must run the following at "include" time, not at function call time,
# to find the path to this module rather than the path to a calling list file
get_filename_component(_gitdescmoddir ${CMAKE_CURRENT_LIST_FILE} PATH)

function(get_git_head_revision _refspecvar _hashvar)
	set(GIT_PARENT_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
	set(GIT_DIR "${GIT_PARENT_DIR}/.git")
	while(NOT EXISTS "${GIT_DIR}")	# .git dir not found, search parent directories
		set(GIT_PREVIOUS_PARENT "${GIT_PARENT_DIR}")
		get_filename_component(GIT_PARENT_DIR ${GIT_PARENT_DIR} PATH)
		if(GIT_PARENT_DIR STREQUAL GIT_PREVIOUS_PARENT)
			# We have reached the root directory, we are not in git
			set(${_refspecvar} "GITDIR-NOTFOUND" PARENT_SCOPE)
			set(${_hashvar} "GITDIR-NOTFOUND" PARENT_SCOPE)
			return()
		endif()
		set(GIT_DIR "${GIT_PARENT_DIR}/.git")
	endwhile()
	# check if this is a submodule
	if(NOT IS_DIRECTORY ${GIT_DIR})
		file(READ ${GIT_DIR} submodule)
		string(REGEX REPLACE "gitdir: (.*)\n$" "\\1" GIT_DIR_RELATIVE ${submodule})
		get_filename_component(SUBMODULE_DIR ${GIT_DIR} PATH)
		get_filename_component(GIT_DIR ${SUBMODULE_DIR}/${GIT_DIR_RELATIVE} ABSOLUTE)
	endif()
	set(GIT_DATA "${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/git-data")
	if(NOT EXISTS "${GIT_DATA}")
		file(MAKE_DIRECTORY "${GIT_DATA}")
	endif()

	if(NOT EXISTS "${GIT_DIR}/HEAD")
		return()
	endif()
	set(HEAD_FILE "${GIT_DATA}/HEAD")
	configure_file("${GIT_DIR}/HEAD" "${HEAD_FILE}" COPYONLY)

	configure_file("${_gitdescmoddir}/GitVersionGenerator.cmake.in"
		"${GIT_DATA}/grabRef.cmake"
		@ONLY)
	include("${GIT_DATA}/grabRef.cmake")

	set(${_refspecvar} "${HEAD_REF}" PARENT_SCOPE)
	set(${_hashvar} "${HEAD_HASH}" PARENT_SCOPE)
endfunction()

function(generate_version _var)
	if(NOT GIT_FOUND)
		find_package(Git QUIET)
	endif()
	get_git_head_revision(refspec hash)
	if(NOT GIT_FOUND)
		set(${_var} "GIT-NOTFOUND" PARENT_SCOPE)
		return()
	endif()
	if(NOT hash)
		set(${_var} "HEAD-HASH-NOTFOUND" PARENT_SCOPE)
		return()
	endif()

	message(STATUS "Arguments to execute_process: ${ARGN}")

	execute_process(COMMAND
		"${GIT_EXECUTABLE}"
		describe

		${ARGN}
		WORKING_DIRECTORY
        "${CMAKE_CURRENT_SOURCE_DIR}"
		RESULT_VARIABLE
		res
		OUTPUT_VARIABLE
		out
		ERROR_QUIET
		OUTPUT_STRIP_TRAILING_WHITESPACE)

	if(NOT res EQUAL 0)
		set(out "${out}-${res}-NOTFOUND")
	endif()

    string(REPLACE "-" ";" out_list ${out})

    list(LENGTH out_list len)
    list(GET out_list 0 out_ver)
    string(REGEX MATCHALL "[0-9]+" ver_count ${out_ver})
    list(LENGTH ver_count out_ver_len)

    string(REPLACE "${out_ver}" "" output ${out})
    string(REGEX REPLACE "[A-Za-z]+" "" out_ver ${out_ver})

    if(${out_ver_len} EQUAL 0)
    	message(FATAL_ERROR "Tag-Version_format is not correct it must be M.M.P")
    elseif(${out_ver_len} EQUAL 1)
        set(out_ver ${out_ver}.0.0)
    elseif(${out_ver_len} EQUAL 2)
        set(out_ver ${out_ver}.0)
    endif()

    if(NOT output)
        set(output "-0")
    endif()

	set(${_var} "${out_ver}${output}" PARENT_SCOPE)
endfunction()
