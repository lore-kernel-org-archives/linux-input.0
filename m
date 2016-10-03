From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH -resend] Input: i8042, lower log level when controller_init fails
Date: Mon,  3 Oct 2016 10:56:52 +0200
Message-ID: <20161003085652.15810-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-input@vger.kernel.org

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
index 405252a884dd..15c87b98d70b 100644
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
2.10.0
