From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RESEND PATCH v6 04/11] dt-bindings: input: add DT bindings for
 max77650
Date: Fri, 22 Mar 2019 10:59:21 +0100
Message-ID: <20190322095920.GM27015@amd>
References: <20190318174228.18194-1-brgl@bgdev.pl>
 <20190318174228.18194-5-brgl@bgdev.pl>
 <20190322090927.GG27015@amd>
 <CAMRc=Md0-UkY07vkf+irqUKwHFSj=Nq3fBYKFRqNG9nzWv9YRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Nj4mAaUCx+wbOcQD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMRc=Md0-UkY07vkf+irqUKwHFSj=Nq3fBYKFRqNG9nzWv9YRw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh@kernel.org>
List-Id: linux-input@vger.kernel.org


--Nj4mAaUCx+wbOcQD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-03-22 10:55:26, Bartosz Golaszewski wrote:
> pt., 22 mar 2019 o 10:09 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
> >
> > On Mon 2019-03-18 18:42:21, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Add the DT binding document for the onkey module of max77650.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > > +     onkey {
> > > +             compatible =3D "maxim,max77650-onkey";
> > > +             linux,code =3D <KEY_END>;
> > > +             maxim,onkey-slide;
> > > +     };
> >
> > This is certainly wrong.
> >
> > "End" key is normal key on a keyboard, certainly not some kind of
> > slider.
> >
> > And this controller is likely to be used for power key, not end key,
> > right?
>=20
> But this is just an example of available properties, not a real use-case.

We can have example that makes sense, right?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Nj4mAaUCx+wbOcQD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyUsfgACgkQMOfwapXb+vL7oACfXt7TCBzA5aDs0AaHx7sSIh/y
OG4An0Bi8Rmg2n4GKLzXGDB4YzPwb4Gu
=DK14
-----END PGP SIGNATURE-----

--Nj4mAaUCx+wbOcQD--
