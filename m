From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] CHROMIUM: Input: synaptics - filter out the events with
 low z values
Date: Wed, 22 Feb 2012 16:24:25 +0100
Message-ID: <20120222152425.GA29436@polaris.bitmath.org>
References: <1329896503-28394-1-git-send-email-cywang@chromium.org>
 <20120222083858.GA26570@polaris.bitmath.org>
 <CAGS+omCU9f=DyC442+4HOF=sGhZYXne+E2ephFiOmuj-XKciMA@mail.gmail.com>
 <20120222110459.GA28126@polaris.bitmath.org>
 <CAGS+omB0GCQHOjrb_T6h7DzHrH2sp4Xqb5av6JC-ttJ8HZ5BcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:46824 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259Ab2BVPYS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Feb 2012 10:24:18 -0500
Content-Disposition: inline
In-Reply-To: <CAGS+omB0GCQHOjrb_T6h7DzHrH2sp4Xqb5av6JC-ttJ8HZ5BcQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Chung-yih Wang <cywang@chromium.org>, Alessandro Rubini <rubini@ipvvis.unipv.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> > I see the problem. However, ignoring it will just move the problem
> > forward to another bug report, will it not? =A0Hysteresis is a slam=
 dunk
> > here. =A0In addition, since the low-pressure state is bound to be
> > transitional (soon to be followed by a real num_fingers=3D=3D1 pack=
age),
> > simply skipping such packages might be a better option.
>=20
> In practice, we don't actually see the profile sensor pad sending one
> low-z finger, and one high-z finger.  In the case where one finger is
> solidly on the pad, and another finger is hovering, lifting, or
> alighting, the pad sends 2 high-z fingers, with one of them having a
> completely wrong x or y coordinate.

Urgh.

> The two reported z-values are
> nearly, but not exactly, identical.  I can't think of good fix for
> this, other than adding finger tracking and filtering out via
> 'moved-too-far-too-fast', where possible, and I'd prefer that this be
> handled in userspace.

It sounds like the z value in the second packet carries zero
information. If that were true, the fact that the patch is effective
suggests the semi-mt slot reporting could follow BTN_TOUCH, more or
less.  In doing so, you would also obtain hysteresis automatically.

> The 1-low-z && 1-high-z case that we are
> discussing here isn't actually ever triggered; either both fingers ar=
e
> high-z, or neither are.

I suspect it depends a bit on the values of low-z and hi-z,
respectively? Otherwise, there really is no information in that extra
packet.

> The real usefulness of this patch is filtering out the 1-low-z-finger
> and 2-low-z fingers cases.
>=20
> As for the hypothetical 1-finger-hi, 1-finger-low case, which I asked
> Chung-yih to add because it seemed like a good idea in theory...
>=20
> Yes, I think you have a good point.  Thanks to evdev's stateful
> nature, simply skipping the (1-strong,1-weak) packet might actually
> work better than forcing num_fingers =3D=3D 0.
>=20
> For cases where a second finger is temporarily reporting low-z becaus=
e
> it is arriving or leaving, evdev would just lock the (1 or 2 initial)
> fingers in their current position until the transition is over, and
> then start reporting the new number of fingers at their new positions=
=2E
>=20
> For cases where there is one high-z finger, and a hovering thumb or
> palm triggers 2-finger reporting temporarily (without ever going abov=
e
> the threshold), the original finger will get frozen in its current
> position until the hovering finger is no longer detected, and then
> snap to its new position.  This might cause strange sudden jumps, but
> that seems unavoidable.

A lot of things seem unavoidable with this hardware. :-)

> I'm not sure hysteresis is a "slam dunk"...  in fact, I don't see how
> it would help much.  But, it is hard to argue against adding the
> functionality, since the hysteresis window can be made arbitrarily
> small.  Perhaps if you are inclined, you can elaborate on why you
> think it is important.

The most striking effect is the ability to better retain a
drag. Although the statement was made in light of possible
(1-strong,1-weak) packets, it should help in the 2-weak case too.

Thanks,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
