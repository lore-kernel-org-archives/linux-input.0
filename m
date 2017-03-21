From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v3 02/11] ARM: sun8i: a33: add all operating points
Date: Tue, 21 Mar 2017 16:36:02 +0100
Message-ID: <20170321153611.16228-3-quentin.schulz@free-electrons.com>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
Reply-To: quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBA4RYXDAKGQEVRNV4WI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170321153611.16228-1-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org
Cc: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org
List-Id: linux-input@vger.kernel.org

This adds almost all operating points allowed for the A33 as defined by
fex files available at:
https://github.com/linux-sunxi/sunxi-boards/tree/master/sys_config/a33

There are more possible frequencies in this patch than there are in the
fex files because the fex files only give an interval of possible
frequencies for a given voltage. All supported frequencies are defined
in the original driver code in Allwinner vendor tree.

There are two missing frequencies though: 1104MHz and 1200MHz which
require the CPU to have 1.32V supplied, which is higher than the default
voltage.

Without all A33 boards defining the CPU regulator, we cannot have these
two frequencies as it would cause the CPU to try to run a higher
frequency without "overvolting" which is very likely to crash the CPU.

Therefore, these two frequencies must be enabled on a per-board basis.

Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---

v2:
  - updated commit log,
  - removed 1.1GHz as it requires overvolting the CPU which need the CPU
  regulator to be set which is set on a per-board basis,

 arch/arm/boot/dts/sun8i-a33.dtsi | 54 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 39b2d78..b1cdff66 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -49,18 +49,72 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
+		opp@120000000 {
+			opp-hz = /bits/ 64 <120000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@240000000 {
+			opp-hz = /bits/ 64 <240000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@312000000 {
+			opp-hz = /bits/ 64 <312000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@504000000 {
+			opp-hz = /bits/ 64 <504000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
 		opp@648000000 {
 			opp-hz = /bits/ 64 <648000000>;
 			opp-microvolt = <1040000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
+		opp@720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
 		opp@816000000 {
 			opp-hz = /bits/ 64 <816000000>;
 			opp-microvolt = <1100000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
+		opp@912000000 {
+			opp-hz = /bits/ 64 <912000000>;
+			opp-microvolt = <1200000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
 		opp@1008000000 {
 			opp-hz = /bits/ 64 <1008000000>;
 			opp-microvolt = <1200000>;
-- 
2.9.3
