From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Sat, 31 Jul 2010 11:28:20 +0200
Message-ID: <4C53ECB4.2080700@euromail.se>
References: <4C1FD2B0.1080504@tudelft.nl> <4C1FD454.4050807@tudelft.nl> <20100721033655.GA9070@core.coreip.homeip.net> <4C532009.4020103@tudelft.nl> <4C533DC3.9070001@euromail.se> <4C53471A.9080001@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:51637 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753264Ab0GaJ2b (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jul 2010 05:28:31 -0400
In-Reply-To: <4C53471A.9080001@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

On 07/30/2010 11:41 PM, =C9ric Piel wrote:

[...]

>> It is true that there are no specific section on how to handle the A=
BS_X/Y

>> events, and different drivers have slightly different strategies. Ho=
wever,
>> common to them all is that a single finger is consistently used to r=
eport the
>> events.
> Maybe it would be useful to add a paragraph to the mt-protocol docume=
nt
> about the relation with the single-touch events.


Indeed.

> Well as an anecdote, on my old laptop with a single-touch synaptics
> hardware, when I press 2 fingers, the average point is reported. That=
's
> all in hardware, though so it probably doesn't count as a typical dri=
ver
> behaviour ;-)


Those devices have no other information to report.

>>> More specifically, on this hardware, when there are two fingers, we=
 get

>>> only the lower coordinates and the higher coordinates, but we don't=
 know
>>> exactly where are the fingers. As there is no tracking, the lower
>>> coordinate might be the second finger applied, so even if we report=
 just
>>> the lower coordinates, there is 75% chance that the cursor will jum=
p.
>>
>>
>> Perhaps it is better to not report ABS_X/Y at all in the case of two=
 fingers on
>> this trackpad. With any reasonable userspace driver, the ABS_X/Y wil=
l be masked
>> out anyways.
> What do you mean? ABS_X/Y is still very useful, for example for gestu=
re,
> or to manage horizontal/vertical scrolling. In the xorg synaptics
> driver, it's not used to move the cursor position, but it's definitel=
y
> not masked out!


Maybe the idea sounds radical, but there is a rationale.

The semantics of ABS_X/Y is a singular, well-defined point. In the trac=
kpad
case, the movement of that point is used to guide a pointer on screen, =
but there
are other scenarios.

In the presence of multiple touch points, both ABS_X/Y and the pointer =
are
ill-defined. This simple fact has far-reaching implications; in Xorg la=
nd, there
is a whole new input protocol cooking to deal with it. For all practica=
l
purposes, the traditional ABS_X/Y point has no meaning in the multitouc=
h case.

Instead of extending the semantics of ABS_X/Y, one could simply omit th=
e event
during a multi-finger touch. In practice, this would most likely confus=
e some
applications. Sending the last known one-finger touch point should be l=
ess
confusing. Not quite equivalent, but close enough.

>>> That's actually the reason I prefer the average: it gives a 100%
>>> expectable behavior (because the average is always correct). In
>>> practice, when using the xorg synaptics driver, with the default
>>> 2-fingers-scrolling mode, the cursor never jumps because as soon as=
 the
>>> second finger is applied, X and Y are not used to move the cursor.
>>
>>
>> It is predictable, but it is still bad behavior. ;-)
> :
> I'm completely against not reporting the position with 2 fingers,
> because definitely, users would lose some features. With 3 and 4
> fingers, we report the lower coordinates (the only ones provided by t=
he
> hardware). So it'd be extremely weird not to report any for 2 fingers=
!


This sounds like a misunderstanding. To rephrase: the suggestion is to =
always
send the last known one-finger touch point, and to update that point on=
ly when
there is a single finger on the pad.


> As a user, I enjoy better when the average is reported, because
> whichever finger I move, I get a feedback, there is never a finger
> "hidden" behind the other one. Nevertheless, if consistency matters,
> let's just leave it as is.


This behavior can be created in userland using the MT touch points, if =
so preferred.

Thanks,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
