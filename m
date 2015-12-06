From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v9 3/8] ARM: dt: Binding documentation for imx25 touchscreen controller
Date: Sun,  6 Dec 2015 20:52:16 +0100
Message-ID: <1449431542-1892-4-git-send-email-mpa@pengutronix.de>
References: <1449431542-1892-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449431542-1892-1-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This is the touchscreen conversion queue binding documentation. It uses
the shared imx25 ADC.

Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---

Notes:
    Changes in v9:
     - Updated binding descriptions
    
    Changes in v5:
     - Fix signed/unsigned comparison
     - Fix unused variable settling_time by putting it in the correct argument list
     - Use continous conversion queue with the repeat feature and a proper
       repeat-wait. Previously the touchscreen caused massive number of interrupts.

 .../bindings/input/touchscreen/fsl-mx25-tcq.txt    | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
new file mode 100644
index 000000000000..d45e50872114
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
@@ -0,0 +1,35 @@
+Freescale mx25 TS conversion queue module
+
+mx25 touchscreen conversion queue module which controls the ADC unit of the
+mx25 for attached touchscreens.
+
+Required properties:
+ - compatible: Should be "fsl,imx25-tcq".
+ - reg: Memory range of the device.
+ - interrupts: Should be the interrupt number associated with this module within
+   the tscadc unit (<0>).
+ - interrupt-parent: Should be a phandle to the tscadc unit.
+ - fsl,wires: Should be '<4>' or '<5>'
+
+Optional properties:
+ - fsl,pen-debounce: Pen debounce time in nanoseconds.
+ - fsl,pen-threshold: Pen-down threshold for the touchscreen. This is a value
+   between 1 and 4096. It is the ratio between the internal reference voltage
+   and the measured voltage after the plate was precharged. Resistence between
+   plates and therefore the voltage decreases with pressure so that a smaller
+   value is equivalent to a higher pressure.
+ - fsl,settling-time: Settling time in nanoseconds. The settling time is before
+   the actual touch detection to wait for an even charge distribution in the
+   plate.
+
+This device includes two conversion queues which can be added as subnodes.
+The first queue is for the touchscreen, the second for general purpose ADC.
+
+Example:
+	tsc: tcq@50030400 {
+		compatible = "fsl,imx25-tcq";
+		reg = <0x50030400 0x60>;
+		interrupt-parent = <&tscadc>;
+		interrupts = <0>;
+		fsl,wires = <4>;
+	};
-- 
2.6.2
