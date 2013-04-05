From: mathieu.poirier@linaro.org
Subject: [PATCH] Input: Adding graceful shutdown to sysrq key reset
Date: Fri,  5 Apr 2013 07:38:32 -0600
Message-ID: <1365169112-7999-1-git-send-email-mathieu.poirier@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:50776 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161548Ab3DENih (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Apr 2013 09:38:37 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb10so2055259pad.39
        for <linux-input@vger.kernel.org>; Fri, 05 Apr 2013 06:38:37 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, arve@android.com, kernel-team@android.com, john.stultz@linaro.org, mathieu.poirier@linaro.org

From: "Mathieu J. Poirier" <mathieu.poirier@linaro.org>

Attempt to reboot the system gracefully when a key combo
is detected.  The system is force to go down if the first
attempt failed and the key combo is pressed a second time.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/tty/sysrq.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 766878a..bd852fc 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -43,6 +43,7 @@
 #include <linux/uaccess.h>
 #include <linux/moduleparam.h>
 #include <linux/jiffies.h>
+#include <linux/syscalls.h>
 
 #include <asm/ptrace.h>
 #include <asm/irq_regs.h>
@@ -584,6 +585,7 @@ struct sysrq_state {
 
 	/* reset sequence handling */
 	bool reset_canceled;
+	bool reset_requested;
 	unsigned long reset_keybit[BITS_TO_LONGS(KEY_CNT)];
 	int reset_seq_len;
 	int reset_seq_cnt;
@@ -624,11 +626,17 @@ static void sysrq_parse_reset_sequence(struct sysrq_state *state)
 
 static void sysrq_do_reset(unsigned long dummy)
 {
-	__handle_sysrq(sysrq_xlate[KEY_B], false);
+	sys_sync();
+	kernel_restart(NULL);
 }
 
 static void sysrq_handle_reset_request(struct sysrq_state *state)
 {
+	if (state->reset_requested)
+		__handle_sysrq(sysrq_xlate[KEY_B], false);
+
+	state->reset_requested = true;
+
 	if (sysrq_reset_downtime_ms)
 		mod_timer(&state->keyreset_timer,
 			jiffies + msecs_to_jiffies(sysrq_reset_downtime_ms));
-- 
1.7.9.5

