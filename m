From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 08/10] Documentation: Describe bindings for STMPE Keypad driver
Date: Fri,  5 Oct 2012 16:31:44 +0100
Message-ID: <1349451107-8009-9-git-send-email-lee.jones@linaro.org>
References: <1349451107-8009-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349451107-8009-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, linus.walleij@stericsson.com, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Here we add the required documentation for the STMPE Device
Tree bindings. It describes all of the bindings currently
supported by the driver.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/input/stmpe-keypad.txt     |   39 ++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/stmpe-keypad.txt

diff --git a/Documentation/devicetree/bindings/input/stmpe-keypad.txt b/Documentation/devicetree/bindings/input/stmpe-keypad.txt
new file mode 100644
index 0000000..e18e2de
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
+ - stericsson,scan-count    : Scanning cycles elapsed before key data is updated
+ - stericsson,no-autorepeat : If specified device will not autorepeat
+
+Example:
+
+	stmpe_keypad {
+		compatible = "st,stmpe-keypad";
+
+		debounce-interval = <64>;
+		stericsson,scan-count = <8>;
+		stericsson,no-autorepeat;
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
