From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v10 1/8] ARM: dt: Binding documentation for imx25 ADC/TSC
Date: Mon, 14 Dec 2015 14:53:47 +0100
Message-ID: <1450101234-2191-2-git-send-email-mpa@pengutronix.de>
References: <1450101234-2191-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43389 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932587AbbLNNyv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Dec 2015 08:54:51 -0500
In-Reply-To: <1450101234-2191-1-git-send-email-mpa@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Denis Carikli <denis@eukrea.com>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hartmut Knaack <knaack.h@gmx.de>, Fabio Estevam <festevam@gmail.com>, Markus Pargmann <mpa@pengutronix.de>

This documentation describes the devicetree bindings for the
ADC/Touchscreen unit of the i.MX25 SoC.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---

Notes:
    Changes in v9:
     - Fixed some style things.
    
    Changes in v6:
     - Removed adc-ref property and replaced it with refp and refn for positive and
       negative references. The properties are optional now as the default
       behaviour is a positive internal reference voltage and ADC GND as negative
       reference.

 .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt

diff --git a/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
new file mode 100644
index 000000000000..b03505286997
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
@@ -0,0 +1,47 @@
+Freescale MX25 ADC/TSC MultiFunction Device (MFD)
+
+This device combines two general purpose conversion queues one used for general
+ADC and the other used for touchscreens.
+
+Required properties:
+ - compatible:			Should be "fsl,imx25-tsadc".
+ - reg:				Start address and size of the memory area of
+ 					the device
+ - interrupts:			Interrupt for this device
+					(See: ../interrupt-controller/interrupts.txt)
+ - clocks:			An 'ipg' clock (See: ../clock/clock-bindings.txt)
+ - interrupt-controller:	This device is an interrupt controller. It
+   					controls the interrupts of both
+					conversion queues.
+ - #interrupt-cells:		Should be '<1>'.
+ - #address-cells:		Should be '<1>'.
+ - #size-cells:			Should be '<1>'.
+
+This device includes two conversion queues which can be added as subnodes.
+The first queue is for the touchscreen, the second for general purpose ADC.
+
+Example:
+	tscadc: tscadc@50030000 {
+		compatible = "fsl,imx25-tsadc";
+		reg = <0x50030000 0xc>;
+		interrupts = <46>;
+		clocks = <&clks 119>;
+		clock-names = "ipg";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		tsc: tcq@50030400 {
+			compatible = "fsl,imx25-tcq";
+			reg = <0x50030400 0x60>;
+			...
+		};
+
+		adc: gcq@50030800 {
+			compatible = "fsl,imx25-gcq";
+			reg = <0x50030800 0x60>;
+			...
+		};
+	};
-- 
2.6.2

