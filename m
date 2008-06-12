From: Jiri Kosina <jkosina@suse.cz>
Subject: [RESEND] [PATCH] Input: add retry logic to resume with respect to
 CTR
Date: Thu, 12 Jun 2008 15:12:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806121511290.10085@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761782AbYFLNMs@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

There are systems that fail in i8042_resume() with

	i8042: Can't write CTR to resume

as i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR) fails even though the
controller claimed itself to be ready before.

One retry after failing write fixes the problems on the failing systems.

Reported-by: Helmut Schaa <hschaa@novell.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/input/serio/i8042.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- linux-2.6.25.orig/drivers/input/serio/i8042.c
+++ linux-2.6.25/drivers/input/serio/i8042.c
@@ -938,8 +938,12 @@ static int i8042_resume(struct platform_
 	i8042_ctr |= I8042_CTR_AUXDIS | I8042_CTR_KBDDIS;
 	i8042_ctr &= ~(I8042_CTR_AUXINT | I8042_CTR_KBDINT);
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
-		printk(KERN_ERR "i8042: Can't write CTR to resume\n");
-		return -EIO;
+		printk(KERN_WARNING "i8042: Can't write CTR to resume, retrying ...\n");
+		msleep(50);
+		if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
+			printk(KERN_ERR "i8042: CTR write retry failed\n");
+			return -EIO;
+		}
 	}
 
 	if (i8042_mux_present) {

--
1.5.2.4
