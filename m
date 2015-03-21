From: Jonathan Richardson <jonathar@broadcom.com>
Subject: [PATCH v5 2/2] Input: touchscreen-iproc: add device tree bindings
Date: Fri, 20 Mar 2015 17:57:26 -0700
Message-ID: <1426899446-16873-3-git-send-email-jonathar@broadcom.com>
References: <1426899446-16873-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426899446-16873-1-git-send-email-jonathar@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>
Cc: Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, Joe Perches <joe@perches.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-input@vger.kernel.org

Documents the touchscreen device tree binding for Broadcom iProc family
of SoCs.

Reviewed-by: Scott Branden <sbranden@broadcom.com>
Tested-by: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
---
 .../input/touchscreen/brcm,iproc-touchscreen.txt   |   76 ++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
new file mode 100644
index 0000000..34e3382
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
@@ -0,0 +1,76 @@
+* Broadcom's IPROC Touchscreen Controller
+
+Required properties:
+- compatible: must be "brcm,iproc-touchscreen"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- clocks:  The clock provided by the SOC to driver the tsc
+- clock-name:  name for the clock
+- interrupts: The touchscreen controller's interrupt
+
+Optional properties:
+- scanning_period: Time between scans. Each step is 1024 us.  Valid 1-256.
+- debounce_timeout: Each step is 512 us.  Valid 0-255
+- settling_timeout: The settling duration (in ms) is the amount of time
+                    the tsc waits to allow the voltage to settle after
+                    turning on the drivers in detection mode.
+                    Valid values: 0-11
+                    0 =  0.008 ms
+                    1 =  0.01 ms
+                    2 =  0.02 ms
+                    3 =  0.04 ms
+                    4 =  0.08 ms
+                    5 =  0.16 ms
+                    6 =  0.32 ms
+                    7 =  0.64 ms
+                    8 =  1.28 ms
+                    9 =  2.56 ms
+                   10 =  5.12 ms
+                   11 = 10.24 ms
+- touch_timeout: The continuous number of scan periods in which touch is
+                not detected before the controller returns to idle state.
+                Valid values 0-255.
+- average_data: Number of data samples which are averaged before a final
+                data point is placed into the FIFO
+                Valid values 0-7
+                0 =   1 sample
+                1 =   2 samples
+                2 =   4 samples
+                3 =   8 samples
+                4 =  16 samples
+                5 =  32 samples
+                6 =  64 samples
+                7 = 128 samples
+- fifo_threshold: Interrupt is generated whenever the number of fifo
+                entries exceeds this value
+                Valid values 0-31
+- touchscreen-size-x: horizontal resolution of touchscreen (in pixels)
+- touchscreen-size-y: vertical resolution of touchscreen (in pixels)
+- touchscreen-fuzz-x: horizontal noise value of the absolute input
+                      device (in pixels)
+- touchscreen-fuzz-y: vertical noise value of the absolute input
+                      device (in pixels)
+- touchscreen-inverted-x: X axis is inverted (boolean)
+- touchscreen-inverted-y: Y axis is inverted (boolean)
+
+Example:
+
+	touchscreen: tsc@0x180A6000 {
+		compatible = "brcm,iproc-touchscreen";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x180A6000 0x40>;
+		clocks = <&adc_clk>;
+		clock-names = "tsc_clk";
+		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+
+		scanning_period = <5>;
+		debounce_timeout = <40>;
+		settling_timeout = <7>;
+		touch_timeout = <10>;
+		average_data = <5>;
+		fifo_threshold = <1>;
+		/* Touchscreen is rotated 180 degrees. */
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
-- 
1.7.9.5
