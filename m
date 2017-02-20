From: Patrick Vogelaar <Patrick.Vogelaar@gigatronik.com>
Subject: [PATCH 2/2] add device tree documentation for cy8cmbr3102
Date: Mon, 20 Feb 2017 11:33:33 +0100
Message-ID: <1487586813-4122-3-git-send-email-Patrick.Vogelaar@gigatronik.com>
References: <1487586813-4122-1-git-send-email-Patrick.Vogelaar@gigatronik.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:50925 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752476AbdBTKeD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Feb 2017 05:34:03 -0500
In-Reply-To: <1487586813-4122-1-git-send-email-Patrick.Vogelaar@gigatronik.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, Patrick Vogelaar <Patrick.Vogelaar@gigatronik.com>

Signed-off-by: Patrick Vogelaar <Patrick.Vogelaar@gigatronik.com>
---
 .../bindings/input/cypress,cy8cmbr3102.txt         | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cypress,cy8cmbr3102.txt

diff --git a/Documentation/devicetree/bindings/input/cypress,cy8cmbr3102.txt b/Documentation/devicetree/bindings/input/cypress,cy8cmbr3102.txt
new file mode 100644
index 0000000..d5294b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/cypress,cy8cmbr3102.txt
@@ -0,0 +1,32 @@
+Device tree bindings for Cypress CY8CMBR3102 CapSense Express controller.
+
+The node for this device must be a child of a I2C controller node, as the
+device communicates via I2C.
+
+Required properties:
+
+	compatible:	Must be "cypress,cy8cmbr3102".
+	reg:		The I2C slave address of the device.
+	linux,keycodes:	Specifies an array of numeric keycode values to
+			be used for reporting button presses. The array can
+			contain up to two entries.
+
+Optional properties:
+
+	autorepeat:	Enables the Linux input system's autorepeat
+			feature on the input device.
+
+Example:
+
+	&i2c1 {
+		/* ... */
+
+		touchb_tn: cy8cmbr3102@37 {
+			compatible = "cypress,cy8cmbr3102";
+			reg = <0x37>;
+			linux,keycodes = <BTN_0>, <BTN_1>;
+			autorepeat;
+		};
+
+		/* ... */
+	};
-- 
2.7.4

