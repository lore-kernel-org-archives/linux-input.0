From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/5] mfd: cros_ec: Delay for 50ms when we see
 EC_CMD_REBOOT_EC
Date: Mon, 29 Sep 2014 08:49:21 +0100
Message-ID: <20140929074921.GA5985@lee--X1>
References: <1411053538-17237-1-git-send-email-javier.martinez@collabora.co.uk>
 <1411053538-17237-2-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411053538-17237-2-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Gwendal Grignou <gwendal@google.com>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 18 Sep 2014, Javier Martinez Canillas wrote:

> From: Doug Anderson <dianders@chromium.org>
>=20
> If someone sends a EC_CMD_REBOOT_EC to the EC, the EC will likely be
> unresponsive for quite a while.  Add a delay to the end of the comman=
d
> to prevent random failures of future commands.
>=20
> NOTES:
> * This could be optimized a bit by simply delaying the next command
>   sent, but EC_CMD_REBOOT_EC is such a rare command that the extra
>   complexity doesn't seem worth it.
> * This is a bit of an "ugly hack" since the SPI driver is effectively
>   snooping on the communication and making a lot of assumptions.  It
>   would be nice to architect in some better solution long term.
> * This same logic probably needs to be applied to the i2c driver.
>=20
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Randall Spangler <rspangler@chromium.org>
> Reviewed-by: Vadim Bendebury <vbendeb@chromium.org>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co=
=2Euk>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/cros_ec_spi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/cros_ec_spi.c b/drivers/mfd/cros_ec_spi.c
> index 588c700..b396705 100644
> --- a/drivers/mfd/cros_ec_spi.c
> +++ b/drivers/mfd/cros_ec_spi.c
> @@ -65,6 +65,12 @@
>    */
>  #define EC_SPI_RECOVERY_TIME_NS	(200 * 1000)
> =20
> +/*
> + * The EC is unresponsive for a time after a reboot command.  Add a
> + * simple delay to make sure that the bus stays locked.
> + */
> +#define EC_REBOOT_DELAY_MS	50
> +
>  /**
>   * struct cros_ec_spi - information about a SPI-connected EC
>   *
> @@ -318,6 +324,9 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_de=
vice *ec_dev,
> =20
>  	ret =3D len;
>  exit:
> +	if (ec_msg->command =3D=3D EC_CMD_REBOOT_EC)
> +		msleep(EC_REBOOT_DELAY_MS);
> +
>  	mutex_unlock(&ec_spi->lock);
>  	return ret;
>  }

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
