l=`kubectl get po -o yaml -n workflow-preview-openfaas-fn | grep image | grep pentium | sort | uniq | grep -v imageID | cut -f2,3 -d ':'`

cat <<EOF > kustomization.yaml
kind: Kustomization

namespace: workflow-preview-openfaas-fn

bases:
  - https://github.com/pnetwork/pnbase//openfaas/?ref=master

secretGenerator:
- name: pn-faas-secret
  behavior: replace
  files:
  - config.json
  type: Opaque

# openfaas
images:
EOF

for i in $l
do
  newName="${i%:*}"
  tag="${i##*:}"
  name="${newName##*\/}"

  cat <<EOF >> kustomization.yaml
- name: __IMAGE/$name
  newName: $newName
  newTag: $tag
EOF
done

