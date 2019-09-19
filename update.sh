
export MALL_PROJECT_HOME=/Users/linyingjie/study/examples-from-internet/mall
cd $MALL_PROJECT_HOME
mvn clean compile package
scp $MALL_PROJECT_HOME/mall-admin/target/mall-admin-1.0-SNAPSHOT.jar root@mall:/var/server/docker-app/mall/mall-admin/docker-image/
scp $MALL_PROJECT_HOME/mall-portal/target/mall-portal-1.0-SNAPSHOT.jar  root@mall:/var/server/docker-app/mall/mall-portal/mall-port/
scp $MALL_PROJECT_HOME/mall-search/target/mall-search-1.0-SNAPSHOT.jar root@mall:/var/server/docker-app/mall/mall-search/docker-image/
pwd;
ls


ssh root@mall "/var/server/docker-app/mall/mall-admin/docker-image/create-image.sh;"
ssh root@mall "/var/server/docker-app/mall/mall-search/docker-image/create-image.sh"
ssh root@mall "/var/server/docker-app/mall/mall-portal/docker-image/create-image.sh"


ssh root@mall "/var/server/docker-app/mall/mall-admin/start-docker.sh;"
ssh root@mall "/var/server/docker-app/mall/mall-search/start-docker.sh;"
ssh root@mall "/var/server/docker-app/mall/mall-portal/start-docker.sh;"
pwd;
ls

