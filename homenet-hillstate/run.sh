repo_path=/repos/yogyui/HomeNetwork

echo "try to update repository"
git pull

source ${repo_path}/Hillstate-Gwanggyosan/activate.sh
python3 ${repo_path}/Hillstate-Gwanggyosan/app.py