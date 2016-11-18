echo "build nginx config"

GITLAB_IP=${GITLAB_IP:-172.18.0.6}
GITLAB_HOST=${GITLAB_HOST:-gitlab.wiznwit.com}

REDMINE_IP=${REDMINE_IP:-172.18.0.4}
REDMINE_HOST=${REDMINE_HOST:-redmine.wiznwit.com}

WORKDIR=${WORKDIR:-/home/nginx/conf}

SITES_DIR=$WORKDIR/conf/sites-enabled

mkdir -p $SITES_DIR

sed \
  -e "s/|SERVER_IP|/$GITLAB_IP/g" \
  -e "s/|SERVER_NAME|/$GITLAB_HOST/g" \
  $SITES_DIR/nginx > $SITES_DIR/gitlab

sed \
  -e "s/|SERVER_IP|/$REDMINE_IP/g" \
  -e "s/|SERVER_NAME|/$REDMINE_HOST/g" \
  $SITES_DIR/nginx > $SITES_DIR/redmine

rm $SITES_DIR/nginx

echo "config set up, starting nginx"

nginx
