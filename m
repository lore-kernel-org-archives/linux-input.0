From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: atkbd: Fix release quirk for Dell models
Date: Mon, 6 Apr 2015 00:00:32 +0200
Message-ID: <201504060000.32145@pali>
References: <1427639779-27377-1-git-send-email-pali.rohar@gmail.com> <20150405214833.GD31564@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4281160.sBnlCLUt0h";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150405214833.GD31564@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--nextPart4281160.sBnlCLUt0h
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 05 April 2015 23:48:33 Dmitry Torokhov wrote:
> Hi Pali,
>=20
> On Sun, Mar 29, 2015 at 04:36:19PM +0200, Pali Roh=C3=A1r wrote:
> > This patch fixes commit 61579ba83934 ("Input: atkbd - expand
> > Latitude's force release quirk to other Dells"). Before
> > that commit release quirks were called for all Dell
> > Latitude models. After that commit only for Portable Dell
> > devices. But lot of Latitude models are Laptop or Notebook
> > DMI devices so quirks are not called.
> >=20
> > Release quirks are still needed also for new Dell Latitude
> > models, so this patch enables quirks for all Portable,
> > Laptop, Notebook and Sub-Notebook Dell devices.
>=20
> Does Dell use all these types for their laptops? What models
> do you know that need this quirk?
>=20
> Thanks.
>=20

I do not if Dell use all types, but months ago Matthew wrote to=20
include also other numbers not only 9 (Laptop) and you agreed.

I do not know exact list of models which needs these quirks, but=20
before that commit (61579ba83934) it was used for all Latitude=20
models. At least I see that switches do not generate release=20
events and on older Latitude machines some Fn keys do not=20
generate them too.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4281160.sBnlCLUt0h
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUhsIAACgkQi/DJPQPkQ1IoOACgsST+qi4G49zHg88RCVIxOWc6
chcAoI2gD41xxDTHPGRWuS3Y3PDEgo1J
=tBEW
-----END PGP SIGNATURE-----

--nextPart4281160.sBnlCLUt0h--
