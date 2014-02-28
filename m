From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v4 7/9] devicetree: bindings: Document PM8921/8058 keypads
Date: Thu, 27 Feb 2014 17:55:18 -0800
Message-ID: <1393552520-9068-8-git-send-email-sboyd@codeaurora.org>
References: <1393552520-9068-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1393552520-9068-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Josh Cartwright <joshc@codeaurora.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Document the keypad device found on PM8921 and PM8058 PMICs.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 .../bindings/input/qcom,pm8xxx-keypad.txt          | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt b/Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
new file mode 100644
index 000000000000..aa5a9c6cf512
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
@@ -0,0 +1,72 @@
+Qualcomm PM8xxx PMIC Keypad
+
+PROPERTIES
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be one of:
+		    "qcom,pm8058-keypad"
+		    "qcom,pm8921-keypad"
+- interrupts:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: the first interrupt specifies the key sense interrupt
+		    and the second interrupt specifies the key stuck interrupt.
+		    The format of the specifier is defined by the binding
+		    document describing the node's interrupt parent.
+
+- linux,keymap:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: the linux keymap. More information can be found in
+		    input/matrix-keymap.txt.
+
+- keypad,num-rows:
+	Usage: required
+	Value type: <u32>
+	Definition: number of rows in the keymap. More information can be found
+		    in input/matrix-keymap.txt.
+
+- keypad,num-columns:
+	Usage: required
+	Value type: <u32>
+	Definition: number of columns in the keymap. More information can be
+		    found in input/matrix-keymap.txt.
+
+- debounce:
+	Usage: optional
+	Value type: <u32>
+	Definition: time in microseconds that key must be pressed or release
+		    for key sense interrupt to trigger.
+
+- scan-delay:
+	Usage: optional
+	Value type: <u32>
+	Definition: time in microseconds to pause between successive scans
+		    of the matrix array.
+
+- row-hold:
+	Usage: optional
+	Value type: <u32>
+	Definition: time in nanoseconds to pause between scans of each row in
+		    the matrix array.
+
+EXAMPLE
+
+	keypad {
+		compatible = "qcom,pm8921-keypad";
+		interrupt-parent = <&pmicintc>;
+		interrupts = <74 1>, <75 1>;
+		linux,keymap = <
+			MATRIX_KEY(0, 0, KEY_VOLUMEUP)
+			MATRIX_KEY(0, 1, KEY_VOLUMEDOWN)
+			MATRIX_KEY(0, 2, KEY_CAMERA_FOCUS)
+			MATRIX_KEY(0, 3, KEY_CAMERA)
+			>;
+		keypad,num-rows = <1>;
+		keypad,num-columns = <5>;
+		debounce = <15>;
+		scan-delay = <32>;
+		row-hold = <91500>;
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
