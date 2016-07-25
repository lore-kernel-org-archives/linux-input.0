From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] Input: i8042, lower log level when controller_init fails
Date: Mon, 25 Jul 2016 16:09:56 +0200
Message-ID: <20160725140956.4559-1-jslaby@suse.cz>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57214 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962AbcGYOJ7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2016 10:09:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

There are a lot of machines without i8042 controller nowadays.
Sometimes i8042_controller_check returns 0 because i8042_flush does
nothing (read from the port returns 0 and the while loop does not
execute).

In that case, the probe method is called and fails with this error
output to console:
i8042: Can't read CTR while initializing i8042
i8042: probe of i8042 failed with error -5

Lower the former error message to be KERN_INFO and make the function
in that case return -ENODEV instead of -EIO. This will suppress the
latter.

There is also an IBM support page about these messages:
https://www-947.ibm.com/support/entry/portal/docdisplay?lndocid=migr-5082417

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/input/serio/i8042.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 454195709a82..e83e3a0ac395 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -950,8 +950,8 @@ static int i8042_controller_init(void)
 			udelay(50);
 
 		if (i8042_command(&ctr[n++ % 2], I8042_CMD_CTL_RCTR)) {
-			pr_err("Can't read CTR while initializing i8042\n");
-			return -EIO;
+			pr_info("Can't read CTR while initializing i8042. Either i8042 controller is not present or it does not respond.\n");
+			return -ENODEV;
 		}
 
 	} while (n < 2 || ctr[0] != ctr[1]);
-- 
2.9.2

