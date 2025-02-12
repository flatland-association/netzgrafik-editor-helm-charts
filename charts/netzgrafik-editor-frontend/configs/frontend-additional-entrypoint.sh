#!/bin/sh

# N.B. As we use public SBB nge images and as configurations resolved at build time, at time we do this sed-workaround.
#      Improvement could be to call a dedicated endpoint on the own location to fetch the data and default to the value in the build configuration.
#      Let's keep it hard-coded for now.

# N.B. /usr/share/nginx/html/ owned by root and not nginx, sed -i fails see https://stackoverflow.com/questions/54460445/sed-permission-denied-on-temporary-file
cd /usr/share/nginx/html/
ls -al
FILE_NAME=`ls main.*.js`
echo "FILE_NAME=${FILE_NAME}"

cp ${FILE_NAME} /tmp/${FILE_NAME}
sed -i 's|backendUrl: "http://localhost:8080",|backendUrl: "BACKEND_URL",|g' /tmp/${FILE_NAME}

sed -i 's|issuer: "http://localhost:8081/realms/netzgrafikeditor",|issuer: "KEYCLOAK_URL",|g' /tmp/${FILE_NAME}

sed -i 's|production: false,|production: PRODUCTION,|g' /tmp/${FILE_NAME}

sed -i 's|label: "local",|label: "LABEL",|g' /tmp/${FILE_NAME}

cat /tmp/${FILE_NAME} > ${FILE_NAME}

cp index.html /tmp/index.html
HEADER=$(cat /docker-entrypoint.d/header.txt)
FOOTER=$(cat /docker-entrypoint.d/footer.txt)

cat index.html| tr '\n' '\f' | sed -e 's|\(.*\)<sbb-root>.*|\1|g' | tr '\f' '\n' > /tmp/index.html
cat /docker-entrypoint.d/header.txt >> /tmp/index.html
cat index.html| tr '\n' '\f' | sed -e 's|.*\(<sbb-root>.*\)</body>.*|\1|g' | tr '\f' '\n' >> /tmp/index.html
cat /docker-entrypoint.d/footer.txt >> /tmp/index.html
cat index.html| tr '\n' '\f' | sed -e 's|.*\(</body>.*\)|\1|g' | tr '\f' '\n' >> /tmp/index.html

sed -i 's|<body>|<body>'${HEADER}'|g' /tmp/index.html
sed -i 's|</body>|'${FOOTER}'</body>|g' /tmp/index.html
cat /tmp/index.html > index.html

