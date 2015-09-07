From: Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH] input: fix data race __ps2_command
Date: Mon,  7 Sep 2015 16:04:35 +0200
Message-ID: <1441634675-114118-1-git-send-email-dvyukov@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, andreyknvl@google.com, kcc@google.com, glider@google.com, ktsan@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
List-Id: linux-input@vger.kernel.org

The data race happens on ps2dev->cmdcnt and ps2dev->cmdbuf contents.
__ps2_command reads that data concurrently with the interrupt handler.
As the result, for example, if a response arrives just after the
timeout, __ps2_command can copy out garbage from ps2dev->cmdbuf
but then see that ps2dev->cmdcnt is 0 and return success.

Stop the interrupt handler with serio_pause_rx() before
reading the results.

The data race was found with KernelThreadSanitizer (KTSAN).

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
---
 drivers/input/serio/libps2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 7551699..8f93336 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -234,17 +234,19 @@ int __ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command)
 				   !(ps2dev->flags & PS2_FLAG_CMD), timeout);
 	}
 
+	serio_pause_rx(ps2dev->serio);
 	if (param)
 		for (i = 0; i < receive; i++)
 			param[i] = ps2dev->cmdbuf[(receive - 1) - i];
 
 	if (ps2dev->cmdcnt && (command != PS2_CMD_RESET_BAT || ps2dev->cmdcnt != 1))
-		goto out;
-
+		goto out_paused;
 	rc = 0;
+	goto out_paused;
 
  out:
 	serio_pause_rx(ps2dev->serio);
+out_paused:
 	ps2dev->flags = 0;
 	serio_continue_rx(ps2dev->serio);
 
-- 
2.5.0.457.gab17608
