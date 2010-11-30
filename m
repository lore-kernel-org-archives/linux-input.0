From: Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 5/8] input: gpio_keys_polled: precompute threshold value in the probe routine
Date: Tue, 30 Nov 2010 19:44:20 +0100
Message-ID: <1291142663-1011-6-git-send-email-juhosg@openwrt.org>
References: <4CF541ED.80905@openwrt.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:37530 "EHLO
	phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755490Ab0K3So2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 13:44:28 -0500
In-Reply-To: <4CF541ED.80905@openwrt.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ben Gardiner <bengardiner@nanometrics.ca>, linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Kevin Hilman <khilman@deeprootsystems.com>, nsekhar@ti.com

The threshold value will be a constant, so precompute that at probe time
to save a few cycles in the polling thread. Also introduce a new bdata
local variable in the probe routine to improve readability.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 drivers/input/keyboard/gpio_keys_polled.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index c9e0d1c..5af0be9 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -32,6 +32,7 @@
 struct gpio_keys_button_data {
 	int last_state;
 	int count;
+	int threshold;
 	int can_sleep;
 };
 
@@ -69,15 +70,13 @@ static void gpio_keys_polled_poll(struct input_polled_dev *dev)
 	struct gpio_keys_polled_dev *bdev = dev->private;
 	struct gpio_keys_platform_data *pdata = bdev->pdata;
 	struct input_dev *input = dev->input;
-	int i, threshold;
+	int i;
 
 	for (i = 0; i < bdev->pdata->nbuttons; i++) {
 		struct gpio_keys_button *button = &pdata->buttons[i];
 		struct gpio_keys_button_data *bdata = &bdev->data[i];
 
-		threshold = DIV_ROUND_UP(button->debounce_interval,
-					 pdata->poll_interval);
-		if (bdata->count < threshold)
+		if (bdata->count < bdata->threshold)
 			bdata->count++;
 		else
 			gpio_keys_polled_check_state(input, button, bdata);
@@ -151,6 +150,7 @@ static int __devinit gpio_keys_polled_probe(struct platform_device *pdev)
 
 	for (i = 0; i < pdata->nbuttons; i++) {
 		struct gpio_keys_button *button = &pdata->buttons[i];
+		struct gpio_keys_button_data *bdata = &bdev->data[i];
 		unsigned int gpio = button->gpio;
 		unsigned int type = button->type ?: EV_KEY;
 
@@ -176,8 +176,10 @@ static int __devinit gpio_keys_polled_probe(struct platform_device *pdev)
 			goto err_free_gpio;
 		}
 
-		bdev->data[i].can_sleep = gpio_cansleep(gpio);
-		bdev->data[i].last_state = -1;
+		bdata->can_sleep = gpio_cansleep(gpio);
+		bdata->last_state = -1;
+		bdata->threshold = DIV_ROUND_UP(button->debounce_interval,
+						pdata->poll_interval);
 
 		input_set_capability(input, type, button->code);
 	}
-- 
1.7.2.1

