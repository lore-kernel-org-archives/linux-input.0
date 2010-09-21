From: Henrik Rydberg <rydberg@euromail.se>
Subject: [RESEND] hid: 3m: Adjust major / minor axes to scale
Date: Tue, 21 Sep 2010 23:45:25 +0200
Message-ID: <4C992775.3000000@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:42367 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755582Ab0IUVpi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Sep 2010 17:45:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

By visual inspection, the reported touch_major and touch_minor axes
are a factor of two too large. Presumably the device actually reports
the width_major and width_minor, which are generally about a factor of
two larger than the touches themselves.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
Just in case this patch got lost somewhere, here it is again.

Cheers,
Henrik

 drivers/hid/hid-3m-pct.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-3m-pct.c b/drivers/hid/hid-3m-pct.c
index 65441e0..cd4b125 100644
--- a/drivers/hid/hid-3m-pct.c
+++ b/drivers/hid/hid-3m-pct.c
@@ -162,16 +162,18 @@ static void mmm_filter_event(struct mmm_data *md, struct
input_dev *input)
 		if (f->touch) {
 			/* this finger is on the screen */
 			int wide = (f->w > f->h);
+			/* divided by two to match visual scale of touch */
+			int major = max(f->w, f->h) >> 1;
+			int minor = min(f->w, f->h) >> 1;
+
 			if (!f->prev_touch)
 				f->id = md->id++;
 			input_event(input, EV_ABS, ABS_MT_TRACKING_ID, f->id);
 			input_event(input, EV_ABS, ABS_MT_POSITION_X, f->x);
 			input_event(input, EV_ABS, ABS_MT_POSITION_Y, f->y);
 			input_event(input, EV_ABS, ABS_MT_ORIENTATION, wide);
-			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR,
-						wide ? f->w : f->h);
-			input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR,
-						wide ? f->h : f->w);
+			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
+			input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
 			/* touchscreen emulation: pick the oldest contact */
 			if (!oldest || ((f->id - oldest->id) & (SHRT_MAX + 1)))
 				oldest = f;
-- 
1.7.1


