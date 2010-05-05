From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 2/2] elantech: Report multitouch with proper ABS_MT messages
Date: Wed, 05 May 2010 20:14:45 +0200
Message-ID: <4BE1B595.9090705@tudelft.nl>
References: <4BE1629E.50901@tudelft.nl> <20100505163832.GA7337@core.coreip.homeip.net> <4BE1B289.2040204@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:53196 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757352Ab0EESOs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 14:14:48 -0400
In-Reply-To: <4BE1B289.2040204@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Op 05-05-10 20:01, Henrik Rydberg schreef:
> Dmitry Torokhov wrote:
>>> @@ -253,7 +253,6 @@ static void elantech_report_absolute_v2(struct psmouse *psmouse)
>>>  
>>>  	/* byte 0: n1  n0   .   .   .   .   R   L */
>>>  	fingers = (packet[0] & 0xc0) >> 6;
>>> -	input_report_key(dev, BTN_TOUCH, fingers != 0);
>>
>> Mousedev works a tad better if BTN_TOUCH is reported first. Otherwise
>> looks good.
>>
>> Henrik, should we report "tool width" as ABS_MT_WIDTH_MAJOR?
> 
> I might be missing some context here, I see no prior use of width in the driver.
> The answer is either ABS_MT_TOUCH_MAJOR or ABS_MT_WIDTH_MAJOR depending on how
> the width is actually computed. Generally, it makes little sense to have
> ABS_MT_WIDTH_MAJOR (width of approaching finger) without ABS_MT_TOUCH_MAJOR
> (width of touching finger), but it is ok to have only ABS_MT_TOUCH_MAJOR. Things
> like thumb detection requires both values to be reliable.
Ok, so it seems in this case, ABS_MT_TOUCH_MAJOR is the most
appropriate... if we care at all.

Let me give you some more details. From what is seems, the hardware can
reports the width of a touch, but only when there is one single touch.
So far we report it via ABS_TOOL_WIDTH. When there is 2 or 3 touches,
the width is unknown. So the precise question is:
Should we report also ABS_MT_TOUCH_MAJOR in addition to ABS_TOOL_WIDTH,
whenever it is known (ie: one finger), or just not bother and only
report ABS_TOOL_WIDTH?

Eric
