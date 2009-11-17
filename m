From: Soeren Sonnenburg <sonne-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [Bug #14626] oops on boot starting udev
Date: Tue, 17 Nov 2009 05:06:47 +0100
Message-ID: <1258430807.12721.12.camel@no>
References: <GUZt44bIwCE.A.vLF.pSdALB@chimera>
	 <xXQGFmujPl.A.fpF.zSdALB@chimera> <20091117011455.GA7977@kroah.com>
	 <20091117020451.GA27967@core.coreip.homeip.net>
	 <1258426743.9883.53.camel@no>
	 <20091117040104.GA5792@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-8DGaYemo9SL3VMfmqH9/"
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091117040104.GA5792-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--=-8DGaYemo9SL3VMfmqH9/
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-11-16 at 20:01 -0800, Dmitry Torokhov wrote:
> On Tue, Nov 17, 2009 at 03:59:03AM +0100, Soeren Sonnenburg wrote:
> > On Mon, 2009-11-16 at 18:04 -0800, Dmitry Torokhov wrote:
> > > On Mon, Nov 16, 2009 at 05:14:55PM -0800, Greg KH wrote:
> > > > On Mon, Nov 16, 2009 at 11:37:48PM +0100, Rafael J. Wysocki wrote:
> > > > > This message has been generated automatically as a part of a repo=
rt
> > > > > of recent regressions.
> > > > >=20
> > > > > The following bug entry is on the current list of known regressio=
ns
> > > > > from 2.6.31.  Please verify if it still should be listed and let =
me know
> > > > > (either way).
> > > > >=20
> > > > >=20
> > > > > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=3D14626
> > > > > Subject		: oops on boot starting udev
> > > > > Submitter	: Soeren Sonnenburg <sonne-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
> > > > > Date		: 2009-11-14 10:16 (3 days old)
> > > > > References	: http://marc.info/?l=3Dlinux-kernel&m=3D1258193802068=
00&w=3D4
> > > >=20
> > > > This looks like an input core problem, as the evdev module was just
> > > > loaded and died.
> > > >=20
> > > > Any input developers have any ideas?
> > > >=20
> > >=20
> > >=20
> > > Hmm, evdev does:
> > >=20
> > > 	dev_set_name(&evdev->dev, "event%d", minor);
> > >=20
> > > Not sure how it can go wrong...
> >=20
> > Anything I should/could do to narrow it down a bit (apart from
> > bisecting?).
> >=20
>=20
> Umm, I looked through the changes between -rc6 and 7 but nothing jumped
> out at me... You don't happen to have any local changes in your tree?

Well only the mouse button #1 emulation - though I don't see what could
go wrong there.

Soeren
--=20
For the one fact about the future of which we can be certain is that it
will be utterly fantastic. -- Arthur C. Clarke, 1962

--=-8DGaYemo9SL3VMfmqH9/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABAgAGBQJLAiFWAAoJEH82z1Wqh6p36qMQAIAqBtH+iAWzZxcKQ8jilLSk
cn94Oqv+InMyZxdxRLJh24+vOlJT2nkFykuKnyODrzOwToBIDQjwXCxYUaee1Kjy
aohp/81MBRBMf9LIA9zbUEUXum/8eobO7fJs36WsjI2kSZz4z5DhD2l+s7aRonqO
0G5jGQH/6IW9qDFsTB1tlnurLlsXl5tKAHpcEENDCzjd11fPax01l/yuGSqR7MtN
mKjMsT0knOhY1h7Ns6q1EsMvfSeoCtsw0T99pd8BBDB8S3LtBF9xYHOBTEvfPKMb
BEgN5aEcNn8HpPfroMbGDEQ76+j1dn7ZtVl3T//64TR6+kRYBxd04OkGyR5oNslY
1JdKUZu0OKD/pH+6CDIurqJtTas1UgMq52Qv/LtqzEceMr/3ES3erpfzCi3f7RCV
QdTeCIiQTpwCk20VZkESxXuUTRcZ09NZ/DhHIsuLtJdxDzRcWtYwKJs0yAS05iV8
CFQEiTekcHVfJMGNFPOoFPA2SmX+hlsDcEnL4YvS9TgtYflrpMiE+jBZy4CbGF1m
TWxcH0xGcHrKXNoCrTJ8cOJ1BCnNCM4vkxkHVuHnKPPB+mg4kLS6pBi0nVVwWLGV
J3YWtmvp5VLp8+Iplb3+XV60Ft+LgeqTWHo0B/xr9nm+Wghvjbwd8+bDzSzBVQnG
O3zT+9VmRP9932P8JPmK
=y7Bn
-----END PGP SIGNATURE-----

--=-8DGaYemo9SL3VMfmqH9/--
