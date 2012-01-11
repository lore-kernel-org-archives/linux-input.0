From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] input/mc13783-ts: add pdata to set conversion delay
Date: Wed, 11 Jan 2012 09:36:34 +0100
Message-ID: <20120111083634.GL14252@pengutronix.de>
References: <1326269903-22180-1-git-send-email-michael.thalmeier@hale.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1326269903-22180-1-git-send-email-michael.thalmeier@hale.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Thalmeier <michael.thalmeier@hale.at>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, michael@thalmeier.at
List-Id: linux-input@vger.kernel.org

Hello Michael,

On Wed, Jan 11, 2012 at 09:18:23AM +0100, Michael Thalmeier wrote:
> MC13783 can be programmed to wait some clock cycles between the touch=
 screen
> polarization and the resistance conversion. This is needed to adjust =
for
> touchscreens with high capacitance between plates.
>=20
> Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
> ---
>  drivers/hwmon/mc13783-adc.c            |    2 +-
>  drivers/input/touchscreen/mc13783_ts.c |    6 +++++-
>  drivers/mfd/mc13xxx-core.c             |   11 +++++++++--
>  include/linux/mfd/mc13xxx.h            |   16 +++++++++++++++-
>  4 files changed, 30 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.=
c
> index ef65ab5..6acd044 100644
> --- a/drivers/hwmon/mc13783-adc.c
> +++ b/drivers/hwmon/mc13783-adc.c
> @@ -53,7 +53,7 @@ static int mc13783_adc_read(struct device *dev,
> =20
>  	ret =3D mc13xxx_adc_do_conversion(priv->mc13xxx,
>  			MC13XXX_ADC_MODE_MULT_CHAN,
> -			channel, sample);
> +			channel, 0, 0, sample);
>  	if (ret)
>  		return ret;
> =20
> diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/t=
ouchscreen/mc13783_ts.c
> index 68f86f7..d71f45a 100644
> --- a/drivers/input/touchscreen/mc13783_ts.c
> +++ b/drivers/input/touchscreen/mc13783_ts.c
> @@ -39,6 +39,7 @@ struct mc13783_ts_priv {
>  	struct delayed_work work;
>  	struct workqueue_struct *workq;
>  	unsigned int sample[4];
> +	struct mc13xxx_ts_platform_data *touch;
>  };
> =20
>  static irqreturn_t mc13783_ts_handler(int irq, void *data)
> @@ -125,7 +126,9 @@ static void mc13783_ts_work(struct work_struct *w=
ork)
>  	unsigned int channel =3D 12;
> =20
>  	if (mc13xxx_adc_do_conversion(priv->mc13xxx,
> -				mode, channel, priv->sample) =3D=3D 0)
> +				mode, channel,
> +				priv->touch->ato, priv->touch->atox,
> +				priv->sample) =3D=3D 0)
>  		mc13783_ts_report_sample(priv);
>  }
> =20
> @@ -179,6 +182,7 @@ static int __init mc13783_ts_probe(struct platfor=
m_device *pdev)
>  	INIT_DELAYED_WORK(&priv->work, mc13783_ts_work);
>  	priv->mc13xxx =3D dev_get_drvdata(pdev->dev.parent);
>  	priv->idev =3D idev;
> +	priv->touch =3D dev_get_platdata(&pdev->dev);
This cannot fail in practice unless the device isn't created via
mc13xxx_probe. Still it would feel a tad better to have error detection
here or at least a comment saying why it doesn't fail.

Other than that:
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
