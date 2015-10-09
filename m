From: Karsten Merker <merker@debian.org>
Subject: [PATCH RFC V2 3/3] Input: goodix - update dt bindings documentation (axis swapping/inversion)
Date: Fri,  9 Oct 2015 19:55:52 +0200
Message-ID: <1444413352-24529-4-git-send-email-merker@debian.org>
References: <1444413352-24529-1-git-send-email-merker@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444413352-24529-1-git-send-email-merker@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Karsten Merker <merker@debian.org>
List-Id: linux-input@vger.kernel.org

The goodix touchscreen driver has gained support for the
optional touchscreen-inverted-x, touchscreen-inverted-y
and touchscreen-swapped-x-y properties as described in
Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt.

Document these properties in the goodix bindings description.

Signed-off-by: Karsten Merker <merker@debian.org>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index 4db3393..4ecd0e1 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -14,6 +14,7 @@ Required properties:
  - interrupts		: Interrupt to which the chip is connected
  - irq-gpio		: GPIO pin used for IRQ
  - reset-gpio		: GPIO pin used for reset
+
 Optional properties:
 
  - esd-recovery-timeout-ms : ESD poll time (in milli seconds) for the driver to
@@ -21,6 +22,11 @@ Optional properties:
                             device. ESD is disabled if this property is not set
                             or is set to 0.
 
+ - touchscreen-inverted-x  : X axis is inverted (boolean)
+ - touchscreen-inverted-y  : Y axis is inverted (boolean)
+ - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
+                             (swapping is done after inverting the axis)
+
 Example:
 
 	i2c@00000000 {
-- 
2.1.4
