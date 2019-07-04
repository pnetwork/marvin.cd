# 替換 namespace
if [ $# -ne 0  ]; then
    sed -i "" "s/__NS_DEFAULT__/$1/g" *.yaml
else
    echo "Usage: \n\t$0 NAMESPACE\n";
    exit
fi
