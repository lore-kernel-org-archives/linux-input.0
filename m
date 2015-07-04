From: Roman Volkov <rvolkov@v1ros.org>
Subject: [PATCH v4 4/4] Documentation: Add 'intel,8042' FDT bindings
Date: Sat,  4 Jul 2015 20:35:44 +0300
Message-ID: <1436031344-15455-5-git-send-email-rvolkov@v1ros.org>
References: <342234234esdfewrewrwer@dkoi.org>
 <1436031344-15455-1-git-send-email-rvolkov@v1ros.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v1ros.org ([109.234.34.72]:53244 "EHLO smtp.v1ros.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755312AbbGEJAr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 5 Jul 2015 05:00:47 -0400
In-Reply-To: <1436031344-15455-1-git-send-email-rvolkov@v1ros.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>, Roman Volkov <rvolkov@v1ros.org>

Add a documentation file for the new OF/FDT binding for the i8042 interface.

Signed-off-by: Roman Volkov <rvolkov@v1ros.org>
---
 .../devicetree/bindings/serio/intel,8042.txt       | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serio/intel,8042.txt

diff --git a/Documentation/devicetree/bindings/serio/intel,8042.txt b/Documentation/devicetree/bindings/serio/intel,8042.txt
new file mode 100644
index 0000000..c2eb26f
--- /dev/null
+++ b/Documentation/devicetree/bindings/serio/intel,8042.txt
@@ -0,0 +1,82 @@
+* Intel 8042 interface
+
+This interface has the long history on various non-x86 platforms. The
+binding is based on the SPARC and PowerPC implementations, compatible to
+Open Firmware. The 'compatible' property has been added to make the binding
+compatible to ePAPR.
+
+Required properties:
+- #address-cells: Must be <1>, since the address for input devices is virtual.
+
+- #size-cells: Must be <0>, since the size is not applicable for the virtual
+  address.
+
+- compatible: Should be "intel,8042".
+
+- reg: Specifies the base address and size of the interface registers in the
+  following order:
+  - DATA: The serial data buffer address.
+  - COMMAND/STATUS: Has the status of the keyboard controller and interface,
+    allows to send commands to the controller.
+
+Optional properties:
+- interrupts: One (keyboard) or two (keyboard and auxiliary) interrupts.
+
+- interrupt-names: names of interrupts, must be "kbd", "aux". If not specified,
+  the first interrupt is "kbd", and the second is "aux".
+
+Child nodes:
+The i8042 interface may control input devices such as keyboard and mouse. Each
+input device is represented by a child node. The input device could be
+identified by the 'compatible' property or the node name (obsolete).
+
+Required properties:
+- reg: Specifies the device virtual address. These numbers should not be
+  duplicated.
+- compatible: should be "pnpPNP,303" for keyboard, and "pnpPNP,f03" for mouse.
+
+Optional properties:
+- interrupts: Specifies the interrupt number for the device. Overwrites the
+  value from the parent node.
+
+Examples:
+
+// Most preferred way
+ps2@d8008800 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "intel,8042";
+	reg = <0xd8008800 0x1>, <0xd8008804 0x1>;
+	interrupts = <23>, <4>;
+	interrupt-names = "kbd", "aux";
+
+	keyboard@0 {
+		reg = <0x0>;
+		compatible = "pnpPNP,303";
+	};
+
+	mouse@1 {
+		reg = <0x1>;
+		compatible = "pnpPNP,f03";
+	};
+};
+
+// PowerPC
+i8042@60 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x1 0x60 0x1 0x1 0x64 0x1>;
+	interrupts = <1 3 12 3>;
+	interrupt-parent = <&i8259>;
+	// 'compatible' property has to be added by the platform code
+
+	keyboard@0 {
+		reg = <0x0>;
+		compatible = "pnpPNP,303";
+	};
+
+	mouse@1 {
+		reg = <0x1>;
+		compatible = "pnpPNP,f03";
+	};
+};
-- 
2.4.2

