From: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH 4/4] HID: multitouch: remove unneeded else conditional
 cases
Date: Thu, 9 Aug 2018 14:03:22 -1000
Message-ID: <20180810000322.my7n5fdzq4f2o6fa@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
 <d35643165a1d1972fd91e547922697a3c785a413.1530402641.git.joeypabalinas@gmail.com>
 <CAO-hwJ+ZHb8xyr=1RgVROvP2=yzmepccVOqZM5qP3hbOEYEo9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xgk3gjfxx6yyurj6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+ZHb8xyr=1RgVROvP2=yzmepccVOqZM5qP3hbOEYEo9g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Joey Pabalinas <joeypabalinas@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Daniel Martin <consume.noise@gmail.com>
List-Id: linux-input@vger.kernel.org


--xgk3gjfxx6yyurj6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 10:17:58AM +0200, Benjamin Tissoires wrote:
> This one looks good.
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>=20
> Just FYI, I sent out a big refactor of the hid-multitouch code. Jiri
> should be still reviewing it, so I am not so sure who will have to
> rebase which series on top of the other, but someone between us will
> have to do it :)

Somehow also missed this reply... I guess I messed up my LKML
filters somewhere. Noted, thanks for the review; I'll check
your trees for the refactor when (if) I do my v2.

--=20
Cheers,
Joey Pabalinas

--xgk3gjfxx6yyurj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlts1kkACgkQruvLfWhy
VBkIjA//c1VMxyu78bYExhBC9NID+s3iORVYfHduxuSEtjn1NJqcKeDYatnV1av/
xqkBdvj8UJ4EH3anEKTXxG64K8Y/xukNgUyzCs42AH0cdLR9rL7CiW/po//Kk/n1
qMaFPxzCDFH+Ae7Na2VIlTTYZKv/t2NYcevkMqBvOIN8FrPR3wSbfmnaZxCxZtVM
ftLBXkSX2Wrx5LLZklpXHiGRJCAqHa7wpf/lnf9xbQ7NfOoaQ4cRN+3zZoYdnzIZ
LRJFfGcSVWWdW8zLVfS+8IVNqnNcrtNzokDjkP0DyI2fdfEQkLbRKAi2XRbjRAlA
WRlv5YjDr9MQjMdfBUdIMNIWbZPhaxKxtncYbe26pu1nvklT6NzK+rv98rnzpmpK
6ODaWbU5824DjoRhhljXXSmo4n68FuqUxOiIH4XXkEeFdmuBYf6E8tat4m8x50hx
hGtx2y1NcqhnnZRLeZixYH8zs418SBVU7SGYZnGw8Uz/IxUf7BTqgWsxg3Qasj8/
MXSeqstEuljmAl/QE8klREJiy2wvCNCuzxBhxBfvaRZV25uTtgJ4BjWSiMFUAkLn
lfxQoHKynykSerhR64fi6MT29l5MzwZbTtMyZ3OTtb+kR9HctNQUfJv9Z4PcVdHI
Cd1KsVTbWGPYsPJDW4pqxhprkOObdAxA41r7s1I5eoiE4nN9gNQ=
=A/21
-----END PGP SIGNATURE-----

--xgk3gjfxx6yyurj6--
