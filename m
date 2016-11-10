From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] drivers: tca8418: Change the interrupt type
Date: Thu, 10 Nov 2016 10:13:02 +0100
Message-ID: <20161110091302.cjn4srrpxtg2mknv@lukather>
References: <20161107144024.15291-1-maxime.ripard@free-electrons.com>
 <20161109000400.GA8719@dtor-ws>
 <20161109080235.v23y42bojnwcw6rk@lukather>
 <20161110040208.GA9498@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5xx3yu2ej6dzqeqt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161110040208.GA9498@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--5xx3yu2ej6dzqeqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 09, 2016 at 08:02:08PM -0800, Dmitry Torokhov wrote:
> On Wed, Nov 09, 2016 at 09:02:35AM +0100, Maxime Ripard wrote:
> > Hello Dmitry,
> >=20
> > On Tue, Nov 08, 2016 at 04:04:00PM -0800, Dmitry Torokhov wrote:
> > > On Mon, Nov 07, 2016 at 03:40:24PM +0100, Maxime Ripard wrote:
> > > > The TCA8418 interrupt has a level trigger, not a edge one.
> > > >=20
> > > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > >=20
> > > Hmm, maybe we could rely on OF data for trigger type?
> >=20
> > We might, even though the i2c core doesn't change the trigger type
> > when it retrieves the interrupt from the DT.
>=20
> i2c core itself does not, and should not, but irq code does:
>=20
> of_irq_get() -> irq_create_of_mapping() -> irq_create_fwspec_mapping()
> -> irqd_set_trigger_type().

Ah, indeed, I overlooked that. I wonder why platform_get_irq does it
then.

>=20
> >=20
> > However, I'm a bit worried about the other probing mechanims (ACPI,
> > board files) that should be supported as well, and removing the
> > trigger type from the flags might break those. There's no board files
> > using it though in the tree, but I don't know about ACPI systems.
>=20
> The driver is not enabled for ACPI systems, at least not in mainline.

Ok. Good.

> By the way, this is what TCA8418 binding dochas to say:
>=20
> "- interrupts: IRQ line number, should trigger on falling edge"
>=20
> so it seems there was at least one system that needed falling edge and
> not level interrupt.

I don't know, looking at the datasheet, it really looks like it's
level triggered to me, and we were actually seeing issues when set in
edge.

http://www.ti.com/lit/ds/symlink/tca8418.pdf
Especially page 20 and 33.

My understanding is that in input, the chip will trigger on edges, but
the line coming from that device to the SoC will be level triggered.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--5xx3yu2ej6dzqeqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYJDoaAAoJEBx+YmzsjxAgBjEP/AsKl1yY+vsPsyvJOUdwQcIY
f+Nly2lJCB67zC3HZKoU9E4whhH3NsaZMMEnBAtzG6lLp6dC7fMX+cH/k9Esb67L
O9wyykkvjGILa72i3o9z4sTA7gGDcsCBuf5T5MwjNKCsHPiJQWF4cr1jsiyuV+gy
mWR+jEzhIiIouP2+OxqnBUzNT4xwd9u5T20aYV6lbQbp1DPONwzsAFuXDA24F78e
j9O9LzPtO1v85lk3tqq4/C+dlMummpLHneestrjBcJ15s6Q2+tRw06mLeIu24HSj
qra9OqrAS9gd+xNZy+eCauH0+yQfsZT1jAXexKJf+jYKPuMl3kprYClvD4cyDLgk
/AcbPquBT/5NHcb13kDxhVGLlRDIVAbWdyhzFDKdnxPnhLUITin+TzhhHNx8b6vL
SZ1VNTQaco99WiyDsCqpmQLFtqZZSAqEmTCYfRsRhKVWAlpSJyh1J0OmiAZSVVP+
EAuib08v8+1mVbiFijbykJKSp1SwbT5FNye4otj/LvbxgjT1FoJkNFjDwYd/ehib
YQirPJTA3xtUJx5wWRiqWCXfT9vG7cmMLIHDYPfoPURMfw6BrObY/cqTYSCZ+UJa
8mSDMWZ9ky3aPxRT+YvrIftSrwI5pF9hn685XIL12CbL9gAv90I/2EIT5yRt1aET
w30qSTvYhmP5++cg6Q7L
=2rQ3
-----END PGP SIGNATURE-----

--5xx3yu2ej6dzqeqt--
