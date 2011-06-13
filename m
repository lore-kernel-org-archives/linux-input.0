From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] input: touchscreen: add OF match table for ads7846
Date: Sun, 12 Jun 2011 23:15:36 -0600
Message-ID: <BANLkTinTGHpyzg69OTcvmsGVLGK3qbZM7g@mail.gmail.com>
References: <1307672920-6261-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60721 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441Ab1FMFP5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jun 2011 01:15:57 -0400
Received: by pzk9 with SMTP id 9so1973584pzk.19
        for <linux-input@vger.kernel.org>; Sun, 12 Jun 2011 22:15:56 -0700 (PDT)
In-Reply-To: <1307672920-6261-1-git-send-email-Baohua.Song@csr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <Baohua.Song@csr.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, Barry Song <21cnbao@gmail.com>, Thomas Chou <thomas@wytron.com.tw>

On Thu, Jun 9, 2011 at 8:28 PM, Barry Song <Baohua.Song@csr.com> wrote:
> The current ads7846 has no OF match table. The method used is by appl=
ying a heuristic (of_modalias_node) which tries to name the device in a=
 way that will match an existing device driver.
> This patch adds explicit OF match table for ads7846, then the normal =
device tree match behaviour will always work.
> It has been tested on PRIMA2 EVB board of CSR with a SPI's child node=
 like the below:
> ts@0 {
> =A0 =A0 =A0 =A0compatible =3D "ti,ads7845";
> =A0 =A0 =A0 =A0reg =3D <0x0>;
> =A0 =A0 =A0 =A0spi-max-frequency =3D <31250>;
> =A0 =A0 =A0 =A0interrupts =3D <90>;
> };
>
> Signed-off-by: Barry Song <21cnbao@gmail.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> cc: Thomas Chou <thomas@wytron.com.tw>
> ---
> =A0drivers/input/touchscreen/ads7846.c | =A0 14 ++++++++++++++

There should also be documentation for the new binding added to
Documentation/devicetree/bindings for the new compatible strings.

> =A01 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touc=
hscreen/ads7846.c
> index 5196861..643138b 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -28,6 +28,7 @@
> =A0#include <linux/slab.h>
> =A0#include <linux/pm.h>
> =A0#include <linux/gpio.h>
> +#include <linux/of.h>
> =A0#include <linux/spi/spi.h>
> =A0#include <linux/spi/ads7846.h>
> =A0#include <linux/regulator/consumer.h>
> @@ -1425,12 +1426,25 @@ static int __devexit ads7846_remove(struct sp=
i_device *spi)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +#if defined(CONFIG_OF)
> +static struct of_device_id ads7846_spi_of_match_table[] __devinitdat=
a =3D {
> + =A0 =A0 =A0 { .compatible =3D "ti,ads7846", },
> + =A0 =A0 =A0 { .compatible =3D "ti,ads7845", },
> + =A0 =A0 =A0 { .compatible =3D "ti,ads7843", },
> + =A0 =A0 =A0 {},
> +};
> +MODULE_DEVICE_TABLE(of, ads7846_spi_of_match_table);

#else
#define ads7846_spi_of_match_table NULL

> +#endif
> +
> =A0static struct spi_driver ads7846_driver =3D {
> =A0 =A0 =A0 =A0.driver =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "ads7846",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.bus =A0 =A0=3D &spi_bus_type,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pm =A0 =A0 =3D &ads7846_pm,
> +#if defined(CONFIG_OF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D ads7846_spi_of_matc=
h_table,
> +#endif

With the #else  block added above, you can drop the #if/#endif
protection around of_match_table.

Otherwise:

Acked-by: Grant Likely <grant.likely@secretlab.ca>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
