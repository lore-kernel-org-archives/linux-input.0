From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 04/13] leds: lm355x: fix attribute-creation race
Date: Wed, 25 Jun 2014 19:08:47 +0200
Message-ID: <1403716136-32694-5-git-send-email-johan@kernel.org>
References: <1403716136-32694-1-git-send-email-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403716136-32694-1-git-send-email-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, Janne Kanniainen <janne.kanniainen@gmail.com>, Jiri Kosina <jkosina@suse.cz>, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>, Johan Hovold <johan@kernel.org>
List-Id: linux-input@vger.kernel.org

Use the attribute groups of the led-class to create the indicator-LED
attributes during probe in order to avoid racing with userspace.

Note that the comment about the pattern attribute only being for LM3554
was incorrect and did not match the code (the original leds-lm3556
driver had the attribute before LM3554 support was added).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/leds/leds-lm355x.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/leds/leds-lm355x.c b/drivers/leds/leds-lm355x.c
index 591eb5e58ae3..f5112cb2d991 100644
--- a/drivers/leds/leds-lm355x.c
+++ b/drivers/leds/leds-lm355x.c
@@ -413,6 +413,12 @@ out:
 
 static DEVICE_ATTR(pattern, S_IWUSR, NULL, lm3556_indicator_pattern_store);
 
+static struct attribute *lm355x_indicator_attrs[] = {
+	&dev_attr_pattern.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(lm355x_indicator);
+
 static const struct regmap_config lm355x_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -501,25 +507,18 @@ static int lm355x_probe(struct i2c_client *client,
 	else
 		chip->cdev_indicator.max_brightness = 8;
 	chip->cdev_indicator.brightness_set = lm355x_indicator_brightness_set;
+	/* indicator pattern control only for LM3556 */
+	if (id->driver_data == CHIP_LM3556)
+		chip->cdev_indicator.groups = lm355x_indicator_groups;
 	err = led_classdev_register((struct device *)
 				    &client->dev, &chip->cdev_indicator);
 	if (err < 0)
 		goto err_create_indicator_file;
-	/* indicator pattern control only for LM3554 */
-	if (id->driver_data == CHIP_LM3556) {
-		err =
-		    device_create_file(chip->cdev_indicator.dev,
-				       &dev_attr_pattern);
-		if (err < 0)
-			goto err_create_pattern_file;
-	}
 
 	dev_info(&client->dev, "%s is initialized\n",
 		 lm355x_name[id->driver_data]);
 	return 0;
 
-err_create_pattern_file:
-	led_classdev_unregister(&chip->cdev_indicator);
 err_create_indicator_file:
 	led_classdev_unregister(&chip->cdev_torch);
 err_create_torch_file:
@@ -534,8 +533,6 @@ static int lm355x_remove(struct i2c_client *client)
 	struct lm355x_reg_data *preg = chip->regs;
 
 	regmap_write(chip->regmap, preg[REG_OPMODE].regno, 0);
-	if (chip->type == CHIP_LM3556)
-		device_remove_file(chip->cdev_indicator.dev, &dev_attr_pattern);
 	led_classdev_unregister(&chip->cdev_indicator);
 	flush_work(&chip->work_indicator);
 	led_classdev_unregister(&chip->cdev_torch);
-- 
1.8.5.5
