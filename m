From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v4 1/3] dt-bindings: input: add GPIO controllable vibrator
Date: Sat, 20 Apr 2019 14:23:31 +0200
Message-ID: <20190420122333.23662-1-luca@z3ntu.xyz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Pascal PAILLET-LME <p.paillet@st.com>, Coly Li <colyli@suse.de>, Lee Jones <lee.jones@linaro.org>, Xiaotong Lu <xiaotong.lu@spreadtrum.com>, Brian Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, David Brown <david.brown@linaro.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, "open list:INPUT KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN..." <linux-input@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Luca Weiss <luca@z3ntu.xyz>
List-Id: linux-input@vger.kernel.org

Provide a simple driver for GPIO controllable vibrators.
It will be used by the Fairphone 2.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes from v3:
- Convert .txt based doc to the new yaml based format

 .../bindings/input/gpio-vibrator.yaml         | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-vibrator.yaml

diff --git a/Documentation/devicetree/bindings/input/gpio-vibrator.yaml b/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
new file mode 100644
index 000000000000..bca1b6ea07a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/input/gpio-vibrator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO vibrator
+
+maintainers:
+  - Luca Weiss <luca@z3ntu.xyz>
+
+description: |+
+  Registers a GPIO device as vibrator, where the on/off capability is controlled by a GPIO.
+
+properties:
+  compatible:
+    items:
+      - const: gpio-vibrator
+
+  enable-gpios:
+    maxItems: 1
+
+  vcc-supply:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Regulator that provides power
+
+required:
+  - compatible
+  - enable-gpios
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    vibrator {
+        compatible = "gpio-vibrator";
+        enable-gpios = <&msmgpio 86 GPIO_ACTIVE_HIGH>;
+        vcc-supply = <&pm8941_l18>;
+    };
-- 
2.21.0
