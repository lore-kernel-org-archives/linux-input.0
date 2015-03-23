From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: ALPS - Detect trackstick presence for v7 protocol
Date: Mon, 23 Mar 2015 18:02:28 +0100
Message-ID: <201503231802.28977@pali>
References: <1427031971-13018-1-git-send-email-pali.rohar@gmail.com> <550FFB84.6000609@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7399814.unQvgYC057";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <550FFB84.6000609@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Santiago Gala <sgala@apache.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--nextPart7399814.unQvgYC057
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 23 March 2015 12:39:48 Hans de Goede wrote:
> Hi,
>=20
> On 22-03-15 14:46, Pali Roh=C3=A1r wrote:
> > This patch adds detection of trackstick for v7 protocol
> > devices. Code in this patch is used in official Dell
> > touchpad linux drivers for Dell models: Dell Latitude
> > E5250/5250, E5450/5450, E5550/5550
> >=20
> > Detection code and base reg for alps v3 rushmore and v7
> > devices is exacly same.
> >=20
> > Also user in bug
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D94801 reported
> > that Toshiba Sattellite Z30-A-1DG has only alps v7 touchpad
> > device without trackstick and kernel reports to userspace
> > also redundant trackstick device.
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>=20
> Looks good, but has this been tested on a laptop which
> actually has a v7 pad + trackstick? I would like to see this
> actually tested on at least one such laptop before it gets
> merged.
>=20
> Regards,
>=20
> Hans
>=20

I did not tested my patch on any v7 touchpad-only laptop.

But I guess Dell should have tested it... Of course we can wait=20
until somebody test this patch and after that we will merge it.

@Santiago: Can you test this patch? You also have v7 touchpad=20
only laptop (without trackstick).

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart7399814.unQvgYC057
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUQRyQACgkQi/DJPQPkQ1LImQCfZYhGTEmMlb7W2BxyUZoNkVET
ttAAoLjxPddX8mB/eruThNMA5aJFTNlc
=igDw
-----END PGP SIGNATURE-----

--nextPart7399814.unQvgYC057--
