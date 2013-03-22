From: mathieu.poirier@linaro.org
Subject: [PATCH v3] sysrq: supplementing reset sequence with timeout functionality
Date: Fri, 22 Mar 2013 08:36:42 -0600
Message-ID: <1363963003-18796-1-git-send-email-mathieu.poirier@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:61356 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933436Ab3CVOgr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Mar 2013 10:36:47 -0400
Received: by mail-pb0-f54.google.com with SMTP id jt11so448949pbb.27
        for <linux-input@vger.kernel.org>; Fri, 22 Mar 2013 07:36:46 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: arve@android.com, linux-input@vger.kernel.org, kernel-team@android.com, john.stultz@linaro.org, mathieu.poirier@linaro.org

From: "Mathieu J. Poirier" <mathieu.poirier@linaro.org>

Some devices have too few buttons, which it makes it hard to have
a reset combo that won't trigger automatically.  As such a
timeout functionality that requires the combination to be held for
a given amount of time before triggering is introduced.

If a key combo is recognized and held for a 'timeout' amount of time,
the system triggers a reset.  If the timeout value is omitted the
driver simply ignores the functionality.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
Changes for v3:
   - Cancel timer if any of the key in the combo is released before
     the timeout period expires.

 drivers/tty/sysrq.c |   44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 7953dfa..2255965 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -42,6 +42,7 @@
 #include <linux/input.h>
 #include <linux/uaccess.h>
 #include <linux/moduleparam.h>
+#include <linux/jiffies.h>
 
 #include <asm/ptrace.h>
 #include <asm/irq_regs.h>
@@ -50,6 +51,9 @@
 static int __read_mostly sysrq_enabled = SYSRQ_DEFAULT_ENABLE;
 static bool __read_mostly sysrq_always_enabled;
 
+unsigned short platform_sysrq_reset_seq[] __weak = { KEY_RESERVED };
+int sysrq_downtime_ms __weak;
+
 static bool sysrq_on(void)
 {
 	return sysrq_enabled || sysrq_always_enabled;
@@ -584,6 +588,7 @@ struct sysrq_state {
 	int reset_seq_len;
 	int reset_seq_cnt;
 	int reset_seq_version;
+	struct timer_list keyreset_timeout;
 };
 
 #define SYSRQ_KEY_RESET_MAX	20 /* Should be plenty */
@@ -617,7 +622,14 @@ static void sysrq_parse_reset_sequence(struct sysrq_state *state)
 	state->reset_seq_version = sysrq_reset_seq_version;
 }
 
-static bool sysrq_detect_reset_sequence(struct sysrq_state *state,
+static void sysrq_handle_reset_request(struct sysrq_state *state)
+{
+	unsigned long expires = jiffies + msecs_to_jiffies(sysrq_downtime_ms);
+	state->keyreset_timeout.expires = expires;
+	add_timer(&state->keyreset_timeout);
+}
+
+static void sysrq_detect_reset_sequence(struct sysrq_state *state,
 					unsigned int code, int value)
 {
 	if (!test_bit(code, state->reset_keybit)) {
@@ -628,18 +640,27 @@ static bool sysrq_detect_reset_sequence(struct sysrq_state *state,
 		if (value && state->reset_seq_cnt)
 			state->reset_canceled = true;
 	} else if (value == 0) {
-		/* key release */
+		/*
+		 * Key release - all keys in the reset sequence need
+		 * to be pressed and held for the reset timeout
+		 * to hold.
+		 */
+		del_timer(&state->keyreset_timeout);
+
 		if (--state->reset_seq_cnt == 0)
 			state->reset_canceled = false;
 	} else if (value == 1) {
 		/* key press, not autorepeat */
 		if (++state->reset_seq_cnt == state->reset_seq_len &&
-		    !state->reset_canceled) {
-			return true;
+						!state->reset_canceled) {
+			sysrq_handle_reset_request(state);
 		}
 	}
+}
 
-	return false;
+static void sysrq_handle_reset_timeout(unsigned long data)
+{
+	__handle_sysrq(sysrq_xlate[KEY_B], false);
 }
 
 static void sysrq_reinject_alt_sysrq(struct work_struct *work)
@@ -746,10 +767,8 @@ static bool sysrq_handle_keypress(struct sysrq_state *sysrq,
 		if (was_active)
 			schedule_work(&sysrq->reinject_work);
 
-		if (sysrq_detect_reset_sequence(sysrq, code, value)) {
-			/* Force emergency reboot */
-			__handle_sysrq(sysrq_xlate[KEY_B], false);
-		}
+		/* Check for reset sequence */
+		sysrq_detect_reset_sequence(sysrq, code, value);
 
 	} else if (value == 0 && test_and_clear_bit(code, sysrq->key_down)) {
 		/*
@@ -810,6 +829,8 @@ static int sysrq_connect(struct input_handler *handler,
 	sysrq->handle.handler = handler;
 	sysrq->handle.name = "sysrq";
 	sysrq->handle.private = sysrq;
+	init_timer(&sysrq->keyreset_timeout);
+	sysrq->keyreset_timeout.function = sysrq_handle_reset_timeout;
 
 	error = input_register_handle(&sysrq->handle);
 	if (error) {
@@ -839,6 +860,7 @@ static void sysrq_disconnect(struct input_handle *handle)
 
 	input_close_device(handle);
 	cancel_work_sync(&sysrq->reinject_work);
+	del_timer(&sysrq->keyreset_timeout);
 	input_unregister_handle(handle);
 	kfree(sysrq);
 }
@@ -868,8 +890,6 @@ static struct input_handler sysrq_handler = {
 
 static bool sysrq_handler_registered;
 
-unsigned short platform_sysrq_reset_seq[] __weak = { KEY_RESERVED };
-
 static inline void sysrq_register_handler(void)
 {
 	unsigned short key;
@@ -929,6 +949,8 @@ static struct kernel_param_ops param_ops_sysrq_reset_seq = {
 module_param_array_named(reset_seq, sysrq_reset_seq, sysrq_reset_seq,
 			 &sysrq_reset_seq_len, 0644);
 
+module_param(sysrq_downtime_ms, int, 0644);
+
 #else
 
 static inline void sysrq_register_handler(void)
-- 
1.7.9.5

