// -----jenkins parameter start-----
// String Parameter or Git Parameter
def branchOrTagForRoot = env.branchOrTagForRoot
// String Parameter or Git Parameter
def repositoryUrlForRoot = env.repositoryUrlForRoot
// String Parameter or Git Parameter
def branchOrTagForService = env.branchOrTagForService
// String Parameter or Git Parameter
def repositoryUrlForService = env.repositoryUrlForService
// String Parameter or Git Parameter
def branchOrTagForClientAdmin = env.branchOrTagForClientAdmin
// String Parameter
def repositoryUrlForClientAdmin = env.repositoryUrlForClientAdmin
// String Parameter
def branchOrTagForClientApp = env.branchOrTagForClientApp
// String Parameter
def repositoryUrlForClientApp = env.repositoryUrlForClientApp
// String Parameter
def branchOrTagForClientMiniApp = env.branchOrTagForClientMiniApp
// String Parameter
def repositoryUrlForClientMiniApp = env.repositoryUrlForClientMiniApp
// String Parameter or Credential
def gitRepositoryCredentialsId = env.gitRepositoryCredentialsId
// String Parameter
def gradleFileId = env.gradleFileId
// String Parameter
def npmrcFileId = env.npmrcFileId
// String Parameter(http or https)
def nexusUrlProtocols = env.nexusUrlProtocols
// String Parameter
def nexusUrl = env.nexusUrl
// String Parameter(eg: tt-docker-docs)
def releaseNexusRepository = env.releaseNexusRepository
// String Parameter or Credential
def releaseNexusCredentialsId = env.releaseNexusCredentialsId
// Multi-line String Parameter
def buildManagerEmail = env.buildManagerEmail
// String Parameter(http or https)
def dockerRepositoryUrlProtocols = env.dockerRepositoryUrlProtocols
// String Parameter
def dockerRepositoryUrl = env.dockerRepositoryUrl
// String Parameter(eg: tt-docker-snapshot)
def dockerNexusRepository = env.dockerNexusRepository
// String Parameter or Credential
def dockerRepositoryCredentialsId = env.dockerRepositoryCredentialsId
// String parameter
def additionLabel = env.additionLabel
// String parameter
def dataFolderForDockerHost = env.dataFolderForDockerHost
// String parameter or Multi-line String Parameter
def additionEmailBody = env.additionEmailBody
// String parameter
def rootAppAdditionVersion = env.rootAppAdditionVersion
// String Parameter(Number)
def keepNumberOfDevComponentGroup = env.keepNumberOfDevComponentGroup
// String Parameter(Number)
def keepNumberOfReleaseComponentGroup = env.keepNumberOfReleaseComponentGroup
// -----jenkins parameter end-----
// -----config start-----
def domain = "com.github.lastsunday"
def productName = "moon"
def productModule = ''
def projectName = ''
// -----config end-----
def productAndProjectName = productName
if(projectName != ''){
	productAndProjectName = productAndProjectName + '-' + projectName
}
def artifactName = productName
if(productModule != ''){
	artifactName += '-' + productModule
}
if(projectName != ''){
	artifactName += '-' + projectName
}
def now = new Date()
def nowDateTimeString = now.format("yyyy-MM-dd HH:mm:ss")
def readyToDeleteComponentIdArray = null
keepNumberOfDevComponentGroup = Integer.parseInt(keepNumberOfDevComponentGroup)
keepNumberOfReleaseComponentGroup = Integer.parseInt(keepNumberOfReleaseComponentGroup)
def rootAppVersionCode = null
def rootAppVersionName = null
def releaseVersion = null
def releaseZipFile = null
def dockerName = domain+"/"+productName
if(productModule != ''){
	dockerName += "-"+productModule
}
if(projectName != ''){
	dockerName+='-'+projectName
}
def standaloneDockerName = dockerName + '-standalone'
def dockerVersion = null
def dockerTag = null
def dockerTagStandalone = null
def artifactCategory = 'release-docs'
def artifactGroupId = domain+'.'+productAndProjectName
def artifactSearchGroup = domain+'/'+productAndProjectName
if(productModule != ''){
	artifactGroupId += '.'+productModule
	artifactSearchGroup += '/'+productModule
}else{

}
artifactSearchGroup += '/' + artifactCategory
def artifactId = artifactCategory
def currentDirName = null
def clientMiniAppVersion = null
def emailSubject = null;
def emailBody = null;
pipeline {
	agent {
		label 'git && docker && nexusArtifactUploader' + additionLabel
	}
	options {
		parallelsAlwaysFailFast() 
	}
	tools{
		'org.jenkinsci.plugins.docker.commons.tools.DockerTool' 'docker'
	}
	stages{
		stage('fetch info from env'){
			steps {
				script{
					def workspace = pwd()
					currentDirName = workspace.replaceAll('/var/jenkins_home','')
				}
			}
		}
		stage('clean workspace') {
			steps {
				script{
					try{
						sh 'docker run --rm -v ' + dataFolderForDockerHost + currentDirName + ':/home alpine:3.13.0 /bin/ash -c \'cd /home; chmod 777 -R *; chmod 777 -R  service/.gradle; \''
					}catch(e){
						//skip
					}
				}
				cleanWs(
					disableDeferredWipeout: true,
					deleteDirs: true
				)
			}
		}
		stage('checkout'){
			parallel{
				stage('checkout root'){
					steps {
						checkout([$class: 'GitSCM', branches: [[name: branchOrTagForRoot]], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'root']], submoduleCfg: [], userRemoteConfigs: [[credentialsId: gitRepositoryCredentialsId, url: repositoryUrlForRoot]]])
					}
				}
				stage('checkout service'){
					steps {
						checkout([$class: 'GitSCM', branches: [[name: branchOrTagForService]], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'service']], submoduleCfg: [], userRemoteConfigs: [[credentialsId: gitRepositoryCredentialsId, url: repositoryUrlForService]]])
					}
				}
				stage('checkout client admin'){
					steps {
						checkout([$class: 'GitSCM', branches: [[name: branchOrTagForClientAdmin]], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'client-admin']], submoduleCfg: [], userRemoteConfigs: [[credentialsId: gitRepositoryCredentialsId, url: repositoryUrlForClientAdmin]]])
					}
				}
				stage('checkout client app'){
					steps {
						checkout([$class: 'GitSCM', branches: [[name: branchOrTagForClientApp]], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'client-app']], submoduleCfg: [], userRemoteConfigs: [[credentialsId: gitRepositoryCredentialsId, url: repositoryUrlForClientApp]]])
					}
				}
				stage('checkout client mini app'){
					steps {
						checkout([$class: 'GitSCM', branches: [[name: branchOrTagForClientMiniApp]], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'client-mini-app']], submoduleCfg: [], userRemoteConfigs: [[credentialsId: gitRepositoryCredentialsId, url: repositoryUrlForClientMiniApp]]])		
					}
				}
			}
		}
		stage('fetch info from source code'){
			steps {
				script{
					def clientMiniAppPackageInfo = readJSON file:'client-mini-app/package.json' 
					clientMiniAppVersion = clientMiniAppPackageInfo.version
					def rootCommitCount = sh(script:'cd root && git rev-list HEAD --first-parent --count',returnStdout: true).trim()
					def rootBranchName = branchOrTagForRoot
					echo 'rootCommitCount='+rootCommitCount
					echo 'rootBranchName='+rootBranchName
					def serviceCommitCount = sh(script:'cd service && git rev-list HEAD --first-parent --count',returnStdout: true).trim()
					def serviceBranchName = branchOrTagForService
					echo 'serviceCommitCount='+serviceCommitCount
					echo 'serviceBranchName='+serviceBranchName
					def clientAdminCommitCount = sh(script:'cd client-admin && git rev-list HEAD --first-parent --count',returnStdout: true).trim()
					def clientAdminBranchName = branchOrTagForClientAdmin
					echo 'clientAdminCommitCount='+clientAdminCommitCount
					echo 'clientAdminBranchName='+clientAdminBranchName
					def clientAppCommitCount = sh(script:'cd client-app && git rev-list HEAD --first-parent --count',returnStdout: true).trim()
					def clientAppBranchName = branchOrTagForClientApp
					echo 'clientAppCommitCount='+clientAppCommitCount
					echo 'clientAppBranchName='+clientAppBranchName
					def clientMiniAppCommitCount = sh(script:'cd client-mini-app && git rev-list HEAD --first-parent --count',returnStdout: true).trim()
					def clientMiniAppBranchName = branchOrTagForClientMiniApp
					echo 'clientMiniAppCommitCount='+clientMiniAppCommitCount
					echo 'clientMiniAppBranchName='+clientMiniAppBranchName

					rootAppVersionCode = rootCommitCount.toInteger()+serviceCommitCount.toInteger()+clientAdminCommitCount.toInteger()+clientAppCommitCount.toInteger()+clientMiniAppCommitCount.toInteger()
					echo 'rootAppVersionCode='+rootAppVersionCode
					rootAppVersionName = ''
					if(rootBranchName.endsWith('dev')){
						rootAppVersionName = 'dev'+'-'+rootAppVersionCode
					}else{
						def rootBranchNameSplitArray = rootBranchName.split('-')
						def rootVersionString = rootBranchNameSplitArray[rootBranchNameSplitArray.length-1];
						rootAppVersionName = rootVersionString
					}
					rootAppVersionName +=rootAppAdditionVersion
					echo 'rootAppVersionName='+rootAppVersionName
					releaseVersion = rootAppVersionName
					releaseZipFile = releaseVersion+".zip"
					dockerTag = "${dockerRepositoryUrl}/${dockerName}:${releaseVersion}"
					dockerTagStandalone = "${dockerRepositoryUrl}/${dockerName}-standalone:${releaseVersion}"
					// set variable to down stream
					env.dockerTag = "${dockerName}:${releaseVersion}"
					env.dockerTagStandalone = "${dockerName}-standalone:${releaseVersion}"
				}
			}
		}
		stage('build service,client'){
			parallel{
				stage('build service'){
					steps {
						sh 'chmod 777 -R service'
						configFileProvider([configFile(fileId: gradleFileId, targetLocation: 'service/gradle.properties')]) {
							sh 'docker run --rm -v ' + dataFolderForDockerHost + currentDirName + ':/home/gradle/project -w /home/gradle/project/service gradle:6.8.0-jdk8 ./gradlew clean bootJar'
						}
					}
				}
				stage('build client admin'){
					steps {
						script{
							configFileProvider([configFile(fileId: npmrcFileId, targetLocation: 'client-admin/.npmrc')]) {
								sh "sed -i 's#\${APP_VERSION}#${releaseVersion}#g' client-admin/src/assets/app_info.js"
								sh "sed -i 's#\${APP_BUILD_DATE}#${nowDateTimeString}#g' client-admin/src/assets/app_info.js"
								sh "docker run --rm -v "+ dataFolderForDockerHost + currentDirName +"/client-admin:/var/task node:14.15.4-buster bash -c 'cd /var/task/; npm run bootstrap && npm run build'"
							}
						}
					}
				}
				stage('build client app'){
					steps {
						script{
							configFileProvider([configFile(fileId: npmrcFileId, targetLocation: 'client-app/.npmrc')]) {
								sh "docker run --rm -v "+ dataFolderForDockerHost + currentDirName +"/client-app:/var/task node:14.15.4-buster bash -c 'cd /var/task/; yarn && npm run build'"
							}
						}
					}
				}
				stage('build client mini app'){
					steps {
						script{
							configFileProvider([configFile(fileId: npmrcFileId, targetLocation: 'client-mini-app/.npmrc')]) {
								sh "docker run --rm -v "+ dataFolderForDockerHost + currentDirName +"/client-mini-app:/var/task node:14.15.4-buster bash -c 'cd /var/task/; yarn && npm run build:h5'"
								sh label: 'Inject App Config', script: 'sed -i \'s#//${APP_APP_CONFIG_INJECT}#Base_Url: \'"\'http://localhost:8080/moon/\'"\',#g\' client-mini-app/src/config/index.js'
								sh "docker run --rm -v "+ dataFolderForDockerHost + currentDirName +"/client-mini-app:/var/task node:14.15.4-buster bash -c 'cd /var/task/; yarn && npm run build:mp-weixin'"

							}
						}
					}
				}
			}
		}
		stage('copy to build folder'){
			steps {
				sh "mkdir build"
				sh "mkdir build/app"
				sh "mkdir build/app/admin"
				sh "mkdir build/app/app"
				sh "mkdir build/app/mini-app"
				sh "cp client-admin/CHANGELOG.md build/app/CHANGELOG-client-admin.md"
				sh "cp client-app/CHANGELOG.md build/app/CHANGELOG-client-app.md"
				sh "cp client-mini-app/CHANGELOG.md build/app/CHANGELOG-client-mini-app.md"
				sh "cp service/CHANGELOG.md build/app/CHANGELOG-service.md"
				sh "cp -r client-admin/dist/* build/app/admin"
				sh "cp -r client-app/dist/* build/app/app"
				sh "cp -r client-mini-app/dist/build/h5/* build/app/mini-app"
				sh "cp service/core/build/libs/service-core.jar build/app"
				sh "cp root/scripts/docker/standard/Dockerfile build"
				sh "mkdir build-standalone"
				sh "cp -r build/* build-standalone"
			}
		}
		stage('package release'){
			steps {
				sh "sed -i 's#\${APP_VERSION}#${releaseVersion}#g' root/release/deploy/docker-compose.yml"
				sh "cp -r client-mini-app/dist/build/mp-weixin/* root/release/微信小程序/源码"
				sh "cp service/core/src/main/resources/application.properties root/release/deploy/conf"
				sh "cp client-admin/CHANGELOG.md root/release/CHANGELOG-client-admin.md"
				sh "cp client-app/CHANGELOG.md root/release/CHANGELOG-client-app.md"
				sh "cp client-mini-app/CHANGELOG.md root/release/CHANGELOG-client-mini-app.md"
				sh "cp service/CHANGELOG.md root/release/CHANGELOG-service.md"
				zip archive: true, dir: 'root/release', zipFile: releaseZipFile
			}
		}
		stage('build and upload docker image'){
			parallel{
				stage('build docker image and upload image'){
					steps {
						script {
							withDockerRegistry(credentialsId: dockerRepositoryCredentialsId, toolName: 'docker', url: "${dockerRepositoryUrlProtocols}://${dockerRepositoryUrl}") {
								def image = docker.build(dockerTag, "-f ./build/Dockerfile ./build/")
								image.push()
							}
					 	}
					}
				}
				stage('build docker standalone image and upload image'){
					steps {
						sh "cp root/scripts/docker/standalone/Dockerfile build-standalone"
						sh "cp root/scripts/docker/standalone/supervisord.conf build-standalone"
						script {
							withDockerRegistry(credentialsId: dockerRepositoryCredentialsId, toolName: 'docker', url: "${dockerRepositoryUrlProtocols}://${dockerRepositoryUrl}") {
								def image = docker.build(dockerTagStandalone, "-f ./build-standalone/Dockerfile ./build-standalone/")
								image.push()
							}
						}
					}
				}
			}
		}
		stage('upload release docs to nexus'){
			steps {
				script{
					nexusArtifactUploader artifacts: [[artifactId: artifactId, classifier: '', file: releaseZipFile, type: 'zip']], credentialsId: releaseNexusCredentialsId, groupId: artifactGroupId, nexusUrl: nexusUrl, nexusVersion: 'nexus3', protocol: nexusUrlProtocols, repository: releaseNexusRepository, version: releaseVersion	
					if(productModule != ''){
						releaseAddress = "${nexusUrlProtocols}://${nexusUrl}/repository/${releaseNexusRepository}/${domain}/${productAndProjectName}/${artifactCategory}/${productModule}/${releaseVersion}/${artifactId}-${releaseVersion}.zip"
					}else{
						releaseAddress = "${nexusUrlProtocols}://${nexusUrl}/repository/${releaseNexusRepository}/${domain}/${productAndProjectName}/${artifactCategory}/${releaseVersion}/${artifactId}-${releaseVersion}.zip"
					}
				}
			}
		}
		stage('clean history component'){
			parallel{
				stage('clean history docker image component'){
					steps {
						script{
							withCredentials([usernamePassword(credentialsId: releaseNexusCredentialsId, passwordVariable: 'password', usernameVariable: 'username')]) {
								def searchCriteria = null;
								def keepNumberComponent = null;
								if(rootAppVersionName.startsWith('dev')){
									searchCriteria = 'dev*'
									keepNumberComponent = keepNumberOfDevComponentGroup
								}else{
									searchCriteria = '*.*.*'
									keepNumberComponent = keepNumberOfReleaseComponentGroup
								}
								def response = sh(script: "curl -u $username:$password -X GET -G ${nexusUrlProtocols}://${nexusUrl}/service/rest/v1/search -d repository=${dockerNexusRepository} -d docker.imageName=${dockerName} -d version=${searchCriteria}", returnStdout: true)
								def json = readJSON text: response
								def groupMap = [:]
								for(def item : json['items']){
									groupMap.put(item['version'],null)
								}
								def groupList = []
								for(def item : groupMap.keySet()){
									groupList.add(item)
								}
								if(groupList.isEmpty()){
									//skip
								}else{
									if(keepNumberComponent < groupList.size()){
										groupList = groupList.sort()
										groupList = groupList.reverse()
										def readyToDeleteGroupList = []
										for(def i=keepNumberComponent;i<groupList.size();i++){
											readyToDeleteGroupList.add(groupList.get(i))
										}
										def readyToDeleteGroupMap = [:];
										for(def i=0;i<readyToDeleteGroupList.size();i++){
											readyToDeleteGroupMap.put(readyToDeleteGroupList.get(i).toString(),null)
										}
										readyToDeleteComponentIdArray = []
										for(def item : json['items']){
										if(readyToDeleteGroupMap.containsKey(item.version)){
											readyToDeleteComponentIdArray.add(item.id+'')
											echo 'readyToDeleteComponent = '+item.name+'/'+item.version
										}else{
											//skip
										}
										}
										if(readyToDeleteComponentIdArray.size() > 0){
											for(def id:readyToDeleteComponentIdArray){
												sh(script: 'curl -u $username:$password -X DELETE '+nexusUrlProtocols+'://'+nexusUrl+'/service/rest/v1/components/'+id, returnStdout: true)
											}
										}else{
											echo 'Unnecessary to clean docker image component'
										}
									}else{
										echo 'Unnecessary to clean docker image component'
									}
								}
							}
						}
					}
				}
				stage('clean history standalone docker image component'){
					steps {
						script{
							withCredentials([usernamePassword(credentialsId: releaseNexusCredentialsId, passwordVariable: 'password', usernameVariable: 'username')]) {
								def searchCriteria = null;
								def keepNumberComponent = null;
								if(rootAppVersionName.startsWith('dev')){
									searchCriteria = 'dev*'
									keepNumberComponent = keepNumberOfDevComponentGroup
								}else{
									searchCriteria = '*.*.*'
									keepNumberComponent = keepNumberOfReleaseComponentGroup
								}
								def response = sh(script: "curl -u $username:$password -X GET -G ${nexusUrlProtocols}://${nexusUrl}/service/rest/v1/search -d repository=${dockerNexusRepository} -d docker.imageName=${standaloneDockerName} -d version=${searchCriteria}", returnStdout: true)
								def json = readJSON text: response
								def groupMap = [:]
								for(def item : json['items']){
									groupMap.put(item['version'],null)
								}
								def groupList = []
								for(def item : groupMap.keySet()){
									groupList.add(item)
								}
								if(groupList.isEmpty()){
									//skip
								}else{
									if(keepNumberComponent < groupList.size()){
										groupList = groupList.sort()
										groupList = groupList.reverse()
										def readyToDeleteGroupList = []
										for(def i=keepNumberComponent;i<groupList.size();i++){
											readyToDeleteGroupList.add(groupList.get(i))
										}
										def readyToDeleteGroupMap = [:];
										for(def i=0;i<readyToDeleteGroupList.size();i++){
											readyToDeleteGroupMap.put(readyToDeleteGroupList.get(i).toString(),null)
										}
										readyToDeleteComponentIdArray = []
										for(def item : json['items']){
										if(readyToDeleteGroupMap.containsKey(item.version)){
											readyToDeleteComponentIdArray.add(item.id+'')
											echo 'readyToDeleteComponent = '+item.name+'/'+item.version
										}else{
											//skip
										}
										}
										if(readyToDeleteComponentIdArray.size() > 0){
											for(def id:readyToDeleteComponentIdArray){
												sh(script: 'curl -u $username:$password -X DELETE '+nexusUrlProtocols+'://'+nexusUrl+'/service/rest/v1/components/'+id, returnStdout: true)
											}
										}else{
											echo 'Unnecessary to clean docker image component'
										}
									}else{
										echo 'Unnecessary to clean docker image component'
									}
								}
							}
						}
					}
				}
				stage('clean history release docs component'){
					steps {
						script{
							withCredentials([usernamePassword(credentialsId: releaseNexusCredentialsId, passwordVariable: 'password', usernameVariable: 'username')]) {
								def searchCriteria = null;
								def keepNumberComponent = null;
								if(rootAppVersionName.startsWith('dev')){
									searchCriteria = 'dev*'
									keepNumberComponent = keepNumberOfDevComponentGroup
								}else{
									searchCriteria = '*.*.*'
									keepNumberComponent = keepNumberOfReleaseComponentGroup
								}
								def response = sh(script: "curl -u $username:$password -X GET -G ${nexusUrlProtocols}://${nexusUrl}/service/rest/v1/search -d repository=${releaseNexusRepository} -d group=/${artifactSearchGroup}/"+searchCriteria, returnStdout: true)
								def json = readJSON text: response
								def groupMap = [:]
								for(def item : json['items']){
									groupMap.put(item['group'],null)
								}
								def groupList = []
								for(def item : groupMap.keySet()){
									groupList.add(item)
								}
								if(groupList.isEmpty()){
									//skip
								}else{
									if(keepNumberComponent < groupList.size()){
										groupList = groupList.sort()
										groupList = groupList.reverse()
										def readyToDeleteGroupList = []
										for(def i=keepNumberComponent;i<groupList.size();i++){
											readyToDeleteGroupList.add(groupList.get(i))
										}
										def readyToDeleteGroupMap = [:];
										for(def i=0;i<readyToDeleteGroupList.size();i++){
											readyToDeleteGroupMap.put(readyToDeleteGroupList.get(i).toString(),null)
										}
										readyToDeleteComponentIdArray = []
										for(def item : json['items']){
										if(readyToDeleteGroupMap.containsKey(item.group)){
											readyToDeleteComponentIdArray.add(item.id+'')
											echo 'readyToDeleteComponent name = '+item.name
										}else{
											//skip
										}
										}
										if(readyToDeleteComponentIdArray.size() > 0){
											for(def id:readyToDeleteComponentIdArray){
												sh(script: 'curl -u $username:$password -X DELETE '+nexusUrlProtocols+'://'+nexusUrl+'/service/rest/v1/components/'+id, returnStdout: true)
											}
										}else{
											echo 'Unnecessary to clean release docs component'
										}
									}else{
										echo 'Unnecessary to clean release docs component'
									}
								}
							}
						}
					}
				}
			}
		}
		stage('gen email content'){
			steps {
				script{
					emailSubject = """Congratulations,gen ${dockerName}-${releaseVersion} success!"""
					emailBody = """
<html>
	<head></head>
	<body>
		<h2>Congratulations,gen ${dockerName}-${releaseVersion} success!</h2>
		<ul>
			<li>Docker image: <b>${dockerName}:${releaseVersion}</b></li>
			<li>Docker standalone image: <b>${dockerName}-standalone:${releaseVersion}</b></li>
			<li>Release docs: <a href="${releaseAddress}">${releaseAddress}</a></li>
		</ul>
		<h3>Build Info</h3>
		<ul>
			<li>Build Datetime: ${nowDateTimeString}</li>
			<li>Build Number: <a href="${BUILD_URL}">${env.BUILD_NUMBER}</a></li>
			<li>Node Name: ${NODE_NAME}</li>
		</ul>
	</body>
</html>
					"""
					emailBody+=additionEmailBody
				}
			}
		}
		stage('clean docker images'){
			steps {
				script {
					sh 'docker image rm '+dockerTag
					sh 'docker image rm '+dockerTagStandalone
				}
			}
		}
	}
	post { 
		success{
			script{
				script{
					try{
						sh 'docker run --rm -v ' + dataFolderForDockerHost + currentDirName + ':/home alpine:3.13.0 /bin/ash -c \'cd /home; chmod 777 -R *; chmod 777 -R  service/.gradle; \''
					}catch(e){
						//skip
					}
				}
				try{
					sh 'cd .. && rm -rf '+env.JOB_NAME+'/ '+env.JOB_NAME+'@script/'
				}catch(e){
					//skip
				}
				emailext attachLog: true, body: emailBody, compressLog: true, subject: emailSubject, to: buildManagerEmail,recipientProviders: [requestor(), developers()]
			}
		}
		unsuccessful{
			script{
				script{
					try{
						sh 'docker run --rm -v ' + dataFolderForDockerHost + currentDirName + ':/home alpine:3.13.0 /bin/ash -c \'cd /home; chmod 777 -R *; chmod 777 -R  service/.gradle; \''
					}catch(e){
						//skip
					}
				}
				try{
					sh 'cd .. && rm -rf '+env.JOB_NAME+'/ '+env.JOB_NAME+'@script/'
				}catch(e){
					//skip
				}
				emailSubject = """Warning,gen ${dockerName}-${releaseVersion} failure!"""
				emailBody = """
<html>
	<head>
		<style>
			.title{
				color:red;
			}
		</style>
	</head>
	<body>
		<h2 class="title">Warning,gen ${dockerName}-${releaseVersion} failure!</h2>
		<h3>Build Info</h3>
		<ul>
			<li>Build Datetime: ${nowDateTimeString}</li>
			<li>Build Number: <a href="${BUILD_URL}">${env.BUILD_NUMBER}</a></li>
			<li>Node Name: ${NODE_NAME}</li>
		</ul>
	</body>
</html>
					"""
				emailBody+=additionEmailBody
				emailext attachLog: true, body: emailBody, compressLog: true, subject: emailSubject, to: buildManagerEmail,recipientProviders: [requestor(), developers()]
			}
		}
	}
}
