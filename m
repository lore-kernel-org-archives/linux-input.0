From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH] Input - keyboard: fix theoretical race on vt switch
Date: Thu, 03 Sep 2009 17:04:57 +0100
Message-ID: <4A9FE929.8030804@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:46801 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754566AbZICQE7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Sep 2009 12:04:59 -0400
Received: by fxm17 with SMTP id 17so44171fxm.37
        for <linux-input@vger.kernel.org>; Thu, 03 Sep 2009 09:05:00 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Switching virtual consoles could change fg_console between

	vc = vc_cons[fg_console].d
and
	kbd = kbd_table + fg_console

Replace the second instance of fg_console with vc->vc_num.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/char/keyboard.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 737be95..4b564c5 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -1157,7 +1157,7 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 		tty->driver_data = vc;
 	}
 
-	kbd = kbd_table + fg_console;
+	kbd = kbd_table + vc->vc_num;
 
 	if (keycode == KEY_LEFTALT || keycode == KEY_RIGHTALT)
 		sysrq_alt = down ? keycode : 0;
-- 
1.6.3.2

