From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v7 3/8] ARM: dt: Binding documentation for imx25 touchscreen controller
Date: Tue,  3 Mar 2015 08:58:13 +0100
Message-ID: <1425369498-25541-4-git-send-email-mpa@pengutronix.de>
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52476 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754639AbbCCH7F (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Mar 2015 02:59:05 -0500
In-Reply-To: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Fabio Estevam <festevam@gmail.com>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>
Cc: Denis Carikli <denis@eukrea.com>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Markus Pargmann <mpa@pengutronix.de>

This is the touchscreen conversion queue binding documentation. It uses
the shared imx25 ADC.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Notes:
    Changes in v5:
     - Fix signed/unsigned comparison
     - Fix unused variable settling_time by putting it in the correct argument list
     - Use continous conversion queue with the repeat feature and a proper
       repeat-wait. Previously the touchscreen caused massive number of interrupts.

 .../bindings/input/touchscreen/fsl-mx25-tcq.txt    | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
new file mode 100644
index 000000000000..4214a99d197a
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
@@ -0,0 +1,29 @@
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
+ - fsl,pen-debounce: Pen debounce time.
+ - fsl,pen-threshold: Pen-down threshold for the touchscreen.
+ - fsl,settling-time: Settling time in nanoseconds.
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
2.1.4

