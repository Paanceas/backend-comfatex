<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <title>Error!</title>
    <link
      href="https://fonts.googleapis.com/css?family=PT+Sans:400,700,400italic&subset=latin,cyrillic"
      rel="stylesheet"
      type="text/css"
    />
    <link
      href="/favicon.png"
      rel="shortcut icon"
      type="image/vnd.microsoft.icon"
    />
  </head>
  <body>
    <style>
      html,
      body {
        height: 100%;
      }

      body {
        background: #2f4256
          url("http://freelansim.ru/images/service_pattern.png") repeat 0 0;
        text-align: center;
        font-family: "PT Sans", Verdana, sans-serif;
        margin: 0;
        padding: 0;
        overflow: hidden;
        display: table;
        min-width: 100%;
      }

      .layout {
        width: 400px;
        margin: 0 auto;
        margin: 0;
        display: table-cell;
        vertical-align: middle;
        height: 100%;
      }

      .logo {
        background: url("http://freelansim.ru/images/logo.png");
        width: 70px;
        height: 70px;
        overflow: hidden;
        text-indent: -999px;
        margin: auto;
        display: block;
        position: absolute;
        top: 20px;
        left: 20px;
      }

      .icon_user_locked {
        background: url("http://freelansim.ru/user_locked.png");
        width: 374px;
        height: 115px;
        margin: 65px auto 60px;
      }

      .icon403 {
        background: url("http://freelansim.ru/403.png");
        width: 391px;
        height: 162px;
        margin: 65px auto 0px;
      }

      .icon500 {
        background: url("http://freelansim.ru/500.png");
        width: 395px;
        height: 162px;
        margin: 65px auto 0px;
      }

      .icon000 {
        background: url("http://freelansim.ru/000.png") no-repeat;
        width: 410px;
        height: 162px;
        margin: 65px auto 0px;
      }

      .text {
        font-size: 36px;
        color: #fff;
        font-weight: normal;
        margin: 0 auto;
        line-height: 1;
      }

      .title {
        font-size: 120px;
        color: #fff;
        font-weight: 700;
        margin: 0 auto 20px;
        line-height: 1;
        font-family: Arial, Verdana, sans-serif;
      }

      .icon_404:after,
      .icon_500:after {
        content: "";
        display: block;
        width: 202px;
        height: 202px;
        margin: 40px auto;
        background-repeat: no-repeat;
        background-position: 0 0;
      }

      .icon_404:after {
        background-image: url("http://freelansim.ru/images/404_icon.png");
        width: 200px
      }

      .icon_500:after {
        background-image: url("assets/img/logo.png");
      }

      .buttons {
        text-align: center;
        display: inline-block;
        margin: auto;
        position: relative;
        border-top: 3px solid #667c93;
        width: 100%;
        text-align: center;
        width: 400px;
      }

      .buttons_wrap {
        padding-top: 35px;
      }

      .text_buttons_intro {
        font-size: 20px;
        font-weight: normal;
        color: #748ca5;
        line-height: 1.5em;
        padding: 0;
        margin: 0;
        width: 100%;
        padding: 35px 0 0;
        text-align: center;
      }

      a.button {
        display: inline-block;
        font-size: 14px;
        font-weight: bold;
        color: #fff !important;
        background: #5bb3ee;
        -webkit-border-radius: 5px;
        -moz-border-radius: 5px;
        border-radius: 5px;
        height: 40px;
        line-height: 40px;
        padding: 0 15px;
        text-align: center;
        vertical-align: middle;
        cursor: pointer;
        margin-right: 10px;
        text-decoration: none;
      }

      .button + .button {
        margin-left: -4px;
      }

      .button:last-child {
        margin-right: 0;
      }

      .button_tasks:before,
      .button_fl:before,
      .button_services:before {
        content: "";
        display: inline-block;
        vertical-align: middle;
        width: 20px;
        height: 20px;
        margin-right: 5px;
      }

      .button_tasks:before {
        background: url("http://freelansim.ru/images/buttons_icons_404.png")
          no-repeat 0 0;
      }

      .button_fl:before {
        background: url("http://freelansim.ru/images/buttons_icons_404.png")
          no-repeat -31px 0;
      }

      .button_services:before {
        background: url("http://freelansim.ru/images/buttons_icons_404.png")
          no-repeat -60px 0;
      }

      a.button:hover {
        text-decoration: none;
      }

      .footer {
        color: #7e8186;
        font-size: 13px;
        margin: 45px auto 0;
      }
    </style>
    <div class="layout">
      <div class="title">SIEGVAD Comfatex Api Rest </div>
      <div class="text icon_500">Version 1.0.5</div>
      <div class="text icon_500">Ucompensar</div>
    </div>
  </body>
</html>
