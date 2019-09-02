hunter_config(Qt VERSION "5.12.3"
    CMAKE_ARGS 
        ANDROID_STL=${ANDROID_STL}
        ANDROID_ABI=${ANDROID_ABI}
        ANDROID_PLATFORM=${ANDROID_PLATFORM}
        CMAKE_ANDROID_ARCH=${CMAKE_ANDROID_ARCH}
    )
    
hunter_config(bigint
    URL https://github.com/edwardbr/bigint/archive/master.tar.gz
    SHA1 7b7af0a373c42bc3a0537e7af673892af31bec12
    CMAKE_ARGS
        ANDROID_STL=${ANDROID_STL}
        ANDROID_ABI=${ANDROID_ABI}
        ANDROID_PLATFORM=${ANDROID_PLATFORM}
        CMAKE_ANDROID_ARCH=${CMAKE_ANDROID_ARCH}
        QT_CMAKE=${QT_CMAKE}
        )