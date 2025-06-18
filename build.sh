versao=$(git rev-parse HEAD | cut -c 1-7)
echo $versao
aws ecr get-login-password --region us-east-1 --profile bia | docker login --username AWS --password-stdin 794038226274.dkr.ecr.us-east-1.amazonaws.com
docker build -t bia .
docker tag bia:latest 794038226274.dkr.ecr.us-east-1.amazonaws.com/bia:$versao
docker push 794038226274.dkr.ecr.us-east-1.amazonaws.com/bia:latest$versao
rm .env 2> /dev/null
./gerar-compose.sh
rm bia-versao-*zip
zip -r bia-versao-$versao.zip docker-compose.yml
git checkout docker-compose.yml