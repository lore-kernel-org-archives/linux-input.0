From: Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH v4 5/8] dt-bindings: input: document stpmic1 pmic onkey
Date: Thu, 18 Oct 2018 09:02:13 +0000
Message-ID: <1539853324-29051-6-git-send-email-p.paillet@st.com>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539853324-29051-1-git-send-email-p.paillet@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>
Cc: Pascal PAILLET-LME <p.paillet@st.com>
List-Id: linux-input@vger.kernel.org

From: pascal paillet <p.paillet@st.com>

The stpmic1 pmic is able to manage an onkey button. It can be configured
to shut-down the power supplies on a long key-press with an adjustable
duration.

Signed-off-by: pascal paillet <p.paillet@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
changes in v4:
* remove interrupt-parent description
* remove st,onkey-pwroff-enabled and power-off-time-sec properties

 .../devicetree/bindings/input/st,stpmic1-onkey.txt | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt

diff --git a/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt b/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
new file mode 100644
index 0000000..4494613
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
@@ -0,0 +1,28 @@
+STMicroelectronics STPMIC1 Onkey
+
+Required properties:
+
+- compatible = "st,stpmic1-onkey";
+- interrupts: interrupt line to use
+- interrupt-names = "onkey-falling", "onkey-rising"
+	onkey-falling: happens when onkey is pressed; IT_PONKEY_F of pmic
+	onkey-rising: happens when onkey is released; IT_PONKEY_R of pmic
+
+Optional properties:
+
+- st,onkey-clear-cc-flag: onkey is able power on after an
+  over-current shutdown event.
+- st,onkey-pu-inactive: onkey pull up is not active
+- power-off-time-sec: Duration in seconds which the key should be kept
+        pressed for device to power off automatically (from 1 to 16 seconds).
+        see See Documentation/devicetree/bindings/input/keys.txt
+
+Example:
+
+onkey {
+	compatible = "st,stpmic1-onkey";
+	interrupt-parent = <&pmic>;
+	interrupts = <IT_PONKEY_F 0>,<IT_PONKEY_R 1>;
+	interrupt-names = "onkey-falling", "onkey-rising";
+	power-off-time-sec = <10>;
+};
-- 
1.9.1
