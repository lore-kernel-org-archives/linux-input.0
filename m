From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5/6] Input: samsung-keypad - change name of wakeup property
Date: Fri, 17 Jul 2015 17:36:20 -0700
Message-ID: <1437179781-21124-6-git-send-email-dmitry.torokhov@gmail.com>
References: <1437179781-21124-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437179781-21124-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: linux-input@vger.kernel.org

Wakeup property of device is not Linux-specific, it describes intended
system behavior regardless of the OS being used. Therefore let's drop
"linux," prefix, and, while at it, use the same name as I2C bus does:
"wakeup-source".

We keep parsing old name to keep compatibility with old DTSes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/devicetree/bindings/input/samsung-keypad.txt | 4 +++-
 drivers/input/keyboard/samsung-keypad.c                    | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/samsung-keypad.txt b/Documentation/devicetree/bindings/input/samsung-keypad.txt
index 942d071..863e77f 100644
--- a/Documentation/devicetree/bindings/input/samsung-keypad.txt
+++ b/Documentation/devicetree/bindings/input/samsung-keypad.txt
@@ -36,9 +36,11 @@ Required Board Specific Properties:
 - pinctrl-0: Should specify pin control groups used for this controller.
 - pinctrl-names: Should contain only one value - "default".
 
+Optional Properties:
+- wakeup-source: use any event on keypad as wakeup event.
+
 Optional Properties specific to linux:
 - linux,keypad-no-autorepeat: do no enable autorepeat feature.
-- linux,keypad-wakeup: use any event on keypad as wakeup event.
 
 
 Example:
diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 43e48dac..dc05f39 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -299,8 +299,10 @@ samsung_keypad_parse_dt(struct device *dev)
 	if (of_get_property(np, "linux,input-no-autorepeat", NULL))
 		pdata->no_autorepeat = true;
 
-	if (of_get_property(np, "linux,input-wakeup", NULL))
-		pdata->wakeup = true;
+	pdata->wakeup = of_property_read_bool(pp, "wakeup-source") ||
+			/* legacy name */
+			of_property_read_bool(pp, "linux,input-wakeup");
+
 
 	return pdata;
 }
-- 
2.4.3.573.g4eafbef
