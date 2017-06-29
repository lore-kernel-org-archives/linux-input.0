From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [PATCHv3 3/4] dt-bindings: mfd: da9052: support TSI as ADC
Date: Thu, 29 Jun 2017 14:43:45 +0200
Message-ID: <20170629124346.22325-4-sebastian.reichel@collabora.co.uk>
References: <20170629124346.22325-1-sebastian.reichel@collabora.co.uk>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170629124346.22325-1-sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

DA9052 allows using the touchscreen input pins as general purpose
analogue input pin by wiring analogue inputs to X+, X-, Y+ and Y-
and providing a reference voltage at TSIREF pin.

Signed-off-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
