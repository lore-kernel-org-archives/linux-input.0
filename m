From: Pavel Machek <pavel@ucw.cz>
Subject: Vibrations in input vs. LED was Re: [PATCH v2 0/3] led:
 ledtrig-transient: add support for hrtimer
Date: Thu, 14 Sep 2017 22:58:04 +0200
Message-ID: <20170914205804.GA24339@amd>
References: <20170913175400.42744-1-dtwlin@google.com>
 <20170913202032.GA30844@amd>
 <9c75c3a9-4123-c7f3-7725-45ba752d672a@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9c75c3a9-4123-c7f3-7725-45ba752d672a@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-input@vger.kernel.org
Cc: David Lin <dtwlin@google.com>, corbet@lwn.net, rpurdie@rpsys.net, hdegoede@redhat.com, gregkh@linuxfoundation.org, robh@kernel.org, romlem@google.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2017-09-14 21:31:31, Jacek Anaszewski wrote:
> Hi David and Pavel,
>=20
> On 09/13/2017 10:20 PM, Pavel Machek wrote:
> > Hi!
> >=20
> >> These patch series add the LED_BRIGHTNESS_FAST flag support for
> >> ledtrig-transient to use hrtimer so that platforms with high-resolutio=
n timer
> >> support can have better accuracy in the trigger duration timing. The n=
eed for
> >> this support is driven by the fact that Android has removed the timed_=
ouput [1]
> >> and is now using led-trigger for handling vibrator control which requi=
res the
> >> timer to be accurate up to a millisecond. However, this flag support w=
ould also
> >> allow hrtimer to co-exist with the ktimer without causing warning to t=
he
> >> existing drivers [2].
> >=20
> > NAK.
> >=20
> > LEDs do not need extra overhead, and vibrator control should not go
> > through LED subsystem.
> >=20
> > Input subsystem includes support for vibrations and force
> > feedback. Please use that instead.
>=20
> I think that most vital criterion here is the usability of the
> interface. If it can be harnessed for doing the work seemingly
> unrelated to the primary subsystem's purpose, that's fine.
> Moreover, it is extremely easy to use in comparison to the force
> feedback one.

Well, no.

Kernel is supposed to provide hardware abstraction, that means it
should hide differences between different devices.

And we already have devices using input as designed. We don't want to
have situation where "on phones A, D and E, vibrations are handled via
input, while on B, C and F, they are handled via /sys/class/leds".

If we want to have discussion "how to make vibrations in input
easier to use", well that's fair. But I don't think it is particulary hard.

If we want to say "lets move all vibrations from input to LED
subsystem"... I don't think that is good idea, but its a valid
discussion. Some good reasons would be needed.

But having half devices use one interface and half use different one
is just bad... especially when only reason to do it that way is
"David wants to do it that way, android library made a mistake and he
now wants it to propagate to whole world".

Thank you,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlm67VwACgkQMOfwapXb+vLgGACgtADyyzoRKFeohSkmTd54fnJ4
Kp0An3oLkcBy2pkyLmNGnTWr0Y2cIfZV
=81g0
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
