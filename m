From: akpm@linux-foundation.org
Subject: [patch 11/22] input: bcm5974: Augmented debug information
Date: Wed, 04 Mar 2009 11:59:01 -0800
Message-ID: <200903041959.n24Jx1J1028430@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56940 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758125AbZCDUDJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Mar 2009 15:03:09 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, rydberg@euromail.se

From: "Henrik Rydberg" <rydberg@euromail.se>

Add more button and finger data to the debug output.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/mouse/bcm5974.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff -puN drivers/input/mouse/bcm5974.c~input-bcm5974-augmented-debug-information drivers/input/mouse/bcm5974.c
--- a/drivers/input/mouse/bcm5974.c~input-bcm5974-augmented-debug-information
+++ a/drivers/input/mouse/bcm5974.c
@@ -297,6 +297,11 @@ static int report_bt_state(struct bcm597
 	if (size != sizeof(struct bt_data))
 		return -EIO;
 
+	dprintk(7,
+		"bcm5974: button data: %x %x %x %x\n",
+		dev->bt_data->unknown1, dev->bt_data->button,
+		dev->bt_data->rel_x, dev->bt_data->rel_y);
+
 	input_report_key(dev->input, BTN_LEFT, dev->bt_data->button);
 	input_sync(dev->input);
 
@@ -327,8 +332,8 @@ static int report_tp_state(struct bcm597
 		raw_y = raw2int(f->abs_y);
 
 		dprintk(9,
-			"bcm5974: raw: p: %+05d w: %+05d x: %+05d y: %+05d\n",
-			raw_p, raw_w, raw_x, raw_y);
+			"bcm5974: raw: p: %+05d w: %+05d x: %+05d y: %+05d "
+			"n: %d\n", raw_p, raw_w, raw_x, raw_y, raw_n);
 
 		ptest = int2bound(&c->p, raw_p);
 		origin = raw2int(f->origin);
@@ -374,8 +379,8 @@ static int report_tp_state(struct bcm597
 
 		dprintk(8,
 			"bcm5974: abs: p: %+05d w: %+05d x: %+05d y: %+05d "
-			"nmin: %d nmax: %d n: %d\n",
-			abs_p, abs_w, abs_x, abs_y, nmin, nmax, dev->fingers);
+			"nmin: %d nmax: %d n: %d ibt: %d\n", abs_p, abs_w,
+			abs_x, abs_y, nmin, nmax, dev->fingers, ibt);
 
 	}
 
_
