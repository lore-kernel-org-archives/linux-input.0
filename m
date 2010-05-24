From: Martyn Welch <martyn.welch@ge.com>
Subject: [PATCH v2] powerpc: Add i8042 keyboard and mouse irq parsing
Date: Mon, 24 May 2010 17:25:15 +0100
Message-ID: <20100524162325.11133.8579.stgit@ES-J7S4D2J.amer.consind.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:57578 "EHLO
	exprod5og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757652Ab0EXQZT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 May 2010 12:25:19 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, benh@kernel.crashing.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org

Currently the irqs for the i8042, which historically provides keyboard and
mouse (aux) support, is hardwired in the driver rather than parsing the
dts.  This patch modifies the powerpc legacy IO code to attempt to parse
the device tree for this information, failing back to the hardcoded values
if it fails.

Signed-off-by: Martyn Welch <martyn.welch@ge.com>
---

v2: This patch no longer requires the DTS files to be modified, reading the
interrupts from the current location as suggested by Grant.

 arch/powerpc/kernel/setup-common.c |   49 ++++++++++++++++++++++++++++++++++--
 drivers/input/serio/i8042-io.h     |    8 ++++++
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 48f0a00..7f1bb99 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -94,6 +94,10 @@ struct screen_info screen_info = {
 	.orig_video_points = 16
 };
 
+/* Variables required to store legacy IO irq routing */
+int of_i8042_kbd_irq;
+int of_i8042_aux_irq;
+
 #ifdef __DO_IRQ_CANON
 /* XXX should go elsewhere eventually */
 int ppc_do_canonicalize_irqs;
@@ -558,13 +562,52 @@ void probe_machine(void)
 /* Match a class of boards, not a specific device configuration. */
 int check_legacy_ioport(unsigned long base_port)
 {
-	struct device_node *parent, *np = NULL;
+	struct device_node *parent, *np = NULL, *np_aux = NULL;
 	int ret = -ENODEV;
 
 	switch(base_port) {
 	case I8042_DATA_REG:
-		if (!(np = of_find_compatible_node(NULL, NULL, "pnpPNP,303")))
-			np = of_find_compatible_node(NULL, NULL, "pnpPNP,f03");
+		np = of_find_compatible_node(NULL, NULL, "pnpPNP,303");
+		if (np) {
+			/* Interrupt routing in parent node */
+			parent = of_get_parent(np);
+			if (parent) {
+				/*
+				 * Attempt to parse DTS for keyboard irq,
+				 * fallback to standard.
+				 */
+				of_i8042_kbd_irq = irq_of_parse_and_map(parent,
+					0);
+				if (!of_i8042_kbd_irq)
+					of_i8042_kbd_irq = 1;
+
+				of_node_put(parent);
+			}
+		}
+
+		np_aux = of_find_compatible_node(NULL, NULL, "pnpPNP,f03");
+		if (np_aux) {
+			if (!np) {
+				of_node_put(np);
+				np = np_aux;
+			}
+
+			/* Interrupt routing in parent node */
+			parent = of_get_parent(np_aux);
+			if (parent) {
+				/*
+				 * Attempt to parse DTS for mouse (aux) irq,
+				 * fallback to standard.
+				 */
+				of_i8042_aux_irq = irq_of_parse_and_map(parent,
+					1);
+				if (!of_i8042_aux_irq)
+					of_i8042_aux_irq = 12;
+
+				of_node_put(parent);
+			}
+		}
+
 		if (np) {
 			parent = of_get_parent(np);
 			of_node_put(np);
diff --git a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
index 847f4aa..8fc8753 100644
--- a/drivers/input/serio/i8042-io.h
+++ b/drivers/input/serio/i8042-io.h
@@ -19,6 +19,11 @@
  * IRQs.
  */
 
+#if defined(CONFIG_PPC)
+extern int of_i8042_kbd_irq;
+extern int of_i8042_aux_irq;
+#endif
+
 #ifdef __alpha__
 # define I8042_KBD_IRQ	1
 # define I8042_AUX_IRQ	(RTC_PORT(0) == 0x170 ? 9 : 12)	/* Jensen is special */
@@ -27,6 +32,9 @@
 #include <asm/irq.h>
 #elif defined(CONFIG_SH_CAYMAN)
 #include <asm/irq.h>
+#elif defined(CONFIG_PPC)
+#define I8042_KBD_IRQ	of_i8042_kbd_irq
+#define I8042_AUX_IRQ	of_i8042_aux_irq
 #else
 # define I8042_KBD_IRQ	1
 # define I8042_AUX_IRQ	12


--
Martyn Welch (Principal Software Engineer)   |   Registered in England and
GE Intelligent Platforms                     |   Wales (3828642) at 100
T +44(0)127322748                            |   Barbirolli Square, Manchester,
E martyn.welch@ge.com                        |   M2 3AB  VAT:GB 927559189
