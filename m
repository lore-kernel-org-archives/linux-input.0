From: Barry Song <21cnbao@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Add device tree binding for WM8753
Date: Mon, 8 Aug 2011 16:38:41 +0800
Message-ID: <CAGsJ_4y2tDb3ZBPo8bCtrjFt0OWzR8WeG+kL_RKJPRP7-pZopw@mail.gmail.com>
References: <1312778255-29755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61761 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab1HHIjC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Aug 2011 04:39:02 -0400
Received: by fxh19 with SMTP id 19so5126965fxh.19
        for <linux-input@vger.kernel.org>; Mon, 08 Aug 2011 01:39:01 -0700 (PDT)
In-Reply-To: <1312778255-29755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, dmitry.torokhov@gmail.com
Cc: Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org

2011/8/8 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Without this patch, DT can still connect driver with device by the
heuristic way(of_modalias_node).

i have a patch just like yours in input subsystem "[PATCH v2] input:
touchscreen: add OF match table for ads7846" with "Acked-by: Grant
Likely", but Dmitry seems to just ignore it.

so not sure whether this kind of new added match tables are totally
liked by people or not.

> ---
> =C2=A0Documentation/devicetree/bindings/sound/wm8753.txt | =C2=A0 18 =
++++++++++++++++++
> =C2=A0sound/soc/codecs/wm8753.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A09 ++=
+++++++
> =C2=A02 files changed, 27 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 Documentation/devicetree/bindings/sound/wm87=
53.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/wm8753.txt b/Doc=
umentation/devicetree/bindings/sound/wm8753.txt
> new file mode 100644
> index 0000000..e65277a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/wm8753.txt
> @@ -0,0 +1,18 @@
> +WM8753 audio CODEC
> +
> +This device supports both I2C and SPI (configured with pin strapping
> +on the board).
> +
> +Required properties:
> +
> + =C2=A0- compatible : "wlf,wm8753"
> +
> + =C2=A0- reg : the I2C address of the device for I2C, the chip selec=
t
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0number for SPI.
> +
> +Example:
> +
> +codec: wm8737@1a {
> + =C2=A0 =C2=A0 =C2=A0 compatible =3D "wlf,wm8753";
> + =C2=A0 =C2=A0 =C2=A0 reg =3D <0x1a>;
> +};
> diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
> index a702550..fe04a10 100644
> --- a/sound/soc/codecs/wm8753.c
> +++ b/sound/soc/codecs/wm8753.c
> @@ -38,6 +38,7 @@
> =C2=A0#include <linux/delay.h>
> =C2=A0#include <linux/pm.h>
> =C2=A0#include <linux/i2c.h>
> +#include <linux/of_device.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/spi/spi.h>
> =C2=A0#include <linux/slab.h>
> @@ -1490,6 +1491,12 @@ static struct snd_soc_codec_driver soc_codec_d=
ev_wm8753 =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.reg_cache_default =3D wm8753_reg,
> =C2=A0};
>
> +static const struct of_device_id wm8753_of_match[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 { .compatible =3D "wlf,wm8753", },
> + =C2=A0 =C2=A0 =C2=A0 { }
> +};
> +MODULE_DEVICE_TABLE(of, wm8753_of_match);
> +
> =C2=A0#if defined(CONFIG_SPI_MASTER)
> =C2=A0static int __devinit wm8753_spi_probe(struct spi_device *spi)
> =C2=A0{
> @@ -1521,6 +1528,7 @@ static struct spi_driver wm8753_spi_driver =3D =
{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.driver =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =3D=
 "wm8753",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.owner =C2=A0=3D=
 THIS_MODULE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .of_match_table =3D=
 wm8753_of_match,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 wm8753_spi_probe,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __=
devexit_p(wm8753_spi_remove),
> @@ -1565,6 +1573,7 @@ static struct i2c_driver wm8753_i2c_driver =3D =
{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.driver =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D "wm8=
753",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.owner =3D THI=
S_MODULE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .of_match_table =3D=
 wm8753_of_match,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.probe =3D =C2=A0 =C2=A0wm8753_i2c_probe,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.remove =3D =C2=A0 __devexit_p(wm8753_i2c_=
remove),
> --
> 1.7.5.4
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
