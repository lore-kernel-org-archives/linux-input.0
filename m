From: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Tue, 21 Jul 2009 17:43:15 -0300
Message-ID: <1248208995.4333.46.camel@brutus>
References: <20090714100634.GA4054@elf.ucw.cz>
	 <5d5443650907140320w334864f4uc1ee13ed32fdb874@mail.gmail.com>
	 <20090715133627.GA2538@elf.ucw.cz>
	 <5d5443650907151033w36008b71pe4b32bcea9489b75@mail.gmail.com>
	 <20090721105924.GK4133@elf.ucw.cz> <20090721113642.GC13286@sirena.org.uk>
	 <5d5443650907210518i6ee4df1evdc04d9ae9453707c@mail.gmail.com>
	 <5d5443650907210530x4aaa03d6gd47ef5f79a3ef8a4@mail.gmail.com>
	 <20090721124933.GA5668@rakim.wolfsonmicro.main>
	 <20090721160436.GD4352@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-OhjLO42kfIzVIPhva3bN"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090721160436.GD4352-wUGeVx6es1+Q2O5dskk9LyLysJ1jNyTM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Arve Hj?nnev?g <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.fujak-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--=-OhjLO42kfIzVIPhva3bN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Ter, 2009-07-21 =C3=A0s 09:04 -0700, Dmitry Torokhov escreveu:
> On Tue, Jul 21, 2009 at 01:49:33PM +0100, Mark Brown wrote:

> >  - Multi-function devices like the twl4030 which have an interrupt
> >    controller on them and would like to expose that interrupt controlle=
r
> >    via the generic IRQ subsystem.  This was a large part of the
> >    discussion in the thread above is a much trickier problem.
> >=20
> > I've added the folks from Samsung posting the MELFAS MCS-5000 driver to
> > the thread since they're running into the same issue.
> >=20
> Let's also add Thomas and David since I believe they worked on the
> feature.

Please, keep me on CC too, pcap has an interrupt controller, is
connected to SPI bus and exposes its interrupts via generic IRQ
subsystem.

--=20
Daniel Ribeiro

--=-OhjLO42kfIzVIPhva3bN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpmKGMACgkQw3OYl0G0liSBoACfUmMi1epB1ROtkx6SfNyd1DEK
nFsAoIq3RNP2Tb9IboODK8eG2srrXWGw
=xZZe
-----END PGP SIGNATURE-----

--=-OhjLO42kfIzVIPhva3bN--
