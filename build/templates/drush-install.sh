#!/bin/bash


if [ "${env.drush.php.path.enable}" == "1" ]; then
  export DRUSH_PHP="${env.drush.php.path}"
fi

DRUSH_BINARY="$2"

DRUPAL_ROOT="$1"
DRUPAL_ACC_NAME="${project.drupal.admin.name}"
DRUPAL_ACC_PASS="${project.drupal.admin.password}"
DRUPAL_ACC_MAIL="${project.drupal.admin.mail}"
DRUPAL_LOCALE="${project.drupal.locale}"
DRUPAL_CLEAN_URL="${project.drupal.clean_url}"
DRUPAL_SITE_NAME="${project.drupal.site.name}"
DRUPAL_SITE_MAIL="${project.drupal.site.mail}"
DRUPAL_SITES_SUBDIR="${drupal.site.subdir}"
DRUPAL_PROFILE="${project.drupal.profile}"
DRUPAL_ENVIRONMENT="${env.environment}"

${DRUSH_BINARY} status --root="${DRUPAL_ROOT}" > /dev/null 2>&1

if [ "$?" == "0" ]; then

	echo "site installed"

else

	echo "site not installed"
	${DRUSH_BINARY} --root="${DRUPAL_ROOT}" --account-name="${DRUPAL_ACC_NAME}" --account-pass="${DRUPAL_ACC_PASS}" --account-mail="${DRUPAL_ACC_MAIL}" --locale="${DRUPAL_LOCALE}" --clean-url="${DRUPAL_CLEAN_URL}" --site-name="${DRUPAL_SITE_NAME}" --site-mail="${DRUPAL_SITE_MAIL}" --sites-subdir="${DRUPAL_SITES_SUBDIR}" --yes site-install ${DRUPAL_PROFILE} install_configure_form.locale="${DRUPAL_LOCALE}"

fi
${DRUSH_BINARY} --root="${DRUPAL_ROOT}" --user="1" --yes cache-clear drush
${DRUSH_BINARY} --root="${DRUPAL_ROOT}" --user="1" --yes solution_install
${DRUSH_BINARY} --root="${DRUPAL_ROOT}" --user="1" --yes --force --strict=0 environment-switch ${DRUPAL_ENVIRONMENT}


