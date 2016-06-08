From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 6/8] mfd: ti_am335x_tscadc: use variable name for
 sizeof() operator
Date: Wed, 8 Jun 2016 16:35:35 +0100
Message-ID: <20160608153535.GU14888@dell>
References: <20160531170013.2649-1-afd@ti.com>
 <20160531170013.2649-7-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160531170013.2649-7-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dave Gerlach <d-gerlach@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 31 May 2016, Andrew F. Davis wrote:

> Fix the code formatting to use the kernel preferred style
> of using the actual variables to determize the size using
> the sizeof() operator.
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_t=
scadc.c
> index d30bea5..c8f027b 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -168,8 +168,7 @@ static	int ti_tscadc_probe(struct platform_device=
 *pdev)
>  	}
> =20
>  	/* Allocate memory for device */
> -	tscadc =3D devm_kzalloc(&pdev->dev,
> -			sizeof(struct ti_tscadc_dev), GFP_KERNEL);
> +	tscadc =3D devm_kzalloc(&pdev->dev, sizeof(*tscadc), GFP_KERNEL);
>  	if (!tscadc) {
>  		dev_err(&pdev->dev, "failed to allocate memory.\n");
>  		return -ENOMEM;

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
