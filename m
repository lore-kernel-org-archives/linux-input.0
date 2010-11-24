From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH WIP 2/6] fixup gpio_buttons: use existing gpio_keys_button structure instead of introducing new gpio_button structure
Date: Wed, 24 Nov 2010 16:01:36 -0500
Message-ID: <8cd1ece4cc014dd6d7ac6eb4bde393a96b376c8c.1290631852.git.bengardiner@nanometrics.ca>
References: <1290524800-21419-10-git-send-email-juhosg@openwrt.org> <cover.1290631852.git.bengardiner@nanometrics.ca>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:45160 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756333Ab0KXVBp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Nov 2010 16:01:45 -0500
Received: by mail-gw0-f52.google.com with SMTP id a18so117423gwa.11
        for <linux-input@vger.kernel.org>; Wed, 24 Nov 2010 13:01:45 -0800 (PST)
In-Reply-To: <cover.1290631852.git.bengardiner@nanometrics.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-input@vger.kernel.org


Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 drivers/input/misc/gpio_buttons.c |    6 +++---
 include/linux/gpio_buttons.h      |   11 ++---------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/input/misc/gpio_buttons.c b/drivers/input/misc/gpio_buttons.c
index f42906c..c34e978 100644
--- a/drivers/input/misc/gpio_buttons.c
+++ b/drivers/input/misc/gpio_buttons.c
@@ -42,7 +42,7 @@ struct gpio_buttons_dev {
 };
 
 static void gpio_buttons_check_state(struct input_dev *input,
-				      struct gpio_button *button,
+				      struct gpio_keys_button *button,
 				      struct gpio_button_data *bdata)
 {
 	int state;
@@ -71,7 +71,7 @@ static void gpio_buttons_poll(struct input_polled_dev *dev)
 	int i, threshold;
 
 	for (i = 0; i < bdev->pdata->nbuttons; i++) {
-		struct gpio_button *button = &pdata->buttons[i];
+		struct gpio_keys_button *button = &pdata->buttons[i];
 		struct gpio_button_data *bdata = &bdev->data[i];
 
 		threshold = round_up(button->debounce_interval,
@@ -132,7 +132,7 @@ static int __devinit gpio_buttons_probe(struct platform_device *pdev)
 	input->id.version = 0x0100;
 
 	for (i = 0; i < pdata->nbuttons; i++) {
-		struct gpio_button *button = &pdata->buttons[i];
+		struct gpio_keys_button *button = &pdata->buttons[i];
 		unsigned int gpio = button->gpio;
 		unsigned int type = button->type ?: EV_KEY;
 
diff --git a/include/linux/gpio_buttons.h b/include/linux/gpio_buttons.h
index c016f07..4d43de9 100644
--- a/include/linux/gpio_buttons.h
+++ b/include/linux/gpio_buttons.h
@@ -15,17 +15,10 @@
 #ifndef _GPIO_BUTTONS_H_
 #define _GPIO_BUTTONS_H_
 
-struct gpio_button {
-	int	gpio;		/* GPIO line number */
-	int	active_low;
-	char	*desc;		/* button description */
-	int	type;		/* input event type (EV_KEY, EV_SW) */
-	int	code;		/* input event code (KEY_*, SW_*) */
-	int debounce_interval;	/* debounce ticks interval in msecs */
-};
+#include <linux/gpio_keys.h>
 
 struct gpio_buttons_platform_data {
-	struct gpio_button *buttons;
+	struct gpio_keys_button *buttons;
 	int	nbuttons;		/* number of buttons */
 	int	poll_interval;		/* polling interval */
 };
-- 
1.7.0.4

