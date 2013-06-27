From: mathieu.poirier@linaro.org
Subject: [PATCH 2/2] Input: Adding DT support for keyreset tuneables
Date: Thu, 27 Jun 2013 10:13:25 -0600
Message-ID: <1372349605-4500-2-git-send-email-mathieu.poirier@linaro.org>
References: <1372349605-4500-1-git-send-email-mathieu.poirier@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53077 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab3F0QNW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jun 2013 12:13:22 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so1113485pbb.19
        for <linux-input@vger.kernel.org>; Thu, 27 Jun 2013 09:13:22 -0700 (PDT)
In-Reply-To: <1372349605-4500-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: grant.likely@linaro.org
Cc: devicetree-discuss@lists.ozlabs.org, dmitry.torokhov@gmail.com, john.stultz@linaro.org, kernel-team@android.com, linux-input@vger.kernel.org

From: "Mathieu J. Poirier" <mathieu.poirier@linaro.org>

This patch adds the possibility to get the keyreset and timeout
values from the device tree.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/tty/sysrq.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index b51c154..91d081c 100644
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
+		pr_info("No sysrq node found");
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

