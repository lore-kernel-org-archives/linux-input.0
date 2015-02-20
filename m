From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Fri, 20 Feb 2015 22:46:19 +0100
Message-ID: <201502202246.19686@pali>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <CAN+gG=F6TyoOb=nNeBAsdh7RrEUWoeJtznTY4YNmr3UGxQ1Hjg@mail.gmail.com> <54E7A9D6.8060506@dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6633934.FE8P9OhOgi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54E7A9D6.8060506@dell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>
List-Id: linux-input@vger.kernel.org

--nextPart6633934.FE8P9OhOgi
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 20 February 2015 22:40:38 Mario Limonciello wrote:
> On 02/20/2015 03:31 PM, Benjamin Tissoires wrote:
> > What is most likely happening is that the synaptics driver
> > switches the touchpad into the i2c/hid protocol. And yes
> > Synaptics told us that only a reset re-enables the touchpad
> > in the PS/2 mode. Kernels 3.11 and later know how to deal
> > with this mode (through hid-rmi), so we should not see
> > these problems in the future unless hid-rmi is not compiled
> > in the running kernel.
> >=20
> > Fortunately, we can deal with the Dell/Synaptics touchpads,
> > the Lenovo ones are using SMBus, and we have never been
> > able to talk to the devices with SMBus :(
> >=20
> > Cheers,
> > Benjamin
>=20
> Ah, yeah that makes more sense to me.  And actually the newer
> touchpads like the one in the XPS 13 (2015) are microsoft
> precision touchpads.  They don't even bother with hid-rmi.=20
> When in I2C mode the hid-multitouch and i2c-hid driver handle
> them sufficiently sans a patch that just hit linux-input to
> fix a problem introduced in 3.19 (and 3.18.3).
>=20
> For clarities sake:
> The touchpad in the XPS 13 (2015) will run in I2C or PS2
> modes. When_OSI of Windows 2013 is recognized it will be put
> into I2C mode.  I know that the current kernel does recognize
> Windows 2013 _OSI so by default the touchpad will be in I2C
> mode with a new kernel.  Unfortunately this also puts the
> sound card into I2S mode which is not yet supported by Linux.
>  This is being worked out separately, but currently we are
> recommending that customers use acpi_osi=3D"!Windows 2013" to
> use the touchpad in PS2 and soundcard in HDA modes.
>=20
> Obviously this patch isn't applicable when running the
> touchpad is running in I2C mode.

Maybe stupid question, but cannot you call that code which put=20
sound card into HDA mode from kernel? It could fix problem when=20
either sound or touchpad is not working...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart6633934.FE8P9OhOgi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTnqysACgkQi/DJPQPkQ1Jp9QCeIFzjabrN/JteqFa/9pa/Vl/z
vXMAniza5hK3VExzii1YyjW/wc8Qsa7A
=XJ47
-----END PGP SIGNATURE-----

--nextPart6633934.FE8P9OhOgi--
