From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCHv5] input: ROHM BU21013 touch panel controller support
Date: Mon, 04 Oct 2010 08:33:41 +0200
Message-ID: <4CA97545.70103@euromail.se>
References: <1285930790-2206-1-git-send-email-naveen.gaddipati@stericsson.com> <4CA6D028.7090102@euromail.se> <81C3A93C17462B4BBD7E272753C1057919238FA5CA@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:41744 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752382Ab0JDGd7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Oct 2010 02:33:59 -0400
In-Reply-To: <81C3A93C17462B4BBD7E272753C1057919238FA5CA@EXDCVYMBSTM005.EQ1STM.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "tsoni@codeaurora.org" <tsoni@codeaurora.org>

On 10/04/2010 07:15 AM, Naveen Kumar GADDIPATI wrote:
[...]
>>> +	has_x_sensors = hweight32(buf[0] & BU21013_SENSORS_EN_0_7);

>>> +	has_y_sensors = hweight32(((buf[1] & BU21013_SENSORS_EN_8_15) |
>>> +		((buf[2] & BU21013_SENSORS_EN_16_23) << SHIFT_8)) >>
>> SHIFT_2);
>>
>>
>> The bitcounting hweight32 can actually be removed here.
>>
> 	This register values of touch controller used to know the valid touch.
> 	Otherwise we need do the calculate the co-ordinates and then decide to ignore.

>  
>>> +	if (!has_x_sensors || !has_y_sensors)
>>> +		return 0;


Testing whether x == 0 or number_of_set_bits(x) == 0 seems pretty equivalent to me.

> 
>>> +
>>> +	input_set_abs_params(in_dev, ABS_MT_POSITION_X, 0,
>>> +						pdata->x_max_res, 0, 0);
>>> +	input_set_abs_params(in_dev, ABS_MT_POSITION_Y, 0,
>>> +						pdata->y_max_res, 0, 0);
>>> +	input_set_abs_params(in_dev, ABS_MT_TOUCH_MAJOR, 0,
>>> +			max(pdata->x_max_res , pdata->y_max_res), 0, 0);
>>
>>
>> Same here - no ABS_MT_TOUCH_MAJOR, please.
>>
> 	According to MT documentation, we need to report this value.
> 	We observe without this value reporting in Pen down case, Android framework is not recognizing the touch.


The touch_major requirement was relaxed during 2009, after discussions. This
makes me wonder if the driver has been tested against 2.6.36. What is the base
version of that Android kernel, 2.6.29?

Henrik
