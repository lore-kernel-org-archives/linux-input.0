From: Sebastian Reichel <sre@debian.org>
Subject: [PATCHv7 2/4] dt: binding documentation for twl4030-pwrbutton
Date: Fri,  8 Nov 2013 23:11:25 +0100
Message-ID: <1383948687-32279-3-git-send-email-sre@debian.org>
References: <1383948687-32279-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1383948687-32279-1-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-input@vger.kernel.org

Add devicetree binding documentation for twl4030-pwrbutton.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 .../devicetree/bindings/input/twl4030-pwrbutton.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt

diff --git a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt b/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
new file mode 100644
index 0000000..c864a46
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
@@ -0,0 +1,21 @@
+Texas Instruments TWL family (twl4030) pwrbutton module
+
+This module is part of the TWL4030. For more details about the whole
+chip see Documentation/devicetree/bindings/mfd/twl-familly.txt.
+
+This module provides a simple power button event via an Interrupt.
+
+Required properties:
+- compatible: should be one of the following
+   - "ti,twl4030-pwrbutton": For controllers compatible with twl4030
+- interrupts: should be one of the following
+   - <8>: For controllers compatible with twl4030
+
+Example:
+
+&twl {
+	twl_pwrbutton: pwrbutton {
+		compatible = "ti,twl4030-pwrbutton";
+		interrupts = <8>;
+	};
+};
-- 
1.8.4.rc3
