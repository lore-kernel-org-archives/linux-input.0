From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 3/4] dt-bindings: mfd: da9052: support TSI as ADC
Date: Fri, 30 Jun 2017 16:35:05 +0200
Message-ID: <20170630143506.10541-4-sebastian.reichel@collabora.co.uk>
References: <20170630143506.10541-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38076 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbdF3Ofi (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 30 Jun 2017 10:35:38 -0400
In-Reply-To: <20170630143506.10541-1-sebastian.reichel@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>

DA9052 allows using the touchscreen input pins as general purpose
analogue input pin by wiring analogue inputs to X+, X-, Y+ and Y-
and providing a reference voltage at TSIREF pin.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 Documentation/devicetree/bindings/mfd/da9052-i2c.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt b/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
index 9554292dc6cb..57fa74e65664 100644
--- a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
+++ b/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
@@ -4,6 +4,14 @@ Required properties:
 - compatible : Should be "dlg,da9052", "dlg,da9053-aa",
 			 "dlg,da9053-ab", or "dlg,da9053-bb"
 
+Optional properties:
+- dlg,tsi-as-adc : Boolean, if set the X+, X-, Y+, Y- touchscreen
+                    input lines are used as general purpose analogue
+					input.
+- tsiref-supply: Phandle to the regulator, which provides the reference
+                 voltage for the TSIREF pin. Must be provided when the
+			     touchscreen pins are used for ADC purposes.
+
 Sub-nodes:
 - regulators : Contain the regulator nodes. The DA9052/53 regulators are
   bound using their names as listed below:
-- 
2.11.0

