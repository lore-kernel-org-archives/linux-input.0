From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Vibrations in input vs. LED was Re: [PATCH v2 0/3] led:
 ledtrig-transient: add support for hrtimer
Date: Sun, 17 Sep 2017 20:22:51 +0200
Message-ID: <20170917182251.GA15328@amd>
References: <20170913175400.42744-1-dtwlin@google.com>
 <20170913202032.GA30844@amd>
 <9c75c3a9-4123-c7f3-7725-45ba752d672a@gmail.com>
 <20170914205804.GA24339@amd>
 <CAKdAkRTJTYsJuAsjOt2Bgutsg6zwhU0LHmNOH9UXsHB3PkLCbw@mail.gmail.com>
 <7a611993-ebaa-08bb-b10c-ebe4fb9ca33a@gmail.com>
 <CAKdAkRT4MBKq-g9BfMVRENcTeoYRL+nvWfEtf578ySXmxap-Cg@mail.gmail.com>
 <0076adca-f843-f99f-09ce-b9839b3e7706@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0076adca-f843-f99f-09ce-b9839b3e7706@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, David Lin <dtwlin@google.com>, Jonathan Corbet <corbet@lwn.net>, Richard Purdie <rpurdie@rpsys.net>, Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > If your objection is that FF is not easily engaged from the shell -
> > yes, but I do not think that actual users who want to do vibration do
> > that via shell either. On the other hand, can you drop privileges and
> > still allow a certain process control your vibrator via LED interface?
> > With FF you can pass an FD to whoever you deem worthy and later revoke
> > access.
> >=20
> > IOW sysfs interfaces are nice for quick hacks, but when you want to
> > use them in real frameworks, where you need to think about proper
> > namespaces, isolation, etc, etc, other kinds of interfaces might suit
> > better.
>=20
> I'd leave the decision to the user. We could add a note to the
> Documentation/leds/ledtrig-transient.txt that force feedback interface
> should be preferable choice for driving vibrate devices.

We don't want to leave decision to the user; because then we'll end up
with userland applications having to support _both_ interfaces.

Plus, it is not really your decision. Dmitry is maintainer of input
subsystem, input was doing force feedback for 10+ years, and he
already made a decision.

> However only if following conditions are met:
> - force feedback driver supports gpio driven devices
> - there is sample application in tools/input showing how to
>   setup gpio driven vibrate device with use of ff interface
> - it will be possible to setup vibrate interval with 1ms accuracy,
>   similarly to what the discussed patch allows to do

I agree these would be nice. Interested parties are welcome to help
there. But I don't think this should have any impact on LED
susbystem. Force feedback just does not belong to LED subsystem.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlm+vXoACgkQMOfwapXb+vK7WQCdETPjVfk88p9hYTc1h+lJ/Fo/
xZkAn3zDDhhU+g3iFGe7KypE5/9jn00W
=DtYN
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
