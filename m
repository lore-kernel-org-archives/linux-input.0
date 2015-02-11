From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/6] Fixes for ALPS trackstick
Date: Wed, 11 Feb 2015 19:13:44 +0100
Message-ID: <201502111913.44537@pali>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com> <201502081326.32877@pali> <20150210063255.GA31045@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2123368.LPR9lzW4PV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:46216 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbbBKSNr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Feb 2015 13:13:47 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so5823945wid.5
        for <linux-input@vger.kernel.org>; Wed, 11 Feb 2015 10:13:46 -0800 (PST)
In-Reply-To: <20150210063255.GA31045@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, Vadim Klishko <vadim@cirque.com>

--nextPart2123368.LPR9lzW4PV
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 10 February 2015 07:32:55 Dmitry Torokhov wrote:
> On Sun, Feb 08, 2015 at 01:26:32PM +0100, Pali Roh=C3=A1r wrote:
> > On Monday 02 February 2015 15:27:55 Pali Roh=C3=A1r wrote:
> > > On Monday 02 February 2015 11:49:58 Pali Roh=C3=A1r wrote:
> > > > On Monday 02 February 2015 06:49:31 Dmitry Torokhov=20
wrote:
> > > > > On Sun, Jan 18, 2015 at 10:47:06AM +0100, Pali Roh=C3=A1r=20
wrote:
> > > > > > On Sunday 18 January 2015 08:22:45 Dmitry Torokhov=20
wrote:
> > > > > > > On Sat, Jan 17, 2015 at 11:01:56AM +0100, Pali
> > > > > > > Roh=C3=A1r
> >=20
> > wrote:
> > > > > > > > On Thursday 15 January 2015 22:02:16 Dmitry
> > > > > > > > Torokhov
> > > >=20
> > > > wrote:
> > > > > > > > > On Thu, Jan 15, 2015 at 09:28:41PM +0100, Pali
> > > > > > > > > Roh=C3=A1r
> > > >=20
> > > > wrote:
> > > > > > > > > > On Thursday 15 January 2015 20:38:18 Dmitry
> > > > > > > > > > Torokhov
> > > > > >=20
> > > > > > wrote:
> > > > > > > > > > > On Thu, Jan 15, 2015 at 08:19:59PM +0100,
> > > > > > > > > > > Pali Roh=C3=A1r
> > > > > >=20
> > > > > > wrote:
> > > > > > > > > > > > On Thursday 15 January 2015 19:18:20
> > > > > > > > > > > > Dmitry Torokhov
> > > > > > > >=20
> > > > > > > > wrote:
> > > > > > > > > > > > > On Thu, Jan 15, 2015 at 11:49:32AM
> > > > > > > > > > > > > +0100, Pali Roh=C3=A1r
> > > > > > > >=20
> > > > > > > > wrote:
> > > > > > > > > > > > > > On Wednesday 14 January 2015
> > > > > > > > > > > > > > 23:55:48 Dmitry Torokhov
> > > > > > > > > >=20
> > > > > > > > > > wrote:
> > > > > > > > > > > > > > > Hi Pali,
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > This series try to address the
> > > > > > > > > > > > > > > issue you brought regarding
> > > > > > > > > > > > > > > trackstick initialization on Dell
> > > > > > > > > > > > > > > Latitudes in a different way than
> > > > > > > > > > > > > > > the patches you proposed.
> > > > > > > > > > > > > > > Basically in this series we move
> > > > > > > > > > > > > > > resetting and all detection in
> > > > > > > > > > > > > > > alps_detect() and make sure we
> > > > > > > > > > > > > > > keep the state so alps_init() can
> > > > > > > > > > > > > > > reuse it and not perform the
> > > > > > > > > > > > > > > detection all over again. Doing
> > > > > > > > > > > > > > > this allows us to set up device
> > > > > > > > > > > > > > > characteristics (name, version,
> > > > > > > > > > > > > > > etc) properly from the get go
> > > > > > > > > > > > > > > while still performing reset only
> > > > > > > > > > > > > > > once.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > This is untested as I do not have
> > > > > > > > > > > > > > > any ALPS devices anymore so I'd
> > > > > > > > > > > > > > > appreciate you giving it a spin.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Thanks!
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Hi Dmitry,
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > on top of which branch/repository
> > > > > > > > > > > > > > should I apply your patches?
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Should be applicable to my 'next'
> > > > > > > > > > > > > branch (which I just upreved to
> > > > > > > > > > > > > 3.19-rc4).
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Thanks.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Not working at top of next (0c3e994).
> > > > > > > > > > > >=20
> > > > > > > > > > > > Applying: Input: ALPS - renumber
> > > > > > > > > > > > protocol numbers Applying: Input: ALPS
> > > > > > > > > > > > - make Rushmore a separate protocol
> > > > > > > > > > > > error: patch failed:
> > > > > > > > > > > > drivers/input/mouse/alps.c:1275 error:
> > > > > > > > > > > > drivers/input/mouse/alps.c: patch does
> > > > > > > > > > > > not apply Patch failed at 0002 Input:
> > > > > > > > > > > > ALPS - make Rushmore a separate
> > > > > > > > > > > > protocol
> > > > > > > > > > >=20
> > > > > > > > > > > Hmm.. I created a new alps branch (based
> > > > > > > > > > > on 3.19-rc4), can you try it?
> > > > > > > > > > >=20
> > > > > > > > > > > Thanks.
> > > > > > > > > >=20
> > > > > > > > > > Compiled from your new alps branch (with "if
> > > > > > > > > > (!priv)" fix) and modprobing psmouse.ko
> > > > > > > > > > caused laptop freeze :-( Even sysrq not
> > > > > > > > > > responded. So something is not working...
> > > > > > > > >=20
> > > > > > > > > Hmm, is it on text console or in X? Any chance
> > > > > > > > > you could go through pathes - there are only
> > > > > > > > > 8 of them including 2 of yours that should be
> > > > > > > > > unmodified.
> > > > > > > > >=20
> > > > > > > > > Thanks.
> > > > > > > >=20
> > > > > > > > Hi, now I tested patch by patch and kernel crash
> > > > > > > > is caused only by last patch 6/6 and only after
> > > > > > > > I touch touchpad or trackstick.
> > > > > > > >=20
> > > > > > > > In text console it prints lot of panic messages
> > > > > > > > and because it prints lot of messages I cannot
> > > > > > > > read (or record) more then last.
> > > > > > > >=20
> > > > > > > > In last call trace I see that
> > > > > > > > alps_register_bare_ps2_mouse() was called and it
> > > > > > > > generated page_fault.
> > > > > > >=20
> > > > > > > That happens because while you added priv->psmouse
> > > > > > > pointer it looks like you forgot to initialize it
> > > > > > > and I missed that too...
> > > > > >=20
> > > > > > Right your patch 6/6 does not initialize
> > > > > > priv->psmouse. I looked into my original patch and
> > > > > > it initialize it, so there was some copy-paste
> > > > > > error.
> > > > > >=20
> > > > > > Look at other emails... can you fix problems and
> > > > > > send new version of your patches for testing?
> > > > >=20
> > > > > I think I did. Can you please take another look at my
> > > > > alps branch?
> > > > >=20
> > > > > Thanks!
> > > >=20
> > > > Now I tried it. It does not crash anymore which is good.
> > > > But it does not working. Driver alsp.c receive only
> > > > bare PS/2 packets, not 6 bites ALPS packets. So ALPS
> > > > touchpad is not properly initialized and so is in
> > > > "legacy" mode when it act as genetic mouse. And events
> > > > are sent via dev3 device (that PS/2 mouse).
> > > >=20
> > > > So your patches do not initialize my ALPS touchpad
> > > > correctly.
> > >=20
> > > Hello Dmitry, I found where is problem.
> > >=20
> > > This chunk is needed:
> > >=20
> > > @@ -135,7 +135,7 @@ static const struct alps_protocol_info
> > > alps_v3_protocol_data =3D { };
> > >=20
> > >  static const struct alps_protocol_info
> > >  alps_v3_rushmore_data
> > >=20
> > > =3D { -	ALPS_PROTO_V3, 0x8f, 0x8f, ALPS_DUALPOINT
> > > +	ALPS_PROTO_V3_RUSHMORE, 0x8f, 0x8f, ALPS_DUALPOINT
> > >=20
> > >  };
> > > =20
> > >  static const struct alps_protocol_info
> > >  alps_v5_protocol_data
> > >=20
> > > =3D {
> > >=20
> > > because rushmore is now separate protocol.
> > >=20
> > > And maybe also these two chunks are needed too:
> > >=20
> > > @@ -663,7 +696,8 @@ static void
> > > alps_process_touchpad_packet_v3_v5(struct psmouse
> > > *psmouse) */
> > >=20
> > >  		if (f->is_mp) {
> > >  	=09
> > >  			fingers =3D f->fingers;
> > >=20
> > > -			if (priv->proto_version =3D=3D ALPS_PROTO_V3) {
> > > +			if (priv->proto_version =3D=3D ALPS_PROTO_V3 ||
> > > +			    priv->proto_version =3D=3D=20
ALPS_PROTO_V3_RUSHMORE) {
> > >=20
> > >  				if (alps_process_bitmap(priv, f) =3D=3D 0)
> > >  			=09
> > >  					fingers =3D 0; /* Use st data */
> > >=20
> > > @@ -1365,8 +1399,9 @@ static psmouse_ret_t
> > > alps_process_byte(struct psmouse *psmouse) psmouse->pktcnt
> > > - 1,
> > >=20
> > >  			    psmouse->packet[psmouse->pktcnt - 1]);
> > >=20
> > > -		if (priv->proto_version =3D=3D ALPS_PROTO_V3_RUSHMORE=20
&&
> > > -		    psmouse->pktcnt =3D=3D psmouse->pktsize) {
> > > +		if ((priv->proto_version =3D=3D ALPS_PROTO_V3 ||
> > > +		     priv->proto_version =3D=3D ALPS_PROTO_V3_RUSHMORE
> > > +		    ) && psmouse->pktcnt =3D=3D psmouse->pktsize) {
> > >=20
> > >  			/*
> > >  		=09
> > >  			 * Some Dell boxes, such as Latitude E6440 or=20
E7440
> > >  			 * with closed lid, quite often smash last byte=20
of
> > >=20
> > > With all these tree parts, initialization of my ALPS
> > > touchpad is OK and working as expected. I compared PS/2
> > > init commands and are same as on 3.13 kernel.
> >=20
> > Dmitry, will you prepare v2 series of patches?
>=20
> Pali, thanks for tracking this down. I'll try update the
> series tomorrow.
>=20
> Thanks.

Hello Dmitry, have you updated this alps patch series?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2123368.LPR9lzW4PV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTbm9gACgkQi/DJPQPkQ1IL5QCgmf5OoyO+MNbURBYtB0WcOIA7
e5AAn0jV6w6jhlJtiJGmU1XNEqgtdXw0
=JrHH
-----END PGP SIGNATURE-----

--nextPart2123368.LPR9lzW4PV--
