From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH FIX for 4.0 0/2] alps: Report alps v2 Dualpoint Stick events via the right event node
Date: Wed, 1 Apr 2015 18:39:34 +0200
Message-ID: <201504011839.34984@pali>
References: <1427903046-26692-1-git-send-email-hdegoede@redhat.com> <201504011811.03302@pali> <551C1973.6060304@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5235986.D8VYWi3T1d";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33257 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbbDAQji (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Apr 2015 12:39:38 -0400
Received: by wgoe14 with SMTP id e14so59393383wgo.0
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2015 09:39:36 -0700 (PDT)
In-Reply-To: <551C1973.6060304@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

--nextPart5235986.D8VYWi3T1d
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 01 April 2015 18:14:43 Hans de Goede wrote:
> Hi,
>=20
> On 01-04-15 18:11, Pali Roh=C3=A1r wrote:
> > On Wednesday 01 April 2015 17:44:04 Hans de Goede wrote:
> >> Hi Dmitry & Pali,
> >>=20
> >> While working on some libinput code to deal with
> >> trackpoints of different model laptops having quite
> >> different speed / sensitivity ootb, I noticed that with
> >> the current 4.0-rc# kernels the trackpoint events on
> >> laptops with a PROTO_V2 alps touchpad are no longer being
> >> send by the "Dualpoint Stick" event node, instead a new
> >> "ALPS PS/2 Mouse" node gets created and sends the
> >> trackpoint events.
> >>=20
> >> The cause of this is that the stick on these devices sends
> >> bare ps/2 packets as data.
> >>=20
> >> Although this does not really break anything (atm, it does
> >> break my libinput work), it is still wrong, esp. also since
> >> the "Dualpoint Stick" node has the POINTING_STICK property
> >> set, where as the "ALPS PS/2 Mouse" node which is actually
> >> sending the stick events does not.
> >>=20
> >> If still possible I would like to see this fixes added to
> >> 4.0, if not we should queue them up for stable.
> >>=20
> >> Regards,
> >>=20
> >> Hans
> >=20
> > Hi Hans, thanks for testing!
> >=20
> > I would like to see this observation also in alps protocol
> > documentation, where is all information how are data from
> > touchpads and tracksticks reported.
>=20
> Good point, for today I'm already a bit late with logging
> off, but I'll do a follow up patch for this tomorrow.
>=20
> > Also for me it it makes sense to squash both patches into
> > one.
>=20
> I think having them separate is slightly better, but either
> way is fine with me,
>=20
> > And can you check if your change is needed only for
> > ALPS_PS2_INTERLEAVED devices? For me it looks like that only
> > those alps devices could mix both 3-bytes and 6-bytes
> > packets...
>=20
> That is what I expected in the beginning too, but no that is
> not the case, this happens on my Latitude D620 too, and that
> one does not use / set ALPS_PS2_INTERLEAVED.
>=20

Ok. It really needs documentation.

And I'm also for including fix to 4.0 stable kernel as this is=20
regression for those dell models.

> Regards,
>=20
> Hans
>=20
> p.s.
>=20
> Talking about ALPS_PS2_INTERLEAVED did you ever try that on
> the current troublesome models which sometime get out of
> sync?
>=20
> Maybe they are actually interleaving things again ?
>=20
> Regards,
>=20
> Hans

No, there are no interleaved packets. All packets are 6-bytes=20
length, but some have swapped bits... When I saw those lot of=20
invalid packets I thought it is similar to ALPS_PS2_INTERLEAVED.=20
But not.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart5235986.D8VYWi3T1d
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUcH0YACgkQi/DJPQPkQ1JlFgCfaYV3Zi11C3zTvlryInOhAi/z
8q8An005Yo+CgES/AdnQ3FNC7BgUjEn3
=d7cx
-----END PGP SIGNATURE-----

--nextPart5235986.D8VYWi3T1d--
