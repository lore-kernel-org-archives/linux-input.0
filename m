From: mathieu.poirier@linaro.org
Subject: [PATCH v4] sysrq: supplementing reset sequence with timeout functionality
Date: Mon,  1 Apr 2013 13:31:51 -0600
Message-ID: <1364844711-32302-1-git-send-email-mathieu.poirier@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:53401 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759394Ab3DATbp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Apr 2013 15:31:45 -0400
Received: by mail-pb0-f54.google.com with SMTP id xa7so525570pbc.41
        for <linux-input@vger.kernel.org>; Mon, 01 Apr 2013 12:31:44 -0700 (PDT)
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
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Changes for v4:
   - Cancel timer if more keys are pressed after a valid combo.
   - Trigger reset right away if timeout hasn't been set.
   - Modifying miscellaneous names.

 drivers/tty/sysrq.c |   55 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 7953dfa..766878a 100644
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
+int sysrq_reset_downtime_ms __weak;
+
 static bool sysrq_on(void)
 {
 	return sysrq_enabled || sysrq_always_enabled;
@@ -584,6 +588,7 @@ struct sysrq_state {
 	int reset_seq_len;
 	int reset_seq_cnt;
 	int reset_seq_version;
+	struct timer_list keyreset_timer;
 };
 
 #define SYSRQ_KEY_RESET_MAX	20 /* Should be plenty */
@@ -617,29 +622,51 @@ static void sysrq_parse_reset_sequence(struct sysrq_state *state)
 	state->reset_seq_version = sysrq_reset_seq_version;
 }
 
-static bool sysrq_detect_reset_sequence(struct sysrq_state *state,
+static void sysrq_do_reset(unsigned long dummy)
+{
+	__handle_sysrq(sysrq_xlate[KEY_B], false);
+}
+
+static void sysrq_handle_reset_request(struct sysrq_state *state)
+{
+	if (sysrq_reset_downtime_ms)
+		mod_timer(&state->keyreset_timer,
+			jiffies + msecs_to_jiffies(sysrq_reset_downtime_ms));
+	else
+		sysrq_do_reset(0);
+}
+
+static void sysrq_detect_reset_sequence(struct sysrq_state *state,
 					unsigned int code, int value)
 {
 	if (!test_bit(code, state->reset_keybit)) {
 		/*
 		 * Pressing any key _not_ in reset sequence cancels
-		 * the reset sequence.
+		 * the reset sequence.  Also cancelling the timer in
+		 * case additional keys were pressed after a reset
+		 * has been requested.
 		 */
-		if (value && state->reset_seq_cnt)
+		if (value && state->reset_seq_cnt) {
 			state->reset_canceled = true;
+			del_timer(&state->keyreset_timer);
+		}
 	} else if (value == 0) {
-		/* key release */
+		/*
+		 * Key release - all keys in the reset sequence need
+		 * to be pressed and held for the reset timeout
+		 * to hold.
+		 */
+		del_timer(&state->keyreset_timer);
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
-
-	return false;
 }
 
 static void sysrq_reinject_alt_sysrq(struct work_struct *work)
@@ -746,10 +773,8 @@ static bool sysrq_handle_keypress(struct sysrq_state *sysrq,
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
@@ -810,6 +835,7 @@ static int sysrq_connect(struct input_handler *handler,
 	sysrq->handle.handler = handler;
 	sysrq->handle.name = "sysrq";
 	sysrq->handle.private = sysrq;
+	setup_timer(&sysrq->keyreset_timer, sysrq_do_reset, 0);
 
 	error = input_register_handle(&sysrq->handle);
 	if (error) {
@@ -839,6 +865,7 @@ static void sysrq_disconnect(struct input_handle *handle)
 
 	input_close_device(handle);
 	cancel_work_sync(&sysrq->reinject_work);
+	del_timer_sync(&sysrq->keyreset_timer);
 	input_unregister_handle(handle);
 	kfree(sysrq);
 }
@@ -868,8 +895,6 @@ static struct input_handler sysrq_handler = {
 
 static bool sysrq_handler_registered;
 
-unsigned short platform_sysrq_reset_seq[] __weak = { KEY_RESERVED };
-
 static inline void sysrq_register_handler(void)
 {
 	unsigned short key;
@@ -929,6 +954,8 @@ static struct kernel_param_ops param_ops_sysrq_reset_seq = {
 module_param_array_named(reset_seq, sysrq_reset_seq, sysrq_reset_seq,
 			 &sysrq_reset_seq_len, 0644);
 
+module_param_named(sysrq_downtime_ms, sysrq_reset_downtime_ms, int, 0644);
+
 #else
 
 static inline void sysrq_register_handler(void)
-- 
1.7.9.5

