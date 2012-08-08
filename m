From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH v2 2/2] Input: add devicetree binding note for egalax_ts
Date: Wed, 8 Aug 2012 17:10:34 +0800
Message-ID: <1344417034-30175-3-git-send-email-jason77.wang@gmail.com>
References: <1344417034-30175-1-git-send-email-jason77.wang@gmail.com>
 <1344417034-30175-2-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:55215 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932599Ab2HHJLM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Aug 2012 05:11:12 -0400
In-Reply-To: <1344417034-30175-2-git-send-email-jason77.wang@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jiejing.zhang@freescale.com
Cc: linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

The egalax_ts driver needs to get the gpio number of the irq pin,
and use this gpio to wake up the controller. So add a note
for this change.

Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---
 .../bindings/input/touchscreen/egalax-ts.txt       |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
new file mode 100644
index 0000000..5dd8213
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
@@ -0,0 +1,17 @@
+* EETI eGalax Multiple Touch Controller
+
+Required properties:
+- compatible: must be "eeti,egalax_ts"
+- reg: i2c slave address
+- interrupts: touch controller interrupt
+- irq-gpio : the gpio pin to be used for irq
+
+Example:
+
+	egalax_ts@04 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 2>;
+		irq-gpio = <&gpio1 9 0>;
+	};
-- 
1.7.6

