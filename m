From: Kevin Fenzi <kevin@scrye.com>
Subject: Re: Lenovo Active Pen 2 and wacom tablet on yoga 920
Date: Fri, 8 Dec 2017 14:24:01 -0800
Message-ID: <2c3db740-8afa-2c35-f4b8-fe38253ff6fc@scrye.com>
References: <458e9d7a-2599-915c-c15e-d08b43f4998d@scrye.com>
 <CANRwn3TwZ3xsFGBPC_OLm4tVEc5ZRpmYkiMNnFHjpPre8EXy2g@mail.gmail.com>
 <cae6e993-80af-9acd-b52f-34e493908820@scrye.com>
 <CANRwn3QhW8Ug5=8N3_7hhM-9MdKwY2xtuvp7P5J=2qYo3Y1MPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="dEmlxwpU05BkJ13niBgKNAfP9cjS0wU9J"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 96-71-165-137-static.hfc.comcastbusiness.net ([96.71.165.137]:47100
        "EHLO mail.scrye.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1752350AbdLHWYH (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 8 Dec 2017 17:24:07 -0500
In-Reply-To: <CANRwn3QhW8Ug5=8N3_7hhM-9MdKwY2xtuvp7P5J=2qYo3Y1MPQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dEmlxwpU05BkJ13niBgKNAfP9cjS0wU9J
Content-Type: multipart/mixed; boundary="p9BuH5bgHX8PA5jPjR7v5D2acaQgICiwM";
 protected-headers="v1"
From: Kevin Fenzi <kevin@scrye.com>
To: Jason Gerecke <killertofu@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>
Message-ID: <2c3db740-8afa-2c35-f4b8-fe38253ff6fc@scrye.com>
Subject: Re: Lenovo Active Pen 2 and wacom tablet on yoga 920
References: <458e9d7a-2599-915c-c15e-d08b43f4998d@scrye.com>
 <CANRwn3TwZ3xsFGBPC_OLm4tVEc5ZRpmYkiMNnFHjpPre8EXy2g@mail.gmail.com>
 <cae6e993-80af-9acd-b52f-34e493908820@scrye.com>
 <CANRwn3QhW8Ug5=8N3_7hhM-9MdKwY2xtuvp7P5J=2qYo3Y1MPQ@mail.gmail.com>
In-Reply-To: <CANRwn3QhW8Ug5=8N3_7hhM-9MdKwY2xtuvp7P5J=2qYo3Y1MPQ@mail.gmail.com>

--p9BuH5bgHX8PA5jPjR7v5D2acaQgICiwM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/08/2017 01:24 PM, Jason Gerecke wrote:
> Sorry about the delay in getting back to you on this issue. It looks

No problem at all. Thanks for looking into it!

> like there are several different reasons that we could be getting
> EREMOTEIO from the lower levels. Would you mind running the sysinfo.sh
> script described at [1] and filing a bug to the project with the
> output attached?=20

Done:
https://github.com/linuxwacom/wacom-hid-descriptors/issues/9

> This should give me an idea of what kind of hardware
> is present in your 920. You might also try doing the following to see
> if anything interesting gets printed to the dmesg log:
>=20
>     # echo "file drivers/i2c/*.c +p" > /sys/kernel/debug/dynamic_debug/=
control
>     # modprobe -r wacom
>     # modprobe wacom

Seems to say:

# echo "file drivers/i2c/*.c +p" > /sys/kernel/debug/dynamic_debug/contro=
l
-bash: /sys/kernel/debug/dynamic_debug/control: Operation not permitted

>=20
> Some of the I2C modules (which I suspect your sensor is using) log
> debug messages prior to returning EREMOTEIO. The above will cause
> these debug messages to be printed to dmesg and then reload the wacom
> module. With luck, we might gain a little more information about
> what's triggering the error.

Sadly not... but I will poke and it and see if I can figure out why it's
not working.

kevin


--p9BuH5bgHX8PA5jPjR7v5D2acaQgICiwM--

--dEmlxwpU05BkJ13niBgKNAfP9cjS0wU9J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESz7rprBJHpbnMnrQSzew2A/7u14FAlorEQEACgkQSzew2A/7
u17wlg/+JvAX/ajCFwJwfUra/TKCeFkFdIwmTVsZ4/2b3/BkyiN+u6ncVx3nVMas
qAn1NHffouFvzOb8xTWZe2K5WguTA41Dc2yJSfBxROcQSOp9jD5lwh9VYjoJR7SS
JAiAHgsvjk8923MJkzdkBscNrPBg3V8HpDliNfyUv7bX3FAlfL2Bxk2nKCdAkKQD
kB6krRo009a+DmjJWAJnWh6S3XnRrGaTSGsfb0RJRTzJGjmgCx3HNvaD84a0ihhh
/Z85wHuo085kvLAUXAIYFixkW+xn+gjXGpjxefI0VWvlhS2vwzVB3+w0gPmsEZN0
drwmMl5Fg3tJudF/0GUu4LCHR3DSMtTT1yS+DEBr4P+S5sgmRcYe10FiYaFtQ514
G2xkKKfRdP9CZwH94VivJSCqDMyEqcFpkDGqMkTCjd0E96K4BtxPyX9sSN6LMaPc
xewuf+N3g1QZr7z/kdXhEucz3EsXCbF3+dCALeOUDYfOzmArhPB8yZ6z6rQhe0NW
2ZrD46oWs17uguZOkWa+Zri5sU6W/aXpNdJUMehKCrICEfFU7rzYJ+/2TXqx8Wzm
xbHSqR0eby2fi0GEPI3xmL/ggnK4uKgJ3O4+akuwtfkYApfIm/kfC+GbKiDRs5VA
lZduoPvWp47C1RbKRAaKXOMBoVp4hlpwDqpyeyu/6du/ujh9l40=
=5Klr
-----END PGP SIGNATURE-----

--dEmlxwpU05BkJ13niBgKNAfP9cjS0wU9J--
