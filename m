From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/6] Input: matrix_keypad - change name of wakeup property to "wakeup-source"
Date: Fri, 17 Jul 2015 17:36:16 -0700
Message-ID: <1437179781-21124-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1437179781-21124-1-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34060 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbbGRAg1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jul 2015 20:36:27 -0400
In-Reply-To: <1437179781-21124-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>

Wakeup property of device is not Linux-specific, it describes intended
system behavior regardless of the OS being used. Therefore let's drop
"linux," prefix, and, while at it, use the same name as I2C bus does:
"wakeup-source".

We keep parsing old name to keep compatibility with old DTSes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt | 2 +-
 drivers/input/keyboard/matrix_keypad.c                         | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
index ead641c..4d86059 100644
--- a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
+++ b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
@@ -19,7 +19,7 @@ Required Properties:
 
 Optional Properties:
 - linux,no-autorepeat:	do no enable autorepeat feature.
-- linux,wakeup:		use any event on keypad as wakeup event.
+- wakeup-source:	use any event on keypad as wakeup event.
 - debounce-delay-ms:	debounce interval in milliseconds
 - col-scan-delay-us:	delay, measured in microseconds, that is needed
 			before we can scan keypad after activating column gpio
diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index b370a59..7f12b65 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -425,8 +425,10 @@ matrix_keypad_parse_dt(struct device *dev)
 
 	if (of_get_property(np, "linux,no-autorepeat", NULL))
 		pdata->no_autorepeat = true;
-	if (of_get_property(np, "linux,wakeup", NULL))
-		pdata->wakeup = true;
+
+	pdata->wakeup = of_property_read_bool(np, "wakeup-source") ||
+			of_property_read_bool(np, "linux,wakeup"); /* legacy */
+
 	if (of_get_property(np, "gpio-activelow", NULL))
 		pdata->active_low = true;
 
-- 
2.4.3.573.g4eafbef

