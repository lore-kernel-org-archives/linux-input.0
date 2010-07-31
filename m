From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Sat, 31 Jul 2010 02:33:12 -0700
Message-ID: <20100731093312.GA3461@core.coreip.homeip.net>
References: <4C1FD2B0.1080504@tudelft.nl>
 <4C1FD454.4050807@tudelft.nl>
 <20100721033655.GA9070@core.coreip.homeip.net>
 <4C532009.4020103@tudelft.nl>
 <4C533DC3.9070001@euromail.se>
 <4C53471A.9080001@tudelft.nl>
 <4C53ECB4.2080700@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58196 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091Ab0GaJdQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jul 2010 05:33:16 -0400
Received: by pwi5 with SMTP id 5so831449pwi.19
        for <linux-input@vger.kernel.org>; Sat, 31 Jul 2010 02:33:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C53ECB4.2080700@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

On Sat, Jul 31, 2010 at 11:28:20AM +0200, Henrik Rydberg wrote:
> On 07/30/2010 11:41 PM, =C9ric Piel wrote:
>=20
> [...]
>=20
> >> It is true that there are no specific section on how to handle the=
 ABS_X/Y
>=20
> >> events, and different drivers have slightly different strategies. =
However,
> >> common to them all is that a single finger is consistently used to=
 report the
> >> events.
> > Maybe it would be useful to add a paragraph to the mt-protocol docu=
ment
> > about the relation with the single-touch events.
>=20
>=20
> Indeed.
>=20
> > Well as an anecdote, on my old laptop with a single-touch synaptics
> > hardware, when I press 2 fingers, the average point is reported. Th=
at's
> > all in hardware, though so it probably doesn't count as a typical d=
river
> > behaviour ;-)
>=20
>=20
> Those devices have no other information to report.
>=20
> >>> More specifically, on this hardware, when there are two fingers, =
we get
>=20
> >>> only the lower coordinates and the higher coordinates, but we don=
't know
> >>> exactly where are the fingers. As there is no tracking, the lower
> >>> coordinate might be the second finger applied, so even if we repo=
rt just
> >>> the lower coordinates, there is 75% chance that the cursor will j=
ump.
> >>
> >>
> >> Perhaps it is better to not report ABS_X/Y at all in the case of t=
wo fingers on
> >> this trackpad. With any reasonable userspace driver, the ABS_X/Y w=
ill be masked
> >> out anyways.
> > What do you mean? ABS_X/Y is still very useful, for example for ges=
ture,
> > or to manage horizontal/vertical scrolling. In the xorg synaptics
> > driver, it's not used to move the cursor position, but it's definit=
ely
> > not masked out!
>=20
>=20
> Maybe the idea sounds radical, but there is a rationale.
>=20
> The semantics of ABS_X/Y is a singular, well-defined point. In the tr=
ackpad
> case, the movement of that point is used to guide a pointer on screen=
, but there
> are other scenarios.
>=20
> In the presence of multiple touch points, both ABS_X/Y and the pointe=
r are
> ill-defined. This simple fact has far-reaching implications; in Xorg =
land, there
> is a whole new input protocol cooking to deal with it. For all practi=
cal
> purposes, the traditional ABS_X/Y point has no meaning in the multito=
uch case.
>=20
> Instead of extending the semantics of ABS_X/Y, one could simply omit =
the event
> during a multi-finger touch. In practice, this would most likely conf=
use some
> applications. Sending the last known one-finger touch point should be=
 less
> confusing. Not quite equivalent, but close enough.
>=20
> >>> That's actually the reason I prefer the average: it gives a 100%
> >>> expectable behavior (because the average is always correct). In
> >>> practice, when using the xorg synaptics driver, with the default
> >>> 2-fingers-scrolling mode, the cursor never jumps because as soon =
as the
> >>> second finger is applied, X and Y are not used to move the cursor=
=2E
> >>
> >>
> >> It is predictable, but it is still bad behavior. ;-)
> > :
> > I'm completely against not reporting the position with 2 fingers,
> > because definitely, users would lose some features. With 3 and 4
> > fingers, we report the lower coordinates (the only ones provided by=
 the
> > hardware). So it'd be extremely weird not to report any for 2 finge=
rs!
>=20
>=20
> This sounds like a misunderstanding. To rephrase: the suggestion is t=
o always
> send the last known one-finger touch point, and to update that point =
only when
> there is a single finger on the pad.
>=20

This would break two-finger scrolling mode of synaptics X driver.

>=20
> > As a user, I enjoy better when the average is reported, because
> > whichever finger I move, I get a feedback, there is never a finger
> > "hidden" behind the other one. Nevertheless, if consistency matters=
,
> > let's just leave it as is.
>=20
>=20
> This behavior can be created in userland using the MT touch points, i=
f so preferred.
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
