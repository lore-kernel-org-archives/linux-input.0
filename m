From: Roman Volkov <v1ron@v1ros.org>
Subject: [PATCH 1/5] i8042: intel-8042 DT documentation
Date: Tue,  3 Feb 2015 00:48:46 +0300
Message-ID: <1422913730-12663-1-git-send-email-v1ron@v1ros.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roman Volkov <v1ron@mail.ru>, Roman Volkov <v1ron@v1ros.org>, Tony Prisk <linux@prisktech.co.nz>
List-Id: linux-input@vger.kernel.org

Documentation for 'intel,8042' DT compatible node.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
Signed-off-by: Roman Volkov <v1ron@v1ros.org>
---
 .../devicetree/bindings/input/intel-8042.txt       | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/intel-8042.txt

diff --git a/Documentation/devicetree/bindings/input/intel-8042.txt b/Documentation/devicetree/bindings/input/intel-8042.txt
new file mode 100644
index 0000000..2aea7ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/intel-8042.txt
@@ -0,0 +1,29 @@
+* Intel 8042 Keyboard Controller
+
+Required properties:
+- compatible: should be "intel,8042"
+- regs: memory for keyboard controller
+- interrupts: two interrupts should be specified (keyboard and aux)
+- command-reg: offset in memory for command register
+- status-reg: offset in memory for status register
+- data-reg: offset in memory for data register
+
+Optional properties:
+- init-reset: Controller should be reset on init and cleanup
+
+Optional Linux-specific properties:
+- linux,kbd_phys_desc: defaults to i8042/serio0
+- linux,aux_phys_desc: defaults to i8042/serio1
+- linux,mux_phys_desc: defaults to i8042/serio%d
+
+
+Example:
+	keyboard@d8008800 {
+		compatible = "intel,8042";
+		reg = <0xd8008800 0x100>;
+		interrupts = <23 4>;
+		command-reg = <0x04>;
+		status-reg = <0x04>;
+		data-reg = <0x00>;
+		mux-ports = <2>;
+	};
-- 
2.2.2
