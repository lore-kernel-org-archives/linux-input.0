From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH 2/2] Input: mcs_touchkey: add device tree binding document
Date: Wed, 21 May 2014 14:51:57 +0900
Message-ID: <537C3EFD.8040601@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:54038 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbaEUFv7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 May 2014 01:51:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, Joonyoung Shim <jy0922.shim@samsung.com>, mark.rutland@arm.com
Cc: Myungjoo Ham <myungjoo.ham@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

This patch add simple device tree bindings to
MELFAS MCS5000/5080 controller.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 .../devicetree/bindings/input/mcs-touchkey.txt     |   25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/mcs-touchkey.txt

diff --git a/Documentation/devicetree/bindings/input/mcs-touchkey.txt b/Documentation/devicetree/bindings/input/mcs-touchkey.txt
new file mode 100644
index 0000000..8364799
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/mcs-touchkey.txt
@@ -0,0 +1,25 @@
+* mcs_touchkey MELFAS MCS5000/5080 controller
+
+Required properties:
+- compatible: must be "mcs5000_touchkey" or "mcs5080_touchkey"
+- reg : I2C address of the chip
+- interrupts: interrupt to which the chip is connected
+- key_maxval: size of keycode table
+- code: key code for this device
+
+Example:
+
+	i2c_touch_key: i2c-gpio-0 {
+	       /* ... */
+
+	       touch_key@20 {
+		       compatible = "mcs5080_touchkey";
+		       reg = <0x20>;
+		       interrupt-patrent = <gpj0>;
+		       key_maxval = <2>;
+		       linux, code = <0x0000009e
+			              0x000000a9>;
+	       };
+
+	       /* ... */
+	};
-- 
1.7.9.5
