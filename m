From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/5] i2c: i2c-cros-ec-tunnel: Set retries to 3
Date: Mon, 29 Sep 2014 08:49:40 +0100
Message-ID: <20140929074940.GB5985@lee--X1>
References: <1411053538-17237-1-git-send-email-javier.martinez@collabora.co.uk>
 <1411053538-17237-3-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:44723 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbaI2Hts (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Sep 2014 03:49:48 -0400
Received: by mail-ie0-f175.google.com with SMTP id y20so4499251ier.20
        for <linux-input@vger.kernel.org>; Mon, 29 Sep 2014 00:49:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1411053538-17237-3-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Gwendal Grignou <gwendal@google.com>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org

On Thu, 18 Sep 2014, Javier Martinez Canillas wrote:

> From: Derek Basehore <dbasehore@chromium.org>
>=20
> Since the i2c bus can get wedged on the EC sometimes, set the number =
of retries
> to 3. Since we un-wedge the bus immediately after the wedge happens, =
this is the
> correct fix since only one transfer will fail.
>=20
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co=
=2Euk>
> ---
>  drivers/i2c/busses/i2c-cros-ec-tunnel.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

> diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/bu=
sses/i2c-cros-ec-tunnel.c
> index 3c15dcc..97e6369 100644
> --- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> +++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> @@ -16,6 +16,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> =20
> +#define I2C_MAX_RETRIES 3
> +
>  /**
>   * struct ec_i2c_device - Driver data for I2C tunnel
>   *
> @@ -290,6 +292,7 @@ static int ec_i2c_probe(struct platform_device *p=
dev)
>  	bus->adap.algo_data =3D bus;
>  	bus->adap.dev.parent =3D &pdev->dev;
>  	bus->adap.dev.of_node =3D np;
> +	bus->adap.retries =3D I2C_MAX_RETRIES;
> =20
>  	err =3D i2c_add_adapter(&bus->adap);
>  	if (err) {

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
