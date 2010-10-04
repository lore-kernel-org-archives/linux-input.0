From: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>
Subject: RE: [PATCHv5] input: ROHM BU21013 touch panel controller support
Date: Mon, 4 Oct 2010 07:15:31 +0200
Message-ID: <81C3A93C17462B4BBD7E272753C1057919238FA5CA@EXDCVYMBSTM005.EQ1STM.local>
References: <1285930790-2206-1-git-send-email-naveen.gaddipati@stericsson.com>
 <4CA6D028.7090102@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:36808 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751738Ab0JDFP7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Oct 2010 01:15:59 -0400
In-Reply-To: <4CA6D028.7090102@euromail.se>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "tsoni@codeaurora.org" <tsoni@codeaurora.org>

Hi Henrik,

> -----Original Message-----
> From: Henrik Rydberg [mailto:rydberg@euromail.se]
> Sent: Saturday, October 02, 2010 11:55 AM


> > +	has_x_sensors = hweight32(buf[0] & BU21013_SENSORS_EN_0_7);
> > +	has_y_sensors = hweight32(((buf[1] & BU21013_SENSORS_EN_8_15) |
> > +		((buf[2] & BU21013_SENSORS_EN_16_23) << SHIFT_8)) >>
> SHIFT_2);
> 
> 
> The bitcounting hweight32 can actually be removed here.
>
	This register values of touch controller used to know the valid touch.
	Otherwise we need do the calculate the co-ordinates and then decide to ignore.
 
> > +	if (!has_x_sensors || !has_y_sensors)
> > +		return 0;
> > +
> > +	for (i = 0; i < MAX_FINGERS; i++) {
> > +		const u8 *p = &buf[4 * i + 3];
> > +		unsigned int x = p[0] << SHIFT_2 | (p[1] & MASK_BITS);
> > +		unsigned int y = p[2] << SHIFT_2 | (p[3] & MASK_BITS);
> > +		if (x == 0 || y == 0)
> > +			continue;
> > +		pos_x[finger_down_count] = x;
> > +		pos_y[finger_down_count] = y;
> > +		finger_down_count++;
> > +	}


> > +
> > +	input_set_abs_params(in_dev, ABS_MT_POSITION_X, 0,
> > +						pdata->x_max_res, 0, 0);
> > +	input_set_abs_params(in_dev, ABS_MT_POSITION_Y, 0,
> > +						pdata->y_max_res, 0, 0);
> > +	input_set_abs_params(in_dev, ABS_MT_TOUCH_MAJOR, 0,
> > +			max(pdata->x_max_res , pdata->y_max_res), 0, 0);
> 
> 
> Same here - no ABS_MT_TOUCH_MAJOR, please.
>
	According to MT documentation, we need to report this value.
	We observe without this value reporting in Pen down case, Android framework is not recognizing the touch.

Thanks & Regards,
Naveen
