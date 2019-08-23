From: Filipe =?ISO-8859-1?Q?La=EDns?= <lains@archlinux.org>
Subject: Re: [Resubmit] Read battery voltage from Logitech Gaming mice
Date: Fri, 23 Aug 2019 15:48:07 +0100
Message-ID: <3c37ccc992d7979358e8472fbf52a583c6e1068f.camel@archlinux.org>
References: <20190822201849.28924-1-pedro@pedrovanzella.com>
         <CAO-hwJKQcTpmk8cVf-YmKu2awXv_53=qfpy2yfmy2rgMu_DEug@mail.gmail.com>
         <e6014a01-1094-9ec7-9b37-2abdf70e305f@pedrovanzella.com>
         <CAO-hwJ+=dAyFnUfiPSmiGpzYTj=9BPDdeKQOY7UoCOvwQ5CH7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ZL5yhscn243euPwV8D1/"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJ+=dAyFnUfiPSmiGpzYTj=9BPDdeKQOY7UoCOvwQ5CH7Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Pedro Vanzella <pedro@pedrovanzella.com>, Bastien Nocera <hadess@hadess.net>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


--=-ZL5yhscn243euPwV8D1/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-23 at 16:32 +0200, Benjamin Tissoires wrote:
> The problem I have with quirks, and that I explained to Filipe on IRC
> is that this is kernel ABI. Even if there is a very low chance we have
> someone using this, re-using the same drv_data bit in the future might
> break someone's device.

But we can reserve those bits. I don't expect there to be a ton of
devices that need to be quirked, so using the remaining bits should be
perfectly fine. Do you agree?

--=-ZL5yhscn243euPwV8D1/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0jW0leqs33gyftiw+JPGdIFqqV0FAl1f/J4ACgkQ+JPGdIFq
qV1G+g//WbYJozb4H2J6ysdXZTZSMtds+YY9NHGZ6oA7l4GPAiiIIBHl7NCdY5c1
F3J+MwhKjk+UrDx/CoLcJUbi1qcRamThb1CULX5PZgE4orvNZ02CNvfZPMF2I60G
1tj9bAyJft80sgB7fnLHnLUuhNDhQvALqFTlVZPUc9mcAWr85YJkp1GX215Woxa/
En5TyPZd9G/mLpTx+FzHHtCXfhHLkrIwe1E26bnAKyifdsNPX/Zat2WcglgTFZu8
kZwXVIUOtzqqawLUzFcfjTdiSmzqpsbmWW1ohFQCQLAMy9Xeg6syBlLBbeb7Pcxm
vxHXAObpyBazshnxtwjrAKqzV8Erjijy5mncOZ1USQQAEgwObZgJAgDZvrI3d3jc
24DtU/CbEMSGkQzVMa5oh3rwHjjVbW+k7gVrINCgY8d0woQvKw7EJ6cPp5yy2agO
mZLA5DzhFrHsiwQHbzYpDmtnbARJImUi0CTEi5+dEU05IrZZTdduUfwfmeUf7q9m
Y4kGBfG8HFHXBcONrl93cTpwNb3U8ZIYkd1aoG/W7Lmkas2rPakqRO1Tu9Aoe8xm
A2VecXM0nh/Z0mbZYk6fgjSkiOwEygUHtxXW5OalNcN5Eqw0rTy6lomgfNZMTFFj
DfRjzfKzMitVDFWrVP7hEQv23OmcVTqWNvLaspQ9+eCMtTC1jDs=
=aZob
-----END PGP SIGNATURE-----

--=-ZL5yhscn243euPwV8D1/--
