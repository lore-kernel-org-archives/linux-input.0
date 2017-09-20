From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Vibrations in input vs. LED was Re: [PATCH v2 0/3] led:
 ledtrig-transient: add support for hrtimer
Date: Wed, 20 Sep 2017 13:29:40 +0200
Message-ID: <20170920112940.GB4283@amd>
References: <9c75c3a9-4123-c7f3-7725-45ba752d672a@gmail.com>
 <20170914205804.GA24339@amd>
 <CAKdAkRTJTYsJuAsjOt2Bgutsg6zwhU0LHmNOH9UXsHB3PkLCbw@mail.gmail.com>
 <7a611993-ebaa-08bb-b10c-ebe4fb9ca33a@gmail.com>
 <CAKdAkRT4MBKq-g9BfMVRENcTeoYRL+nvWfEtf578ySXmxap-Cg@mail.gmail.com>
 <0076adca-f843-f99f-09ce-b9839b3e7706@gmail.com>
 <20170917182251.GA15328@amd>
 <9d5d045e-5019-e132-9449-7fb40b1b7895@gmail.com>
 <CAKdAkRRsn+bV34yq9=Qqnp3D+DjWtGfrLAmF6pJCgvbyBqz2Cw@mail.gmail.com>
 <4226b524-35e1-16c0-f6ca-e339dd2eab1d@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4226b524-35e1-16c0-f6ca-e339dd2eab1d@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, David Lin <dtwlin@google.com>, Jonathan Corbet <corbet@lwn.net>, Richard Purdie <rpurdie@rpsys.net>, Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >>> I'd leave the decision to the user. We could add a note to the
> >>> Documentation/leds/ledtrig-transient.txt that force feedback interface
> >>> should be preferable choice for driving vibrate devices.
> >>> However only if following conditions are met:
> >>
> >> What I meant is that it is my decision, as a LED subsystem maintainer,
> >> to accept the addition of a note about some other subsystem offering
> >> an equivalent or even better substitute of the feature being available
> >> in the subsystem I am responsible for. And I will accept such a patch
> >> only if mentioned conditions are met.
> >=20
> > Having the wording in documentation does not in any way stops Android
> > folks from continuing [ab]using the transient trigger. But this is
> > their choice. The purpose of documentation is to document the best
> > practices, not all possible crazy solutions one can come up with.
>=20
> Yes. but if the information has been in place for years, we can't
> just remove it without giving an instruction on how to use the
> substitute.

I gave you information how to use the substitute.

I already suggested patch to documentation. If you do the same, maybe
we can agree on documentation update.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnCUSQACgkQMOfwapXb+vLysACgofyBm06BNJXInztADrzfJao/
hzgAnA3hZk7mdoPSX+RqchLgSiGdVZZW
=jomO
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
