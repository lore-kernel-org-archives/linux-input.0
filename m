From: Roman Volkov <v1ron@v1ros.org>
Subject: [PATCH v3 1/5] i8042: intel-8042 DT documentation
Date: Mon, 16 Feb 2015 00:11:43 +0300
Message-ID: <1424034707-15723-2-git-send-email-v1ron@v1ros.org>
References: <1423857173-16432-6-git-send-email-v1ron@v1ros.org>
 <1424034707-15723-1-git-send-email-v1ron@v1ros.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424034707-15723-1-git-send-email-v1ron@v1ros.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roman Volkov <v1ron@v1ros.org>, Tony Prisk <linux@prisktech.co.nz>
List-Id: linux-input@vger.kernel.org

Documentation for 'intel,8042' DT compatible node.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
Signed-off-by: Roman Volkov <v1ron@v1ros.org>
---
 .../devicetree/bindings/input/intel-8042.txt       | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/intel-8042.txt

diff --git a/Documentation/devicetree/bindings/input/intel-8042.txt b/Documentation/devicetree/bindings/input/intel-8042.txt
new file mode 100644
index 0000000..ab8a3e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/intel-8042.txt
@@ -0,0 +1,26 @@
+Intel 8042 Keyboard Controller
+
+Required properties:
+- compatible: should be "intel,8042"
+- regs: memory for keyboard controller
+- interrupts: usually, two interrupts should be specified (keyboard and aux).
+	However, only one interrupt is also allowed in case of absence of the
+	physical port in the controller. The i8042 driver must be loaded with
+	nokbd/noaux option in this case.
+- interrupt-names: interrupt names corresponding to numbers in the list.
+	"kbd" is the keyboard interrupt and "aux" is the auxiliary (mouse)
+	interrupt.
+- command-reg: offset in memory for command register
+- status-reg: offset in memory for status register
+- data-reg: offset in memory for data register
+
+Example:
+	i8042@d8008800 {
+		compatible = "intel,8042";
+		regs = <0xd8008800 0x100>;
+		interrupts = <23>, <4>;
+		interrupt-names = "kbd", "aux";
+		command-reg = <0x04>;
+		status-reg = <0x04>;
+		data-reg = <0x00>;
+	};
-- 
2.3.0
