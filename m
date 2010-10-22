From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: touchscreen: AD7879: prevent invalid finger data
 reports
Date: Thu, 21 Oct 2010 22:00:07 -0700
Message-ID: <20101022050007.GB10493@core.coreip.homeip.net>
References: <1287408804-19789-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61239 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab0JVFAO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Oct 2010 01:00:14 -0400
Received: by ywk9 with SMTP id 9so349670ywk.19
        for <linux-input@vger.kernel.org>; Thu, 21 Oct 2010 22:00:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287408804-19789-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com
Cc: linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, drivers@analog.com

Hi Michael,

On Mon, Oct 18, 2010 at 03:33:24PM +0200, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Considering following scenario - the touch is present on the screen
> at the beginning of the last conversion sequence, but by the time
> the last sequence is finished, the finger is lift off.
> The AD7879 data available interrupt signals (DAV) completion,
> however some X,Y values are not valid because the screen inputs were
> floating during the acquisition.
> 
> The AD7877 acts differently here, since it only asserts DAV
> if the touch is still present when the conversion sequence finished.
> 
> Based on the fact that this can only happen in the last sample of the
> repeated conversion sequence. We simply skip the last.
> (Short glitches are filtered by the AD7879 internal median and average filters)
> This doesn't cause noticeable side effects, since the minimum conversion
> interval is 9.44ms. We receive ~100 waypoint samples per second,
> so we simply delay the result by 9.44ms.
> 
> Actually this patch repeats the first waypoint twice and then skips the last.

Input core won't actually pass the 2nd instance through. I think the
whole thing should look like the patch below.

Thanks.

-- 
Dmitry

Input: ad7879 - prevent invalid finger data reports

From: Michael Hennerich <michael.hennerich@analog.com>

Considering following scenario - the touch is present on the screen
at the beginning of the last conversion sequence, but by the time
the last sequence is finished, the finger is lift off. The AD7879 data
available interrupt signals (DAV) completion, however some X,Y values
are not valid because the screen inputs were floating during the
acquisition.

The AD7877 acts differently here, since it only asserts DAV if the
touch is still present when the conversion sequence finished.

Based on the fact that this can only happen in the last sample of the
repeated conversion sequence, we simply skip the last (short glitches
are filtered by the AD7879 internal median and average filters).
This doesn't cause noticeable side effects, since the minimum conversion
interval is 9.44ms. We receive ~100 waypoint samples per second, so we
simply delay the result by 9.44ms.

We also reject samples where pressure is greater than pressure_max.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/ad7879.c |   32 +++++++++++++++++++++++++++-----
 1 files changed, 27 insertions(+), 5 deletions(-)


diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index ba6f0bd..bc3b518 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -129,6 +129,9 @@ struct ad7879 {
 	u16			cmd_crtl1;
 	u16			cmd_crtl2;
 	u16			cmd_crtl3;
+	int			x;
+	int			y;
+	int			Rt;
 };
 
 static int ad7879_read(struct ad7879 *ts, u8 reg)
@@ -175,13 +178,32 @@ static int ad7879_report(struct ad7879 *ts)
 		Rt /= z1;
 		Rt = (Rt + 2047) >> 12;
 
-		if (!timer_pending(&ts->timer))
+		/*
+		 * Sample found inconsistent, pressure is beyond
+		 * the maximum. Don't report it to user space.
+		 */
+		if (Rt > ts->pressure_max)
+			return -EINVAL;
+
+		/*
+		 * Note that we delay reporting events by one sample.
+		 * This is done to avoid reporting last sample of the
+		 * touch sequence, which may be incomplete if finger
+		 * leaves the surface before last reading is taken.
+		 */
+		if (timer_pending(&ts->timer)) {
+			/* Touch continues */
 			input_report_key(input_dev, BTN_TOUCH, 1);
+			input_report_abs(input_dev, ABS_X, ts->x);
+			input_report_abs(input_dev, ABS_Y, ts->y);
+			input_report_abs(input_dev, ABS_PRESSURE, ts->Rt);
+			input_sync(input_dev);
+		}
+
+		ts->x = x;
+		ts->y = y;
+		ts->Rt = Rt;
 
-		input_report_abs(input_dev, ABS_X, x);
-		input_report_abs(input_dev, ABS_Y, y);
-		input_report_abs(input_dev, ABS_PRESSURE, Rt);
-		input_sync(input_dev);
 		return 0;
 	}
 
