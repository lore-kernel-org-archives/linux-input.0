From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 23/36] [Driver][Qualcomm 1065][AT_COMMAND]retrieve message
Date: Mon, 26 Jul 2010 16:30:32 +0800
Message-ID: <1280133045-25945-23-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34938 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899Ab0GZIdV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:33:21 -0400
Received: by pzk26 with SMTP id 26so890224pzk.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:33:21 -0700 (PDT)
In-Reply-To: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: "morris.chen" <morris_chen@quantatw.com>

From: morris.chen <morris_chen@quantatw.com>

---
 arch/arm/mach-msm/smd_tty.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)
 mode change 100644 => 100755 arch/arm/mach-msm/smd_tty.c

diff --git a/arch/arm/mach-msm/smd_tty.c b/arch/arm/mach-msm/smd_tty.c
old mode 100644
new mode 100755
index d4272fa..f43c086
--- a/arch/arm/mach-msm/smd_tty.c
+++ b/arch/arm/mach-msm/smd_tty.c
@@ -80,7 +80,9 @@ static void smd_tty_work_func(struct work_struct *work)
 			printk(KERN_ERR "OOPS - smd_tty_buffer mismatch?!");
 		}
 		mutex_unlock(&smd_tty_lock);
-
+		//QCI, morris chen, 20100608, begin, return ATcmd's message back
+		printk("%s\n",ptr);
+		//QCI, morris chen, end
 		tty_flip_buffer_push(tty);
 	}
 
-- 
1.7.0.4

