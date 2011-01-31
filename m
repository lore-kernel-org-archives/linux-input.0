From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input : wacom_w8001 - report resolution to userland
Date: Mon, 31 Jan 2011 09:26:44 -0800
Message-ID: <20110131172643.GC31891@core.coreip.homeip.net>
References: <1296283062-20469-1-git-send-email-pinglinux@gmail.com>
 <20110131115014.GA5576@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56628 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab1AaR0x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Jan 2011 12:26:53 -0500
Received: by gxk9 with SMTP id 9so2087169gxk.19
        for <linux-input@vger.kernel.org>; Mon, 31 Jan 2011 09:26:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110131115014.GA5576@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Mon, Jan 31, 2011 at 12:50:14PM +0100, Henrik Rydberg wrote:
> Hi Ping,
> 
> On Fri, Jan 28, 2011 at 10:37:42PM -0800, Ping Cheng wrote:
> > Serial devices send both pen and touch data through the same logical
> > port. Since we scaled touch to pen maximum, we use pen resolution
> > for touch as well here.
> > 
> > This is under the assumption that pen and touch share the same physical
> > surface. In the case when a small physical dimensional difference occurs
> > between pen and touch, we assume the tolerance for touch point precision
> > is higher than pen and the difference is within touch point tolerance.
> > 
> > A per-MT tool based resolution mechanism should be introduced if the
> > above assumption does not hold true for the pen and touch devices any
> > more. A good candidate to resolve this issue without introducing design
> > change could be to report touch resolution through ABS_MT_POSITION_X/Y.
> 
> This still sounds a bit like mixing apples and oranges. If this case
> would ever happen, and I doubt it since the whole idea is to use
> different tools on the same surface, then splitting into separate
> devices would be appropriate.
> 
> > 
> > This version corrected an oversimplified if statement in v2.
> > 
> > Signed-off-by: Ping Cheng <pingc@wacom.com>
> > ---
> 
> >  drivers/input/touchscreen/wacom_w8001.c |   20 +++++++++++++++-----
> >  1 files changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
> > index 5cb8449..68dcca0 100644
> > --- a/drivers/input/touchscreen/wacom_w8001.c
> > +++ b/drivers/input/touchscreen/wacom_w8001.c
> > @@ -51,6 +51,10 @@ MODULE_LICENSE("GPL");
> >  #define W8001_PKTLEN_TPCCTL	11	/* control packet */
> >  #define W8001_PKTLEN_TOUCH2FG	13
> >  
> > +/* resolution in points/mm */
> > +#define W8001_PEN_RESOLUTION    100
> > +#define W8001_TOUCH_RESOLUTION  10
> > +
> >  struct w8001_coord {
> >  	u8 rdy;
> >  	u8 tsw;
> > @@ -198,7 +202,7 @@ static void parse_touchquery(u8 *data, struct w8001_touch_query *query)
> >  		query->y = 1024;
> >  		if (query->panel_res)
> >  			query->x = query->y = (1 << query->panel_res);
> > -		query->panel_res = 10;
> > +		query->panel_res = W8001_TOUCH_RESOLUTION;
> >  	}
> >  }
> >  
> > @@ -394,6 +398,8 @@ static int w8001_setup(struct w8001 *w8001)
> >  
> >  		input_set_abs_params(dev, ABS_X, 0, coord.x, 0, 0);
> >  		input_set_abs_params(dev, ABS_Y, 0, coord.y, 0, 0);
> > +		input_abs_set_res(dev, ABS_X, W8001_PEN_RESOLUTION);
> > +		input_abs_set_res(dev, ABS_Y, W8001_PEN_RESOLUTION);
> >  		input_set_abs_params(dev, ABS_PRESSURE, 0, coord.pen_pressure, 0, 0);
> >  		if (coord.tilt_x && coord.tilt_y) {
> >  			input_set_abs_params(dev, ABS_TILT_X, 0, coord.tilt_x, 0, 0);
> > @@ -418,15 +424,19 @@ static int w8001_setup(struct w8001 *w8001)
> >  		w8001->max_touch_x = touch.x;
> >  		w8001->max_touch_y = touch.y;
> 
> So max_touch is set here
> 
> >  
> > -		/* scale to pen maximum */
> > +		/* pen supported */
> >  		if (w8001->max_pen_x && w8001->max_pen_y) {
> > +			/* scale to pen maximum */
> >  			touch.x = w8001->max_pen_x;
> >  			touch.y = w8001->max_pen_y;
> 
> And possibly redefined here
> 
> > +		} else { /* touch only */
> > +			/* set axes with touch data */
> > +			input_set_abs_params(dev, ABS_X, 0, touch.x, 0, 0);
> > +			input_set_abs_params(dev, ABS_Y, 0, touch.y, 0, 0);
> > +			input_abs_set_res(dev, ABS_X, touch.panel_res);
> > +			input_abs_set_res(dev, ABS_Y, touch.panel_res);
> >  		}
> >  
> > -		input_set_abs_params(dev, ABS_X, 0, touch.x, 0, 0);
> > -		input_set_abs_params(dev, ABS_Y, 0, touch.y, 0, 0);
> > -
> >  		switch (touch.sensor_id) {
> >  		case 0:
> >  		case 2:
> 
> And then just used to set MT later on, which will lead to
> ABS_MT_POSITION_X values different from ABS_X. This is just getting
> messier. In fact, the whole setup function is messy, with unclear
> handling of error paths. Any chance one could simplify the logic
> involved here? It should be possible to use a single code path for
> input_set_abs_params() and input_abs_set_res(), for instance.
> 

I have the following for the resolution reporting:

Input: wacom_w8001 - report resolution to userland

From: Ping Cheng <pinglinux@gmail.com>

Serial devices send both pen and touch data through the same logical
port. Since we scaled touch to pen maximum, we use pen resolution
for touch as well here.

This is under the assumption that pen and touch share the same physical
surface. In the case when a small physical dimensional difference occurs
between pen and touch, we assume the tolerance for touch point precision
is higher than pen and the difference is within touch point tolerance.

A per-MT tool based resolution mechanism should be introduced if the
above assumption does not hold true for the pen and touch devices any
more.

Signed-off-by: Ping Cheng <pingc@wacom.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/wacom_w8001.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)


diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 5cb8449..c14412e 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -51,6 +51,10 @@ MODULE_LICENSE("GPL");
 #define W8001_PKTLEN_TPCCTL	11	/* control packet */
 #define W8001_PKTLEN_TOUCH2FG	13
 
+/* resolution in points/mm */
+#define W8001_PEN_RESOLUTION    100
+#define W8001_TOUCH_RESOLUTION  10
+
 struct w8001_coord {
 	u8 rdy;
 	u8 tsw;
@@ -198,7 +202,7 @@ static void parse_touchquery(u8 *data, struct w8001_touch_query *query)
 		query->y = 1024;
 		if (query->panel_res)
 			query->x = query->y = (1 << query->panel_res);
-		query->panel_res = 10;
+		query->panel_res = W8001_TOUCH_RESOLUTION;
 	}
 }
 
@@ -394,6 +398,8 @@ static int w8001_setup(struct w8001 *w8001)
 
 		input_set_abs_params(dev, ABS_X, 0, coord.x, 0, 0);
 		input_set_abs_params(dev, ABS_Y, 0, coord.y, 0, 0);
+		input_abs_set_res(dev, ABS_X, W8001_PEN_RESOLUTION);
+		input_abs_set_res(dev, ABS_Y, W8001_PEN_RESOLUTION);
 		input_set_abs_params(dev, ABS_PRESSURE, 0, coord.pen_pressure, 0, 0);
 		if (coord.tilt_x && coord.tilt_y) {
 			input_set_abs_params(dev, ABS_TILT_X, 0, coord.tilt_x, 0, 0);
@@ -418,14 +424,17 @@ static int w8001_setup(struct w8001 *w8001)
 		w8001->max_touch_x = touch.x;
 		w8001->max_touch_y = touch.y;
 
-		/* scale to pen maximum */
 		if (w8001->max_pen_x && w8001->max_pen_y) {
+			/* if pen is supported scale to pen maximum */
 			touch.x = w8001->max_pen_x;
 			touch.y = w8001->max_pen_y;
+			touch.panel_res = W8001_PEN_RESOLUTION;
 		}
 
 		input_set_abs_params(dev, ABS_X, 0, touch.x, 0, 0);
 		input_set_abs_params(dev, ABS_Y, 0, touch.y, 0, 0);
+		input_abs_set_res(dev, ABS_X, touch.panel_res);
+		input_abs_set_res(dev, ABS_Y, touch.panel_res);
 
 		switch (touch.sensor_id) {
 		case 0:
-- 
Dmitry
