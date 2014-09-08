From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] elantech: Fix detection of touchpad on ASUS s301l
Date: Mon, 8 Sep 2014 14:40:59 -0700
Message-ID: <20140908214059.GD24033@core.coreip.homeip.net>
References: <1409754242-10196-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409754242-10196-1-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Sep 03, 2014 at 04:24:02PM +0200, Hans de Goede wrote:
> http://mariusmonton.com/?p=3D489
>=20
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: M=E0rius Monton <marius.monton@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thank you.

> ---
>  drivers/input/mouse/elantech.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/ela=
ntech.c
> index daaf82f..fad7367 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1331,6 +1331,13 @@ static bool elantech_is_signature_valid(const =
unsigned char *param)
>  	if (param[1] =3D=3D 0)
>  		return true;
> =20
> +	/*
> +	 * Some models have a revision higher then 20. Meaning param[2] may
> +	 * be 10 or 20, skip the rates check for these.
> +	 */
> +	if (param[0] =3D=3D 0x46 && (param[1] & 0xef) =3D=3D 0x0f && param[=
2] < 40)
> +		return true;
> +
>  	for (i =3D 0; i < ARRAY_SIZE(rates); i++)
>  		if (param[2] =3D=3D rates[i])
>  			return false;
> --=20
> 2.1.0
>=20

--=20
Dmitry
