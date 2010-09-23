From: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>
Subject: RE: [PATCHv3] input: ROHM BU21013 touch panel controller support
Date: Thu, 23 Sep 2010 08:09:52 +0200
Message-ID: <81C3A93C17462B4BBD7E272753C1057918FC733DF6@EXDCVYMBSTM005.EQ1STM.local>
References: <1285060851-30173-1-git-send-email-naveen.gaddipati@stericsson.com>
 <4C9A490C.6020907@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:37486 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752293Ab0IWGK3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Sep 2010 02:10:29 -0400
In-Reply-To: <4C9A490C.6020907@euromail.se>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "tsoni@codeaurora.org" <tsoni@codeaurora.org>

Hi Henrik,

Thanks for your comments.

> -----Original Message-----
> From: Henrik Rydberg [mailto:rydberg@euromail.se]
> Sent: Wednesday, September 22, 2010 11:51 PM


> > +struct bu21013_ts_data {
> > +	struct i2c_client *client;
> > +	wait_queue_head_t wait;
> > +	bool touch_stopped;
> > +	const struct bu21013_platform_device *chip;
> > +	struct input_dev *in_dev;
> > +	unsigned int intr_pin;
> > +	signed short	x_pos[2];
> > +	signed short	y_pos[2];
> > +	bool previous_press_reported;
> 
> 
> The MT state here (x_pos, y_pos, previous_press_reported) could, in
> principle,
> be simplified away, since the type A protocol is stateless.
> 
> [...]

	What is type A protocol? Could you elaborate.

> > +static int bu21013_do_touch_report(struct bu21013_ts_data *data)


> > +	if (((number_of_active_x_sensors != 0) &&
> > +		(number_of_active_y_sensors == 0)) ||
> > +		((number_of_active_x_sensors == 0) &&
> > +		(number_of_active_y_sensors != 0)))
> > +		return 0;
> 
> 
> So these should really be completely ignored, not reported as touch up?
> Any
> chance the above is the last event seen before a period of no activity?
>
	This is the case one of x or y sensors is 0(when touch is not recognized properly),
	this should be ignored.
 
Thanks & Regards,
Naveen
