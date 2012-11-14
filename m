From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 5/5] Documentation: Describe bindings for STMPE Keypad driver
Date: Wed, 14 Nov 2012 13:47:17 +0000
Message-ID: <1352900837-20759-6-git-send-email-lee.jones@linaro.org>
References: <1352900837-20759-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352900837-20759-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Here we add the required documentation for the STMPE Device
Tree bindings. It describes all of the bindings currently
supported by the driver.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/input/stmpe-keypad.txt     |   39 ++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/stmpe-keypad.txt

diff --git a/Documentation/devicetree/bindings/input/stmpe-keypad.txt b/Documentation/devicetree/bindings/input/stmpe-keypad.txt
new file mode 100644
index 0000000..1b97222
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/stmpe-keypad.txt
@@ -0,0 +1,39 @@
+* STMPE Keypad
+
+Required properties:
+ - compatible               : "st,stmpe-keypad"
+ - linux,keymap             : See ./matrix-keymap.txt
+
+Optional properties:
+ - debounce-interval        : Debouncing interval time in milliseconds
+ - st,scan-count            : Scanning cycles elapsed before key data is updated
+ - st,no-autorepeat         : If specified device will not autorepeat
+
+Example:
+
+	stmpe_keypad {
+		compatible = "st,stmpe-keypad";
+
+		debounce-interval = <64>;
+		st,scan-count = <8>;
+		st,no-autorepeat;
+
+		linux,keymap = <0x205006b
+				0x4010074
+				0x3050072
+				0x1030004
+				0x502006a
+				0x500000a
+				0x5008b
+				0x706001c
+				0x405000b
+				0x6070003
+				0x3040067
+				0x303006c
+				0x60400e7
+				0x602009e
+				0x4020073
+				0x5050002
+				0x4030069
+				0x3020008>;
+	};
-- 
1.7.9.5
