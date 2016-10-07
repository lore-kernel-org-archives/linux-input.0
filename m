From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2 03/18] HID: wacom: Refactor button-to-key translation into function
Date: Fri,  7 Oct 2016 15:16:38 -0700
Message-ID: <20161007221653.26941-3-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
 <20161007221653.26941-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35566 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757021AbcJGWSB (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2016 18:18:01 -0400
Received: by mail-qk0-f195.google.com with SMTP id v138so2086839qka.2
        for <linux-input@vger.kernel.org>; Fri, 07 Oct 2016 15:17:08 -0700 (PDT)
In-Reply-To: <20161007221653.26941-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

This just centralizes the logic used in both wacom_setup_numbered_buttons
and wacom_report_numbered_buttons so that they don't drift out of sync.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_wac.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index e09830c..a9f6d11 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2779,17 +2779,29 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 	return 0;
 }
 
+static int wacom_numbered_button_to_key(int n)
+{
+	if (n < 10)
+		return BTN_0 + n;
+	else if (n < 16)
+		return BTN_A + (n-10);
+	else if (n < 18)
+		return BTN_BASE + (n-16);
+	else
+		return 0;
+}
+
 static void wacom_setup_numbered_buttons(struct input_dev *input_dev,
 				int button_count)
 {
 	int i;
 
-	for (i = 0; i < button_count && i < 10; i++)
-		__set_bit(BTN_0 + i, input_dev->keybit);
-	for (i = 10; i < button_count && i < 16; i++)
-		__set_bit(BTN_A + (i-10), input_dev->keybit);
-	for (i = 16; i < button_count && i < 18; i++)
-		__set_bit(BTN_BASE + (i-16), input_dev->keybit);
+	for (i = 0; i < button_count; i++) {
+		int key = wacom_numbered_button_to_key(i);
+
+		if (key)
+			__set_bit(key, input_dev->keybit);
+	}
 }
 
 static void wacom_24hd_update_leds(struct wacom *wacom, int mask, int group)
@@ -2891,12 +2903,12 @@ static void wacom_report_numbered_buttons(struct input_dev *input_dev,
 	for (i = 0; i < wacom->led.count; i++)
 		wacom_update_led(wacom,  button_count, mask, i);
 
-	for (i = 0; i < button_count && i < 10; i++)
-		input_report_key(input_dev, BTN_0 + i, mask & (1 << i));
-	for (i = 10; i < button_count && i < 16; i++)
-		input_report_key(input_dev, BTN_A + (i-10), mask & (1 << i));
-	for (i = 16; i < button_count && i < 18; i++)
-		input_report_key(input_dev, BTN_BASE + (i-16), mask & (1 << i));
+	for (i = 0; i < button_count; i++) {
+		int key = wacom_numbered_button_to_key(i);
+
+		if (key)
+			input_report_key(input_dev, key, mask & (1 << i));
+	}
 }
 
 int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
-- 
2.10.0

