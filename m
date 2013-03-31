From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] sysrq: supplementing reset sequence with timeout
 functionality
Date: Sun, 31 Mar 2013 00:36:54 -0700
Message-ID: <20130331073654.GE7919@core.coreip.homeip.net>
References: <1363963003-18796-1-git-send-email-mathieu.poirier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:59560 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756165Ab3CaHg5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 Mar 2013 03:36:57 -0400
Received: by mail-pb0-f41.google.com with SMTP id mc17so313027pbc.0
        for <linux-input@vger.kernel.org>; Sun, 31 Mar 2013 00:36:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363963003-18796-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: arve@android.com, linux-input@vger.kernel.org, kernel-team@android.com, john.stultz@linaro.org

Hi Mathieu,

On Fri, Mar 22, 2013 at 08:36:42AM -0600, mathieu.poirier@linaro.org wrote:
> +
> +static void sysrq_detect_reset_sequence(struct sysrq_state *state,
>  					unsigned int code, int value)
>  {
>  	if (!test_bit(code, state->reset_keybit)) {
> @@ -628,18 +640,27 @@ static bool sysrq_detect_reset_sequence(struct sysrq_state *state,
>  		if (value && state->reset_seq_cnt)
>  			state->reset_canceled = true;
>  	} else if (value == 0) {
> -		/* key release */
> +		/*
> +		 * Key release - all keys in the reset sequence need
> +		 * to be pressed and held for the reset timeout
> +		 * to hold.
> +		 */
> +		del_timer(&state->keyreset_timeout);
> +

I believe you need to cancel the timer also when any other key is
pressed (the branch above). Can you please try the version below?

I also realized that even when timer expires right away (the delay
is 0) it is not executed immediately (contrary to what I said earlier)
so I reverted to doing explicit call to reset instead of always using
timer.

Thanks.

-- 
Dmitry


Input: sysrq - supplementing reset sequence with timeout functionality

From: Mathieu J. Poirier <mathieu.poirier@linaro.org>

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
 drivers/tty/sysrq.c |   26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 3687f0c..f31f417 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -43,6 +43,7 @@
 #include <linux/input.h>
 #include <linux/uaccess.h>
 #include <linux/moduleparam.h>
+#include <linux/jiffies.h>
 
 #include <asm/ptrace.h>
 #include <asm/irq_regs.h>
@@ -51,6 +52,9 @@
 static int __read_mostly sysrq_enabled = SYSRQ_DEFAULT_ENABLE;
 static bool __read_mostly sysrq_always_enabled;
 
+unsigned short platform_sysrq_reset_seq[] __weak = { KEY_RESERVED };
+int sysrq_reset_downtime_ms __weak;
+
 static bool sysrq_on(void)
 {
 	return sysrq_enabled || sysrq_always_enabled;
@@ -586,6 +590,7 @@ struct sysrq_state {
 	int reset_seq_len;
 	int reset_seq_cnt;
 	int reset_seq_version;
+	struct timer_list keyreset_timer;
 };
 
 #define SYSRQ_KEY_RESET_MAX	20 /* Should be plenty */
@@ -644,6 +649,11 @@ static bool sysrq_detect_reset_sequence(struct sysrq_state *state,
 	return false;
 }
 
+static void sysrq_do_reset(unsigned long dummy)
+{
+	__handle_sysrq(sysrq_xlate[KEY_B], false);
+}
+
 static void sysrq_reinject_alt_sysrq(struct work_struct *work)
 {
 	struct sysrq_state *sysrq =
@@ -748,10 +758,13 @@ static bool sysrq_handle_keypress(struct sysrq_state *sysrq,
 		if (was_active)
 			schedule_work(&sysrq->reinject_work);
 
-		if (sysrq_detect_reset_sequence(sysrq, code, value)) {
-			/* Force emergency reboot */
-			__handle_sysrq(sysrq_xlate[KEY_B], false);
-		}
+		if (!sysrq_detect_reset_sequence(sysrq, code, value))
+			del_timer(&sysrq->keyreset_timer);
+		else if (sysrq_reset_downtime_ms)
+			mod_timer(&sysrq->keyreset_timer,
+				jiffies + msecs_to_jiffies(sysrq_reset_downtime_ms));
+		else
+			sysrq_do_reset(0);
 
 	} else if (value == 0 && test_and_clear_bit(code, sysrq->key_down)) {
 		/*
@@ -812,6 +825,7 @@ static int sysrq_connect(struct input_handler *handler,
 	sysrq->handle.handler = handler;
 	sysrq->handle.name = "sysrq";
 	sysrq->handle.private = sysrq;
+	setup_timer(&sysrq->keyreset_timer, sysrq_do_reset, 0);
 
 	error = input_register_handle(&sysrq->handle);
 	if (error) {
@@ -841,6 +855,7 @@ static void sysrq_disconnect(struct input_handle *handle)
 
 	input_close_device(handle);
 	cancel_work_sync(&sysrq->reinject_work);
+	del_timer_sync(&sysrq->keyreset_timer);
 	input_unregister_handle(handle);
 	kfree(sysrq);
 }
@@ -870,8 +885,6 @@ static struct input_handler sysrq_handler = {
 
 static bool sysrq_handler_registered;
 
-unsigned short platform_sysrq_reset_seq[] __weak = { KEY_RESERVED };
-
 static inline void sysrq_register_handler(void)
 {
 	unsigned short key;
@@ -930,6 +943,7 @@ static struct kernel_param_ops param_ops_sysrq_reset_seq = {
 
 module_param_array_named(reset_seq, sysrq_reset_seq, sysrq_reset_seq,
 			 &sysrq_reset_seq_len, 0644);
+module_param_named(reset_downtime_ms, sysrq_reset_downtime_ms, int, 0644);
 
 #else
 
