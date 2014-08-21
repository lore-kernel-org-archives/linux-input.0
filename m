From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH 5/7] mfd: cros_ec: wait for completion of commands
 that return IN_PROGRESS
Date: Thu, 21 Aug 2014 15:21:00 +0100
Message-ID: <20140821142100.GM4266@lee--X1>
References: <1408536812-7836-1-git-send-email-javier.martinez@collabora.co.uk>
 <1408536812-7836-6-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408536812-7836-6-git-send-email-javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 20 Aug 2014, Javier Martinez Canillas wrote:

> From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>=20
> When an EC command returns EC_RES_IN_PROGRESS, we need to query
> the state of the EC until it indicates that it is no longer busy.
> Do this in cros_ec_cmd_xfer() under the EC's mutex so that other
> commands (e.g. keyboard, I2C passtru) aren't issued to the EC while
> it is working on the in-progress command.
>=20
> Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Reviewed-by: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8rSCDK34cm6iQ@public.gmane.org=
=2Euk>
> ---
>  drivers/mfd/cros_ec.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index c53804a..634c434 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -23,6 +23,10 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/cros_ec.h>
>  #include <linux/mfd/cros_ec_commands.h>
> +#include <linux/delay.h>
> +
> +#define EC_COMMAND_RETRIES	50
> +#define EC_RETRY_DELAY_MS	10
> =20
>  int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
>  		       struct cros_ec_command *msg)
> @@ -65,10 +69,39 @@ EXPORT_SYMBOL(cros_ec_check_result);
>  int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>  		     struct cros_ec_command *msg)
>  {
> -	int ret;
> +	int ret, i;
> =20
>  	mutex_lock(&ec_dev->lock);
>  	ret =3D ec_dev->cmd_xfer(ec_dev, msg);
> +	if (ret =3D=3D -EAGAIN && msg->result =3D=3D EC_RES_IN_PROGRESS) {
> +		/*
> +		 * Query the EC's status until it's no longer busy or
> +		 * we encounter an error.
> +		 */
> +		for (i =3D 0; i < EC_COMMAND_RETRIES; i++) {
> +			struct cros_ec_command status_msg;
> +			struct ec_response_get_comms_status status;
> +
> +			msleep(EC_RETRY_DELAY_MS);
> +
> +			status_msg.version =3D 0;
> +			status_msg.command =3D EC_CMD_GET_COMMS_STATUS;
> +			status_msg.outdata =3D NULL;
> +			status_msg.outsize =3D 0;
> +			status_msg.indata =3D (uint8_t *)&status;
> +			status_msg.insize =3D sizeof(status);
> +
> +			ret =3D ec_dev->cmd_xfer(ec_dev, &status_msg);
> +			if (ret < 0)
> +				break;
> +
> +			msg->result =3D status_msg.result;
> +			if (status_msg.result !=3D EC_RES_SUCCESS)
> +				break;
> +			if (!(status.flags & EC_COMMS_STATUS_PROCESSING))
> +				break;
> +		}
> +	}

Wow!  Things just got ugly real fast.

Do the *xfer() calls fiddle with msg passed into cros_ec_cmd_xfer()?
If not, why is it necessary to keep populating it?

If all this stuff is necessary (and I really hope that it's not) I
think it would be better to have the for() loop as the outer layer.
Then we only have one instance of cmd_xfer() invocation and we save a
layer of tabbing.=20

>  	mutex_unlock(&ec_dev->lock);
> =20
>  	return ret;

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
