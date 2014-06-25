From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 01/13] leds: add led-class attribute-group support
Date: Wed, 25 Jun 2014 19:08:44 +0200
Message-ID: <1403716136-32694-2-git-send-email-johan@kernel.org>
References: <1403716136-32694-1-git-send-email-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403716136-32694-1-git-send-email-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, Janne Kanniainen <janne.kanniainen@gmail.com>, Jiri Kosina <jkosina@suse.cz>, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>, Johan Hovold <johan@kernel.org>
List-Id: linux-input@vger.kernel.org

Allow led-class devices to be created with optional attribute groups.

This is needed in order to allow led drivers to create custom device
attributes in a race-free manner.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/leds/led-class.c | 5 +++--
 include/linux/leds.h     | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index f37d63cf726b..aa29198fca3e 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -210,8 +210,9 @@ static const struct dev_pm_ops leds_class_dev_pm_ops = {
  */
 int led_classdev_register(struct device *parent, struct led_classdev *led_cdev)
 {
-	led_cdev->dev = device_create(leds_class, parent, 0, led_cdev,
-				      "%s", led_cdev->name);
+	led_cdev->dev = device_create_with_groups(leds_class, parent, 0,
+					led_cdev, led_cdev->groups,
+					"%s", led_cdev->name);
 	if (IS_ERR(led_cdev->dev))
 		return PTR_ERR(led_cdev->dev);
 
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 0287ab296689..e43686472197 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -63,6 +63,8 @@ struct led_classdev {
 				     unsigned long *delay_off);
 
 	struct device		*dev;
+	const struct attribute_group	**groups;
+
 	struct list_head	 node;			/* LED Device list */
 	const char		*default_trigger;	/* Trigger to use */
 
-- 
1.8.5.5
