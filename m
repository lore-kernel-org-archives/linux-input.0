From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Vibrations in input vs. LED was Re: [PATCH v2 0/3] led:
 ledtrig-transient: add support for hrtimer
Date: Sun, 17 Sep 2017 23:15:36 +0200
Message-ID: <20170917211536.GA28812@amd>
References: <20170913175400.42744-1-dtwlin@google.com>
 <20170913202032.GA30844@amd>
 <9c75c3a9-4123-c7f3-7725-45ba752d672a@gmail.com>
 <20170914205804.GA24339@amd>
 <CAKdAkRTJTYsJuAsjOt2Bgutsg6zwhU0LHmNOH9UXsHB3PkLCbw@mail.gmail.com>
 <7a611993-ebaa-08bb-b10c-ebe4fb9ca33a@gmail.com>
 <CAKdAkRT4MBKq-g9BfMVRENcTeoYRL+nvWfEtf578ySXmxap-Cg@mail.gmail.com>
 <0076adca-f843-f99f-09ce-b9839b3e7706@gmail.com>
 <20170917182251.GA15328@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170917182251.GA15328@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, David Lin <dtwlin@google.com>, Jonathan Corbet <corbet@lwn.net>, Richard Purdie <rpurdie@rpsys.net>, Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > However only if following conditions are met:
> > - force feedback driver supports gpio driven devices

INPUT_PWM_VIBRA option was just merged into v4.14.

 									Pavel



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlm+5fgACgkQMOfwapXb+vJU+gCeJh4QwWPCaH1UbrJfJBOV3jAV
fPwAn3Qsx128vg1mgeHN6p4hNszGOxUw
=hg0Q
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
