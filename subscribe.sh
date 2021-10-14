pod_name=$(kubectl get pods|awk 'END{print $1}')

domain=$(kubectl logs $pod_name -c tunnel|grep trycloudflare.com|awk 'END{print $4}'|awk -F/ '{print $3}')

ip=$(ibmcloud ks worker ls --cluster $IKS_CLUSTER|awk 'NR==3{print $2}')

sed -i "s/v2ray_ip/$ip/g" subscribe.py
sed -i "s/v2ray_host/$domain/g" subscribe.py

python2 subscribe.py > subscribe.txt
