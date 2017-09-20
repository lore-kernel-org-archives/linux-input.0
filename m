From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Vibrations in input vs. LED was Re: [PATCH v2 0/3] led:
 ledtrig-transient: add support for hrtimer
Date: Wed, 20 Sep 2017 13:26:27 +0200
Message-ID: <20170920112627.GA4283@amd>
References: <20170913175400.42744-1-dtwlin@google.com>
 <20170913202032.GA30844@amd>
 <9c75c3a9-4123-c7f3-7725-45ba752d672a@gmail.com>
 <20170914205804.GA24339@amd>
 <CAKdAkRTJTYsJuAsjOt2Bgutsg6zwhU0LHmNOH9UXsHB3PkLCbw@mail.gmail.com>
 <7a611993-ebaa-08bb-b10c-ebe4fb9ca33a@gmail.com>
 <CAKdAkRT4MBKq-g9BfMVRENcTeoYRL+nvWfEtf578ySXmxap-Cg@mail.gmail.com>
 <0076adca-f843-f99f-09ce-b9839b3e7706@gmail.com>
 <20170917182251.GA15328@amd>
 <9d5d045e-5019-e132-9449-7fb40b1b7895@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9d5d045e-5019-e132-9449-7fb40b1b7895@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, David Lin <dtwlin@google.com>, Jonathan Corbet <corbet@lwn.net>, Richard Purdie <rpurdie@rpsys.net>, Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> However only if following conditions are met:
> >> - force feedback driver supports gpio driven devices
> >> - there is sample application in tools/input showing how to
> >>   setup gpio driven vibrate device with use of ff interface
> >> - it will be possible to setup vibrate interval with 1ms accuracy,
> >>   similarly to what the discussed patch allows to do
> >=20
> > I agree these would be nice. Interested parties are welcome to help
> > there. But I don't think this should have any impact on LED
> > susbystem. Force feedback just does not belong to LED subsystem.
>=20
> You cut off important piece of my text from the beginning of this
> paragraph. It was:
>=20
> > I'd leave the decision to the user. We could add a note to the
> > Documentation/leds/ledtrig-transient.txt that force feedback interface
> > should be preferable choice for driving vibrate devices.
> > However only if following conditions are met:

And that's very bad idea.

As a user of these interfaces, I am telling you: I want _single_
kernel interface to control vibration. Not different interfaces
depending on which phone I'm running at.

> What I meant is that it is my decision, as a LED subsystem maintainer,
> to accept the addition of a note about some other subsystem offering
> an equivalent or even better substitute of the feature being available
> in the subsystem I am responsible for. And I will accept such a patch
> only if mentioned conditions are met.

If you want to improve input, please go ahead.

If you want to encourage haptic feedback to use LED subsystem, that is
not welcome.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnCUGMACgkQMOfwapXb+vLKhwCgqKxjB3ltazdx0MwlGl+KGQ7J
g7MAoI3zBYqmtVZSOWv1pPDMO7Bs3eN5
=Y5ph
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
