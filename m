From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Vibrations in input vs. LED was Re: [PATCH v2 0/3] led:
 ledtrig-transient: add support for hrtimer
Date: Wed, 20 Sep 2017 13:15:26 +0200
Message-ID: <20170920111526.GA3097@amd>
References: <20170913175400.42744-1-dtwlin@google.com>
 <20170913202032.GA30844@amd>
 <9c75c3a9-4123-c7f3-7725-45ba752d672a@gmail.com>
 <20170914205804.GA24339@amd>
 <ef3472a0-1e70-e64f-fe11-7fdfd768fc85@gmail.com>
 <20170916015809.GA5072@localhost>
 <9afbd987-b237-24d4-e16a-ddd7fa70766a@gmail.com>
 <20170917175013.GB13003@amd>
 <a17f76a4-9c9b-6154-6b5e-d30fd499efa7@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:32952 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751585AbdITLP3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 20 Sep 2017 07:15:29 -0400
Content-Disposition: inline
In-Reply-To: <a17f76a4-9c9b-6154-6b5e-d30fd499efa7@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: linux-input@vger.kernel.org, David Lin <dtwlin@google.com>, corbet@lwn.net, rpurdie@rpsys.net, hdegoede@redhat.com, gregkh@linuxfoundation.org, robh@kernel.org, romlem@google.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2017-09-18 22:43:40, Jacek Anaszewski wrote:
> Hi,
>=20
> On 09/17/2017 07:50 PM, Pavel Machek wrote:
> > Hi!
> >=20
> >>>> Do you think such an improvement could be harmful in some way,
> >>>> even if it was made optional?
> >>>
> >>> Of course, we can make LED timing accurate down to microseconds. It w=
ill
> >>> mean increased overhead -- for "improvement" human can not perceive.
> >>>
> >>> If someone has problems with LED delays not being accurate enough... =
we
> >>> may want to fix it. But that is not the case here, is it?
> >>
> >> AFAIR David was mentioning that the hr_timer support is perceivable
> >=20
> > He said that hr_timer support is perceivable _when he is driving
> > vibration motor_. Which he should not do in the first place.
> >=20
> > Yes, if the difference is perceivable with LED in non-crazy
> > configuration (*), we can take the patch. Is it? Do we have someone
> > not from Google observing it?
> >=20
> > (*) emulating PWM using blink trigger counts as "crazy" :-)
>=20
> How about adding CONFIG_LED_TRIGGERS_HR_TIMER_SUPPORT, guarding the
> hr timer support in triggers (timer trigger could also benefit from it)
> with it, and adding "(EXPERIMENTAL)" tag to the config description?

Why would we want to add code in the LED subsystem that is useless for
LEDs?
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnCTc4ACgkQMOfwapXb+vJGoQCgoo/6NOCFgdepohucKwDNmJw6
dQMAn1hvX9J2+E9ToW7aWOgeYn2WOaJJ
=di60
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
