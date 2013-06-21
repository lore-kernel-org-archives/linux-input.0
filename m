From: Gerhard Sittig <gsi@denx.de>
Subject: [PATCH v1 01/12] input: matrix-keypad: update devicetree binding doc
Date: Fri, 21 Jun 2013 20:09:47 +0200
Message-ID: <1371838198-7327-2-git-send-email-gsi@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:59247 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423552Ab3FUSKQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jun 2013 14:10:16 -0400
In-Reply-To: <1371838198-7327-1-git-send-email-gsi@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Marek Vasut <marek.vasut@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Anatolij Gustschin <agust@denx.de>, Detlev Zundel <dzu@denx.de>, Gerhard Sittig <gsi@denx.de>

update the device tree binding documentation for the GPIO matrix keypad
driver: mention the driver's selecting all columns at once, reword the
delay descriptions, add the missing active low GPIO pin level property

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 .../bindings/input/gpio-matrix-keypad.txt          |   42 +++++++++++++++++---
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
index ead641c..11d030e 100644
--- a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
+++ b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
@@ -2,9 +2,30 @@
 
 GPIO driven matrix keypad is used to interface a SoC with a matrix keypad.
 The matrix keypad supports multiple row and column lines, a key can be
-placed at each intersection of a unique row and a unique column. The matrix
-keypad can sense a key-press and key-release by means of GPIO lines and
-report the event using GPIO interrupts to the cpu.
+placed at each intersection of a unique row and a unique column.
+
+Sampling the keypad status is done by individually activating column
+lines (which thus are outputs) and reading back row lines (which are
+inputs).  Each combination of row and column is checked separately to
+determine the status of a single key.
+
+To reduce load on the CPU, changes in the keys' status can get detected
+by means of GPIO interrupts, which get generated upon changes in the pin
+levels.  This approach assumes that any change in the key press status
+will result in a GPIO pin level change interrupt when all columns are
+selected (active) at the same time.  Which in turn assumes that all
+column lines can get activated at the same time, and no harm is done to
+the hardware when multiple keys are pressed simultaneously.
+
+Simple keypad matrix layouts just connect GPIO lines to mechanical
+switches, with no other active components involved.  Although due to the
+driver's operation of activating all columns at the same time for most
+of the time, the use of current limiting resistors may be desirable, or
+column GPIO lines shall operate in open collector mode.
+
+More involved matrix layouts may include externally connected line
+drivers and might influence signal polarity.  The driver supports low
+active signals, while high active line levels are assumed by default.
 
 Required Properties:
 - compatible:		Should be "gpio-matrix-keypad"
@@ -20,9 +41,18 @@ Required Properties:
 Optional Properties:
 - linux,no-autorepeat:	do no enable autorepeat feature.
 - linux,wakeup:		use any event on keypad as wakeup event.
-- debounce-delay-ms:	debounce interval in milliseconds
-- col-scan-delay-us:	delay, measured in microseconds, that is needed
-			before we can scan keypad after activating column gpio
+- debounce-delay-ms:	debounce interval in milliseconds, which needs
+			to pass between detecting a change in the key
+			press status and sampling the new status, e.g.
+			to support multi key presses without spurious
+			single key events, or to cope with bouncing
+			mechanical key switches
+- col-scan-delay-us:	delay interval in microseconds between selecting
+			a column line and reading back its row status,
+			such that pin levels can settle after
+			propagating through the matrix and its
+			associated hardware components
+- gpio-activelow:	row pins as well as column pins are active low
 
 Example:
 	matrix-keypad {
-- 
1.7.10.4

