From: Andreas Bosch <linux@progandy.de>
Subject: [PATCH v2] Input: alps - fix v4 button press recognition
Date: Tue, 14 Oct 2014 21:08:05 +0200
Message-ID: <1413313685-24405-1-git-send-email-linux@progandy.de>
References: <CAA0OBZzqB28ZpfSt-ruOTOwdMxMC7SEdR+MsM03_ZVa16ybjug@mail.gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:48541 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbaJNTI6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2014 15:08:58 -0400
Received: by mail-la0-f51.google.com with SMTP id ge10so9128162lab.10
        for <linux-input@vger.kernel.org>; Tue, 14 Oct 2014 12:08:56 -0700 (PDT)
In-Reply-To: <CAA0OBZzqB28ZpfSt-ruOTOwdMxMC7SEdR+MsM03_ZVa16ybjug@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

Since the change to struct input_mt_pos some variables are now bitfields
instead of integers. Automatic conversion from integer to bitfield entry
destroys information, therefore enforce boolean interpretation instead.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1114768
Fixes: 02d04254a5df ("Input: alps - use struct input_mt_pos to track coordinates")
Signed-off-by: Andreas Bosch <linux@progandy.de>
---

This is the second version of the patch. The first try got mangled 
during the transmission.

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 35a49bf..2b0ae8c 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -835,8 +835,8 @@ static void alps_process_packet_v4(struct psmouse *psmouse)
 		f->fingers = alps_process_bitmap(priv, f);
 	}
 
-	f->left = packet[4] & 0x01;
-	f->right = packet[4] & 0x02;
+	f->left = !!(packet[4] & 0x01);
+	f->right = !!(packet[4] & 0x02);
 
 	f->st.x = ((packet[1] & 0x7f) << 4) | ((packet[3] & 0x30) >> 2) |
 		  ((packet[0] & 0x30) >> 4);
-- 
2.1.2

