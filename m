From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v3] input: PCAP2 misc input driver
Date: Mon, 10 Aug 2009 11:13:00 +0200
Message-ID: <20090810111300.6c9abe57.ospite@studenti.unina.it>
References: <1249678456-15381-1-git-send-email-drwyrm@gmail.com>
	<20090810072431.D2068526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__10_Aug_2009_11_13_00_+0200_lb7ek4ZoAc+CSKaJ"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753096AbZHJJNj@vger.kernel.org>
In-Reply-To: <20090810072431.D2068526EC9@mailhub.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Ribeiro <drwyrm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, eric.y.miao@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, openezx-devel@lists.openezx.org, Ilya Petrov <ilya.muromec@gmail.com>
List-Id: linux-input@vger.kernel.org

--Signature=_Mon__10_Aug_2009_11_13_00_+0200_lb7ek4ZoAc+CSKaJ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 9 Aug 2009 23:54:07 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Fri, Aug 07, 2009 at 10:54:16PM +0200, Daniel Ribeiro wrote:
> > diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> > index 0d979fd..679bae3 100644
> > --- a/drivers/input/misc/Makefile
> > +++ b/drivers/input/misc/Makefile
> > @@ -26,3 +26,4 @@ obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+=3D twl4030-pw=
rbutton.o
> >  obj-$(CONFIG_INPUT_UINPUT)		+=3D uinput.o
> >  obj-$(CONFIG_INPUT_WISTRON_BTNS)	+=3D wistron_btns.o
> >  obj-$(CONFIG_INPUT_YEALINK)		+=3D yealink.o
> > +obj-$(CONFIG_INPUT_PCAP)		+=3D pcap_keys.o
>=20
> Btw, could we please keep Makefile sorted alphabetically? This should
> help with merge conflicts a bit (I know Kconfig is still not sorted).
>

Ok, do I need to send another version?

And, is Samuel taking this one and the pcap_ts one?
They depends on changes already in his for-next branch.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

--Signature=_Mon__10_Aug_2009_11_13_00_+0200_lb7ek4ZoAc+CSKaJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkp/5JwACgkQ5xr2akVTsAEndQCeJ1oeMWeihERU5zEfpIkNfIWq
ZoYAn1gqNfj9HT37HCIF+qJ8nu31gm0Z
=3J0A
-----END PGP SIGNATURE-----

--Signature=_Mon__10_Aug_2009_11_13_00_+0200_lb7ek4ZoAc+CSKaJ--
