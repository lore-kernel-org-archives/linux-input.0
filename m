From: Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH 5/8] dt-bindings: input: document stpmu1 pmic onkey
Date: Thu, 5 Jul 2018 15:14:24 +0000
Message-ID: <1530803657-17684-6-git-send-email-p.paillet@st.com>
References: <1530803657-17684-1-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530803657-17684-1-git-send-email-p.paillet@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Cc: Pascal PAILLET-LME <p.paillet@st.com>
List-Id: linux-input@vger.kernel.org

From: pascal paillet <p.paillet@st.com>

The stpmu1 pmic is able to manage an onkey button. It can be configured
to shut-down the power supplies on a long key-press with an adjustable
duration.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
 .../devicetree/bindings/input/st,stpmu1-onkey.txt  | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/st,stpmu1-onkey.txt

diff --git a/Documentation/devicetree/bindings/input/st,stpmu1-onkey.txt b/Documentation/devicetree/bindings/input/st,stpmu1-onkey.txt
new file mode 100644
index 0000000..cc42b7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/st,stpmu1-onkey.txt
@@ -0,0 +1,31 @@
+STMicroelectronics STPMU1 Onkey
+
+Required properties:
+
+- compatible = "st,stpmu1-onkey";
+- interrupt-parent: phandle to the parent interrupt controller
+- interrupts: interrupt line to use
+- interrupt-names = "onkey-falling", "onkey-rising"
+	onkey-falling: happens when onkey is pressed; IT_PONKEY_F of pmic
+	onkey-rising: happens when onkey is released; IT_PONKEY_R of pmic
+
+Optional properties:
+
+- st,onkey-pwroff-enabled: power off on long key-press
+- st,onkey-long-press-seconds: long key-press duration from 1 to 16s
+  (default 16s)
+- st,onkey-clear-cc-flag: onkey is able power on after an
+  over-current shutdown event.
+- st,onkey-pu-inactive: onkey pull up is not active
+
+Example:
+
+onkey {
+	compatible = "st,stpmu1-onkey";
+	interrupt-parent = <&pmic>;
+	interrupts = <7 0>,<6 1>;
+	interrupt-names = "onkey-falling", "onkey-rising";
+	status = "okay";
+	st,onkey-pwroff-enabled;
+	st,onkey-long-press-seconds = <10>;
+};
-- 
1.9.1
