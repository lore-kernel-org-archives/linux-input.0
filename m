From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Vibrations in input vs. LED was Re: [PATCH v2 0/3] led:
 ledtrig-transient: add support for hrtimer
Date: Sun, 17 Sep 2017 19:50:14 +0200
Message-ID: <20170917175013.GB13003@amd>
References: <20170913175400.42744-1-dtwlin@google.com>
 <20170913202032.GA30844@amd>
 <9c75c3a9-4123-c7f3-7725-45ba752d672a@gmail.com>
 <20170914205804.GA24339@amd>
 <ef3472a0-1e70-e64f-fe11-7fdfd768fc85@gmail.com>
 <20170916015809.GA5072@localhost>
 <9afbd987-b237-24d4-e16a-ddd7fa70766a@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9afbd987-b237-24d4-e16a-ddd7fa70766a@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: linux-input@vger.kernel.org, David Lin <dtwlin@google.com>, corbet@lwn.net, rpurdie@rpsys.net, hdegoede@redhat.com, gregkh@linuxfoundation.org, robh@kernel.org, romlem@google.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Do you think such an improvement could be harmful in some way,
> >> even if it was made optional?
> >=20
> > Of course, we can make LED timing accurate down to microseconds. It will
> > mean increased overhead -- for "improvement" human can not perceive.
> >=20
> > If someone has problems with LED delays not being accurate enough... we
> > may want to fix it. But that is not the case here, is it?
>=20
> AFAIR David was mentioning that the hr_timer support is perceivable

He said that hr_timer support is perceivable _when he is driving
vibration motor_. Which he should not do in the first place.

Yes, if the difference is perceivable with LED in non-crazy
configuration (*), we can take the patch. Is it? Do we have someone
not from Google observing it?

									Pavel
(*) emulating PWM using blink trigger counts as "crazy" :-)


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlm+tdUACgkQMOfwapXb+vLLvgCbBiWHvnsdIXonk5c7XkX6UjzB
bcAAn28XYPQlQGzM8ueuY64iL7E2GquD
=HOqZ
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
