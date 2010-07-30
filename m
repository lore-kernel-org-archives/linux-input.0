From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Fri, 30 Jul 2010 23:41:46 +0200
Message-ID: <4C53471A.9080001@tudelft.nl>
References: <4C1FD2B0.1080504@tudelft.nl> <4C1FD454.4050807@tudelft.nl> <20100721033655.GA9070@core.coreip.homeip.net> <4C532009.4020103@tudelft.nl> <4C533DC3.9070001@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:39507 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab0G3Vlu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jul 2010 17:41:50 -0400
In-Reply-To: <4C533DC3.9070001@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

Op 30-07-10 23:01, Henrik Rydberg schreef:
> On 07/30/2010 08:55 PM, =C9ric Piel wrote:
:
>>> I am concerned what happens when you put one finger first and then =
add
>>> another one. Would not that couse the cursor to jump?
>=20
>=20
> I agree, I have seen this behavior before and it is not quite what yo=
u want. The
> average point does jump.
>=20
>>> I'd say we need to obey MT protocol and continue reporting the firs=
t
>>> contact in non-MT protocol and rely on MT-aware drivers to do bette=
r job
>>> of contact tracking. This is also consistent with how other drivers=
,
>>> such as bcm5974, report coordinates.
>> If the MT protocol says we should always report on the single-touch =
side
>> the first contact, then I guess it's better to do so. However, I've =
just
>> read the latest version of the mt-protocol document, and couldn't se=
e
>> anything saying that. Are you sure this is the official behavior? I'=
d
>> tend to think that single-touch and multi-touch are never read toget=
her,
>> so they can be different.
>=20
>=20
> It is true that there are no specific section on how to handle the AB=
S_X/Y
> events, and different drivers have slightly different strategies. How=
ever,
> common to them all is that a single finger is consistently used to re=
port the
> events.
Maybe it would be useful to add a paragraph to the mt-protocol document
about the relation with the single-touch events.

Well as an anecdote, on my old laptop with a single-touch synaptics
hardware, when I press 2 fingers, the average point is reported. That's
all in hardware, though so it probably doesn't count as a typical drive=
r
behaviour ;-)

>> More specifically, on this hardware, when there are two fingers, we =
get
>> only the lower coordinates and the higher coordinates, but we don't =
know
>> exactly where are the fingers. As there is no tracking, the lower
>> coordinate might be the second finger applied, so even if we report =
just
>> the lower coordinates, there is 75% chance that the cursor will jump=
=2E
>=20
>=20
> Perhaps it is better to not report ABS_X/Y at all in the case of two =
fingers on
> this trackpad. With any reasonable userspace driver, the ABS_X/Y will=
 be masked
> out anyways.
What do you mean? ABS_X/Y is still very useful, for example for gesture=
,
or to manage horizontal/vertical scrolling. In the xorg synaptics
driver, it's not used to move the cursor position, but it's definitely
not masked out!

>> That's actually the reason I prefer the average: it gives a 100%
>> expectable behavior (because the average is always correct). In
>> practice, when using the xorg synaptics driver, with the default
>> 2-fingers-scrolling mode, the cursor never jumps because as soon as =
the
>> second finger is applied, X and Y are not used to move the cursor.
>=20
>=20
> It is predictable, but it is still bad behavior. ;-)
:
I'm completely against not reporting the position with 2 fingers,
because definitely, users would lose some features. With 3 and 4
fingers, we report the lower coordinates (the only ones provided by the
hardware). So it'd be extremely weird not to report any for 2 fingers!

As a user, I enjoy better when the average is reported, because
whichever finger I move, I get a feedback, there is never a finger
"hidden" behind the other one. Nevertheless, if consistency matters,
let's just leave it as is.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
