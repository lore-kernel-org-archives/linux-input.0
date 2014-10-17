From: Clark Li <clark.li86@gmail.com>
Subject: [PATCH 1/1] input: Expose states of gpio keypad
Date: Fri, 17 Oct 2014 20:40:46 +1030
Message-ID: <1413540646-8455-2-git-send-email-clark.li86@gmail.com>
References: <1413540646-8455-1-git-send-email-clark.li86@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:44002 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbaJQKL2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Oct 2014 06:11:28 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so582468pad.1
        for <linux-input@vger.kernel.org>; Fri, 17 Oct 2014 03:11:27 -0700 (PDT)
In-Reply-To: <1413540646-8455-1-git-send-email-clark.li86@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: clark.li86@gmail.com

Allow user to poll the gpio keypad states in sysfs

Signed-off-by: Clark Li <clark.li86@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index b29ca65..d3a0536 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -3,6 +3,7 @@
  *
  * Copyright 2005 Phil Blundell
  * Copyright 2010, 2011 David Jander <david@protonic.nl>
+ * Copyright 2014 Clark Li <clark.li86@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -49,6 +50,12 @@ struct gpio_keys_drvdata {
 	struct gpio_button_data data[0];
 };
 
+/** What to display in sysfs attributes */
+enum gpio_attr_display {
+	gpio_attr_display_key,
+	gpio_attr_display_state
+};
+
 /*
  * SYSFS interface for enabling/disabling keys and switches:
  *
@@ -150,6 +157,7 @@ static void gpio_keys_enable_button(struct gpio_button_data *bdata)
  * @only_disabled: does caller want only those buttons that are
  *                 currently disabled or all buttons that can be
  *                 disabled
+ * @display: display the key or key state
  *
  * This function writes buttons that can be disabled to @buf. If
  * @only_disabled is true, then @buf contains only those buttons
@@ -158,12 +166,14 @@ static void gpio_keys_enable_button(struct gpio_button_data *bdata)
  */
 static ssize_t gpio_keys_attr_show_helper(struct gpio_keys_drvdata *ddata,
 					  char *buf, unsigned int type,
-					  bool only_disabled)
+					  bool only_disabled,
+					  enum gpio_attr_display display)
 {
 	int n_events = get_n_events_by_type(type);
 	unsigned long *bits;
 	ssize_t ret;
 	int i;
+	int state;
 
 	bits = kcalloc(BITS_TO_LONGS(n_events), sizeof(*bits), GFP_KERNEL);
 	if (!bits)
@@ -178,7 +188,15 @@ static ssize_t gpio_keys_attr_show_helper(struct gpio_keys_drvdata *ddata,
 		if (only_disabled && !bdata->disabled)
 			continue;
 
-		__set_bit(bdata->button->code, bits);
+		if (display == gpio_attr_display_key)
+			__set_bit(bdata->button->code, bits);
+		else if (display == gpio_attr_display_state) {
+			state = gpio_get_value_cansleep(bdata->button->gpio)
+				? 1 : 0;
+			state ^= bdata->button->active_low;
+			if (state)
+				__set_bit(bdata->button->code, bits);
+		}
 	}
 
 	ret = bitmap_scnlistprintf(buf, PAGE_SIZE - 2, bits, n_events);
@@ -251,7 +269,7 @@ out:
 	return error;
 }
 
-#define ATTR_SHOW_FN(name, type, only_disabled)				\
+#define ATTR_SHOW_FN(name, type, only_disabled, display)		\
 static ssize_t gpio_keys_show_##name(struct device *dev,		\
 				     struct device_attribute *attr,	\
 				     char *buf)				\
@@ -260,22 +278,25 @@ static ssize_t gpio_keys_show_##name(struct device *dev,		\
 	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);	\
 									\
 	return gpio_keys_attr_show_helper(ddata, buf,			\
-					  type, only_disabled);		\
+		type, only_disabled, display);				\
 }
 
-ATTR_SHOW_FN(keys, EV_KEY, false);
-ATTR_SHOW_FN(switches, EV_SW, false);
-ATTR_SHOW_FN(disabled_keys, EV_KEY, true);
-ATTR_SHOW_FN(disabled_switches, EV_SW, true);
+ATTR_SHOW_FN(keys, EV_KEY, false, gpio_attr_display_key);
+ATTR_SHOW_FN(switches, EV_SW, false, gpio_attr_display_key);
+ATTR_SHOW_FN(states, EV_KEY, false, gpio_attr_display_state);
+ATTR_SHOW_FN(disabled_keys, EV_KEY, true, gpio_attr_display_key);
+ATTR_SHOW_FN(disabled_switches, EV_SW, true, gpio_attr_display_key);
 
 /*
  * ATTRIBUTES:
  *
  * /sys/devices/platform/gpio-keys/keys [ro]
  * /sys/devices/platform/gpio-keys/switches [ro]
+ * /sys/devices/platform/gpio-keys/states [ro]
  */
 static DEVICE_ATTR(keys, S_IRUGO, gpio_keys_show_keys, NULL);
 static DEVICE_ATTR(switches, S_IRUGO, gpio_keys_show_switches, NULL);
+static DEVICE_ATTR(states, S_IRUGO, gpio_keys_show_states, NULL);
 
 #define ATTR_STORE_FN(name, type)					\
 static ssize_t gpio_keys_store_##name(struct device *dev,		\
@@ -313,6 +334,7 @@ static DEVICE_ATTR(disabled_switches, S_IWUSR | S_IRUGO,
 static struct attribute *gpio_keys_attrs[] = {
 	&dev_attr_keys.attr,
 	&dev_attr_switches.attr,
+	&dev_attr_states.attr,
 	&dev_attr_disabled_keys.attr,
 	&dev_attr_disabled_switches.attr,
 	NULL,
-- 
1.8.3.2

