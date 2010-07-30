From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Fri, 30 Jul 2010 23:01:55 +0200
Message-ID: <4C533DC3.9070001@euromail.se>
References: <4C1FD2B0.1080504@tudelft.nl> <4C1FD454.4050807@tudelft.nl> <20100721033655.GA9070@core.coreip.homeip.net> <4C532009.4020103@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:54451 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753279Ab0G3VCe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jul 2010 17:02:34 -0400
In-Reply-To: <4C532009.4020103@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

On 07/30/2010 08:55 PM, =C9ric Piel wrote:

> On 21-07-10 05:36, Dmitry Torokhov wrote:
>> On Mon, Jun 21, 2010 at 11:06:28PM +0200, =C9ric Piel wrote:
>>> When 2 fingers are pressed, the low and high coordinates are given.
>>> Instead of reporting just the low coordinate as the normal position=
,
>>> report an average of both. This allow to have the cursor always mov=
e,
>>> whichever finger moves. In practice, this improves the support of
>>> two-fingers scolling with the synaptics X driver.
> :
>>> -        input_report_abs(dev, ABS_X, x1<<  2);
>>> -        input_report_abs(dev, ABS_Y, y1<<  2);
>>> +        input_report_abs(dev, ABS_X, (x1 + x2)<<  1);
>>> +        input_report_abs(dev, ABS_Y, (y1 + y2)<<  1);
>>
>> I am concerned what happens when you put one finger first and then a=
dd
>> another one. Would not that couse the cursor to jump?


I agree, I have seen this behavior before and it is not quite what you =
want. The
average point does jump.

>> I'd say we need to obey MT protocol and continue reporting the first
>> contact in non-MT protocol and rely on MT-aware drivers to do better=
 job
>> of contact tracking. This is also consistent with how other drivers,
>> such as bcm5974, report coordinates.
> If the MT protocol says we should always report on the single-touch s=
ide
> the first contact, then I guess it's better to do so. However, I've j=
ust
> read the latest version of the mt-protocol document, and couldn't see
> anything saying that. Are you sure this is the official behavior? I'd
> tend to think that single-touch and multi-touch are never read togeth=
er,
> so they can be different.


It is true that there are no specific section on how to handle the ABS_=
X/Y
events, and different drivers have slightly different strategies. Howev=
er,
common to them all is that a single finger is consistently used to repo=
rt the
events.

> More specifically, on this hardware, when there are two fingers, we g=
et
> only the lower coordinates and the higher coordinates, but we don't k=
now
> exactly where are the fingers. As there is no tracking, the lower
> coordinate might be the second finger applied, so even if we report j=
ust
> the lower coordinates, there is 75% chance that the cursor will jump.


Perhaps it is better to not report ABS_X/Y at all in the case of two fi=
ngers on
this trackpad. With any reasonable userspace driver, the ABS_X/Y will b=
e masked
out anyways.

> That's actually the reason I prefer the average: it gives a 100%
> expectable behavior (because the average is always correct). In
> practice, when using the xorg synaptics driver, with the default
> 2-fingers-scrolling mode, the cursor never jumps because as soon as t=
he
> second finger is applied, X and Y are not used to move the cursor.


It is predictable, but it is still bad behavior. ;-)

> So, I think this patch is an improvement for the user, but if you thi=
nk
> that it would not respect the MT protocol, just drop it.


Either dropping the patch or muting ABS_X/Y in case of multiple fingers=
 is what
I would recommend.

Cheers,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
