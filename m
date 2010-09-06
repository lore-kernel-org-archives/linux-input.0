From: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>
Subject: RE: input:rohm based bu21013 touch panel controller driver support
Date: Mon, 6 Sep 2010 06:59:42 +0200
Message-ID: <81C3A93C17462B4BBD7E272753C1057916DE769064@EXDCVYMBSTM005.EQ1STM.local>
References: <81C3A93C17462B4BBD7E272753C1057916DE6765F2@EXDCVYMBSTM005.EQ1STM.local>
 <20100901020427.GC23585@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:44734 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751123Ab0IFFAA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 6 Sep 2010 01:00:00 -0400
In-Reply-To: <20100901020427.GC23585@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

Hi Dmitry,

Thanks for your comments.

I have some questions about the following comments.

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Wednesday, September 01, 2010 7:34 AM
> To: Naveen Kumar GADDIPATI

> > +       input_report_abs(data->in_dev, ABS_X, pt0x);
> > +       input_report_abs(data->in_dev, ABS_Y, pt0y);
> > +       input_report_abs(data->in_dev, ABS_PRESSURE, 1);
> > +       input_report_abs(data->in_dev, ABS_TOOL_WIDTH, 1);
> 
> The device apparently does not provide pressure and contact size
> readings, please do not supply fake data.

	These values are required for android framework. If I remove the report of these values, 
	Android is not able to recognize the touch.

> > +       input_report_abs(data->in_dev, ABS_MT_TOUCH_MAJOR, 1);
> > +       input_report_abs(data->in_dev, ABS_MT_TOUCH_MINOR, 1);
> 
> Your device obviously does not provide contact size data so please do
> not fake it.

	These values are required for android framework. If I remove the report of these values, 
	Android is not able to recognize the touch.

> > +static void bu21013_touch_calc
> > +       (struct bu21013_ts_data *data, int x, int y, int count)
> > +{
> > +       data->x_pos[count] = x * data->factor_x / SCALE_FACTOR;
> > +       data->y_pos[count] = y * data->factor_y / SCALE_FACTOR;
> 
> Scaling should be done in userspace.

	In the controller configuration, we are using the 384 X 704 touch panel resolution.
	If we don't do the scaling in driver to display resolution, android framework is not getting exact co-ordinates.

> > +static bool bu21013_verify_delta(int x1, int y1, int x2, int y2)
> > +{
> > +       int delta_x, delta_y;
> > +       if ((x1 != 0) && (y1 != 0)) {
> > +               delta_x = x2 - x1;
> > +               if (x1 > x2)
> > +                       delta_x = x1 - x2;
> > +               delta_y = y2 - y1;
> > +               if (y1 > y2)
> > +                       delta_y = y1 - y2;
> > +               if ((delta_x < DELTA_MIN) || (delta_y < DELTA_MIN))
> > +                       return false;
> 
> If you specify "fuzz" for given axis I think input core will do this
> for
> you.
	What is fuzz?

> > +/**
> > + * bu21013_timer_callback() - callback handler for timer
> > + * @dev_data:touch screen data
> > + *
> > + * This timer callback handler used to schedule the work during
> > + * polling of pen down interrupts and returns none
> > + */
> > +static void bu21013_timer_callback(unsigned long dev_data)
> > +{
> > +       struct bu21013_ts_data *data = (struct bu21013_ts_data
> *)dev_data;
> > +       schedule_work(&data->timer_wq_handler);
> 
> This is called delayed_work().
> 
> However please consider switching to threaded IRQ - you can sleep in
> your IRQ handler until you are done and get "pen up" condition. You
> just
> need to make sure you exit the handler promptly when unbinding the
> device from the driver. See drivers/input/keyboard/samsung-keypad.c
> 
	This work queue is called during polling of co-ordinates
	when user is doing some dragging on touch panel for every certain
	amount of timeout. I think its ok.

Thanks & Regards,
Naveen
