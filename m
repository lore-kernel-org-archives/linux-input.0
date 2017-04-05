From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 7/8] ARM: sun8i: a33: Add devfreq-based GPU cooling
Date: Wed,  5 Apr 2017 11:06:33 +0200
Message-ID: <20170405090634.4649-8-quentin.schulz@free-electrons.com>
References: <20170405090634.4649-1-quentin.schulz@free-electrons.com>
Reply-To: quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBPHHSLDQKGQE6GQLDZY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170405090634.4649-1-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org
Cc: thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

This adds GPU thermal throttling for the Allwinner A33.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---

v3:
  - got rid of cooling-min-level and cooling-max-level as it's not used in any
  code in the kernel,

added in v2
 arch/arm/boot/dts/sun8i-a23-a33.dtsi |  1 +
 arch/arm/boot/dts/sun8i-a33.dtsi     | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 5e8725d..6d81a6d 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -495,6 +495,7 @@
 
 			assigned-clocks = <&ccu CLK_GPU>;
 			assigned-clock-rates = <384000000>;
+			#cooling-cells = <2>;
 		};
 
 		gic: interrupt-controller@01c81000 {
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index b88c107..541ca45 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -188,6 +188,16 @@
 					trip = <&cpu_alert1>;
 					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
+
+				map2 {
+					trip = <&gpu_alert0>;
+					cooling-device = <&mali 1 THERMAL_NO_LIMIT>;
+				};
+
+				map3 {
+					trip = <&gpu_alert1>;
+					cooling-device = <&mali 2 THERMAL_NO_LIMIT>;
+				};
 			};
 
 			trips {
@@ -198,6 +208,13 @@
 					type = "passive";
 				};
 
+				gpu_alert0: gpu_alert0 {
+					/* milliCelsius */
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu_alert1: cpu_alert1 {
 					/* milliCelsius */
 					temperature = <90000>;
@@ -205,6 +222,13 @@
 					type = "hot";
 				};
 
+				gpu_alert1: gpu_alert1 {
+					/* milliCelsius */
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
 				cpu_crit: cpu_crit {
 					/* milliCelsius */
 					temperature = <110000>;
-- 
2.9.3
