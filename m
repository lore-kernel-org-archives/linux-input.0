From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v2 1/3] dt-bindings: input: add GPIO controllable vibrator
Date: Sun,  7 Apr 2019 17:58:40 +0200
Message-ID: <20190407155841.27354-1-luca@z3ntu.xyz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Pascal PAILLET-LME <p.paillet@st.com>, Coly Li <colyli@suse.de>, Lee Jones <lee.jones@linaro.org>, Xiaotong Lu <xiaotong.lu@spreadtrum.com>, Brian Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, "open list:INPUT KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN..." <linux-input@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, ope <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Provide a simple driver for GPIO controllable vibrators.
It will be used by the Fairphone 2.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes from v1:
- Mark vcc-supply as optional

 .../bindings/input/gpio-vibrator.txt          | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-vibrator.txt

diff --git a/Documentation/devicetree/bindings/input/gpio-vibrator.txt b/Documentation/devicetree/bindings/input/gpio-vibrator.txt
new file mode 100644
index 000000000000..93e5a8e7622d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/gpio-vibrator.txt
@@ -0,0 +1,20 @@
+* GPIO vibrator device tree bindings
+
+Registers a GPIO device as vibrator, where the vibration motor just has the
+capability to turn on or off. If the device is connected to a pwm, you should
+use the pwm-vibrator driver instead.
+
+Required properties:
+- compatible: should contain "gpio-vibrator"
+- enable-gpios: Should contain a GPIO handle
+
+Optional properties:
+- vcc-supply: Phandle for the regulator supplying power
+
+Example from Fairphone 2:
+
+vibrator {
+	compatible = "gpio-vibrator";
+	enable-gpios = <&msmgpio 86 GPIO_ACTIVE_HIGH>;
+	vcc-supply = <&pm8941_l18>;
+};
-- 
2.21.0
