From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Fri, 30 Jul 2010 20:55:05 +0200
Message-ID: <4C532009.4020103@tudelft.nl>
References: <4C1FD2B0.1080504@tudelft.nl> <4C1FD454.4050807@tudelft.nl> <20100721033655.GA9070@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:60242 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759226Ab0G3SzE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jul 2010 14:55:04 -0400
In-Reply-To: <20100721033655.GA9070@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>, Henrik Rydberg <rydberg@euromail.se>

On 21-07-10 05:36, Dmitry Torokhov wrote:
> On Mon, Jun 21, 2010 at 11:06:28PM +0200, =C9ric Piel wrote:
>> When 2 fingers are pressed, the low and high coordinates are given.
>> Instead of reporting just the low coordinate as the normal position,
>> report an average of both. This allow to have the cursor always move=
,
>> whichever finger moves. In practice, this improves the support of
>> two-fingers scolling with the synaptics X driver.
:
>> -		input_report_abs(dev, ABS_X, x1<<  2);
>> -		input_report_abs(dev, ABS_Y, y1<<  2);
>> +		input_report_abs(dev, ABS_X, (x1 + x2)<<  1);
>> +		input_report_abs(dev, ABS_Y, (y1 + y2)<<  1);
>
> I am concerned what happens when you put one finger first and then ad=
d
> another one. Would not that couse the cursor to jump?
>
> I'd say we need to obey MT protocol and continue reporting the first
> contact in non-MT protocol and rely on MT-aware drivers to do better =
job
> of contact tracking. This is also consistent with how other drivers,
> such as bcm5974, report coordinates.
If the MT protocol says we should always report on the single-touch sid=
e=20
the first contact, then I guess it's better to do so. However, I've jus=
t=20
read the latest version of the mt-protocol document, and couldn't see=20
anything saying that. Are you sure this is the official behavior? I'd=20
tend to think that single-touch and multi-touch are never read together=
,=20
so they can be different.

More specifically, on this hardware, when there are two fingers, we get=
=20
only the lower coordinates and the higher coordinates, but we don't kno=
w=20
exactly where are the fingers. As there is no tracking, the lower=20
coordinate might be the second finger applied, so even if we report jus=
t=20
the lower coordinates, there is 75% chance that the cursor will jump.

That's actually the reason I prefer the average: it gives a 100%=20
expectable behavior (because the average is always correct). In=20
practice, when using the xorg synaptics driver, with the default=20
2-fingers-scrolling mode, the cursor never jumps because as soon as the=
=20
second finger is applied, X and Y are not used to move the cursor.

So, I think this patch is an improvement for the user, but if you think=
=20
that it would not respect the MT protocol, just drop it.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
