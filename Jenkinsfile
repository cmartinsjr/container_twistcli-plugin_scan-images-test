node {
def app
def IMAGE = "martins6170/docker-lab:v1"
    stage('Clone repository') {
        checkout scm
    }

    stage('Scan image and publish to Jenkins') {
        try {
            prismaCloudScanImage ca: '', cert: '', dockerAddress: 'unix:///var/run/docker.sock', ignoreImageBuildTime: true, image: "${IMAGE}", key: '', logLevel: 'debug', podmanPath: '', project: '', resultsFile: 'prisma-cloud-scan-results.json'
        } finally {
            prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
        }
    }

    stage('Scan image with twistcli') {
        withCredentials([usernamePassword(credentialsId: 'twistlock_creds', passwordVariable: 'TL_PASS', usernameVariable: 'TL_USER')]) {
            sh "curl -k -u $TL_USER:$TL_PASS --output ./twistcli https://$TL_CONSOLE/api/v1/util/twistcli"
            sh "sudo chmod a+x ./twistcli"
            sh "./twistcli --debug images scan --u $TL_USER --p $TL_PASS --address https://$TL_CONSOLE  --details ${IMAGE}"
        }
    }
}