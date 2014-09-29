From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 3/5] mfd: cros_ec: stop calling ->cmd_xfer() directly
Date: Mon, 29 Sep 2014 08:50:46 +0100
Message-ID: <20140929075046.GD5985@lee--X1>
References: <1411053538-17237-1-git-send-email-javier.martinez@collabora.co.uk>
 <1411053538-17237-4-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411053538-17237-4-git-send-email-javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Gwendal Grignou <gwendal-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 18 Sep 2014, Javier Martinez Canillas wrote:

> From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>=20
> Instead of having users of the ChromeOS EC call the interface-specifi=
c
> cmd_xfer() callback directly, introduce a central cros_ec_cmd_xfer()
> to use instead.  This will allow us to put all the locking and retry
> logic in one place instead of duplicating it across the different
> drivers.
>=20
> Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Reviewed-by: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8rSCDK34cm6iQ@public.gmane.org=
=2Euk>
> Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-cros-ec-tunnel.c |  2 +-
>  drivers/input/keyboard/cros_ec_keyb.c   |  2 +-
>  drivers/mfd/cros_ec.c                   |  7 +++++++
>  include/linux/mfd/cros_ec.h             | 24 ++++++++++++++++++-----=
-
>  4 files changed, 27 insertions(+), 8 deletions(-)

Applied, thanks.

> diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/bu=
sses/i2c-cros-ec-tunnel.c
> index 97e6369..ec5c38d 100644
> --- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> +++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> @@ -229,7 +229,7 @@ static int ec_i2c_xfer(struct i2c_adapter *adap, =
struct i2c_msg i2c_msgs[],
>  	msg.indata =3D response;
>  	msg.insize =3D response_len;
> =20
> -	result =3D bus->ec->cmd_xfer(bus->ec, &msg);
> +	result =3D cros_ec_cmd_xfer(bus->ec, &msg);
>  	if (result < 0)
>  		goto exit;
> =20
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/ke=
yboard/cros_ec_keyb.c
> index 8c09b3e..462bfcb 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -157,7 +157,7 @@ static int cros_ec_keyb_get_state(struct cros_ec_=
keyb *ckdev, uint8_t *kb_state)
>  		.insize =3D ckdev->cols,
>  	};
> =20
> -	return ckdev->ec->cmd_xfer(ckdev->ec, &msg);
> +	return cros_ec_cmd_xfer(ckdev->ec, &msg);
>  }
> =20
>  static irqreturn_t cros_ec_keyb_irq(int irq, void *data)
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index 4873f9c..a9faebd 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -62,6 +62,13 @@ int cros_ec_check_result(struct cros_ec_device *ec=
_dev,
>  }
>  EXPORT_SYMBOL(cros_ec_check_result);
> =20
> +int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
> +		     struct cros_ec_command *msg)
> +{
> +	return ec_dev->cmd_xfer(ec_dev, msg);
> +}
> +EXPORT_SYMBOL(cros_ec_cmd_xfer);
> +
>  static const struct mfd_cell cros_devs[] =3D {
>  	{
>  		.name =3D "cros-ec-keyb",
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.=
h
> index fcbe9d1..0e166b9 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -62,10 +62,6 @@ struct cros_ec_command {
>   * @dev: Device pointer
>   * @was_wake_device: true if this device was set to wake the system =
from
>   * sleep at the last suspend
> - * @cmd_xfer: send command to EC and get response
> - *     Returns the number of bytes received if the communication suc=
ceeded, but
> - *     that doesn't mean the EC was happy with the command. The call=
er
> - *     should check msg.result for the EC's result code.
>   *
>   * @priv: Private data
>   * @irq: Interrupt to use
> @@ -82,6 +78,10 @@ struct cros_ec_command {
>   * @dout_size: size of dout buffer to allocate (zero to use static d=
out)
>   * @parent: pointer to parent device (e.g. i2c or spi device)
>   * @wake_enabled: true if this device can wake the system from sleep
> + * @cmd_xfer: send command to EC and get response
> + *     Returns the number of bytes received if the communication suc=
ceeded, but
> + *     that doesn't mean the EC was happy with the command. The call=
er
> + *     should check msg.result for the EC's result code.
>   * @lock: one transaction at a time
>   */
>  struct cros_ec_device {
> @@ -92,8 +92,6 @@ struct cros_ec_device {
>  	struct device *dev;
>  	bool was_wake_device;
>  	struct class *cros_class;
> -	int (*cmd_xfer)(struct cros_ec_device *ec,
> -			struct cros_ec_command *msg);
> =20
>  	/* These are used to implement the platform-specific interface */
>  	void *priv;
> @@ -104,6 +102,8 @@ struct cros_ec_device {
>  	int dout_size;
>  	struct device *parent;
>  	bool wake_enabled;
> +	int (*cmd_xfer)(struct cros_ec_device *ec,
> +			struct cros_ec_command *msg);
>  	struct mutex lock;
>  };
> =20
> @@ -153,6 +153,18 @@ int cros_ec_check_result(struct cros_ec_device *=
ec_dev,
>  			 struct cros_ec_command *msg);
> =20
>  /**
> + * cros_ec_cmd_xfer - Send a command to the ChromeOS EC
> + *
> + * Call this to send a command to the ChromeOS EC.  This should be u=
sed
> + * instead of calling the EC's cmd_xfer() callback directly.
> + *
> + * @ec_dev: EC device
> + * @msg: Message to write
> + */
> +int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
> +		     struct cros_ec_command *msg);
> +
> +/**
>   * cros_ec_remove - Remove a ChromeOS EC
>   *
>   * Call this to deregister a ChromeOS EC, then clean up any private =
data.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
