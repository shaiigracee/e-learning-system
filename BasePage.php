<?php

require_once  __DIR__ . '/config.php';

class BasePage
{

    private $conn;
    private $settings;

    function __construct()
    {
        $this->conn = (new DBConnection())->conn;
        $this->settings = new SystemSettings();
    }

    function getConnection()
    {
        return $this->conn;
    }

    function getSettings()
    {
        return $this->settings;
    }
}
