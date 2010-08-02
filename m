From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Mon, 2 Aug 2010 09:39:13 -0700
Message-ID: <20100802163913.GB3276@core.coreip.homeip.net>
References: <4C567F27.7070900@tudelft.nl>
 <4C5697C4.1020801@euromail.se>
 <4C56A81E.3040703@tudelft.nl>
 <4C56AA67.8000902@euromail.se>
 <4C56AD12.1080106@tudelft.nl>
 <4C56B00B.50204@euromail.se>
 <4C56B686.60606@tudelft.nl>
 <4C56BA13.3030104@euromail.se>
 <4C56BE30.2070807@tudelft.nl>
 <4C56C213.2010605@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36447 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab0HBQjT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Aug 2010 12:39:19 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so1403798pzk.19
        for <linux-input@vger.kernel.org>; Mon, 02 Aug 2010 09:39:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C56C213.2010605@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>, Chris Bagwell <chris@cnpbagwell.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

On Mon, Aug 02, 2010 at 03:03:15PM +0200, Henrik Rydberg wrote:
> On 08/02/2010 02:46 PM, =C9ric Piel wrote:
>=20
> [...]
>=20
> >>
> >> We can do better in the sense that since the device cannot comply =
with MT-A, we
> >> can do as close as possible to MT-B with less cpu usage. But frank=
ly, the best
> >> solution at this stage seems to be to drop MT handling altogether,=
 since there
> >> does not seem to be any plan to use it.
> > Ah, this alternative solution is a bit boring ;-) In addition it's =
not
> > compatible with my own master plan to eventually have the "pinch to
> > zoom" and "rotate to rotate" gestures work on my laptop, like in Wi=
ndows ;-)
>=20
>=20
> Since rotational symmetry is what prevents us from implementing prope=
r MT
> support, it is not likely going to work anyways.
>=20

Not work at all or not work as good as with other devices? "Not as good=
"
is still OK, hardware is different and we have to make the best of it.
The same elantech does not export pressure (at lest the version in
mainline does not) and thus users are unable to adjust sensitivity.
Still the device is useable with Synaptics X.

> > So, let's agree on just the two patches I'm going to send to suppor=
t
> > "better than nothing" MT-protocol for now. When, later, someone has
> > better ideas, he can send patches to improve MT-protocol
> > support/compliance. Fine?
>=20
>=20
> No. I think it is fair to say we tried to make it work properly, but =
the (known)
> information about the device is simply not enough. As long as MT does=
 not work
> properly, there is no point in adding it at all - in particular not a=
n elaborate
> solution. I can see that zoom would work even with a poor MT implemen=
tation, but
> that is not what the MT protocol is about. Maybe one day someone will=
 find the
> missing information somewhere in the packets.
>=20
> For your usecase, perhaps one should add ABS_ZOOM etcetera instead, a=
nd patch up
> synaptics to use those values.

No, I do not believe that this is the direcion we should be taking. I'd
prefer we export as much information as we can for MT to be useful. And
if we discover some missing pieces in proocol (or future firmware
revisioons will be smarter) we can improve MT support.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
