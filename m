From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] Input: max8997_haptic - Fix module alias
Date: Wed, 26 Aug 2015 02:19:41 +0200
Message-ID: <1440548381-4148-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jingoo Han <jg1.han@samsung.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The driver is a platform driver and not a I2C driver so its modalias
should be exported with MODULE_DEVICE_TABLE(platform,...) instead of
MODULE_DEVICE_TABLE(i2c,...).

Also, remove the unnecessary MODULE_ALIAS("platform:max8997-haptic")
now that the correct module alias is created.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/input/misc/max8997_haptic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/max8997_haptic.c
index d0f687281339..a806ba3818f7 100644
--- a/drivers/input/misc/max8997_haptic.c
+++ b/drivers/input/misc/max8997_haptic.c
@@ -394,7 +394,7 @@ static const struct platform_device_id max8997_haptic_id[] = {
 	{ "max8997-haptic", 0 },
 	{ },
 };
-MODULE_DEVICE_TABLE(i2c, max8997_haptic_id);
+MODULE_DEVICE_TABLE(platform, max8997_haptic_id);
 
 static struct platform_driver max8997_haptic_driver = {
 	.driver	= {
@@ -407,7 +407,6 @@ static struct platform_driver max8997_haptic_driver = {
 };
 module_platform_driver(max8997_haptic_driver);
 
-MODULE_ALIAS("platform:max8997-haptic");
 MODULE_AUTHOR("Donggeun Kim <dg77.kim@samsung.com>");
 MODULE_DESCRIPTION("max8997_haptic driver");
 MODULE_LICENSE("GPL");
-- 
2.4.3
