From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: ALPS - Detect trackstick presence for v7 protocol
Date: Tue, 24 Mar 2015 17:46:12 +0100
Message-ID: <201503241746.12446@pali>
References: <1427031971-13018-1-git-send-email-pali.rohar@gmail.com> <551111E1.6090303@redhat.com> <CAPXTYCXrvFDbvEDkEQxkcJ5y1OHx7Ldm+bu-LnWfigjTj6gECw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4684781.GqLcdjuLji";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:36618 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbbCXQqQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Mar 2015 12:46:16 -0400
In-Reply-To: <CAPXTYCXrvFDbvEDkEQxkcJ5y1OHx7Ldm+bu-LnWfigjTj6gECw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Santiago Gala <sgala@apache.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart4684781.GqLcdjuLji
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello, I can compile psmouse.ko module for you. Just let me know=20
which ubuntu kernel (and from) are you using.

On Tuesday 24 March 2015 11:25:13 Santiago Gala wrote:
> I can't compile the  kernel in this laptop, sorry, I tried but
> couln't complete: it requires too much free disk (more than
> 9GB) and the SSD is very small.
>=20
> If there is a way (I have not found it even though I know that
> dkms exists) to just compile the modjule I could easily test
> the patch with the mainline ubuntu binary of the relevant
> 4.0.0-rcN, but spending some time trying it didn't show how
> to do i
>=20
> Regards
> Santiago
>=20
> El mar., 24 de marzo de 2015 a las 8:30, Hans de Goede
> (<hdegoede@redhat.com>)
>=20
> escribi=C3=B3:
> > Hi,
> >=20
> > On 23-03-15 18:02, Pali Roh=C3=A1r wrote:
> > > On Monday 23 March 2015 12:39:48 Hans de Goede wrote:
> > >> Hi,
> > >>=20
> > >> On 22-03-15 14:46, Pali Roh=C3=A1r wrote:
> > >>> This patch adds detection of trackstick for v7 protocol
> > >>> devices. Code in this patch is used in official Dell
> > >>> touchpad linux drivers for Dell models: Dell Latitude
> > >>> E5250/5250, E5450/5450, E5550/5550
> > >>>=20
> > >>> Detection code and base reg for alps v3 rushmore and v7
> > >>> devices is exacly same.
> > >>>=20
> > >>> Also user in bug
> > >>> https://bugzilla.kernel.org/show_bug.cgi?id=3D94801
> > >>> reported that Toshiba Sattellite Z30-A-1DG has only
> > >>> alps v7 touchpad device without trackstick and kernel
> > >>> reports to userspace also redundant trackstick device.
> > >>>=20
> > >>> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > >>=20
> > >> Looks good, but has this been tested on a laptop which
> > >> actually has a v7 pad + trackstick? I would like to see
> > >> this actually tested on at least one such laptop before
> > >> it gets merged.
> > >>=20
> > >> Regards,
> > >>=20
> > >> Hans
> > >=20
> > > I did not tested my patch on any v7 touchpad-only laptop.
> >=20
> > Ah, but I'm not worried about testing on a touchpad-only
> > laptop, we are already reporting a trackpoint there even
> > though there is none. I'm worried about breaking existing
> > v7 using laptops which actually have a trackstick.
> >=20
> > So if this is tested on a v7 laptop with trackstick, and it
> > does not break the trackstick then that is good enough for
> > me.
> >=20
> > Regards,
> >=20
> > Hans

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4684781.GqLcdjuLji
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlURlNQACgkQi/DJPQPkQ1K7fwCfRyTDFZCMGUVmt+N7MMjhbJJ8
7rMAoIsWcyMQ5/RRSrjHP0MCrhK+Uo/D
=PSsc
-----END PGP SIGNATURE-----

--nextPart4684781.GqLcdjuLji--
