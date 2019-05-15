with import <nixpkgs> {}; {
     curlEnv = stdenv.mkDerivation {
       name = "curl-env";
       buildInputs = [ bash libtool autoconf automake stdenv pkgconfig perl groff nss nspr libssh2 libidn2 nghttp2 libpsl zlib gnutls stunnel openssh ];
       builder=./builder.sh;
     };
   }
