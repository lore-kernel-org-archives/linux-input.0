From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 08/13] leds: ns2: fix attribute-creation race
Date: Wed, 25 Jun 2014 19:08:51 +0200
Message-ID: <1403716136-32694-9-git-send-email-johan@kernel.org>
References: <1403716136-32694-1-git-send-email-johan@kernel.org>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1403716136-32694-1-git-send-email-johan@kernel.org>
Sender: linux-leds-owner@vger.kernel.org
To: Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, Janne Kanniainen <janne.kanniainen@gmail.com>, Jiri Kosina <jkosina@suse.cz>, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>, Johan Hovold <johan@kernel.org>
List-Id: linux-input@vger.kernel.org

Use the attribute groups of the led-class to create the sata attribute
during probe in order to avoid racing with userspace.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/leds/leds-ns2.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/leds/leds-ns2.c b/drivers/leds/leds-ns2.c
index efa625883c83..231993d1fe21 100644
--- a/drivers/leds/leds-ns2.c
+++ b/drivers/leds/leds-ns2.c
@@ -185,6 +185,12 @@ static ssize_t ns2_led_sata_show(struct device *dev,
 
 static DEVICE_ATTR(sata, 0644, ns2_led_sata_show, ns2_led_sata_store);
 
+static struct attribute *ns2_led_attrs[] = {
+	&dev_attr_sata.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(ns2_led);
+
 static int
 create_ns2_led(struct platform_device *pdev, struct ns2_led_data *led_dat,
 	       const struct ns2_led *template)
@@ -219,6 +225,7 @@ create_ns2_led(struct platform_device *pdev, struct ns2_led_data *led_dat,
 	led_dat->cdev.blink_set = NULL;
 	led_dat->cdev.brightness_set = ns2_led_set;
 	led_dat->cdev.flags |= LED_CORE_SUSPENDRESUME;
+	led_dat->cdev.groups = ns2_led_groups;
 	led_dat->cmd = template->cmd;
 	led_dat->slow = template->slow;
 
@@ -235,20 +242,11 @@ create_ns2_led(struct platform_device *pdev, struct ns2_led_data *led_dat,
 	if (ret < 0)
 		return ret;
 
-	ret = device_create_file(led_dat->cdev.dev, &dev_attr_sata);
-	if (ret < 0)
-		goto err_free_cdev;
-
 	return 0;
-
-err_free_cdev:
-	led_classdev_unregister(&led_dat->cdev);
-	return ret;
 }
 
 static void delete_ns2_led(struct ns2_led_data *led_dat)
 {
-	device_remove_file(led_dat->cdev.dev, &dev_attr_sata);
 	led_classdev_unregister(&led_dat->cdev);
 }
 
-- 
1.8.5.5
