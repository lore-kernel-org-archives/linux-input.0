From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v6 2/8] ARM: dt: Binding documentation for imx25 GCQ
Date: Thu, 29 Jan 2015 15:09:10 +0100
Message-ID: <1422540556-14828-3-git-send-email-mpa@pengutronix.de>
References: <1422540556-14828-1-git-send-email-mpa@pengutronix.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422540556-14828-1-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>
Cc: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The documentation describes the bindings for the imx25 GCQ unit which is
essentially a generic conversion queue using the imx25 ADC.

Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---

Notes:
    Changes in v6:
     - Moved the raw_read code out to a different function to cleanup the code
     - Changed bindings to use adc-refp and adc-refn. Also a bit of cleanup in the
       setup routine.
     - Added defines for a complete list of references in the dt binding macros
    
    Changes in v5:
     - Fixed locking
     - Removed module owner

 .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
new file mode 100644
index 000000000000..9f7c08990034
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
@@ -0,0 +1,54 @@
+Freescale i.MX25 ADC GCQ device
+
+This is a generic conversion queue device that can convert any of the
+analog inputs using the ADC unit of the i.MX25.
+
+Required properties:
+ - compatible: Should be "fsl,imx25-gcq".
+ - reg: Should be the register range of the module.
+ - interrupts: Should be the interrupt number of the module.
+   Typically this is <1>.
+ - interrupt-parent: phandle to the tsadc module of the i.MX25.
+ - #address-cells: Should be <1> (setting for the subnodes)
+ - #size-cells: Should be <0> (setting for the subnodes)
+
+Optional properties:
+ - vref-supply: The regulator supplying the ADC reference voltage.
+   Required when at least one subnode uses the external reference.
+
+Sub-nodes:
+Optionally you can define subnodes which define the reference voltage
+for the analog inputs.
+
+Required properties for subnodes:
+ - reg: Should be the number of the analog input.
+     0: xp
+     1: yp
+     2: xn
+     3: yn
+     4: wiper
+     5: inaux0
+     6: inaux1
+     7: inaux2
+Optional properties for subnodes:
+ - fsl,adc-refp: specifies the positive reference input as defined in
+     <dt-bindings/iio/adc/fsl-imx25-gcq.h>
+ - fsl,adc-refn: specifies the negative reference input as defined in
+     <dt-bindings/iio/adc/fsl-imx25-gcq.h>
+
+Example:
+
+	adc: adc@50030800 {
+		compatible = "fsl,imx25-gcq";
+		reg = <0x50030800 0x60>;
+		interrupt-parent = <&tscadc>;
+		interrupts = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		inaux@5 {
+			reg = <5>;
+			fsl,adc-refp = <MX25_ADC_REF_INT>;
+			fsl,adc-refn = <MX25_ADC_REF_NGND>;
+		};
+	};
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
