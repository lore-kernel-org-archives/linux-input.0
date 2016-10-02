From: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 5/5] mfd: Move binding document
Date: Sun,  2 Oct 2016 16:15:49 +0200
Message-ID: <e4106d819bf15c1d35ea5dadebc354fd0f999f71.1475416202.git.ksenija.stanojevic@gmail.com>
References: <cover.1475416202.git.ksenija.stanojevic@gmail.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1475416202.git.ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1475416202.git.ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1475416202.git.ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org, stefan.wahren-eS4NqCHxEME@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The bindings, which are now used in MFD, need also to be
documented in the MFD binding document.

Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Changes in v7:
 - add to the patchset

 .../devicetree/bindings/iio/adc/mxs-lradc.txt      | 47 ----------------------
 .../devicetree/bindings/mfd/mxs-lradc.txt          | 47 ++++++++++++++++++++++
 2 files changed, 47 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/mxs-lradc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt b/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
deleted file mode 100644
index 555fb11..0000000
--- a/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-* Freescale MXS LRADC device driver
-
-Required properties:
-- compatible: Should be "fsl,imx23-lradc" for i.MX23 SoC and "fsl,imx28-lradc"
-              for i.MX28 SoC
-- reg: Address and length of the register set for the device
-- interrupts: Should contain the LRADC interrupts
-
-Optional properties:
-- fsl,lradc-touchscreen-wires: Number of wires used to connect the touchscreen
-                               to LRADC. Valid value is either 4 or 5. If this
-                               property is not present, then the touchscreen is
-                               disabled. 5 wires is valid for i.MX28 SoC only.
-- fsl,ave-ctrl: number of samples per direction to calculate an average value.
-                Allowed value is 1 ... 32, default is 4
-- fsl,ave-delay: delay between consecutive samples. Allowed value is
-                 2 ... 2048. It is used if 'fsl,ave-ctrl' > 1, counts at
-                 2 kHz and its default is 2 (= 1 ms)
-- fsl,settling: delay between plate switch to next sample. Allowed value is
-                1 ... 2047. It counts at 2 kHz and its default is
-                10 (= 5 ms)
-
-Example for i.MX23 SoC:
-
-	lradc@80050000 {
-		compatible = "fsl,imx23-lradc";
-		reg = <0x80050000 0x2000>;
-		interrupts = <36 37 38 39 40 41 42 43 44>;
-		status = "okay";
-		fsl,lradc-touchscreen-wires = <4>;
-		fsl,ave-ctrl = <4>;
-		fsl,ave-delay = <2>;
-		fsl,settling = <10>;
-	};
-
-Example for i.MX28 SoC:
-
-	lradc@80050000 {
-		compatible = "fsl,imx28-lradc";
-		reg = <0x80050000 0x2000>;
-		interrupts = <10 14 15 16 17 18 19 20 21 22 23 24 25>;
-		status = "okay";
-		fsl,lradc-touchscreen-wires = <5>;
-		fsl,ave-ctrl = <4>;
-		fsl,ave-delay = <2>;
-		fsl,settling = <10>;
-	};
diff --git a/Documentation/devicetree/bindings/mfd/mxs-lradc.txt b/Documentation/devicetree/bindings/mfd/mxs-lradc.txt
new file mode 100644
index 0000000..555fb11
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mxs-lradc.txt
@@ -0,0 +1,47 @@
+* Freescale MXS LRADC device driver
+
+Required properties:
+- compatible: Should be "fsl,imx23-lradc" for i.MX23 SoC and "fsl,imx28-lradc"
+              for i.MX28 SoC
+- reg: Address and length of the register set for the device
+- interrupts: Should contain the LRADC interrupts
+
+Optional properties:
+- fsl,lradc-touchscreen-wires: Number of wires used to connect the touchscreen
+                               to LRADC. Valid value is either 4 or 5. If this
+                               property is not present, then the touchscreen is
+                               disabled. 5 wires is valid for i.MX28 SoC only.
+- fsl,ave-ctrl: number of samples per direction to calculate an average value.
+                Allowed value is 1 ... 32, default is 4
+- fsl,ave-delay: delay between consecutive samples. Allowed value is
+                 2 ... 2048. It is used if 'fsl,ave-ctrl' > 1, counts at
+                 2 kHz and its default is 2 (= 1 ms)
+- fsl,settling: delay between plate switch to next sample. Allowed value is
+                1 ... 2047. It counts at 2 kHz and its default is
+                10 (= 5 ms)
+
+Example for i.MX23 SoC:
+
+	lradc@80050000 {
+		compatible = "fsl,imx23-lradc";
+		reg = <0x80050000 0x2000>;
+		interrupts = <36 37 38 39 40 41 42 43 44>;
+		status = "okay";
+		fsl,lradc-touchscreen-wires = <4>;
+		fsl,ave-ctrl = <4>;
+		fsl,ave-delay = <2>;
+		fsl,settling = <10>;
+	};
+
+Example for i.MX28 SoC:
+
+	lradc@80050000 {
+		compatible = "fsl,imx28-lradc";
+		reg = <0x80050000 0x2000>;
+		interrupts = <10 14 15 16 17 18 19 20 21 22 23 24 25>;
+		status = "okay";
+		fsl,lradc-touchscreen-wires = <5>;
+		fsl,ave-ctrl = <4>;
+		fsl,ave-delay = <2>;
+		fsl,settling = <10>;
+	};
-- 
1.9.1
