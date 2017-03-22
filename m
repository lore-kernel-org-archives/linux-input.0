From: Jagan Teki <jagan@openedev.com>
Subject: [PATCH v7 2/3] dt-bindings: input: touchscreen: Add max11801-ts binding
Date: Wed, 22 Mar 2017 16:36:47 +0530
Message-ID: <1490180808-2856-2-git-send-email-jagan@openedev.com>
References: <1490180808-2856-1-git-send-email-jagan@openedev.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32816 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758814AbdCVLIZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Mar 2017 07:08:25 -0400
In-Reply-To: <1490180808-2856-1-git-send-email-jagan@openedev.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Michael Trimarchi <michael@amarulasolutions.com>

From: Jagan Teki <jagan@amarulasolutions.com>

Add missing documentation of max11801-ts dt-binding details.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v7:
- add vendor prefix as maxim
Changes for v6:
- Replace the lable and name of the node
   ts: max11801 => max11801: touchscreen@48
Changes for v5:
- Newly added patch

 .../bindings/input/touchscreen/max11801-ts.txt         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/max11801-ts.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/max11801-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/max11801-ts.txt
new file mode 100644
index 0000000..8a6cb95
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/max11801-ts.txt
@@ -0,0 +1,18 @@
+* MAXI MAX11801 Resistive touch screen controller with i2c interface
+
+Required properties:
+- compatible: must be "maxim,max11801"
+- reg: i2c slave address
+- interrupt-parent: the phandle for the interrupt controller
+- interrupts: touch controller interrupt
+
+Example:
+
+&i2c1 {
+	max11801: touchscreen@48 {
+		compatible = "maxim,max11801";
+		reg = <0x48>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <31 2>;
+	};
+};
-- 
1.9.1

