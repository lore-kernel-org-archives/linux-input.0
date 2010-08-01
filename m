From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Sun, 01 Aug 2010 09:52:57 +0200
Message-ID: <4C5527D9.4080903@euromail.se>
References: <4C1FD2B0.1080504@tudelft.nl> <4C1FD454.4050807@tudelft.nl> <20100721033655.GA9070@core.coreip.homeip.net> <4C532009.4020103@tudelft.nl> <4C533DC3.9070001@euromail.se> <4C53471A.9080001@tudelft.nl> <4C53ECB4.2080700@euromail.se> <20100731093312.GA3461@core.coreip.homeip.net> <4C541BC3.9000100@euromail.se> <4C54AAFF.7000206@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:54204 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752125Ab0HAHxU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 1 Aug 2010 03:53:20 -0400
In-Reply-To: <4C54AAFF.7000206@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

On 08/01/2010 01:00 AM, =C9ric Piel wrote:

> Op 31-07-10 14:49, Henrik Rydberg schreef:
>> On 07/31/2010 11:33 AM, Dmitry Torokhov wrote:
>> [...]
>>
>>>> This sounds like a misunderstanding. To rephrase: the suggestion i=
s to always
>>>> send the last known one-finger touch point, and to update that poi=
nt only when
>>>> there is a single finger on the pad.
>>>>
>>>
>>> This would break two-finger scrolling mode of synaptics X driver.
>>
>>
>> I envision synaptics being MT-aware at some point, but alright, the =
idea is too
>> radical at this stage.
>>
>> Back to the original problem. When adding the second finger, the fir=
st finger
>> will actually be in one of the four corners of the detected rectangl=
e, correct?
>> So how about keeping as a state what corner of the rectangle represe=
nts the
>> original touch, and continue to report that corner as ABS_X/Y during=
 a
>> two-finger touch?
> That could work, but in general the policy is to not do finger tracki=
ng
> in the kernel. And still, if you leave this first finger before the
> second finger, you'll necessarily see this "jump" as well.


The difference being that all positions reported correspond to real fin=
gers.

The problem with this particular device is that it is more primitive th=
an type
A, so some method to produce correct MT information would be desirable.=
 Keeping
track of what corners of the rectangle correspond to fingers does not t=
ell which
finger is which (thus not finger tracking), but makes this device compl=
y with
type A, which is capable of detecting an unordered set of actual touch =
points.

Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
