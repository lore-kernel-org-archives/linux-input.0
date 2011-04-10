From: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Subject: [PATCH] gpio_keys: Add support for EV_ABS
Date: Sun, 10 Apr 2011 17:03:11 +0200
Message-ID: <1302447791-9284-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from jack.hrz.tu-chemnitz.de ([134.109.132.46]:46399 "EHLO
	jack.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467Ab1DJPDL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Apr 2011 11:03:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>

With this patch you can setup a group of GPIOs representing a specific
position on an EV_ABS axis.

Signed-off-by: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
---
See also the discussion thread beginning at http://www.spinics.net/lists/linux-input/msg14324.html

 drivers/input/keyboard/gpio_keys.c |    7 ++++++-
 include/linux/gpio_keys.h          |    3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index eb30063..f319884 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -324,7 +324,12 @@ static void gpio_keys_report_event(struct gpio_button_data *bdata)
 	unsigned int type = button->type ?: EV_KEY;
 	int state = (gpio_get_value_cansleep(button->gpio) ? 1 : 0) ^ button->active_low;
 
-	input_event(input, type, button->code, !!state);
+	if (type == EV_ABS) {
+		if (state)
+			input_event(input, type, button->code, button->value);
+	} else {
+		input_event(input, type, button->code, !!state);
+	}
 	input_sync(input);
 }
 
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index dd1a56f..c09d7fb 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -7,7 +7,8 @@ struct gpio_keys_button {
 	int gpio;
 	int active_low;
 	char *desc;
-	int type;		/* input event type (EV_KEY, EV_SW) */
+	int type;		/* input event type (EV_KEY, EV_SW, EV_ABS) */
+	int value;		/* axis value for EV_ABS */
 	int wakeup;		/* configure the button as a wake-up source */
 	int debounce_interval;	/* debounce ticks interval in msecs */
 	bool can_disable;
-- 
1.7.4.1

