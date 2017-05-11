From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] input: cros_ec_keyb: remove extraneous 'const'
Date: Thu, 11 May 2017 13:48:04 +0200
Message-ID: <20170511114822.2951151-1-arnd@arndb.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:56999 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932405AbdEKLtN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 11 May 2017 07:49:13 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>, Enric Balletbo Serra <enric.balletbo@collabora.com>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Rajat Jain <rajatja@google.com>, Gwendal Grignou <gwendal@chromium.org>, Guenter Roeck <linux@roeck-us.net>, Vic Yang <victoryang@google.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

gcc-7 warns about 'const SIMPLE_DEV_PM_OPS', as that macro already constains
a 'const' keyword:

drivers/input/keyboard/cros_ec_keyb.c:663:14: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
 static const SIMPLE_DEV_PM_OPS(cros_ec_keyb_pm_ops, NULL, cros_ec_keyb_resume);

This removes the extra one.

Fixes: 6af6dc2d2aa6 ("input: Add ChromeOS EC keyboard driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/keyboard/cros_ec_keyb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index c7a8120b13c0..79eb29550c34 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -660,7 +660,7 @@ static const struct of_device_id cros_ec_keyb_of_match[] = {
 MODULE_DEVICE_TABLE(of, cros_ec_keyb_of_match);
 #endif
 
-static const SIMPLE_DEV_PM_OPS(cros_ec_keyb_pm_ops, NULL, cros_ec_keyb_resume);
+static SIMPLE_DEV_PM_OPS(cros_ec_keyb_pm_ops, NULL, cros_ec_keyb_resume);
 
 static struct platform_driver cros_ec_keyb_driver = {
 	.probe = cros_ec_keyb_probe,
-- 
2.9.0

