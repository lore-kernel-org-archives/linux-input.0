Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFFA414409
	for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791803084; cv=none; b=XxVIhJdnp6CAIEGnMUB6RvUF5/MPGhnzrQwYZSBLXHuJttFAkcRmkTALelEZ0aVt9aMclRHkkG/lOAxC//KrPSoJkyOMDFXL964e7i340ePkFFLnxPVUddw/ZmB5+QQ6XCoKcC3WUBAZWMv+psV9S5keXM/Quj7E6PytMpWyyb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791803084; c=relaxed/simple;
	bh=nlIvW7pRhzlbUPUJa72z14ST6hPdfpq+U230+od9S6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMD7kiPaNrSZZFu1JJ/E8EYN4vAXNSdkYyyzHRRHxb4pJd7eih7C5wa/1kkF05y7nDAFNsF8nmhZBzNPCUO5aFOpepXsY3fHa82qZTxtevXzB6krgyWFv0ToGopwAvjtac8HlPsT/WjJ0hzPYROO22t9ZLUU5eeejqYVeigHdso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=jBZm6G13; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="jBZm6G13"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so17217555e9.0
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 04:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791803080; x=1792407880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p/9CUmDFbrCucNd3kWT0eYJSCJxWLPHWPqV9kk2CL0Y=;
        b=jBZm6G13MlO4Y+DYvK8ubdBqOUwtOGv008o8sv8aAWBg1W5ff633AMFHiT8B1kOCAQ
         KU20i1T+PeyfrkM6mVx9bYHhwLvPJh1hNsImB+xxfkkNGX2kWjrFKvu8z1OZzCe5oI7j
         rcibtuyhhxAcMFynio3tRs3tnc6ySHORPiMPNbiH81TKpMWKMvpo0Yr/nJ4GGlTtxVuW
         anVK3h5AehMFb+rsWseHlf+qHTOckPcLilM9dF0UA5KY+b+cnMmaaNDz9s+65XQ01MqV
         uRQ7+7VaodYpdA+KvZUolXSKON3DXGTQvpCPKS+MzqYsjfME6rCAJxgKFC7AhncEEzF5
         8/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791803080; x=1792407880;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p/9CUmDFbrCucNd3kWT0eYJSCJxWLPHWPqV9kk2CL0Y=;
        b=adAwO55YfgyVmpxnhaH/nEhr3GkuxIROwEEZXdGcxecHbTY2gF1JZL9ZOpyqQ8kB96
         fc3uhltqFr3MvWmfO7GL84kxLj/FHVKHB4n/eUa0pRmgYVfWI1ezY9aTqujlKjVjzoyF
         gQfCoKQ4+35JUO5qaV2n3CeQXn5bZZTC6oChIVcESHLLuAySZrs2MkBuxMG4KHBG2wYV
         E2R50TwAKSTLtXQcheMGSARYCxm1YRS1w7R23fQeE7jlq5VyXXRFwrphOh2xvypHHchH
         eROtKJMa7agUtt88lNi2GbjU+fS0psXfKP0xeAoldCYrz7dukMihUphoqM/PHCGYRrds
         ff0A==
X-Forwarded-Encrypted: i=1; AKwUvBxGRfrDVXb0rjetbGrmGh1oXv8VBOVWkXc3mHE/x4fiCX3DkhVp1Qksmir8kiSnhzdLXPbMRJCn7zLt8g==@vger.kernel.org
X-Gm-Message-State: AFq9FYJCuK5CwkuwtQUyyHG6NbrG00+YMBobefpmU9HQEwkUC0YpYJfp
	3jIT7P/4pDfAM4LAk+K416NYFndjaxSkOAvwI9Wfcw7vvIVSpLnygCmhSzoJpqFrw8I=
X-Gm-Gg: AYBFou0ZC5PPDUDB9Kh4r5i1Ns0/5IXprfewLF2GNOuv8DVOtcGwDbG0cJGuzAUghI2
	/1y4I5R6zcvab+7f0G/kuEKOyc48lSTSxPtiRFla2MAGrK0fwpuja3Pf+fknUGxcBysHvlCMMRN
	+5JNc9i4zDx/rnGuMRLuA7D6ML1cabe4NHGljMN6CouGk9ABiUS2o7ubjXK0tFmUNHAEk7EOu97
	YTOl4JRyI2k6+vdlgxkWpM7R2PcVcjjuAjrKt4sijDrE5pL2H+VFQzy6mvfn8YqW5b7PBgH5bPz
	+wty8CF1pmpSk2jWXliReQ7/KE3m9TKsWc4BeJn6If+LVH7jVftr4CK/0symvM04GyUuVcNIK5S
	Iu1KKFm2WFw9XZgs927j7Hav3WnC2npsrYClGOu3To2DYP1IJ7PnP5A3xTTI281rMhXZhVtfD5Q
	l++pD4GOMZtb6zsMdzDSO/Xrq9Mzh52NKuTG5VsNyzj39A8R7EqnGyGj4552ad+IMWKXTAO1AqN
	5uf9hjgNNKlYniqkpJIL0hLWkOLWcwL7rLEkqvbrMxCC3BoAmPc5XCNtPbMRQ==
X-Received: by 2002:a05:600c:3b99:b0:4a0:1ea2:10c6 with SMTP id 5b1f17b1804b1-4a18e48eeb6mr223563165e9.17.1791803079382;
        Mon, 12 Oct 2026 04:04:39 -0700 (PDT)
Received: from localhost (p200300f65f19a904ade4f69ba751c34c.dip0.t-ipconnect.de. [2003:f6:5f19:a904:ade4:f69b:a751:c34c])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a18c198134sm280374685e9.15.2026.10.12.04.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 04:04:37 -0700 (PDT)
Date: Mon, 12 Oct 2026 13:04:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lukas Timmermann <foss@timmermann.space>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/7] Input: s6sy761 - split into core and I2C modules
Message-ID: <asy92cwqv8Xjc2PX@monoceros>
References: <20261011-lat3st-google-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space>
 <20261011-lat3st-google-raven-touch-upstream-v1-2-2a9f55159b9e@timmermann.space>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eblkicd243zh2pgk"
Content-Disposition: inline
In-Reply-To: <20261011-lat3st-google-raven-touch-upstream-v1-2-2a9f55159b9e@timmermann.space>


--eblkicd243zh2pgk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/7] Input: s6sy761 - split into core and I2C modules
MIME-Version: 1.0

On Sun, Oct 11, 2026 at 02:44:57PM +0200, Lukas Timmermann wrote:
> Split this driver into a bus-agnostic core and I2C transport part in
> preparation for adding SPI support. Also add a mutex because the
> driver now has a transfer buffer shared between IRQ, sysfs
> and PM threads.
>=20
> The Kconfig is backwards-compatible and should work on boards with an
> S6SY761 touchscreen as before. The I2C transfers of the driver should be
> byte by byte identical.
>=20
> The modules are now called s6sy761_core and s6sy761_i2c.
>=20
> Signed-off-by: Lukas Timmermann <foss@timmermann.space>
> ---
>  drivers/input/touchscreen/Kconfig                  |   8 +-
>  drivers/input/touchscreen/Makefile                 |   3 +-
>  .../touchscreen/{s6sy761.c =3D> s6sy761_core.c}      | 214 +++++++++----=
--------
>  drivers/input/touchscreen/s6sy761_core.h           |  34 ++++
>  drivers/input/touchscreen/s6sy761_i2c.c            | 112 +++++++++++
>  5 files changed, 245 insertions(+), 126 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscree=
n/Kconfig
> index 9b9ae8ac3f7f..76651a61324f 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -535,8 +535,12 @@ config TOUCHSCREEN_S6SY761
> =20
>  	  If unsure, say N
> =20
> -	  To compile this driver as module, choose M here: the
> -	  module will be called s6sy761.
> +	  To compile this driver as a module, choose M here: the
> +	  modules will be called s6sy761_core and s6sy761_i2c.
> +	select TOUCHSCREEN_S6SY761_I2C if I2C
> +
> +config TOUCHSCREEN_S6SY761_I2C
> +	tristate
> =20
>  config TOUCHSCREEN_GUNZE
>  	tristate "Gunze AHL-51S touchscreen"
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscre=
en/Makefile
> index bfd9de83389d..24b8fb1e38d3 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -77,7 +77,8 @@ obj-$(CONFIG_TOUCHSCREEN_USB_COMPOSITE)	+=3D usbtouchsc=
reen.o
>  obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+=3D penmount.o
>  obj-$(CONFIG_TOUCHSCREEN_PIXCIR)	+=3D pixcir_i2c_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_RM_TS)		+=3D raydium_i2c_ts.o
> -obj-$(CONFIG_TOUCHSCREEN_S6SY761)	+=3D s6sy761.o
> +obj-$(CONFIG_TOUCHSCREEN_S6SY761)	+=3D s6sy761_core.o
> +obj-$(CONFIG_TOUCHSCREEN_S6SY761_I2C)	+=3D s6sy761_i2c.o
>  obj-$(CONFIG_TOUCHSCREEN_SILEAD)	+=3D silead.o
>  obj-$(CONFIG_TOUCHSCREEN_SIS_I2C)	+=3D sis_i2c.o
>  obj-$(CONFIG_TOUCHSCREEN_ST1232)	+=3D st1232.o
> diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscr=
een/s6sy761_core.c
> similarity index 71%
> rename from drivers/input/touchscreen/s6sy761.c
> rename to drivers/input/touchscreen/s6sy761_core.c
> index 899c179fb2d3..0e455060dbc0 100644
> --- a/drivers/input/touchscreen/s6sy761.c
> +++ b/drivers/input/touchscreen/s6sy761_core.c
> @@ -3,18 +3,21 @@
>  //
>  // Copyright (c) 2017 Samsung Electronics Co., Ltd.
>  // Copyright (c) 2017 Andi Shyti <andi@etezian.org>
> +// Copyright (c) 2026 Lukas Timmermann <foss@timmermann.space>
> =20
>  #include <linux/unaligned.h>
>  #include <linux/delay.h>
> -#include <linux/i2c.h>
>  #include <linux/input/mt.h>
>  #include <linux/input/touchscreen.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> =20
> +#include "s6sy761_core.h"
> +
>  /* commands */
>  #define S6SY761_SENSE_ON		0x10
>  #define S6SY761_SENSE_OFF		0x11
> @@ -84,22 +87,18 @@
>  #define S6SY761_APP_FLASH		0x3
>  #define S6SY761_APP_SLEEP		0x4
> =20
> -#define S6SY761_EVENT_SIZE		8
> -#define S6SY761_EVENT_COUNT		32
>  #define S6SY761_DEVID_SIZE		3
>  #define S6SY761_PANEL_ID_SIZE		11
>  #define S6SY761_TS_STATUS_SIZE		5
>  #define S6SY761_MAX_FINGERS		10
> =20
> -#define S6SY761_DEV_NAME	"s6sy761"
> -
> -enum s6sy761_regulators {
> -	S6SY761_REGULATOR_VDD,
> -	S6SY761_REGULATOR_AVDD,
> -};
> -
>  struct s6sy761_data {
> -	struct i2c_client *client;
> +	struct device *dev;
> +	const struct s6sy761_bus_ops *bus_ops;
> +	u8 *xfer_buf;
> +	/* serializes bus access and protects xfer_buf */
> +	struct mutex xfer_lock;
> +	int irq;
>  	struct regulator_bulk_data regulators[2];
>  	struct input_dev *input;
>  	struct touchscreen_properties prop;
> @@ -110,33 +109,21 @@ struct s6sy761_data {
>  	u8 tx_channel;
>  };
> =20
> -/*
> - * We can't simply use i2c_smbus_read_i2c_block_data because we
> - * need to read more than 255 bytes
> - */
> -static int s6sy761_read_events(struct s6sy761_data *sdata, u16 n_events)
> -{
> -	u8 cmd =3D S6SY761_READ_ALL_EVENT;
> -	struct i2c_msg msgs[2] =3D {
> -		{
> -			.addr	=3D sdata->client->addr,
> -			.len	=3D 1,
> -			.buf	=3D &cmd,
> -		},
> -		{
> -			.addr	=3D sdata->client->addr,
> -			.flags	=3D I2C_M_RD,
> -			.len	=3D (n_events * S6SY761_EVENT_SIZE),
> -			.buf	=3D sdata->data + S6SY761_EVENT_SIZE,
> -		},
> -	};
> -	int ret;
> +enum s6sy761_regulators {
> +	S6SY761_REGULATOR_VDD,
> +	S6SY761_REGULATOR_AVDD,
> +};
> =20
> -	ret =3D i2c_transfer(sdata->client->adapter, msgs, ARRAY_SIZE(msgs));
> -	if (ret < 0)
> -		return ret;
> +static int s6sy761_read(struct s6sy761_data *sdata, u8 cmd, size_t len, =
void *buf)
> +{
> +	guard(mutex)(&sdata->xfer_lock);
> +	return sdata->bus_ops->read(sdata->dev, sdata->xfer_buf, cmd, len, buf);
> +}
> =20
> -	return ret =3D=3D ARRAY_SIZE(msgs) ? 0 : -EIO;
> +static int s6sy761_write(struct s6sy761_data *sdata, u8 cmd, size_t len,=
 const void *buf)
> +{
> +	guard(mutex)(&sdata->xfer_lock);
> +	return sdata->bus_ops->write(sdata->dev, sdata->xfer_buf, cmd, len, buf=
);
>  }
> =20
>  static void s6sy761_report_coordinates(struct s6sy761_data *sdata,
> @@ -226,12 +213,10 @@ static irqreturn_t s6sy761_irq_handler(int irq, voi=
d *dev)
>  	int ret;
>  	u8 n_events;
> =20
> -	ret =3D i2c_smbus_read_i2c_block_data(sdata->client,
> -					    S6SY761_READ_ONE_EVENT,
> -					    S6SY761_EVENT_SIZE,
> -					    sdata->data);
> +	ret =3D s6sy761_read(sdata, S6SY761_READ_ONE_EVENT,
> +			   S6SY761_EVENT_SIZE, sdata->data);
>  	if (ret < 0) {
> -		dev_err(&sdata->client->dev, "failed to read events\n");
> +		dev_err(sdata->dev, "failed to read events\n");
>  		return IRQ_HANDLED;
>  	}
> =20
> @@ -243,9 +228,11 @@ static irqreturn_t s6sy761_irq_handler(int irq, void=
 *dev)
>  		return IRQ_HANDLED;
> =20
>  	if (n_events) {
> -		ret =3D s6sy761_read_events(sdata, n_events);
> +		ret =3D s6sy761_read(sdata, S6SY761_READ_ALL_EVENT,
> +				   n_events * S6SY761_EVENT_SIZE,
> +				   sdata->data + S6SY761_EVENT_SIZE);
>  		if (ret < 0) {
> -			dev_err(&sdata->client->dev, "failed to read events\n");
> +			dev_err(sdata->dev, "failed to read events\n");
>  			return IRQ_HANDLED;
>  		}
>  	}
> @@ -259,7 +246,7 @@ static int s6sy761_input_open(struct input_dev *dev)
>  {
>  	struct s6sy761_data *sdata =3D input_get_drvdata(dev);
> =20
> -	return i2c_smbus_write_byte(sdata->client, S6SY761_SENSE_ON);
> +	return s6sy761_write(sdata, S6SY761_SENSE_ON, 0, NULL);
>  }
> =20
>  static void s6sy761_input_close(struct input_dev *dev)
> @@ -267,9 +254,9 @@ static void s6sy761_input_close(struct input_dev *dev)
>  	struct s6sy761_data *sdata =3D input_get_drvdata(dev);
>  	int ret;
> =20
> -	ret =3D i2c_smbus_write_byte(sdata->client, S6SY761_SENSE_OFF);
> +	ret =3D s6sy761_write(sdata, S6SY761_SENSE_OFF, 0, NULL);
>  	if (ret)
> -		dev_err(&sdata->client->dev, "failed to turn off sensing\n");
> +		dev_err(sdata->dev, "failed to turn off sensing\n");
>  }
> =20
>  static ssize_t s6sy761_sysfs_devid(struct device *dev,
> @@ -286,12 +273,23 @@ static struct attribute *s6sy761_sysfs_attrs[] =3D {
>  	&dev_attr_devid.attr,
>  	NULL
>  };
> -ATTRIBUTE_GROUPS(s6sy761_sysfs);
> +
> +static const struct attribute_group s6sy761_sysfs_group =3D {
> +	.attrs =3D s6sy761_sysfs_attrs,
> +};
> +
> +const struct attribute_group *s6sy761_sysfs_groups[] =3D {
> +	&s6sy761_sysfs_group,
> +	NULL,
> +};
> +EXPORT_SYMBOL_NS_GPL(s6sy761_sysfs_groups, "S6SY761");
> =20
>  static int s6sy761_power_on(struct s6sy761_data *sdata)
>  {
> +	__le16 touch_func;
>  	u8 buffer[S6SY761_EVENT_SIZE];
>  	u8 event;
> +	u8 status;
>  	int ret;
> =20
>  	ret =3D regulator_bulk_enable(ARRAY_SIZE(sdata->regulators),
> @@ -302,10 +300,7 @@ static int s6sy761_power_on(struct s6sy761_data *sda=
ta)
>  	msleep(140);
> =20
>  	/* double check whether the touch is functional */
> -	ret =3D i2c_smbus_read_i2c_block_data(sdata->client,
> -					    S6SY761_READ_ONE_EVENT,
> -					    S6SY761_EVENT_SIZE,
> -					    buffer);
> +	ret =3D s6sy761_read(sdata, S6SY761_READ_ONE_EVENT, S6SY761_EVENT_SIZE,=
 buffer);
>  	if (ret < 0)
>  		return ret;
> =20
> @@ -317,18 +312,17 @@ static int s6sy761_power_on(struct s6sy761_data *sd=
ata)
>  		return -ENODEV;
>  	}
> =20
> -	ret =3D i2c_smbus_read_byte_data(sdata->client, S6SY761_BOOT_STATUS);
> +	ret =3D s6sy761_read(sdata, S6SY761_BOOT_STATUS, 1, &status);
>  	if (ret < 0)
>  		return ret;
> =20
>  	/* for some reasons the device might be stuck in the bootloader */
> -	if (ret !=3D S6SY761_BS_APPLICATION)
> +	if (status !=3D S6SY761_BS_APPLICATION)
>  		return -ENODEV;
> =20
>  	/* enable touch functionality */
> -	ret =3D i2c_smbus_write_word_data(sdata->client,
> -					S6SY761_TOUCH_FUNCTION,
> -					S6SY761_MASK_TOUCH);
> +	touch_func =3D cpu_to_le16(S6SY761_MASK_TOUCH);
> +	ret =3D s6sy761_write(sdata, S6SY761_TOUCH_FUNCTION, sizeof(touch_func)=
, &touch_func);
>  	if (ret)
>  		return ret;
> =20
> @@ -339,25 +333,20 @@ static int s6sy761_hw_init(struct s6sy761_data *sda=
ta,
>  			   unsigned int *max_x, unsigned int *max_y)
>  {
>  	u8 buffer[S6SY761_PANEL_ID_SIZE]; /* larger read size */
> +	u8 integrity;
>  	int ret;
> =20
>  	ret =3D s6sy761_power_on(sdata);
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D i2c_smbus_read_i2c_block_data(sdata->client,
> -					    S6SY761_DEVICE_ID,
> -					    S6SY761_DEVID_SIZE,
> -					    buffer);
> +	ret =3D s6sy761_read(sdata, S6SY761_DEVICE_ID, S6SY761_DEVID_SIZE, buff=
er);
>  	if (ret < 0)
>  		return ret;
> =20
>  	sdata->devid =3D get_unaligned_be16(buffer + 1);
> =20
> -	ret =3D i2c_smbus_read_i2c_block_data(sdata->client,
> -					    S6SY761_PANEL_INFO,
> -					    S6SY761_PANEL_ID_SIZE,
> -					    buffer);
> +	ret =3D s6sy761_read(sdata, S6SY761_PANEL_INFO, S6SY761_PANEL_ID_SIZE, =
buffer);
>  	if (ret < 0)
>  		return ret;
> =20
> @@ -367,11 +356,10 @@ static int s6sy761_hw_init(struct s6sy761_data *sda=
ta,
>  	/* if no tx channels defined, at least keep one */
>  	sdata->tx_channel =3D max_t(u8, buffer[8], 1);
> =20
> -	ret =3D i2c_smbus_read_byte_data(sdata->client,
> -				       S6SY761_FIRMWARE_INTEGRITY);
> +	ret =3D s6sy761_read(sdata, S6SY761_FIRMWARE_INTEGRITY, 1, &integrity);
>  	if (ret < 0)
>  		return ret;
> -	else if (ret !=3D S6SY761_FW_OK)
> +	else if (integrity !=3D S6SY761_FW_OK)
>  		return -ENODEV;
> =20
>  	return 0;
> @@ -381,38 +369,44 @@ static void s6sy761_power_off(void *data)
>  {
>  	struct s6sy761_data *sdata =3D data;
> =20
> -	disable_irq(sdata->client->irq);
> +	disable_irq(sdata->irq);
>  	regulator_bulk_disable(ARRAY_SIZE(sdata->regulators),
>  						sdata->regulators);
>  }
> =20
> -static int s6sy761_probe(struct i2c_client *client)
> +int s6sy761_probe(struct device *dev, const struct s6sy761_bus_ops *bus_=
ops, int irq)
>  {
>  	struct s6sy761_data *sdata;
>  	unsigned int max_x, max_y;
>  	int err;
> =20
> -	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> -						I2C_FUNC_SMBUS_BYTE_DATA |
> -						I2C_FUNC_SMBUS_I2C_BLOCK))
> -		return -ENODEV;
> -
> -	sdata =3D devm_kzalloc(&client->dev, sizeof(*sdata), GFP_KERNEL);
> +	sdata =3D devm_kzalloc(dev, sizeof(*sdata), GFP_KERNEL);
>  	if (!sdata)
>  		return -ENOMEM;
> =20
> -	i2c_set_clientdata(client, sdata);
> -	sdata->client =3D client;
> +	sdata->xfer_buf =3D devm_kzalloc(dev, S6SY761_XFER_BUFFER_SIZE, GFP_KER=
NEL);
> +	if (!sdata->xfer_buf)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, sdata);
> +
> +	sdata->bus_ops =3D bus_ops;
> +	sdata->dev =3D dev;
> +	sdata->irq =3D irq;
> +
> +	err =3D devm_mutex_init(dev, &sdata->xfer_lock);
> +	if (err)
> +		return err;
> =20
>  	sdata->regulators[S6SY761_REGULATOR_VDD].supply =3D "vdd";
>  	sdata->regulators[S6SY761_REGULATOR_AVDD].supply =3D "avdd";
> -	err =3D devm_regulator_bulk_get(&client->dev,
> +	err =3D devm_regulator_bulk_get(dev,
>  				      ARRAY_SIZE(sdata->regulators),
>  				      sdata->regulators);
>  	if (err)
>  		return err;
> =20
> -	err =3D devm_add_action_or_reset(&client->dev, s6sy761_power_off, sdata=
);
> +	err =3D devm_add_action_or_reset(dev, s6sy761_power_off, sdata);
>  	if (err)
>  		return err;
> =20
> @@ -420,12 +414,12 @@ static int s6sy761_probe(struct i2c_client *client)
>  	if (err)
>  		return err;
> =20
> -	sdata->input =3D devm_input_allocate_device(&client->dev);
> +	sdata->input =3D devm_input_allocate_device(dev);
>  	if (!sdata->input)
>  		return -ENOMEM;
> =20
>  	sdata->input->name =3D S6SY761_DEV_NAME;
> -	sdata->input->id.bustype =3D BUS_I2C;
> +	sdata->input->id.bustype =3D bus_ops->bustype;
>  	sdata->input->open =3D s6sy761_input_open;
>  	sdata->input->close =3D s6sy761_input_close;
> =20
> @@ -441,7 +435,7 @@ static int s6sy761_probe(struct i2c_client *client)
> =20
>  	if (!input_abs_get_max(sdata->input, ABS_X) ||
>  	    !input_abs_get_max(sdata->input, ABS_Y)) {
> -		dev_warn(&client->dev, "the axis have not been set\n");
> +		dev_warn(dev, "the axis have not been set\n");
>  	}
> =20
>  	err =3D input_mt_init_slots(sdata->input, sdata->tx_channel,
> @@ -455,37 +449,39 @@ static int s6sy761_probe(struct i2c_client *client)
>  	if (err)
>  		return err;
> =20
> -	err =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +	err =3D devm_request_threaded_irq(dev, sdata->irq, NULL,
>  					s6sy761_irq_handler,
>  					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>  					"s6sy761_irq", sdata);
>  	if (err)
>  		return err;
> =20
> -	pm_runtime_enable(&client->dev);
> +	pm_runtime_enable(dev);
> =20
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(s6sy761_probe, "S6SY761");
> =20
> -static void s6sy761_remove(struct i2c_client *client)
> +void s6sy761_remove(struct device *dev)
>  {
> -	pm_runtime_disable(&client->dev);
> +	pm_runtime_disable(dev);
>  }
> +EXPORT_SYMBOL_NS_GPL(s6sy761_remove, "S6SY761");
> =20
>  static int s6sy761_runtime_suspend(struct device *dev)
>  {
>  	struct s6sy761_data *sdata =3D dev_get_drvdata(dev);
> +	u8 mode =3D S6SY761_APP_SLEEP;
> =20
> -	return i2c_smbus_write_byte_data(sdata->client,
> -				S6SY761_APPLICATION_MODE, S6SY761_APP_SLEEP);
> +	return s6sy761_write(sdata, S6SY761_APPLICATION_MODE, 1, &mode);
>  }
> =20
>  static int s6sy761_runtime_resume(struct device *dev)
>  {
>  	struct s6sy761_data *sdata =3D dev_get_drvdata(dev);
> +	u8 mode =3D S6SY761_APP_NORMAL;
> =20
> -	return i2c_smbus_write_byte_data(sdata->client,
> -				S6SY761_APPLICATION_MODE, S6SY761_APP_NORMAL);
> +	return s6sy761_write(sdata, S6SY761_APPLICATION_MODE, 1, &mode);
>  }
> =20
>  static int s6sy761_suspend(struct device *dev)
> @@ -506,51 +502,23 @@ static int s6sy761_resume(struct device *dev)
>  	if (err)
>  		return err;
> =20
> -	enable_irq(sdata->client->irq);
> +	enable_irq(sdata->irq);
> =20
>  	guard(mutex)(&sdata->input->mutex);
> =20
>  	if (!input_device_enabled(sdata->input))
>  		return 0;
> =20
> -	err =3D i2c_smbus_write_byte(sdata->client, S6SY761_SENSE_ON);
> +	err =3D s6sy761_write(sdata, S6SY761_SENSE_ON, 0, NULL);
> =20
>  	return err;
>  }
> =20
> -static const struct dev_pm_ops s6sy761_pm_ops =3D {
> +EXPORT_NS_GPL_DEV_PM_OPS(s6sy761_pm_ops, S6SY761) =3D {
>  	SYSTEM_SLEEP_PM_OPS(s6sy761_suspend, s6sy761_resume)
>  	RUNTIME_PM_OPS(s6sy761_runtime_suspend, s6sy761_runtime_resume, NULL)
>  };
> =20
> -#ifdef CONFIG_OF
> -static const struct of_device_id s6sy761_of_match[] =3D {
> -	{ .compatible =3D "samsung,s6sy761", },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, s6sy761_of_match);
> -#endif
> -
> -static const struct i2c_device_id s6sy761_id[] =3D {
> -	{ .name =3D "s6sy761" },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(i2c, s6sy761_id);
> -
> -static struct i2c_driver s6sy761_driver =3D {
> -	.driver =3D {
> -		.name =3D S6SY761_DEV_NAME,
> -		.dev_groups =3D s6sy761_sysfs_groups,
> -		.of_match_table =3D of_match_ptr(s6sy761_of_match),
> -		.pm =3D pm_ptr(&s6sy761_pm_ops),
> -	},
> -	.probe =3D s6sy761_probe,
> -	.remove =3D s6sy761_remove,
> -	.id_table =3D s6sy761_id,
> -};
> -
> -module_i2c_driver(s6sy761_driver);
> -
>  MODULE_AUTHOR("Andi Shyti <andi.shyti@samsung.com>");
> -MODULE_DESCRIPTION("Samsung S6SY761 Touch Screen");
> -MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Samsung S6SY761 Touch Screen core");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/input/touchscreen/s6sy761_core.h b/drivers/input/tou=
chscreen/s6sy761_core.h
> new file mode 100644
> index 000000000000..059cd5a36a34
> --- /dev/null
> +++ b/drivers/input/touchscreen/s6sy761_core.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _S6SY761_H
> +#define _S6SY761_H
> +
> +#include <linux/align.h>
> +#include <linux/types.h>
> +
> +#define S6SY761_EVENT_SIZE			8
> +#define S6SY761_EVENT_COUNT			32
> +/* largest SPI read: reply header + all events + checksum */
> +#define S6SY761_XFER_BUFFER_SIZE	ALIGN(7 + S6SY761_EVENT_SIZE * S6SY761_=
EVENT_COUNT + 1, 4)
> +
> +#define S6SY761_DEV_NAME	"s6sy761"
> +
> +struct device;
> +struct dev_pm_ops;
> +struct attribute_group;
> +
> +struct s6sy761_bus_ops {
> +	u16 bustype;
> +	int (*write)(struct device *dev, u8 *xfer_buf,
> +		     u8 cmd, size_t length, const void *values);
> +	int (*read)(struct device *dev, u8 *xfer_buf,
> +		    u8 cmd, size_t length, void *values);
> +};
> +
> +extern const struct dev_pm_ops s6sy761_pm_ops;
> +
> +extern const struct attribute_group *s6sy761_sysfs_groups[];
> +
> +int s6sy761_probe(struct device *dev, const struct s6sy761_bus_ops *bus_=
ops, int irq);
> +void s6sy761_remove(struct device *dev);
> +
> +#endif
> diff --git a/drivers/input/touchscreen/s6sy761_i2c.c b/drivers/input/touc=
hscreen/s6sy761_i2c.c
> new file mode 100644
> index 000000000000..b5cbebfd722a
> --- /dev/null
> +++ b/drivers/input/touchscreen/s6sy761_i2c.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Samsung S6SY761 I2C Touchscreen device driver
> +//
> +// Copyright (c) 2017 Samsung Electronics Co., Ltd.
> +// Copyright (c) 2017 Andi Shyti <andi@etezian.org>
> +// Copyright (c) 2026 Lukas Timmermann <foss@timmermann.space>
> +
> +#include <linux/input.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>

Please don't add new usages of <linux/mod_devicetable.h>. <linux/i2c.h>
is enough to get the definition of of_device_id and i2c_device_id.

I didn't look into the other patches of this series in detail, but I
suspect that the same holds true in your spi patch. <linux/spi/spi.h>
provides of_device_id and spi_device_id, so don't add
<linux/mod_devicetable.h> there either.

(If you want to go full iwyu, use the subsystem specific headers below
linux/device-id/.

> +static const struct of_device_id s6sy761_of_match[] =3D {
> +	{ .compatible =3D "samsung,s6sy761", },
> +	{ },

No trailing comma after the list terminator please.

> +};
> +MODULE_DEVICE_TABLE(of, s6sy761_of_match);
> +
> +static const struct i2c_device_id s6sy761_id[] =3D {
> +	{ "s6sy761" },

please make this: { .name =3D "s6sy761" }

Best regards
Uwe

--eblkicd243zh2pgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrMvsEACgkQj4D7WH0S
/k5Shgf+IsmMZaet7PbB2OnQ9hd7mrfIqEfg/OB8ToTjp8rW26Kov8zQKsgaj9QO
aHCArCuZUkJpbqCwnKkmPsEuropi0LqZ/19i07lEYy/RAq1PD2w7q50zX3ipF/VO
g1wnMs7x8zwNq6Kt99YtO8wWdC2enPtwQxwelgstVRGdGPcuZAseg+GMpQ1Qoqz4
sfthr/hktJUEUI89PfrbbS/mO6GGHUkHzj2SXD+RVBIvDV80CSrh/LeLXMmYtZ5h
+IoK7/JsAYOYn6BLblaZDrTG2P09YJIxwMYmvPbDuhlpbBqY317G4lRotBaOTk0J
IXH/mrSdNwOCOCGV9GTpPAQIJTKmuw==
=ADAt
-----END PGP SIGNATURE-----

--eblkicd243zh2pgk--
