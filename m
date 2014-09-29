From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 5/5] mfd: cros_ec: wait for completion of commands
 that return IN_PROGRESS
Date: Mon, 29 Sep 2014 08:52:02 +0100
Message-ID: <20140929075202.GB7308@lee--X1>
References: <1411053538-17237-1-git-send-email-javier.martinez@collabora.co.uk>
 <1411053538-17237-6-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:58708 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbaI2HwJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Sep 2014 03:52:09 -0400
Received: by mail-ig0-f178.google.com with SMTP id l13so1287612iga.11
        for <linux-input@vger.kernel.org>; Mon, 29 Sep 2014 00:52:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1411053538-17237-6-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Gwendal Grignou <gwendal@google.com>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org

On Thu, 18 Sep 2014, Javier Martinez Canillas wrote:

> From: Andrew Bresticker <abrestic@chromium.org>
>=20
> When an EC command returns EC_RES_IN_PROGRESS, we need to query
> the state of the EC until it indicates that it is no longer busy.
> Do this in cros_ec_cmd_xfer() under the EC's mutex so that other
> commands (e.g. keyboard, I2C passtru) aren't issued to the EC while
> it is working on the in-progress command.
>=20
> The 10 milliseconds delay and the number of retries are the values
> that were used by the flashrom tool when retrying commands.
>=20
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co=
=2Euk>
> ---
>=20
> Changes since v3:
>  - Fix us time and use raw values instead of a define. Suggested by L=
ee Jones.
>=20
> Changes since v2:
>  - Explain in the commit message from where the delay and retry value=
s come from.
>    Commented by Andrew Bresticker.
>  - Move the needed definitions inside the if block. Suggested by Lee =
Jones.
>  - Only check if result is EC_RES_IN_PROGRESS instead of checking als=
o if ret is
>    -EAGAIN since the former implies the later. Suggested by Lee Jones=
=2E
>  - Use usleep_range() instead of msleep() since doesn't handle values=
 between 1~20.
>    Suggested by Lee Jones.
>=20
> Changes since v1:
>  - The *xfer() calls don't modify the passed cros_ec_command so there=
 is
>    no need to populate it inside the for loop. Suggested by Lee Jones=
=2E
>=20
>  drivers/mfd/cros_ec.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Assuming that it's okay to return success even on failure,

=2E.. applied, thanks.

> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index c53804a..fc0c81e 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -23,6 +23,9 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/cros_ec.h>
>  #include <linux/mfd/cros_ec_commands.h>
> +#include <linux/delay.h>
> +
> +#define EC_COMMAND_RETRIES	50
> =20
>  int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
>  		       struct cros_ec_command *msg)
> @@ -69,6 +72,36 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev=
,
> =20
>  	mutex_lock(&ec_dev->lock);
>  	ret =3D ec_dev->cmd_xfer(ec_dev, msg);
> +	if (msg->result =3D=3D EC_RES_IN_PROGRESS) {
> +		int i;
> +		struct cros_ec_command status_msg;
> +		struct ec_response_get_comms_status status;
> +
> +		status_msg.version =3D 0;
> +		status_msg.command =3D EC_CMD_GET_COMMS_STATUS;
> +		status_msg.outdata =3D NULL;
> +		status_msg.outsize =3D 0;
> +		status_msg.indata =3D (uint8_t *)&status;
> +		status_msg.insize =3D sizeof(status);
> +
> +		/*
> +		 * Query the EC's status until it's no longer busy or
> +		 * we encounter an error.
> +		 */
> +		for (i =3D 0; i < EC_COMMAND_RETRIES; i++) {
> +			usleep_range(10000, 11000);
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
>  	mutex_unlock(&ec_dev->lock);
> =20
>  	return ret;

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
