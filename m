From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: atkbd: Fix release quirk for Dell models
Date: Mon, 6 Apr 2015 10:06:10 +0200
Message-ID: <201504061006.10853@pali>
References: <1427639779-27377-1-git-send-email-pali.rohar@gmail.com> <201504060000.32145@pali> <20150405235343.GA5313@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6616986.MFWQWt1NM0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150405235343.GA5313@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--nextPart6616986.MFWQWt1NM0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 06 April 2015 01:53:43 Dmitry Torokhov wrote:
> On Mon, Apr 06, 2015 at 12:00:32AM +0200, Pali Roh=C3=A1r wrote:
> > On Sunday 05 April 2015 23:48:33 Dmitry Torokhov wrote:
> > > Hi Pali,
> > >=20
> > > On Sun, Mar 29, 2015 at 04:36:19PM +0200, Pali Roh=C3=A1r wrote:
> > > > This patch fixes commit 61579ba83934 ("Input: atkbd -
> > > > expand Latitude's force release quirk to other Dells").
> > > > Before that commit release quirks were called for all
> > > > Dell Latitude models. After that commit only for
> > > > Portable Dell devices. But lot of Latitude models are
> > > > Laptop or Notebook DMI devices so quirks are not
> > > > called.
> > > >=20
> > > > Release quirks are still needed also for new Dell
> > > > Latitude models, so this patch enables quirks for all
> > > > Portable, Laptop, Notebook and Sub-Notebook Dell
> > > > devices.
> > >=20
> > > Does Dell use all these types for their laptops? What
> > > models do you know that need this quirk?
> > >=20
> > > Thanks.
> >=20
> > I do not if Dell use all types, but months ago Matthew wrote
> > to include also other numbers not only 9 (Laptop) and you
> > agreed.
>=20
> Hmm, I tried looking back but I could not quite find the
> discussion.
>=20

Search for Message-ID: <20141222175632.GB18556@dtor-ws>
(this should be unique identifier for emails)

> > I do not know exact list of models which needs these quirks,
> > but before that commit (61579ba83934) it was used for all
> > Latitude models. At least I see that switches do not
> > generate release events and on older Latitude machines some
> > Fn keys do not generate them too.
>=20
> So the question is still: what models do need this quirk and
> what chassis type they are used.
>=20

My model:

$ cat /sys/class/dmi/id/chassis_type=20
9
$ cat /sys/class/dmi/id/sys_vendor
Dell Inc.
$ cat /sys/class/dmi/id/product_name
Latitude E6440

> Regardless, I have not accepted quirks for force_release and
> atkbd keymaps for many years now as the task to adjust both
> keymap and force_release list has been offloaded to udev.
>=20
> Thanks.

Ok, and what to do with kernel regressions? As before commit=20
61579ba83934 it worked, because quirk was called for all Latitude=20
(independently on chassis_type).

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart6616986.MFWQWt1NM0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUiPnIACgkQi/DJPQPkQ1IjAQCeMKKQkqHaJwVgV90QOd0cdkQu
DpQAoMRvSh2sMkhZ0OXsuMDDa2LFrzNC
=oMIB
-----END PGP SIGNATURE-----

--nextPart6616986.MFWQWt1NM0--
