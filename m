From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/5] Port hid-lg4ff to ff-memless-next
Date: Thu, 20 Feb 2014 16:16:52 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402201616270.1192@pobox.suse.cz>
References: <1602354.DiHhm9tiaI@geidi-prime> <63cea0aa616907d1186526ea155ff1d0.squirrel@mungewell.org> <CADbOyBSXKvRpTB-3NezDhFwggrD7i7qS9e6Aa4JWUe_BynVH3g@mail.gmail.com> <7140464.ckcuvrghVW@geidi-prime>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55356 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754954AbaBTPQ4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Feb 2014 10:16:56 -0500
In-Reply-To: <7140464.ckcuvrghVW@geidi-prime>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@prifuk.cz>
Cc: Simon Wood <simon@mungewell.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wed, 5 Feb 2014, Michal Mal=FD wrote:

> > > We need to think carefully on this as a '+10' combined with '-10'=
 force
> > > will result in '0'; however we do not want to deactivate the whee=
l
> > > (no-resistance mode) as this will result in 'ticking' on the whee=
l as
> > > force transitions through 0.... ideally we'd need to know that th=
ere are
> > > no forces set.
> >=20
> > No problem Simon, this is thought about:
> > If forces are active, and they cancel out, hid_lg4ff_start_combined=
 is
> > called with 0 force (scaled_x =3D 0x80), instead of hid_lg4ff_stop_=
combined
> > as you assumed.
>=20
> Okay, so to set things straight: I should modify to patch to send 0x1=
3 when=20
> the effect is fully stopped and use 0x11 0x80 to only zeroize the for=
ce when=20
> the overall force is zero? My DFP doesn't differentiate between these=
 states=20
> so I cannot tell what is the right thing to do.

Has there been any conclusion to this, please?

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
