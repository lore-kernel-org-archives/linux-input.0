From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 02/13] Input: misc - Drop calls to platform_set_drvdata and i2c_set_clientdata
Date: Sat, 21 Jan 2017 10:45:54 -0800
Message-ID: <1485024365-3368-3-git-send-email-linux@roeck-us.net>
References: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48803 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdAUSqq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 21 Jan 2017 13:46:46 -0500
In-Reply-To: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, usrp-users@lists.ettus.com

There is no call to i2c_get_clientdata(), platform_get_drvdata(),
or dev_get_drvdata() in any of the drivers in this patch.
Drop the unnecessary calls to to i2c_set_clientdata() and
platform_set_drvdata().

This conversion was done automatically with coccinelle.
The semantic patch is available at
https://github.com/groeck/coccinelle-patches/blob/master/common/pdev.cocci

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/misc/arizona-haptics.c   | 2 --
 drivers/input/misc/atmel_captouch.c    | 1 -
 drivers/input/misc/da9063_onkey.c      | 1 -
 drivers/input/misc/e3x0-button.c       | 1 -
 drivers/input/misc/twl4030-pwrbutton.c | 1 -
 5 files changed, 6 deletions(-)

diff --git a/drivers/input/misc/arizona-haptics.c b/drivers/input/misc/arizona-haptics.c
index 07ec465f1095..21dc1b8b2a4a 100644
--- a/drivers/input/misc/arizona-haptics.c
+++ b/drivers/input/misc/arizona-haptics.c
@@ -201,8 +201,6 @@ static int arizona_haptics_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, haptics);
-
 	return 0;
 }
 
diff --git a/drivers/input/misc/atmel_captouch.c b/drivers/input/misc/atmel_captouch.c
index 941265415a89..c4c0f4bb7627 100644
--- a/drivers/input/misc/atmel_captouch.c
+++ b/drivers/input/misc/atmel_captouch.c
@@ -191,7 +191,6 @@ static int atmel_captouch_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	capdev->client = client;
-	i2c_set_clientdata(client, capdev);
 
 	err = atmel_read(capdev, REG_KEY_STATE,
 			    &capdev->prev_btn, sizeof(capdev->prev_btn));
diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index b4ff1e86d3d3..3e9c353d82ef 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -287,7 +287,6 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	platform_set_drvdata(pdev, onkey);
 	return 0;
 }
 
diff --git a/drivers/input/misc/e3x0-button.c b/drivers/input/misc/e3x0-button.c
index 13bfca8a7b16..b0b374112db3 100644
--- a/drivers/input/misc/e3x0-button.c
+++ b/drivers/input/misc/e3x0-button.c
@@ -120,7 +120,6 @@ static int e3x0_button_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	platform_set_drvdata(pdev, input);
 	device_init_wakeup(&pdev->dev, 1);
 	return 0;
 }
diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index 603fc2fadf05..54162d2cbcfc 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -85,7 +85,6 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	platform_set_drvdata(pdev, pwr);
 	device_init_wakeup(&pdev->dev, true);
 
 	return 0;
-- 
2.7.4

