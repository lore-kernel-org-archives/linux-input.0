From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: edt-ft5x06 question
Date: Wed, 15 Nov 2017 10:32:08 +0100
Message-ID: <1510738328.18096.32.camel@kernelconcepts.de>
References: <9036109f-ae02-01de-77a7-13442e3d9e53@micronovasrl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-IKTcFEhcdME6ZavYVXLx"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([188.40.83.200]:58704 "EHLO
        mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756098AbdKOJzP (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 15 Nov 2017 04:55:15 -0500
In-Reply-To: <9036109f-ae02-01de-77a7-13442e3d9e53@micronovasrl.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Giulio Benetti <giulio.benetti@micronovasrl.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@bitmath.org, linux@roeck-us.net, stefan.schoefegger@ginzinger.com, luca@lucaceresoli.net, martink@posteo.de, a.mathur@samsung.com


--=-IKTcFEhcdME6ZavYVXLx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Giulio

On Tue, 2017-11-14 at 22:42 +0100, Giulio Benetti wrote:
> I'm using ft5206 with edt-ft5x06.c driver,
> but what I see is that registers with M09 or M06
> seem different from focaltech ft5206=20
> https://www.buydisplay.com/download/ic/FT5206.pdf
>=20
> For example, except address 0x80 for threshold register(thgroup),
> all the others don't appear:
> GAIN 0x30 or 0x92 should be 0x82(thcal maybe?)
>=20
> Can someone clarify this?

The Registers depend heavily on the actual firmware flashed into the
ft5x06. M06 and M09 refers to the resp. touch glasses from EDT (hence
the name of the driver), who have a custom firmware installed. Despite
being based on the same focaltec chips, their i2c interface is totally
different...

Most non-EDT ft5x06 touches do use a communication protocol similiar to
the M09 series. Unfortunately I've witnessed a lot that it is not
possible to rely on the registers that are supposed to provide
vendor/model information (according to the Focaltec datasheet). It
always takes a little bit of tweaking to figure out what resolution=20
they actually provide (which is possible with the custom EDT-M09
firmware).

There is a patch series I've sent to this mailinglist (and need to
resend, because the first part of the patch series is bogus) that might
improve the model detection a little bit, but it by no means is
bulletproof.

(see https://patchwork.kernel.org/patch/9987467/ and=20
https://patchwork.kernel.org/patch/9987471/)

For non-EDT touches that are bonded together with a display it is a
reasonable assumption that the touch resolution matches the screen
resolution (Which I consider unfortunate: Why throw away more
resolution?).

Anyway if you have suggestions for improving this driver I am
interested in feedback.

Bye,
        Simon

--=20
     kernel concepts GmbH                 Simon Budig
     Sieghuetter Hauptweg 48              simon.budig@kernelconcepts.de
     D-57072 Siegen                       +49-271-771091-17
     http://www.kernelconcepts.de/
     HR Siegen, HR B 9613; Gesch=C3=A4ftsf=C3=BChrer: Ole Reinhardt
--=-IKTcFEhcdME6ZavYVXLx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQTPAwhwx6BA+WIUvUM7Y79Fd6yIcAUCWgwJmAAKCRA7Y79Fd6yI
cFQwAJwOC/mgnIJkyJdvvlBECZxzRfMB1wCfXYJ/oJZ+/fvZDx/PWhq+XXluj6c=
=b5JT
-----END PGP SIGNATURE-----

--=-IKTcFEhcdME6ZavYVXLx--

