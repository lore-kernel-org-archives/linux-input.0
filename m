From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] Input: i8042 - Lower log level for "no controller" message
Date: Fri,  4 Sep 2015 12:07:22 +0200
Message-ID: <1441361242-15138-1-git-send-email-tiwai@suse.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49631 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092AbbIDKH0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Sep 2015 06:07:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Nowadays the machines without i8042 controller is popular, and no need
to print "No controller found" message in the error log level, which
annoys at booting in quiet mode.  Let's lower it info level.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/input/serio/i8042.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index cb5ece77fd7d..b8cde6912d93 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -871,7 +871,7 @@ static int __init i8042_check_aux(void)
 static int i8042_controller_check(void)
 {
 	if (i8042_flush()) {
-		pr_err("No controller found\n");
+		pr_info("No controller found\n");
 		return -ENODEV;
 	}
 
-- 
2.5.1

