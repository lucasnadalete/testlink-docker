<?php
    // Generated by Lucas Goncalves Nadalete
    $tlCfg->log_path = getenv("PATH_TESTLINK_LOG");
    $g_repositoryPath = getenv("PATH_TESTLINK_UPLOAD_AREA");

    $tlCfg->sessionInactivityTimeout = getenv("SESSION_INACTIVITY_TIMEOUT");    

    $tlCfg->config_check_warning_mode = getenv("CHECK_WARNING_MODE");

    $g_smtp_host = getenv("SMTP_HOST");
    $g_tl_admin_email = getenv("SMTP_USER");
    $g_from_email = getenv("SMTP_USER");
    $g_return_path_email = getenv("SMTP_USER");
    $g_smtp_username = getenv("SMTP_USER");
    $g_smtp_password = getenv("SMTP_PASSWORD");
    $g_smtp_port = getenv("SMTP_PORT");
    $g_smtp_connection_mode = getenv("SMTP_CONNECTION_MODE");

    $tlCfg->default_language = getenv("DEFAULT_LANGUAGE");
?>