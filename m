From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: [PATCH 2/2] input: pm8941-pwrkey: Add DT binding documentation
Date: Mon, 6 Oct 2014 18:12:01 -0700
Message-ID: <1412644321-27683-3-git-send-email-bjorn.andersson@sonymobile.com>
References: <1412644321-27683-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1412644321-27683-1-git-send-email-bjorn.andersson@sonymobile.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, Courtney Cavin <courtney.cavin@sonymobile.com>
List-Id: linux-input@vger.kernel.org

From: Courtney Cavin <courtney.cavin@sonymobile.com>

Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 .../bindings/input/qcom,pm8941-pwrkey.txt          |   43 ++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
new file mode 100644
index 0000000..4d75e2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
@@ -0,0 +1,43 @@
+Qualcomm PM8941 PMIC Power Key
+
+PROPERTIES
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be one of:
+		    "qcom,pm8941-pwrkey"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: base address of registers for block
+
+- interrupts:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: key change interrupt; The format of the specifier is
+		    defined by the binding document describing the node's
+		    interrupt parent.
+
+- debounce:
+	Usage: optional
+	Value type: <u32>
+	Definition: time in microseconds that key must be pressed or released
+		    for state change interrupt to trigger.
+
+- bias-pull-up:
+	Usage: optional
+	Value type: <empty>
+	Definition: presence of this property indicates that the KPDPWR_N pin
+		    should be configured for pull up.
+
+EXAMPLE
+
+	pwrkey@800 {
+		compatible = "qcom,pm8941-pwrkey";
+		reg = <0x800>;
+		interrupts = <0x0 0x8 0 0>;
+		debounce = <15625>;
+		bias-pull-up;
+	};
-- 
1.7.9.5
