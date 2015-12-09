From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 154/182] hid: cp2112: use gpiochip data pointer
Date: Wed,  9 Dec 2015 14:44:18 +0100
Message-ID: <1449668658-5642-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:32992 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643AbbLINoX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Dec 2015 08:44:23 -0500
Received: by lfaz4 with SMTP id z4so34532111lfa.0
        for <linux-input@vger.kernel.org>; Wed, 09 Dec 2015 05:44:22 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Michael Welling <mwelling@ieee.org>, Markus Pargmann <mpa@pengutronix.de>, Jiri Kosina <jikos@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-input@vger.kernel.org

This makes the driver use the data pointer added to the gpio_chip
to store a pointer to the state container instead of relying on
container_of().

Cc: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Jiri: please ACK this so I can merge it in the GPIO tree.
---
 drivers/hid/hid-cp2112.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index f47954e8fd2c..0ccdd37e121a 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -24,7 +24,7 @@
  *   http://www.silabs.com/Support%20Documents/TechnicalDocs/AN495.pdf
  */
 
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/hid.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -169,8 +169,7 @@ MODULE_PARM_DESC(gpio_push_pull, "GPIO push-pull configuration bitmask");
 
 static int cp2112_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	struct cp2112_device *dev = container_of(chip, struct cp2112_device,
-						 gc);
+	struct cp2112_device *dev = gpiochip_get_data(chip);
 	struct hid_device *hdev = dev->hdev;
 	u8 buf[5];
 	int ret;
@@ -198,8 +197,7 @@ static int cp2112_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 
 static void cp2112_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
-	struct cp2112_device *dev = container_of(chip, struct cp2112_device,
-						 gc);
+	struct cp2112_device *dev = gpiochip_get_data(chip);
 	struct hid_device *hdev = dev->hdev;
 	u8 buf[3];
 	int ret;
@@ -216,8 +214,7 @@ static void cp2112_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 static int cp2112_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	struct cp2112_device *dev = container_of(chip, struct cp2112_device,
-						 gc);
+	struct cp2112_device *dev = gpiochip_get_data(chip);
 	struct hid_device *hdev = dev->hdev;
 	u8 buf[2];
 	int ret;
@@ -235,8 +232,7 @@ static int cp2112_gpio_get(struct gpio_chip *chip, unsigned offset)
 static int cp2112_gpio_direction_output(struct gpio_chip *chip,
 					unsigned offset, int value)
 {
-	struct cp2112_device *dev = container_of(chip, struct cp2112_device,
-						 gc);
+	struct cp2112_device *dev = gpiochip_get_data(chip);
 	struct hid_device *hdev = dev->hdev;
 	u8 buf[5];
 	int ret;
@@ -1106,7 +1102,7 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	dev->gc.can_sleep		= 1;
 	dev->gc.parent			= &hdev->dev;
 
-	ret = gpiochip_add(&dev->gc);
+	ret = gpiochip_add_data(&dev->gc, dev);
 	if (ret < 0) {
 		hid_err(hdev, "error registering gpio chip\n");
 		goto err_free_i2c;
-- 
2.4.3

