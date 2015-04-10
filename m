From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Sat, 11 Apr 2015 01:14:45 +0200
Message-ID: <201504110114.45676@pali>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <201504110039.40761@pali> <55285797.1080303@dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart54956631.rT5EMj35mv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35536 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbbDJXOt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Apr 2015 19:14:49 -0400
In-Reply-To: <55285797.1080303@dell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

--nextPart54956631.rT5EMj35mv
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 11 April 2015 01:07:03 Mario Limonciello wrote:
> On 04/10/2015 05:39 PM, Pali Roh=C3=A1r wrote:
> > On Wednesday 25 February 2015 21:45:22 Pali Roh=C3=A1r wrote:
> > Hello Mario,
> > have you patched synaptics driver with some resetafter
> > parameter? And have some team in dell found reason for
> > invalid packets?
>=20
> Hi Pali,
>=20
> The reason was found for the invalid packets in PS2 mode, but
> I can't go into the details about it publicly.
>=20
> I think it's better to not bother including my proposed
> solution, however.  The vector of users in PS2 mode should be
> very small now. Here's why:
> With no kernel command line options applied the touchpad will
> run in I2C mode with the current kernel.  The only reason
> that users were being exposed to the PS2 mode was if they ran
> with the kernel command line option acpi_osi=3D"!Windows 2013".
>  This was required with BIOS A01 due to the problem with I2S
> audio.  This I2S audio problem has been resolved for BIOS A02
> and BIOS A03.  With no options applied on the kernel command
> line the system will run in I2C touchpad and HDA audio. All
> new machines will be coming with A03 or later.  Users with
> earlier versions have been advised to upgrade to fix this
> among other issues.
>=20
> The HDA audio will work correctly for output with 4.0.  It
> will work properly for input when these two patches are
> applied (which will land in 4.1)
>=20
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/c
> ommit/?h=3Dfor-next&id=3De1e62b98ebddc3234f3259019d3236f66fc667f8
>=20
> and
>=20
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/c
> ommit/?h=3Dfor-next&id=3Df3b703326541d0c1ce85f5e570f6d2b6bd4296ec
>=20
>=20
> If the patch to disambiguate the value of _REV() lands in 4.1
> the audio will begin to operate fully in I2S mode and the
> necessary support will be included in 4.1 as well.
>=20
> So with all those factors I feel that it's a very low risk
> that users will end up in PS2 mode with the current
> development focus kernels.
>=20
> Thanks,

I could see problem with using older kernels which are in more=20
stable or LTS distribution versions...

But it is nice that problems are fixes for future 4.0/4.1=20
versions.

And if you located reason for invalid packets in PS/2 mode, will=20
you fix it in some new bios versions?

Can you comment if this is also same problem with invalid packets=20
on E6440/E7440 machines?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart54956631.rT5EMj35mv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUoWWUACgkQi/DJPQPkQ1IQxwCfblKARboZoCkZZFIdDIyxLqE1
mkAAnRm7CnxYzQy1WHcnJTikJtN+cduX
=6WOe
-----END PGP SIGNATURE-----

--nextPart54956631.rT5EMj35mv--
