From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH v2 2/4] input: keyboard: tegra: use devm_* for resource
 allocation
Date: Mon, 14 Jan 2013 16:49:59 +0100
Message-ID: <20130114154959.GA25049@avionic-0098.adnet.avionic-design.de>
References: <1357371910-3164-1-git-send-email-ldewangan@nvidia.com>
 <1357371910-3164-3-git-send-email-ldewangan@nvidia.com>
 <20130105080658.GA1315@core.coreip.homeip.net>
 <20130106192739.GA11566@avionic-0098.adnet.avionic-design.de>
 <20130106195748.GA28212@core.coreip.homeip.net>
 <20130109070745.GA12782@avionic-0098.adnet.avionic-design.de>
 <20130109091939.GA4369@core.coreip.homeip.net>
 <20130109092352.GA28037@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130109092352.GA28037@avionic-0098.adnet.avionic-design.de>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, grant.likely@secretlab.ca, rob.herring@calxeda.com, swarren@nvidia.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2013 at 10:23:52AM +0100, Thierry Reding wrote:
> On Wed, Jan 09, 2013 at 01:19:39AM -0800, Dmitry Torokhov wrote:
> > On Wed, Jan 09, 2013 at 08:07:45AM +0100, Thierry Reding wrote:
> > > On Sun, Jan 06, 2013 at 11:57:48AM -0800, Dmitry Torokhov wrote:
> > > > On Sun, Jan 06, 2013 at 08:27:39PM +0100, Thierry Reding wrote:
> > > > > On Sat, Jan 05, 2013 at 12:06:58AM -0800, Dmitry Torokhov wrote:
> > > > > > On Sat, Jan 05, 2013 at 01:15:08PM +0530, Laxman Dewangan wrote:
> > > > > [...]
> > > > > > > @@ -735,25 +738,16 @@ static int tegra_kbc_probe(struct platf=
orm_device *pdev)
> > > > > > >  	spin_lock_init(&kbc->lock);
> > > > > > >  	setup_timer(&kbc->timer, tegra_kbc_keypress_timer, (unsigne=
d long)kbc);
> > > > > > > =20
> > > > > > > -	res =3D request_mem_region(res->start, resource_size(res), =
pdev->name);
> > > > > > > -	if (!res) {
> > > > > > > -		dev_err(&pdev->dev, "failed to request I/O memory\n");
> > > > > > > -		err =3D -EBUSY;
> > > > > > > -		goto err_free_mem;
> > > > > > > -	}
> > > > > > > -
> > > > > > > -	kbc->mmio =3D ioremap(res->start, resource_size(res));
> > > > > > > +	kbc->mmio =3D devm_request_and_ioremap(&pdev->dev, res);
> > > > > > >  	if (!kbc->mmio) {
> > > > > > > -		dev_err(&pdev->dev, "failed to remap I/O memory\n");
> > > > > > > -		err =3D -ENXIO;
> > > > > > > -		goto err_free_mem_region;
> > > > > > > +		dev_err(&pdev->dev, "Cannot request memregion/iomap addres=
s\n");
> > > > > > > +		return -EADDRNOTAVAIL;
> > > > > >=20
> > > > > > Erm, no, -EBUSY please.
> > > > >=20
> > > > > EADDRNOTAVAIL is the canonical error for devm_request_and_ioremap=
()
> > > > > failure. The kerneldoc comment in lib/devres.c even gives a short
> > > > > example that uses this error code.
> > > >=20
> > > > I am sorry, but I do not consider a function that was added a little
> > > > over a year ago as a canon. If you look at the uses of EADDRNOTAVAI=
L it
> > > > is used predominantly in networking code to indicate that attempted
> > > > _network_ address is not available.
> > >=20
> > > EBUSY might be misleading, though. devm_request_and_ioremap() can fail
> > > in both the request_mem_region() and ioremap() calls. Furthermore it'd
> > > be good to settle on a consistent error-code instead of doing it
> > > differently depending on subsystem and/or driver. Currently the vario=
us
> > > error codes used are:
> > >=20
> > > 	EBUSY, EADDRNOTAVAIL, ENXIO, ENOMEM, ENODEV, ENOENT, EINVAL,
> > > 	EIO, EFAULT, EADDRINUSE
> > >=20
> > > Also if we can settle on one error code we should follow up with a pa=
tch
> > > to make it consistent across the tree and also update that kerneldoc
> > > comment. I volunteer to do that if nobody else steps up. I'm also Cc'=
ing
> > > Wolfram (the original author), maybe he has some thoughts on this.
> > >=20
> >=20
> > If you going to change all drivers make devm_request_and_ioremap()
> > return ERR_PTR()-encoded errors and then we can differentiate what
> > part of it failed.
>=20
> Yeah, that thought also crossed my mind. I'll give other people some
> time to comment before hurling myself into preparing patches.

I've prepared a patch that changes devm_request_and_ioremap() to return
ERR_PTR()-encoded errors and adjusts all callers. As you can imagine it
is a bit on the huge side. scripts/get_maintainer.pl lists 156 people
and mailing lists. I've gone through the list, and as far as I can tell
everyone on that list is actually affected by the patch, so there's not
much potential for tuning it down.

There is also the issue of whose tree this should go into. Unfortunately
the patch can't be broken down into smaller chunks because it changes
how the devm_request_and_ioremap() function's return value is handled in
an incompatible way, so it won't be possible to gradually phase this in.
Furthermore I can imagine that until the end of the release cycle new
code may be added on which the same transformations need to be done. I
have a semantic patch to do the bulk of the work, but quite a bit of
coordination will be required.

I'm adding Arnd and Greg on Cc, maybe they can advise on how best to
handle this kind of patch.

Thierry

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ9CknAAoJEN0jrNd/PrOhh0kP/2DM6RgWVZ+2DSN62B0yZdrp
ZdAKkJyYXc2jAMtWJkI1hB6gddfkOGOcgCI5bVwimG08QVaSPi5Y65NLJHXjxfJr
YnswsEP6+Xmo/UvUCoBHEhx41kNbUu7zIfZz15GHIa3ZHb2y3ZWpSZdLOLh8E8bb
Z8PBhuwKAfYUqGOFbcz0DFJKnZypWtPO5leY2PH4WJO1KhtFou6FOp7HXdtYHxbT
Cn5aGvHrG//g11aeqk1oq/gYKmiyopotRHw11AjARLzXdoc0zIIQLu5v5I0lrwV1
dNZjhNZYl2Z9y0wwJguoMPdk1F9AkpDLebgKCr3JB5amm61AhP/XwQ9fYjFXuXyh
t0PtOfwAq5yZUFyxGHFuEkxllRfCXbPHe/wfGZCl7usCiSBKm88AoUfpdkOTBZeC
jPHr404Ymazwxx9BYNG0StFf7N9UkBMAydVbJxYt3Ru8HFROecqrQ+fPCvVD/Bxf
/rg5Iw1rWXFRxSvH+ybnPW6aHq75ksbI8EDLKOB9CJsEMFtvU7OEimpcnTCLSLda
q/KqBaWuD3PiStCetDgL1GV7QFAYh/Azxfsw0h8zzd6nD9w2L3wYtnzbV96dDDxG
Si8xPf0oD+zAa+iddY9zL+NpBRC4AmDniYvq+8prxQKEo+c8J5pFx4LEVNZkCAVI
wffnk8NAesxGL0ADiO21
=l2O0
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
