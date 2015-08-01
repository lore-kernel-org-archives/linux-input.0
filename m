From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 05/15] drivers: input: Drop unlikely before IS_ERR(_OR_NULL)
Date: Sat, 1 Aug 2015 13:44:59 +0200
Message-ID: <201508011344.59372@pali>
References: <cover.1438331416.git.viresh.kumar@linaro.org> <20150731165841.GD5613@dtor-ws> <20150801112251.GK899@linux>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3367423.SIxKtUkyAF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150801112251.GK899@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: akpm@linux-foundation.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Masaki Ota <masaki.ota@jp.alps.com>
List-Id: linux-input@vger.kernel.org

--nextPart3367423.SIxKtUkyAF
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 01 August 2015 13:22:51 Viresh Kumar wrote:
> On 31-07-15, 09:58, Dmitry Torokhov wrote:
> > On Fri, Jul 31, 2015 at 02:08:25PM +0530, Viresh Kumar wrote:
> > > IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag and
> > > there is no need to do that again from its callers. Drop it.
> >=20
> > I'd rather keep it as it documents the expected behavior and double
> > unlikely should work just fine.
>=20
> TBH, I don't really agree that it is there for documentation. The
> only purpose of such compiler flags is to try make code more
> efficient.
>=20
> Anyway, I got to this series as someone asked me to fix this for one
> of my patches which used unlikely(IS_ERR_OR_NULL()). And so I
> thought about fixing all sites that are doing double unlikely (that
> shouldn't hurt for sure).
>=20
> I will leave it to you.

I think that unlikely() macro here make code more readable. Yes, it is=20
also for compiler optimization, but also for me it looks like Clean Code=20
pattern <https://de.wikipedia.org/wiki/Clean_Code> -- is not it?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3367423.SIxKtUkyAF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlW8sTsACgkQi/DJPQPkQ1LQaACfVggcmkQRTJLk7T449aO0Hbah
FQwAoIvRtqMpx5rWhXPwTGfy385EHYWd
=ftpS
-----END PGP SIGNATURE-----

--nextPart3367423.SIxKtUkyAF--
