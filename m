From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] Input: raspberrypi-ft5406: Add Raspberry Pi Touchscreen driver
Date: Fri, 26 Feb 2016 12:15:12 -0800
Message-ID: <87vb5bi5yn.fsf@eliezer.anholt.net>
References: <1456479036-13174-1-git-send-email-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:44495 "EHLO anholt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422697AbcBZUWf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Feb 2016 15:22:35 -0500
In-Reply-To: <1456479036-13174-1-git-send-email-lkundrak@v3.sk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: linux-input@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, Stephen Warren <swarren@wwwdotorg.org>, Gordon Hollingworth <gordon@raspberrypi.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Lubomir Rintel <lkundrak@v3.sk> writes:

> Raspberry Pi uses a FT5406 attached to the VideoCore's I2C bus. The
> firmware runs a thread that periodicaly does a register dump to a shared
> memory window.  The interrupt and wake signals seem disconnected.
>
> This driver is based on the driver by Gordon Hollingworth. Notable change=
s:
>  - Changed to use input polldev instead of a dedicated thread
>  - Streamlined the probe routing with devm_*() functions
>  - Get a memory window from the device tree instead of via firmware call
>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Gordon Hollingworth <gordon@raspberrypi.org>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
> A few notes/questions; to the bcm2835 crowd:
>
> - Tested on RPi2 (with some changes, see below) with the touchscreen conn=
ected
>   only to the DSI connector (the cables to I2C1 not in place).
>
> - This now uses the memory window that needs to be set up by the bootload=
er.=20
>
>   The necessary change to u-boot (not submitted yet) is here:
>   https://github.com/lkundrak/u-boot/commit/860614e8.patch
>
>   Is this okay? It makes the driver simpler as if we called firmware dire=
ctly.
>
> - It would probably be best if we could access the I2C directly.
>
>   According to Gordon Hollingworth it's not possible, since the VideoCore
>   uses the bus for its business too (power control).
>
>   Could we perhaps convince Raspberry Pi to include a more generic I2C
>   interface via firmware?
>
> - The driver doesn't work now, since when the gpio driver sets the gpios =
0 and 1=20
>   to alt0 the firmware stops updating the buffer.
>
>   This might be a firmware bug? The firmware not being able to access I2C
>   might not be a good thing in any case?
>
>   No idea why this doesn't happen with the downstream kernel; their gpio =
driver
>   is mostly the same and they set the 0 and 1 gpios to alt0 too.

Overally, this whole "just have the firmware run all of our device
drivers" is something I'm not a fan of.  I understand that we need to
compromise on a few things (thermal appears to be one), but a generic
i2c driver for a touchscreen doesn't seem like such a case.

My plan had been to write a native driver once I got DSI going.  We
should be able to use pinctrl to steal the pins to an i2c adapter that
we own.  Hopefully someone from the Foundation could clarify which i2c
bus we can definitely own -- I think i've been seeing issues with the
firmware talking to the busses behind my back.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW0LJRAAoJELXWKTbR/J7oKHIP/2boa2LcSqS2pQ2E8RpHyhkk
jY95yOl7N3m7BQJ/1MPlsObTBpxSAatKyUoWDFKi9X9er9m9t6aYM+i6ZO+LwUJF
o8yaevdtp8m2EGQaFkihlBssT3ILmPePFN0bP5ecUr8/XLVtkly9PwAgy3otRTR8
wiISfCAkM02RDLiNQseYrCkETKnTx43wojpbJCH0KGWcOwFQ/Xso3BzoTficuaxv
iA3N9UsPdoC/y339quyXg2rT6NgBYX+Lb08PEZA+BTJ6hribZldBmkhoB1Cz9kzi
BIp1j8yYhC3+HtklVlwA1Xcz02mFqTKZ7FUi9hQv5qlUy0zy0wKcTJDAARVnYSGs
oXeWbavktf57RRNTy2l5y/d9Zvl1Qc3hRnZ+6jqxgVcAB+EycnjSn3R20Eweyk/T
VJhs8yRtF5ckCt27hS2CxuZbBFH0xwjdgzNpEH3jvGPaEoUdOzL8hbcGqAg4u5fT
T4O3Jdazij+ckGtKI+ARz2TJp68p6R1T7N409seBLkOu3ZI5kX2HXOFeZFYA0Avp
V79SH0EpT5GVe6yY2jvPcdxsRGFMAJvLc5Wy0RD29cHLs2ohncQhZCRNv5pNDhWe
gy25ZsF5PwvITJDnPZIYXtugKPQqcysJYzkWBgt+4xoZgJvsm35cSEfFR31kbETK
JmD+gQzuSPR/h4QBbxMb
=5zBa
-----END PGP SIGNATURE-----
--=-=-=--
