From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] input: add driver support for Sharp gp2ap002a00f
 proximity sensor
Date: Tue, 15 Nov 2011 10:47:59 +0200
Message-ID: <20111115084758.GF6492@legolas.emea.dhcp.ti.com>
References: <1321285158-7123-1-git-send-email-oskar.andero@sonyericsson.com>
 <20111114170352.GA12659@core.coreip.homeip.net>
 <20111115075629.GE9307@caracas.corpusers.net>
 <20111115082926.GA13157@core.coreip.homeip.net>
 <20111115083454.GE6492@legolas.emea.dhcp.ti.com>
 <20111115084609.GB13157@core.coreip.homeip.net>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111115084609.GB13157@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, oskar.andero@sonyericsson.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>, "aghayal@codeaurora.org" <aghayal@codeaurora.org>, "Cavin, Courtney" <Courtney.Cavin@sonyericsson.com>
List-Id: linux-input@vger.kernel.org


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 15, 2011 at 12:46:09AM -0800, Dmitry Torokhov wrote:
> > On Tue, Nov 15, 2011 at 12:29:26AM -0800, Dmitry Torokhov wrote:
> > > > > > +	error =3D input_register_device(dt->device);
> > > > > > +	if (error) {
> > > > > > +		dev_err(&dt->device->dev, "device registration failed\n");
> > > > > > +		input_free_device(dt->device);
> > > > >=20
> > > > > If you swap request_threaded_irq() and input_register_device() so=
 that
> > > > > registration is the last action error handling will be much simpl=
er.
> > > > >
> > > >=20
> > > > I am getting a bit confused here, since you asked me to swap the or=
der
> > > > of request_threaded_irq() and input_register_device() in my previous
> > > > version as well. Swapping again will take us back to square one or =
maybe
> > > > I am misinterpreting your comment?
> > >=20
> > > Gah, sorry, a bit of boilerplate slipped in. You already have the cal=
ls
> > > in right order, you just need proper labels.
> > >=20
> > >=20
> > > 	input_dev =3D input_allocate_device();
> > > 	if (!input_dev) {
> > > 		dev_err(...);
> > > 		error =3D -ENOMEM;
> > > 		goto err_free_mem;
> > > 	}
> > >=20
> > > 	... set up input device fully ...
> > >=20
> > > 	error =3D request_threaded_irq(...);
> > > 	if (error) {
> > > 		dev_err(...);
> > > 		goto err_free_input_dev;
> > > 	}
> > >=20
> > > 	error =3D input_register_device(input_dev);
> > > 	if (error) {
> > > 		dev_err(...);
> > > 		goto err_free_irq;
> > > 	}
> >=20
> > are you sure this is right order ? Won't this create a very small
> > timeframe where we could try to call input_report_switch() and
> > input_sync() on an unregistered input device ??
> >=20
>=20
> Yes, this is fine. As long as input device was allocated with
> input_allocate_device() it can be used by input_report_*() and
> input_sync() even tough device may not be registered yet - the events
> will simply be dropped.

good to know, thanks :-)

--=20
balbi

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOwic+AAoJEIaOsuA1yqREjSgP/1lvu3uonP6Z4OgPhjyqCtjm
ZIcGL7UkH+3r+VknX0J9jgJH+UIVLucXr2lktKYO06htaFoN0P+Kwhu2gft0Qaab
ejLH5yjSk8jUJH9BL74d+v2nns66rvAcSftgNsYg+5BSrPBSzlShGWWdbi3FeoDq
2x639mWrb6KDStaMykCOMSttKcgApxohzfpm+PrjayA5VXqT+Z1zvOqqjJU326Zj
Z35u7wPZysna5IXBJKbjeW9pQ/kPL41ncq0x4P7+kzqAq71ZeIgF98JRGQ/EaV8p
I7Da5U9/PV7dlMUhhaqviMnDgj8wRO/wDqi3vF3DPS/owVBbMoX9Wb3GJrprWHnn
VBUI08vX5AgEpWDiUj+4BRc1jKEQNMh/DLZcokxziaBWz9TCAGHGbfP3dd0ky81C
WxctWdIPTY8Q34qILjFfm715QxnL8dvN1FWTMNlWB/BNCujlT5KurH+cRvSmWtqO
TjXfQTVnHQEqiiOgWgY1CUdd2yHsit1IZ3zlVNfdeuNDozXABfo7GfFhdKbpGJ9v
OF9iO3s/NXUnhW8D/X35zzBLUe3PyuwmszA5rLW4Mj3ZktIAVV66S9pA/rHC9Nf6
Z9jzJEVBnXymioIiGBLBGEwftkef15k/1KlkKhT6NO1Yz1PGMLBXGx2f3y1tZKuf
cWQvQbnLedfPJ2QHHXGo
=/PET
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--
