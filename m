From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v5 9/9] devicetree: bindings: Document PM8921/8058 vibrators
Date: Tue,  4 Mar 2014 10:34:48 -0800
Message-ID: <1393958088-1456-10-git-send-email-sboyd@codeaurora.org>
References: <1393958088-1456-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393958088-1456-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Josh Cartwright <joshc@codeaurora.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Document the vibration device found on PM8921 and PM8058 PMICs.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 .../devicetree/bindings/input/qcom,pm8xxx-vib.txt  | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
new file mode 100644
index 000000000000..4ed467b1e402
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
@@ -0,0 +1,22 @@
+Qualcomm PM8xxx PMIC Vibrator
+
+PROPERTIES
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be one of:
+		    "qcom,pm8058-vib"
+		    "qcom,pm8921-vib"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: address of vibration control register
+
+EXAMPLE
+
+	vibrator@4a {
+		compatible = "qcom,pm8058-vib";
+		reg = <0x4a>;
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
