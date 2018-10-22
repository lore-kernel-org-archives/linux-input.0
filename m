From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Input: uinput - fix Spectre v1 vulnerability
Date: Mon, 22 Oct 2018 16:14:59 +0200
Message-ID: <20181022141458.GA29727@amd>
References: <20181016111313.GA28307@embeddedor.com>
 <20181016172107.GA230131@dtor-ws>
 <ead3e95a-1acb-362a-0ee2-d02dbc4f378c@embeddedor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ead3e95a-1acb-362a-0ee2-d02dbc4f378c@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-10-16 19:52:58, Gustavo A. R. Silva wrote:
> Hi Dmitry,
>=20
> On 10/16/18 7:21 PM, Dmitry Torokhov wrote:
> > Hi Gustavo,
> >=20
> > On Tue, Oct 16, 2018 at 01:13:13PM +0200, Gustavo A. R. Silva wrote:
> >> setup.code can be indirectly controlled by user-space, hence leading to
> >> a potential exploitation of the Spectre variant 1 vulnerability.
> >>
> >> This issue was detected with the help of Smatch:
> >>
> >> drivers/input/misc/uinput.c:512 uinput_abs_setup() warn: potential
> >> spectre issue 'dev->absinfo' [w] (local cap)
> >>
> >> Fix this by sanitizing setup.code before using it to index dev->absinf=
o.
> >=20
> > So we are saying that attacker, by repeatedly calling ioctl(...,
> > UI_ABS_SETUP, ...) will be able to poison branch predictor and discover
> > another program or kernel secrets? But uinput is a privileged interface
> > open to root only, as it allows injecting arbitrary keystrokes into the
> > kernel. And since only root can use uinput, meh?
> >=20
>=20
> Oh I see... in that case this is a false positive.

No, please lets fix it.

Some people are trying to make sure kernel is "more priviledged" than
root -- its called secure boot etc.

And "if you givean attacker possibility to generate keystrokes, he can
read kernel memory as well"... is very unexpected.

Unexpected is bad when talking about security.
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvN22IACgkQMOfwapXb+vJ1xACgkmaCK/eqBI2FyKOW4ixQxGGK
9sYAoJcEKV2/6EU79TFPSfLv9m06gnaV
=lcj5
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
