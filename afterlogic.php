<?php
include_once '/var/www/html/libraries/afterlogic/api.php';

if (CApi::IsValid())
{
  $settings = & CApi::GetSettings();
  if ($settings)
  {
    $settings->SetConf('Common/DBHost', 'mysql');
    $settings->SetConf('Common/DBName', 'afterlogic');
    $settings->SetConf('Common/DBLogin', 'root');
    $settings->SetConf('Common/DBPassword', 'my-secret-pw');

    CDbCreator::ClearStatic();
    CDbCreator::CreateConnector($settings);

    $oApiDbManager = CApi::Manager('db');
    $oApiDbManager->SyncTables();

    $settings->SaveToXml();
  }
}
