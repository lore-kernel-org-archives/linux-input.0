From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 12/13] input: max77650: add onkey support
Date: Thu, 31 Jan 2019 12:28:13 +0000
Message-ID: <20190131122813.GB20797@sirena.org.uk>
References: <20190129133545.1931-1-brgl@bgdev.pl>
 <20190129133545.1931-14-brgl@bgdev.pl>
 <20190130185328.GA149208@dtor-ws>
 <CAMRc=McaqqmU6S_Yz35ZMvhWtWO4hTASA0fmL5CT4JizbYgu4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMRc=McaqqmU6S_Yz35ZMvhWtWO4hTASA0fmL5CT4JizbYgu4Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 31, 2019 at 09:15:01AM +0100, Bartosz Golaszewski wrote:

> I'm not sure what the policy is on merging MFD drivers, but I'm seeing
> that Mark Brown has already picked up the regulator part into his tree
> (including the binding document). I think you can just pick up the
> input patches and it will simply not show up in Kconfig until the core
> mfd module is upstream.

> @Mark: could you please confirm it?

Right, as it's a new MFD the Kconfig will stop it causing build breakage
until the MFD is merged.  I'm doing it partly just to cut down on the
amount of mail from resends while the rest of the series gets reviewed.

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxS6dwACgkQJNaLcl1U
h9BBNAf/Yq7Uoem9cGciS63O6v97feMamBfser9PLXATQwLIfr7vuvbz8Ig1I/jt
1UQPV4xcX4J6Oj13T5hUuc6BgQ7eGEwwHE4fDLbSs5Ze2Hj1Brd9sM7ER/Ro3L3m
Xuz7lFta+tF8gWGtdX8bKyJEcIfWOtawyLhIsCZ7qSWE44x5yUmUmV9kxSpXyAnI
IfDJnfSW1E3XHt5WjfpIcDIxvup1fPxIstkHts7+OdsQcIcSUmrnFIvuzmbq94/z
zvyu2vj0Qm0DkkGQDYfVMdINpac608CdtXlAUQ1F4+ImRgSDNn32QZ9Jde+1190c
3HjaOajFH7egd9TFMTJxLaHaiEHaeA==
=y+sH
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
