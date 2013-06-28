From: mathieu.poirier@linaro.org
Subject: [PATCH v2] Input: Add device tree bindings for input keys
Date: Fri, 28 Jun 2013 07:46:12 -0600
Message-ID: <1372427172-9546-1-git-send-email-mathieu.poirier@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:50690 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab3F1NqI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jun 2013 09:46:08 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so2264008pbb.36
        for <linux-input@vger.kernel.org>; Fri, 28 Jun 2013 06:46:08 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: grant.likely@linaro.org
Cc: devicetree-discuss@lists.ozlabs.org, dmitry.torokhov@gmail.com, john.stultz@linaro.org, kernel-team@android.com, linux-input@vger.kernel.org

From: "Mathieu J. Poirier" <mathieu.poirier@linaro.org>

This adds a simple device tree binding for the specification of
key sequences.  Definition of the keys found in the sequence are
located in 'include/uapi/linux/input.h'.

A keyset can be applied to a single device or the system as a
whole, depending on the associated driver.  An extention is also
provided for the definition of multiple keysets.

Lastly, the possibility to get keyreset timeout values from the
device tree based on the new binding is added.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
changes for v2:
   - Moving to pr_debug when 'sysrq' node isn't found.
   - Merging binding description and code enhancement.
---
 .../devicetree/bindings/input/input-keyset.txt     |   78 ++++++++++++++++++++
 drivers/tty/sysrq.c                                |   54 ++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/input-keyset.txt

diff --git a/Documentation/devicetree/bindings/input/input-keyset.txt b/Documentation/devicetree/bindings/input/input-keyset.txt
new file mode 100644
index 0000000..4f96299
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/input-keyset.txt
@@ -0,0 +1,78 @@
+Input: keyset
+
+A simple binding to represent a set of keys as described in
+include/uapi/linux/input.h.  This is targeted at devices that want
+to react to certain key combination being pressed or need to
+perform some configuration based on a set of input keys.
+
+It can also be used in a scenario where the system has a whole
+needs to respond to a specific sequence of keys.
+
+Required properties:
+ - linux,input-keyset: An array of 1-cell entries representing the
+   values associated with the KEY_xyz #defines found in input.h.
+
+Example1:
+Applicable to a specific device:
+
+        matrix-keypad {
+                compatible = "gpio-matrix-keypad";
+                debounce-delay-ms = <5>;
+                col-scan-delay-us = <2>;
+
+                row-gpios = <&gpio2 25 0
+                             &gpio2 26 0
+                             &gpio2 27 0>;
+
+                col-gpios = <&gpio2 21 0
+                             &gpio2 22 0
+                             &gpio2 23 0>;
+
+                linux,keymap = <0x00000002
+                                0x01000005
+                                0x02000008
+                                0x00010003
+                                0x01010006
+                                0x02010009
+                                0x00020004
+                                0x01020007
+                                0x0202000a>;
+
+                linux,keyset = <0x04
+                                0x05
+                                0x0a>;
+        };
+
+Example2:
+Used as a system-wide parameter:
+
+	sysrq {
+		linux,input-keyset = <0x01
+				      0x0A
+				      0x19>;
+		timout-ms = <3000>;
+	};
+
+Would represent KEY_1, KEY_9 and KEY_P.
+
+Example3:
+Binding used when multiple declarations are needed:
+
+acme_keysets {
+        keyset0 {
+                linux,input-keyset = <0x01
+                                      0x02
+                                      0x03>;
+        };
+        keyset1 {
+                linux,input-keyset = <0x04
+                                      0x05
+                                      0x06>;
+        };
+        keyset2 {
+                linux,input-keyset = <0x07
+                                      0x08
+                                      0x09>;
+        };
+
+};
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index b51c154..9c20886 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -44,6 +44,7 @@
 #include <linux/uaccess.h>
 #include <linux/moduleparam.h>
 #include <linux/jiffies.h>
+#include <linux/of.h>
 
 #include <asm/ptrace.h>
 #include <asm/irq_regs.h>
@@ -671,6 +672,50 @@ static void sysrq_detect_reset_sequence(struct sysrq_state *state,
 	}
 }
 
+static void sysrq_of_get_keyreset_config(void)
+{
+	unsigned short key;
+	struct device_node *np;
+	const struct property *prop;
+	const __be32 *val;
+	int count, i;
+
+	np = of_find_node_by_path("/sysrq");
+	if (!np) {
+		pr_debug("No sysrq node found");
+		goto out;
+	}
+
+	prop = of_find_property(np, "linux,input-keyset", NULL);
+	if (!prop || !prop->value) {
+		pr_err("Invalid input-keyset");
+		goto out;
+	}
+
+	count = prop->length / sizeof(u32);
+	val = prop->value;
+
+	if (count > SYSRQ_KEY_RESET_MAX)
+		count = SYSRQ_KEY_RESET_MAX;
+
+	/* reset in case a __weak definition was present */
+	sysrq_reset_seq_len = 0;
+
+	for (i = 0; i < count; i++) {
+		key = (unsigned short)be32_to_cpup(val++);
+		if (key == KEY_RESERVED || key > KEY_MAX)
+			break;
+
+		sysrq_reset_seq[sysrq_reset_seq_len++] = key;
+	}
+
+	/* get reset timeout if any */
+	of_property_read_u32(np, "timeout-ms", &sysrq_reset_downtime_ms);
+
+ out:
+	;
+}
+
 static void sysrq_reinject_alt_sysrq(struct work_struct *work)
 {
 	struct sysrq_state *sysrq =
@@ -688,6 +733,7 @@ static void sysrq_reinject_alt_sysrq(struct work_struct *work)
 		input_inject_event(handle, EV_KEY, KEY_SYSRQ, 1);
 		input_inject_event(handle, EV_SYN, SYN_REPORT, 1);
 
+
 		input_inject_event(handle, EV_KEY, KEY_SYSRQ, 0);
 		input_inject_event(handle, EV_KEY, alt_code, 0);
 		input_inject_event(handle, EV_SYN, SYN_REPORT, 1);
@@ -903,6 +949,7 @@ static inline void sysrq_register_handler(void)
 	int error;
 	int i;
 
+	/* first check if a __weak interface was instantiated */
 	for (i = 0; i < ARRAY_SIZE(sysrq_reset_seq); i++) {
 		key = platform_sysrq_reset_seq[i];
 		if (key == KEY_RESERVED || key > KEY_MAX)
@@ -911,6 +958,13 @@ static inline void sysrq_register_handler(void)
 		sysrq_reset_seq[sysrq_reset_seq_len++] = key;
 	}
 
+	/*
+	 * DT configuration takes precedence over anything
+	 * that would have been defined via the __weak
+	 * interface
+	 */
+	sysrq_of_get_keyreset_config();
+
 	error = input_register_handler(&sysrq_handler);
 	if (error)
 		pr_err("Failed to register input handler, error %d", error);
-- 
1.7.9.5

