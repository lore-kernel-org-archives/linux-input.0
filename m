From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 4/6] input: bcm5974: Augmented debug information
Date: Wed, 28 Jan 2009 11:23:47 +0100
Message-ID: <1233138229-12489-5-git-send-email-rydberg@euromail.se>
References: <1233138229-12489-1-git-send-email-rydberg@euromail.se>
 <1233138229-12489-2-git-send-email-rydberg@euromail.se>
 <1233138229-12489-3-git-send-email-rydberg@euromail.se>
 <1233138229-12489-4-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:48685 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752171AbZA1KYJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jan 2009 05:24:09 -0500
In-Reply-To: <1233138229-12489-4-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

This patch adds more button and finger data to the debug output.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/mouse/bcm5974.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index f85a296..874ae11 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -297,6 +297,11 @@ static int report_bt_state(struct bcm5974 *dev, int size)
 	if (size != sizeof(struct bt_data))
 		return -EIO;
 
+	dprintk(7,
+		"bcm5974: button data: %x %x %x %x\n",
+		dev->bt_data->unknown1, dev->bt_data->button,
+		dev->bt_data->rel_x, dev->bt_data->rel_y);
+
 	input_report_key(dev->input, BTN_LEFT, dev->bt_data->button);
 	input_sync(dev->input);
 
@@ -327,8 +332,8 @@ static int report_tp_state(struct bcm5974 *dev, int size)
 		raw_y = raw2int(f->abs_y);
 
 		dprintk(9,
-			"bcm5974: raw: p: %+05d w: %+05d x: %+05d y: %+05d\n",
-			raw_p, raw_w, raw_x, raw_y);
+			"bcm5974: raw: p: %+05d w: %+05d x: %+05d y: %+05d "
+			"n: %d\n", raw_p, raw_w, raw_x, raw_y, raw_n);
 
 		ptest = int2bound(&c->p, raw_p);
 		origin = raw2int(f->origin);
@@ -374,8 +379,8 @@ static int report_tp_state(struct bcm5974 *dev, int size)
 
 		dprintk(8,
 			"bcm5974: abs: p: %+05d w: %+05d x: %+05d y: %+05d "
-			"nmin: %d nmax: %d n: %d\n",
-			abs_p, abs_w, abs_x, abs_y, nmin, nmax, dev->fingers);
+			"nmin: %d nmax: %d n: %d ibt: %d\n", abs_p, abs_w,
+			abs_x, abs_y, nmin, nmax, dev->fingers, ibt);
 
 	}
 
-- 
1.5.6.3

