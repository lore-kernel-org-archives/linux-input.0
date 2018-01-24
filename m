From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH 4/4] Input: mms114 - add support for mms152
Date: Wed, 24 Jan 2018 21:04:08 +0100
Message-ID: <20180124200408.GB705@gmail.com>
References: <20180124193804.155654-1-dmitry.torokhov@gmail.com>
 <20180124193804.155654-5-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180124193804.155654-5-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Simon Shields <simon@lineageos.org>, Andi Shyti <andi.shyti@samsung.com>, Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dmitry,

On Wed, Jan 24, 2018 at 11:38:04AM -0800, Dmitry Torokhov wrote:
> From: Simon Shields <simon@lineageos.org>
>=20
> @@ -241,12 +251,28 @@ static int mms114_get_version(struct mms114_data *d=
ata)
>  	u8 buf[6];
>  	int error;
> =20
> -	error =3D __mms114_read_reg(data, MMS114_TSP_REV, 6, buf);
> -	if (error < 0)
> -		return error;
> +	switch (data->type) {
> +	case TYPE_MMS152:
> +		error =3D __mms114_read_reg(data, MMS152_FW_REV, 3, buf);
> +		if (error)
> +			return error;
> +		buf[3] =3D i2c_smbus_read_byte_data(data->client,
> +						  MMS152_COMPAT_GROUP);
> +		if (buf[3] < 0)
> +			return buf[3];

buf is unsigned.

Maybe
		error =3D i2c_smbus_read_byte_data(data->client,
						  MMS152_COMPAT_GROUP);
		if (error < 0)
			return error;
Instead?


> +		dev_info(dev, "TSP FW Rev: bootloader 0x%x / core 0x%x / config 0x%x, =
Compat group: %c\n",
> +			 buf[0], buf[1], buf[2], buf[3]);
> +		break;
> +
> +	case TYPE_MMS114:
> +		error =3D __mms114_read_reg(data, MMS114_TSP_REV, 6, buf);
> +		if (error)
> +			return error;
> =20
> -	dev_info(dev, "TSP Rev: 0x%x, HW Rev: 0x%x, Firmware Ver: 0x%x\n",
> -		 buf[0], buf[1], buf[3]);
> +		dev_info(dev, "TSP Rev: 0x%x, HW Rev: 0x%x, Firmware Ver: 0x%x\n",
> +			 buf[0], buf[1], buf[3]);
> +		break;
> +	}
> =20
>  	return 0;
>  }


Best regards
Marcus Folkesson

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlpo5rIACgkQiIBOb1ld
UjJyrxAAx3k5sjvQDliSwHEnJ+C2kdWcjs0YeNJCUzwX4DbK4/gBgj/w1dxEmigD
6an9VyrQdSPHbuHWxqZF1FRE3M7TYB/P9xdaSAwRv8kNoqLb0eN7HXyia5/GMTbk
ei7Dk8YJwbvr6kBglM+pBf7DDoZiBLR3Z+5R1JBneHue8eVuqIujf8ZdIVZNL19c
jYt2gyuGBugjZooF7i22l0Ak04RvZHRyIEc3BulLUkLJ3PWx9IC2486Ek943bqcI
crEZavsgAmIgySVIsgGK0afARYs4ncirOWkh6AsitFCQvXXX3PvcgLx58lwgWvb6
noe6iX0N75YDvYEI2qrXJKVCehS8RKG2PkYX5b1bTzzKEx5sKInzWSdHFMIb7zZW
s6l8PLe7vykYxdTdoHXyuJuw2o5MFhLSQ2vLl38iTuqob5lYjdlsKQ8NmAxXxfyu
d0bN9LVc1p683G4aP3XOI+xnp01TbdvaPctEd68sQw5/DLHa03maYFSIEEhAzJ/q
ohBJSMo8mUIVjSmte74YOET2EfaLgPWC9XiSE6vyJwZ2XutUBaPpwrRtN/pezTZQ
0lGVArf3Lx4w4Gd8K9dzFYzl2fMKQp5LXJprzLP2FMisP0jnZzphNj6bF49mSkhY
C2SQdAQ0vdZllDT1iwdkeyk51TcxCilPqo9uieYEv7yMclSKXYg=
=MDcj
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
