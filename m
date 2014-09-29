From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 4/5] mfd: cros_ec: move locking into cros_ec_cmd_xfer
Date: Mon, 29 Sep 2014 08:51:17 +0100
Message-ID: <20140929075117.GA7308@lee--X1>
References: <1411053538-17237-1-git-send-email-javier.martinez@collabora.co.uk>
 <1411053538-17237-5-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411053538-17237-5-git-send-email-javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Gwendal Grignou <gwendal-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 18 Sep 2014, Javier Martinez Canillas wrote:

> From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>=20
> Now that there's a central cros_ec_cmd_xfer(), move the locking
> out of the SPI driver.
>=20
> Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Reviewed-by: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8rSCDK34cm6iQ@public.gmane.org=
=2Euk>
> Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>=20
> Changes since v1:
>  - Remove mention of LPC driver in the commit message since it does n=
ot
>    exist in mainline yet. Suggested by Doug Anderson.
>=20
>  drivers/mfd/cros_ec.c     | 10 +++++++++-
>  drivers/mfd/cros_ec_spi.c | 11 -----------
>  2 files changed, 9 insertions(+), 12 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index a9faebd..c53804a 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -65,7 +65,13 @@ EXPORT_SYMBOL(cros_ec_check_result);
>  int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>  		     struct cros_ec_command *msg)
>  {
> -	return ec_dev->cmd_xfer(ec_dev, msg);
> +	int ret;
> +
> +	mutex_lock(&ec_dev->lock);
> +	ret =3D ec_dev->cmd_xfer(ec_dev, msg);
> +	mutex_unlock(&ec_dev->lock);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(cros_ec_cmd_xfer);
> =20
> @@ -98,6 +104,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev=
)
>  			return -ENOMEM;
>  	}
> =20
> +	mutex_init(&ec_dev->lock);
> +
>  	err =3D mfd_add_devices(dev, 0, cros_devs,
>  			      ARRAY_SIZE(cros_devs),
>  			      NULL, ec_dev->irq, NULL);
> diff --git a/drivers/mfd/cros_ec_spi.c b/drivers/mfd/cros_ec_spi.c
> index b396705..bf6e08e 100644
> --- a/drivers/mfd/cros_ec_spi.c
> +++ b/drivers/mfd/cros_ec_spi.c
> @@ -79,13 +79,11 @@
>   *	if no record
>   * @end_of_msg_delay: used to set the delay_usecs on the spi_transfe=
r that
>   *      is sent when we want to turn off CS at the end of a transact=
ion.
> - * @lock: mutex to ensure only one user of cros_ec_cmd_xfer_spi at a=
 time
>   */
>  struct cros_ec_spi {
>  	struct spi_device *spi;
>  	s64 last_transfer_ns;
>  	unsigned int end_of_msg_delay;
> -	struct mutex lock;
>  };
> =20
>  static void debug_packet(struct device *dev, const char *name, u8 *p=
tr,
> @@ -232,13 +230,6 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_d=
evice *ec_dev,
>  	int sum;
>  	int ret =3D 0, final_ret;
> =20
> -	/*
> -	 * We have the shared ec_dev buffer plus we do lots of separate spi=
_sync
> -	 * calls, so we need to make sure only one person is using this at =
a
> -	 * time.
> -	 */
> -	mutex_lock(&ec_spi->lock);
> -
>  	len =3D cros_ec_prepare_tx(ec_dev, ec_msg);
>  	dev_dbg(ec_dev->dev, "prepared, len=3D%d\n", len);
> =20
> @@ -327,7 +318,6 @@ exit:
>  	if (ec_msg->command =3D=3D EC_CMD_REBOOT_EC)
>  		msleep(EC_REBOOT_DELAY_MS);
> =20
> -	mutex_unlock(&ec_spi->lock);
>  	return ret;
>  }
> =20
> @@ -359,7 +349,6 @@ static int cros_ec_spi_probe(struct spi_device *s=
pi)
>  	if (ec_spi =3D=3D NULL)
>  		return -ENOMEM;
>  	ec_spi->spi =3D spi;
> -	mutex_init(&ec_spi->lock);
>  	ec_dev =3D devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
>  	if (!ec_dev)
>  		return -ENOMEM;

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
