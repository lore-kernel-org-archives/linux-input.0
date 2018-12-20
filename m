From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v2 2/2] input: add official Raspberry Pi's touchscreen driver
Date: Thu, 20 Dec 2018 10:39:07 -0800
Message-ID: <87r2ecdovo.fsf@anholt.net>
References: <20181211112408.9524-1-nsaenzjulienne@suse.de> <20181211112408.9524-3-nsaenzjulienne@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211112408.9524-3-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-rpi-kernel@lists.infradead.org, stefan.wahren@i2se.com, agraf@suse.de, afaerber@suse.com, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Corentin Labbe <clabbe.montjoie@gmail.com>, Mark Jonas <mark.jonas@de.bosch.com>, Masanari Iida <standby24x7@gmail.com>, Heiko Schocher <hs@denx.de>, Hans de Goede <hdegoede@redhat.com>, Eugen Hristev <eugen.hristev@microchip.com>, Zhu Yi <yi.zhu5@cn.bosch.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--=-=-=
Content-Type: text/plain

Nicolas Saenz Julienne <nsaenzjulienne@suse.de> writes:

> Add's support to Raspberry Pi's 7" Touch device. Instead of using a
> conventional bus all information is copied into a memory mapped area by
> RPi's firmware.
>
> Based on the driver found in RPi's kernel repository.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

While I wish we could just have a native driver instead, it does make
sense to have this driver upstream given the constraints.

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlwb4csACgkQtdYpNtH8
nugdkQ/+LY9jN6gEKsBN58yufoqoWA2ZTKuYIcPGi94pLuVG/WJ+JHu/FRnHCFln
+I+BrPqPXPFndixY6UStBgj+xDPqUXbwbrXO+C4uc//0cdROP5zi4NLN3Pu+6agX
VgwbpP4SUHhMVlq8MS0zywRtkyYF2Zp8rFho9QI/+E1/4ITOto+Goj5WESCXIGNg
IpO7/yY0g+yAZca2UtK2OUDZyWRFmUBymXqCQhJ6lyH9AhwNxbOBxfNZWzvZBXpr
kZhWtCVys9IDGCfzMLfz/IKwYwZF2kNtxVm3unIQbFN4REf1RnQj8VD5X5sVHJ2B
Ju5ZpksCTevQfHy4JL/sxvAaNJ8BXJ84eIuvHzXVqFCO0lqClRrnr77G3qZdsUC0
vo3v8IlEhb6QtLVQ7SgkG4CuN4lIk2eI9Y8Adpia5iR8CZW1JnZDHwWn/ccgduoJ
PwQpDJJeAothSpa7NFbmkdMEa1qEP/AZ5ZchsPiRTocLKS3f/dWJ8JbGJ/tc70WZ
VumGiaPsR1dGCjEabyKSAKQklLcJb3J2uIDfhhPAybEhnS2xajRnyRCtAw/aR1Gg
JoVn8JwuUDiAnw2zLbljouX1VqTXdNNNPOZZAVeOTGOcVShWT14gtekWXwh6noJO
kzdyZTrj+9lkJTHMv6/5tRUoKMBqem/dCjUGwwJNqxHcUMHNgPI=
=cJa8
-----END PGP SIGNATURE-----
--=-=-=--
