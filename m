From: =?windows-1252?Q?S=E9bastien_Szymanski?=
	<sebastien.szymanski@armadeus.com>
Subject: Re: [PATCH] Input: sx8654 - fix memory allocation check
Date: Mon, 11 May 2015 11:51:22 +0200
Message-ID: <55507B9A.4060700@armadeus.com>
References: <20150508235031.GA29274@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150508235031.GA29274@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello,

Acked-by: S=E9bastien Szymanski <sebastien.szymanski@armadeus.com>

On 05/09/2015 01:50 AM, Dmitry Torokhov wrote:
> We have been testing wrong variable when trying to make sure that inp=
ut
> allocation succeeded.
>=20
> Reported by Coverity (CID 1295918).
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/sx8654.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touch=
screen/sx8654.c
> index aecb9ad..642f4a5 100644
> --- a/drivers/input/touchscreen/sx8654.c
> +++ b/drivers/input/touchscreen/sx8654.c
> @@ -187,7 +187,7 @@ static int sx8654_probe(struct i2c_client *client=
,
>  		return -ENOMEM;
> =20
>  	input =3D devm_input_allocate_device(&client->dev);
> -	if (!sx8654)
> +	if (!input)
>  		return -ENOMEM;
> =20
>  	input->name =3D "SX8654 I2C Touchscreen";
>=20


--=20
S=E9bastien Szymanski
Software Engineer
Armadeus Systems - A new vision of the embedded world
sebastien.szymanski@armadeus.com
Tel: +33 (0)9 72 29 41 44
=46ax: +33 (0)9 72 28 79 26
