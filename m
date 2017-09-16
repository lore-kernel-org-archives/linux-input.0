From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Vibrations in input vs. LED was Re: [PATCH v2 0/3] led:
 ledtrig-transient: add support for hrtimer
Date: Sat, 16 Sep 2017 14:59:58 +0200
Message-ID: <20170916125958.GA6034@amd>
References: <20170913175400.42744-1-dtwlin@google.com>
 <20170913202032.GA30844@amd>
 <9c75c3a9-4123-c7f3-7725-45ba752d672a@gmail.com>
 <20170914205804.GA24339@amd>
 <CAKdAkRTJTYsJuAsjOt2Bgutsg6zwhU0LHmNOH9UXsHB3PkLCbw@mail.gmail.com>
 <7a611993-ebaa-08bb-b10c-ebe4fb9ca33a@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7a611993-ebaa-08bb-b10c-ebe4fb9ca33a@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, David Lin <dtwlin@google.com>, Jonathan Corbet <corbet@lwn.net>, Richard Purdie <rpurdie@rpsys.net>, Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> If we want to have discussion "how to make vibrations in input
> >> easier to use", well that's fair. But I don't think it is particulary =
hard.
> >>
> >=20
> > I would like to know more about why you find the FF interface hard,
>=20
> led-transient trigger can be activated using only following bash
> commands:
>=20
> # echo 1 > state
> # echo 1000 > duration
> # while [ 1 ]; do echo 1 > activate; sleep 3; done
>=20
> Could you share sample sequence of commands to use ff driver?

Well, LED transient trigger can be activated like that. But that will
not work on any hardware currently supported by the mainline kernel.

Equivalent command with forcefeedback is:

(echo 5; sleep 1; echo -1) | sudo fftest /dev/input/event2

You would not want to use either in production.

> >> But having half devices use one interface and half use different one
> >> is just bad...
> >=20
> > Completely agree here. I just merged PWM vibra driver from Sebastian
> > Reichel, we already had regulator-haptic driver, do we need gpio-based
> > one? Or make regulator-based one working with fixed regulators?
>=20
> Just to clarify: the background of this discussion is the question
> whether we should remove the following lines from
> Documentation/leds/ledtrig-transient.txt:
>=20
> -As a specific example of this use-case, let's look at vibrate feature on
> -phones. Vibrate function on phones is implemented using PWM pins on SoC =
or
> -PMIC. There is a need to activate one shot timer to control the vibrate
> -feature, to prevent user space crashes leaving the phone in vibrate mode
> -permanently causing the battery to drain.
> whether we should remove the following use case example from
>=20
> In effect Pavel has objections to increasing ledtrig-transient
> interval accuracy by adding hr_timer support to it, because vibrate
> devices, as one of the use cases, can benefit from it.
>=20
> So there are two issues:
> 1. Addition of hr_timer support to LED trigger.
> 2. Removal of vibrate devices use case from ledtrig-transient doc.
>=20
> I am in favour of 1. and against 2. since we're not gaining anything
> by hiding information about some kernel functionality when it will
> still be there. It also doesn't define the location of any vibrate
> device drivers, since sheer leds-gpio driver can be used for that
> purpose.

I would like to see reasonable explanation why we want 1. (and
vibrations are not that) and certainly 2. because we don't want people
to use LED subsystem for vibrations.

We already have perfectly good interface for that.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlm9IE4ACgkQMOfwapXb+vJqkACaAjYSVnDrUpq5zMn0xtukGIAv
YaIAoItq3hYv1KkOBnE6TZAgtsQeyqRK
=I4XU
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
