From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/9] mfd: max77693: Store I2C device type as enum and
 add default unknown
Date: Wed, 27 May 2015 11:23:34 +0100
Message-ID: <20150527102334.GD11677@x1>
References: <1432446213-4886-1-git-send-email-k.kozlowski.k@gmail.com>
 <1432446213-4886-3-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432446213-4886-3-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 24 May 2015, Krzysztof Kozlowski wrote:

> Store the device type (obtained from i2c_device_id) as an enum and ad=
d a
> default type of unknown to distinguish from case when this is not set
> at all.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---
>  include/linux/mfd/max77693-private.h | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Applied, thanks.

> diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd=
/max77693-private.h
> index ad67b8235a8d..e3c0afff38d3 100644
> --- a/include/linux/mfd/max77693-private.h
> +++ b/include/linux/mfd/max77693-private.h
> @@ -529,13 +529,18 @@ enum max77693_irq_muic {
>  	MAX77693_MUIC_IRQ_NR,
>  };
> =20
> +enum max77693_types {
> +	TYPE_MAX77693_UNKNOWN,
> +	TYPE_MAX77693,
> +};
> +
>  struct max77693_dev {
>  	struct device *dev;
>  	struct i2c_client *i2c;		/* 0xCC , PMIC, Charger, Flash LED */
>  	struct i2c_client *muic;	/* 0x4A , MUIC */
>  	struct i2c_client *haptic;	/* 0x90 , Haptic */
> =20
> -	int type;
> +	enum max77693_types type;
> =20
>  	struct regmap *regmap;
>  	struct regmap *regmap_muic;
> @@ -549,8 +554,4 @@ struct max77693_dev {
>  	int irq;
>  };
> =20
> -enum max77693_types {
> -	TYPE_MAX77693,
> -};
> -
>  #endif /*  __LINUX_MFD_MAX77693_PRIV_H */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
