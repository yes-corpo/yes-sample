alias yes-sample-build="docker compose up --build -d"
alias yes-sample-start="docker compose up -d"
alias yes-sample-stop="docker compose down --remove-orphans"
alias yes-sample-restart="yes-sample-stop && yes-sample-start"
alias yes-sample-restart-hard="yes-sample-stop && yes-sample-build"
alias yes-sample-terminal="docker exec -it --user=www-data web_yes_sample bash"
