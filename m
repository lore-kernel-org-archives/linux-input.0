From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCHv2] Input - keyboard: fix theoretical race on vt switch
Date: Sat, 05 Sep 2009 15:16:34 +0100
Message-ID: <4AA272C2.5070908@tuffmail.co.uk>
References: <4A9FE929.8030804@tuffmail.co.uk> <20090905074222.122C8526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fallback-out2.mxes.net ([216.86.168.191]:52645 "EHLO
	fallback-in2.mxes.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751196AbZIEO0l (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Sep 2009 10:26:41 -0400
Received: from mxout-08.mxes.net (mxout-08.mxes.net [216.86.168.183])
	by fallback-in1.mxes.net (Postfix) with ESMTP id 509982FDC0B
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2009 10:17:41 -0400 (EDT)
In-Reply-To: <20090905074222.122C8526EC9@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Thu, Sep 03, 2009 at 05:04:57PM +0100, Alan Jenkins wrote:
>>
>>  
>> -	kbd = kbd_table + fg_console;
>> +	kbd = kbd_table + vc->vc_num;
>>     
>
> Hmm, I see more such cases there...
>
>   

Oops, sorry.  I think there's only one more case, it's just
embarrassingly close to the other one.

Regards
Alan

---

>From e02f5d1cd72bc0344654872278f7f8313bc9325e Mon Sep 17 00:00:00 2001
From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Date: Sun, 30 Aug 2009 17:40:40 +0100
Subject: [PATCHv2] Input - keyboard: close race on vt-switch

A VT switch can theoretically change fg_console between

	vc = vc_cons[fg_console].d
and
	kbd = kbd_table + fg_console

Fix it by replacing the second fg_console with vc->vc_num.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/char/keyboard.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 737be95..747683f 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -1136,7 +1136,7 @@ static int emulate_raw(struct vc_data *vc, unsigned int keycode, unsigned char u
 static void kbd_rawcode(unsigned char data)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
-	kbd = kbd_table + fg_console;
+	kbd = kbd_table + vc->vc_num;
 	if (kbd->kbdmode == VC_RAW)
 		put_queue(vc, data);
 }
@@ -1157,7 +1157,7 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 		tty->driver_data = vc;
 	}
 
-	kbd = kbd_table + fg_console;
+	kbd = kbd_table + vc->vc_num;
 
 	if (keycode == KEY_LEFTALT || keycode == KEY_RIGHTALT)
 		sysrq_alt = down ? keycode : 0;
-- 
1.5.4.3




