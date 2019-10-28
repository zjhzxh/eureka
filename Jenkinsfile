pipeline {
    agent any
    environment{
       def dockerPath = tool 'docker' //全局配置里的docker
       def JAVA_HOME = tool 'JAVA_HOME'
       def MAVEN_HOME = tool 'MAVEN_HOME'
       PATH = "${dockerPath}/bin:${env.PATH}:${JAVA_HOME}/bin:${MAVEN_HOME}/bin" //添加了系统环境变量上
       def DEPOSITORY_URL = 'registry.cn-hangzhou.aliyuncs.com'//镜像仓库域名
       def DEPOSITORY_HOST = 'springboot-cloud/eureka'//镜像仓库命名空间
       def DEPOSITORY_NAME= '769185835@qq.com'//镜像仓库登录名
       def DEPOSITORY_PWD = 'zj0797144oo'//远程镜像仓库密码
   }
    stages {
        stage('Checkout') {
             steps {
                echo 'Checkout'
                checkout([$class: 'GitSCM', branches: [[name: '$Tag']],
                 doGenerateSubmoduleConfigurations: false,
                 extensions: [],
                 submoduleCfg: [],
                 userRemoteConfigs: [[credentialsId: '326fac0a-284c-4133-ad11-a1ef882ec61d',
                 url: 'https://github.com/zjhzxh/eureka']]])
             }
        }
        stage('Build') {
            steps {
                echo 'Building'
                sh  'mvn clean package -Dmaven.test.skip=true'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying'
                sh '''
                  docker login --username=${DEPOSITORY_NAME} --password=${DEPOSITORY_PWD}  ${DEPOSITORY_URL}
                 docker build -t ${DEPOSITORY_URL}/${DEPOSITORY_HOST}:${Tag} .
                 docker push ${DEPOSITORY_URL}/${DEPOSITORY_HOST}:${Tag}
                 docker rmi ${DEPOSITORY_URL}/${DEPOSITORY_HOST}:${Tag}
                '''
                echo 'Deploying'
            }
        }
    }
}