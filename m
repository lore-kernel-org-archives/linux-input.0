From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v5 3/3] ARM: dts: msm8974-FP2: Add vibration motor
Date: Fri, 26 Apr 2019 21:47:47 +0200
Message-ID: <20190426194747.22256-3-luca@z3ntu.xyz>
References: <20190426194747.22256-1-luca@z3ntu.xyz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426194747.22256-1-luca@z3ntu.xyz>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Pascal PAILLET-LME <p.paillet@st.com>, Coly Li <colyli@suse.de>, Lee Jones <lee.jones@linaro.org>, Xiaotong Lu <xiaotong.lu@spreadtrum.com>, Brian Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, David Brown <david.brown@linaro.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, "open list:INPUT KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN..." <linux-input@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Luca Weiss <luca@z3ntu.xyz>
List-Id: linux-input@vger.kernel.org

Add a node describing the vibration motor on the Fairphone 2.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
index 643c57f84818..bf402ae39226 100644
--- a/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
@@ -50,6 +50,12 @@
 		};
 	};
 
+	vibrator {
+		compatible = "gpio-vibrator";
+		enable-gpios = <&msmgpio 86 GPIO_ACTIVE_HIGH>;
+		vcc-supply = <&pm8941_l18>;
+	};
+
 	smd {
 		rpm {
 			rpm_requests {
-- 
2.21.0
