From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/6] Fixes for ALPS trackstick
Date: Sun, 18 Jan 2015 10:47:06 +0100
Message-ID: <201501181047.06541@pali>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com> <201501171101.56430@pali> <20150118072245.GA35316@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1514724.PhK52qL1gJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:58618 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbbARJrJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Jan 2015 04:47:09 -0500
Received: by mail-wi0-f169.google.com with SMTP id bs8so11386238wib.0
        for <linux-input@vger.kernel.org>; Sun, 18 Jan 2015 01:47:08 -0800 (PST)
In-Reply-To: <20150118072245.GA35316@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, Vadim Klishko <vadim@cirque.com>

--nextPart1514724.PhK52qL1gJ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 18 January 2015 08:22:45 Dmitry Torokhov wrote:
> On Sat, Jan 17, 2015 at 11:01:56AM +0100, Pali Roh=C3=A1r wrote:
> > On Thursday 15 January 2015 22:02:16 Dmitry Torokhov wrote:
> > > On Thu, Jan 15, 2015 at 09:28:41PM +0100, Pali Roh=C3=A1r wrote:
> > > > On Thursday 15 January 2015 20:38:18 Dmitry Torokhov=20
wrote:
> > > > > On Thu, Jan 15, 2015 at 08:19:59PM +0100, Pali Roh=C3=A1r=20
wrote:
> > > > > > On Thursday 15 January 2015 19:18:20 Dmitry Torokhov
> >=20
> > wrote:
> > > > > > > On Thu, Jan 15, 2015 at 11:49:32AM +0100, Pali
> > > > > > > Roh=C3=A1r
> >=20
> > wrote:
> > > > > > > > On Wednesday 14 January 2015 23:55:48 Dmitry
> > > > > > > > Torokhov
> > > >=20
> > > > wrote:
> > > > > > > > > Hi Pali,
> > > > > > > > >=20
> > > > > > > > > This series try to address the issue you
> > > > > > > > > brought regarding trackstick initialization
> > > > > > > > > on Dell Latitudes in a different way than the
> > > > > > > > > patches you proposed. Basically in this
> > > > > > > > > series we move resetting and all detection in
> > > > > > > > > alps_detect() and make sure we keep the state
> > > > > > > > > so alps_init() can reuse it and not perform
> > > > > > > > > the detection all over again. Doing this
> > > > > > > > > allows us to set up device characteristics
> > > > > > > > > (name, version, etc) properly from the get go
> > > > > > > > > while still performing reset only once.
> > > > > > > > >=20
> > > > > > > > > This is untested as I do not have any ALPS
> > > > > > > > > devices anymore so I'd appreciate you giving
> > > > > > > > > it a spin.
> > > > > > > > >=20
> > > > > > > > > Thanks!
> > > > > > > >=20
> > > > > > > > Hi Dmitry,
> > > > > > > >=20
> > > > > > > > on top of which branch/repository should I apply
> > > > > > > > your patches?
> > > > > > >=20
> > > > > > > Should be applicable to my 'next' branch (which I
> > > > > > > just upreved to 3.19-rc4).
> > > > > > >=20
> > > > > > > Thanks.
> > > > > >=20
> > > > > > Not working at top of next (0c3e994).
> > > > > >=20
> > > > > > Applying: Input: ALPS - renumber protocol numbers
> > > > > > Applying: Input: ALPS - make Rushmore a separate
> > > > > > protocol error: patch failed:
> > > > > > drivers/input/mouse/alps.c:1275 error:
> > > > > > drivers/input/mouse/alps.c: patch does not apply
> > > > > > Patch failed at 0002 Input: ALPS - make Rushmore a
> > > > > > separate protocol
> > > > >=20
> > > > > Hmm.. I created a new alps branch (based on 3.19-rc4),
> > > > > can you try it?
> > > > >=20
> > > > > Thanks.
> > > >=20
> > > > Compiled from your new alps branch (with "if (!priv)"
> > > > fix) and modprobing psmouse.ko caused laptop freeze :-(
> > > > Even sysrq not responded. So something is not
> > > > working...
> > >=20
> > > Hmm, is it on text console or in X? Any chance you could
> > > go through pathes - there are only 8 of them including 2
> > > of yours that should be unmodified.
> > >=20
> > > Thanks.
> >=20
> > Hi, now I tested patch by patch and kernel crash is caused
> > only by last patch 6/6 and only after I touch touchpad or
> > trackstick.
> >=20
> > In text console it prints lot of panic messages and because
> > it prints lot of messages I cannot read (or record) more
> > then last.
> >=20
> > In last call trace I see that alps_register_bare_ps2_mouse()
> > was called and it generated page_fault.
>=20
> That happens because while you added priv->psmouse pointer it
> looks like you forgot to initialize it and I missed that
> too...
>=20

Right your patch 6/6 does not initialize priv->psmouse. I looked=20
into my original patch and it initialize it, so there was some
copy-paste error.

Look at other emails... can you fix problems and send new version=20
of your patches for testing?

> > I do not understand why that
> > function was ever called (I do not have connected any PS/2
> > mouse which can generate bare 3 bytes PS/2 packet) and also
> > why that function caused page fault.
>=20
> Hmm... my memory might be hazy but I seem to recall that
> trackstick data can come as either dedicated packets or bare
> PS/2 format, I am not sure if we can actually split the data
> streams into 2 devices.
>=20
> I do not have boxes with ALPS devices though so I am unable to
> experiment.
>=20
> Thanks.

=46rom documentation and also source code it looks like trackstick=20
data are reported in ALPS 6bytes packets and not in bare 3bytes.

3 months ago Vadim Klishko (CCed) wrote me:

"I don't think there is an Alps device that would mix 3-byte and=20
6-byte packets."

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1514724.PhK52qL1gJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlS7gRoACgkQi/DJPQPkQ1KjdgCgsZaP12k4kS1bGzbNaCQxe+KZ
ypoAoKgAT61IFEa1hX8I/xNfwE8t8og8
=wWsa
-----END PGP SIGNATURE-----

--nextPart1514724.PhK52qL1gJ--
