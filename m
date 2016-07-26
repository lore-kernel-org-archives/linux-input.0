From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 4/5] input: touchscreen: support Allwinner SoCs'
 touchscreen
Date: Tue, 26 Jul 2016 17:13:11 +0200
Message-ID: <20160726151311.GG7190@lukather>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-5-git-send-email-quentin.schulz@free-electrons.com>
 <20160721062950.GB5993@lukather>
 <20160721064140.GA17658@dtor-ws>
 <20160725094542.GI7419@lukather>
 <20160725170839.GA27415@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:35441 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754198AbcGZPNO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jul 2016 11:13:14 -0400
Content-Disposition: inline
In-Reply-To: <20160725170839.GA27415@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org, lee.jones@linaro.org, antoine.tenart@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 25, 2016 at 10:08:39AM -0700, Dmitry Torokhov wrote:
> > > > ... but your driver isn't registered yet. How does input_report and
> > > > input_sync behave in such a case?
> > >=20
> > > This is explicitly allowed:
> > >=20
> > > "
> > > ...
> > >  * NOTE: input_event() may be safely used right after input device was
> > >  * allocated with input_allocate_device(), even before it is register=
ed
> > >  * with input_register_device(), but the event will not reach any of =
the
> > >  * input handlers. Such early invocation of input_event() may be used
> > >  * to 'seed' initial state of a switch or initial position of absolute
> > >  * axis, etc.
> > >  */
> > > "
> >=20
> > Good to know. Still, it feels like it should be handled explicitly,
> > instead of relying on the fact that we only call input_event in our
> > handler and that it works that way.
>=20
> Why? It is the documented property of input API and it is done so
> precisely so that you can register interrupt before registering input
> device. That is done because once registered input device is supposed to
> be fully-functional.  It does not matter for this driver but there are
> drivers out there that require interrupt handling as part of their
> "open" method.

I'm not questionning the input framework itself, and it works right
now because we all looked at that issue and found that it would work
even in the event of an early interrupt.

What I'm afraid of is that in a few weeks /monthes / years / decades,
someone will add something new in the driver without taking care of
that, and we will miss it because we won't have enough context.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXl34HAAoJEBx+YmzsjxAgNwoP/2eKDNzG8g6xMquD9F2QrOVv
ztykgMy8qd9KO9zy5/jC30OtHFfGjr4nwOPQqO8C+3QqBe5245u4KonQMPurQm38
wKgH91qpiLZapCjTlJpjDMFJe1gqzxZCclQlHHFn78TdfQJeO0RIaMpOIMFm4MSF
d7TzWQymK2S2pGj9XZCaDJucorXn+yAmJkS3BWqwMpHUVQ8RKJyrEX263vZnRzbf
u11e2XKTKpKNhlImT0mGPastvZjC6qR2lpwQTHWHkntr9FXjVhbbdqPh4BqjL/tZ
spuE2dBlM9i2R9YsSzrrPLoDlgKZ2AgjaQ7jI0BTJEqZcZcDL1rRtSZWygJQCtrK
BPu2qe5XUP5uPTBnliB80UUvvcO6KU+w0Piwdt4dkK/nH6H7ei/YkItpcb5/ImX1
J+C6eCRnIdz+18Mq42nOGs9b4/t1XnLrsE/0rLlvdWdYCvC8+lrzpTZuEjmufHm6
u6zSAd7JKYwViTud1RFHMp6ljMIOwqqtT8ZJPQr9NBH67Ea8+vISooam96dlF9wx
GT5h2eLuzrfxn68RPuZ8dqo8w4v0gzjc8lgUjkuMWJzFW9PCzfFTQi/PG48UCQ5k
R1e0ZKUZN/l3LzyyVRf4GZfQpSENUjcvN4iLxGYjKrU45lEIFB4sXhnzS29/dORl
98ISILG3nafEZZ6K7uFU
=NQCK
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--
