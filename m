Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA68D37E2EE
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435771; cv=none; b=PidaDshVQ8JOJ2Aq6f47DQ3Z9rmQ83h6WWtOhnq1S1KbLp0yIdmtKIkCPRTIAjwZvAcg6Hw5T8OG2zAHIGaKRNM0gnsfNfa9iPXeM3UH+m1L30zIXBgxI/cGE3puv4YM4nlpXj2dn7D2bt60wsBLutJSq/ZYBkewsq6M381cjnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435771; c=relaxed/simple;
	bh=Fnqd9M8znQ7W+k+mLZTX2fvx5rLXZURI8c+ln2YNW5c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dr9J2Y7zzITfVkmeY39dKnuy+4qITqR+nJGOWfgQf6gbqUcmXpPmy3EG5DIqajI1enRGqnhwaJZbDtFJzrFHqJTED3T05EAvJBDBEpbRyQ4x0s+uGnSEU18Cc8qaaxy1MGyV7sBvnCemLJW+MqZMDOmr2uXGw5vv07FVvNL2T/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E25Ctf7f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E25Ctf7f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EBF1F000E9;
	Sat, 22 Aug 2026 21:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787435769;
	bh=pHh9G0GCmFBuoJwxwaX48Mpsyo/mOyCEJSj7dZz+wDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E25Ctf7fpatGXFDqP4V/CBAut1uFEr05qNWh2OYvCJAhhW0ngkRzg42fgGpB3PZcu
	 zsL/gXAbVcxx7SozdzMgt1mFYbz8uMdFx0EkGceBj8sSmeRhXGNtqPnGCY5hAwsMQ8
	 fr7gDddxalPXokaqUDczPkEnVj1UFKAyWsk+qaszuAwc/KdvywlzBLl6dUUJ4wEiPM
	 DFlv1Afq9Py5bHEZGp/pamcdM5LoreWqXrd2GTo7XCBllAw0OOv6F/pzdjECGQpanY
	 WBLTWTv5JXK+uDbRgJ9wUXEW8FakPv9eR4QBREwZgtuqSTie5AutRaOrQ3yBEzFqFd
	 LHMMd7BaYaIQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/13] HID: ft260: add GPIO support on top of UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260822213941.98882-4-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
 <20260822213941.98882-4-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 21:56:09 +0000
Message-Id: <20260822215609.75EBF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Uninitialized GPIO shadow state (`dev->gpio`) corrupts the hardwar=
e configuration of unrelated pins during updates.
- [High] Unvalidated `cfg->uart_mode` read from the device is used as an ar=
ray index, leading to an out-of-bounds read.
- [Medium] Setting a GPIO direction to output introduces a hardware glitch =
by splitting the operation into two non-atomic USB requests.
- [Medium] Setting the UART mode to OFF unintentionally disables all non-UA=
RT GPIOs.
--

--- Patch [3]: [PATCH 03/13] HID: ft260: add GPIO support on top of UART ---
commit d5e8f3410c2633ba90471af57e3193f95d3193d4
Author: Michael Zaidman <michael.zaidman@gmail.com>
   =20
HID: ft260: add GPIO support on top of UART
   =20
Add gpiochip support for the FT260 multifunctional pins, including
GPIO2/GPIOA/GPIOG function selection via sysfs, and enable the
available GPIOs according to the active UART mode.
   =20
Link: https://lore.kernel.org/lkml/20230211115752.26276-2-michael.zaidman@g=
mail.com/

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index b6c408267a685..cc3b8f5791dea 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
[ ... ]
> @@ -906,6 +1023,322 @@ static const struct i2c_algorithm ft260_i2c_algo =
=3D {
>  	.functionality =3D ft260_functionality,
>  };
> =20
> +static void ft260_gpio_en_set(struct ft260_device *dev, u16 bitmap)
> +{
> +	dev->gpio_en |=3D bitmap & FT260_GPIO_MASK;
> +}
> +
> +static void ft260_gpio_en_clr(struct ft260_device *dev, u16 bitmap)
> +{
> +	dev->gpio_en &=3D ~bitmap & FT260_GPIO_MASK;
> +}
> +
> +static void ft260_gpio_en_update(struct hid_device *hdev, u8 req, u8 val=
ue)
> +{
> +	u16 bitmap;
> +	struct ft260_device *dev =3D hid_get_drvdata(hdev);
> +
> +	switch (req) {
> +
> +	case FT260_SET_I2C_MODE:
> +		bitmap =3D FT260_GPIO_I2C_DEFAULT;
> +		break;
> +	case FT260_SET_UART_MODE:
> +		switch (value) {
> +		case FT260_UART_CFG_FLOW_CTRL_OFF:
> +			bitmap =3D (u16)FT260_GPIO_MASK;
> +			break;
[ ... ]
> +		}
> +		ft260_gpio_en_clr(dev, bitmap);
> +		bitmap =3D dev->gpio_uart_mode[value];
> +		ft260_gpio_en_set(dev, bitmap);
> +		goto exit;

[Severity: Medium]
Does setting the UART flow control to OFF unintentionally disable all non-U=
ART
GPIOs?=20

When value is FT260_UART_CFG_FLOW_CTRL_OFF (0), bitmap is set to
FT260_GPIO_MASK, which represents all 14 GPIO bits. Calling
ft260_gpio_en_clr() inadvertently clears all of these bits from dev->gpio_e=
n.
Subsequently, only the FT260_GPIO_UART_MODE_0_SET bits are restored, which
permanently disables I2C and other multi-function GPIOs until they are
manually re-enabled.

[ ... ]
> +static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
> +{
> +	int ret =3D 0;
> +	struct ft260_gpio_write_request_report rep;
> +	struct ft260_device *dev =3D gpiochip_get_data(gc);
> +	struct hid_device *hdev =3D dev->hdev;
> +
> +	if (offset >=3D FT260_GPIO_TOTAL) {
> +		hid_err(hdev, "%s: invalid offset %d\n", __func__, offset);
> +		return -EINVAL;
> +	}
> +
> +	ft260_dbg("offset %d val %d\n", offset, value);
> +
> +	mutex_lock(&dev->lock);
> +
> +	if (!(dev->gpio_en & (1 << offset))) {
> +		hid_err(hdev, "%s: wrong pin function %d\n", __func__, offset);
> +		ret =3D -EINVAL;
> +		goto exit;
> +	}
> +
> +	rep.report =3D FT260_GPIO;
> +	rep.gpio =3D dev->gpio;
> +
> +	if (offset < FT260_GPIO_MAX) {
[ ... ]
> +	ret =3D ft260_hid_feature_report_set(hdev, (u8 *)&rep, sizeof(rep));

[Severity: High]
Does this corrupt the hardware configuration of unrelated pins?

The shadow state dev->gpio is zero-initialized via kzalloc during device
allocation and is never synced with the actual hardware state during
ft260_gpio_init(). Because the entire dev->gpio struct is written to the
device here, won't all unmodified pins be unintentionally configured to inp=
ut
mode with value 0?

> +	if (unlikely(ret < 0)) {
> +		hid_err(hdev, "%s: cannot set GPIO: %d\n", __func__, ret);
> +		goto exit;
> +	}
> +
> +	dev->gpio =3D rep.gpio;
> +	ret =3D 0;
> +exit:
> +	mutex_unlock(&dev->lock);
> +	return ret;
> +}
> +
> +static int ft260_gpio_direction_set(struct gpio_chip *gc, u32 offset,
> +				    int value, int direction)
> +{
> +	int ret;
> +	struct ft260_gpio_read_request_report buf;
> +	struct ft260_gpio_write_request_report *rep;
> +	struct ft260_device *dev =3D gpiochip_get_data(gc);
> +	struct hid_device *hdev =3D dev->hdev;
> +
[ ... ]
> +	ret =3D ft260_hid_feature_report_set(hdev, (u8 *)rep, sizeof(*rep));
> +	if (unlikely(ret < 0)) {
> +		hid_err(hdev, "%s: cannot set GPIO: %d\n", __func__, ret);
> +		goto exit;
> +	}
> +
> +	dev->gpio =3D rep->gpio;
> +	mutex_unlock(&dev->lock);
> +
> +	if (direction =3D=3D FT260_GPIO_DIR_OUTPUT)
> +		ft260_gpio_set(gc, offset, value);

[Severity: Medium]
Could this introduce a hardware glitch when changing a pin's direction to
output?=20

The code updates the direction bits to output without setting the correspon=
ding
value bits, and writes this immediately to the device via
ft260_hid_feature_report_set(). Then it sends a second USB request via
ft260_gpio_set() to set the desired output value. During the window between
these two USB transfers, will the pin assert an unintended logic level?

> +
> +	return 0;
> +exit:
> +	mutex_unlock(&dev->lock);
> +	return ret;
> +}
[ ... ]
> +static int ft260_gpio_init(struct ft260_device *dev,
> +			   struct ft260_get_system_status_report *cfg)
> +{
> +	int ret;
> +	int label_sz;
> +	char *label;
> +	struct ft260_get_chip_version_report ver;
> +	struct hid_device *hdev =3D dev->hdev;
> +	char prefix[] =3D "ft260_";
> +	u8 mode =3D cfg->chip_mode;
> +
> +	hid_info(hdev, "initialize gpio chip\n");
> +
> +	dev->gpio_uart_mode[0] =3D (u16)FT260_GPIO_UART_MODE_0_SET;
> +	dev->gpio_uart_mode[1] =3D (u16)FT260_GPIO_UART_MODE_1_SET;
> +	dev->gpio_uart_mode[2] =3D (u16)FT260_GPIO_UART_MODE_2_SET;
> +	dev->gpio_uart_mode[3] =3D (u16)FT260_GPIO_UART_MODE_3_SET;
> +	dev->gpio_uart_mode[4] =3D (u16)FT260_GPIO_UART_MODE_4_SET;
> +
> +	if (mode =3D=3D FT260_MODE_ALL)
> +		mode =3D FT260_MODE_BOTH;
> +
> +	if (mode & FT260_MODE_UART)
> +		dev->gpio_en |=3D dev->gpio_uart_mode[cfg->uart_mode];

[Severity: High]
Can this read out of bounds?=20

cfg->uart_mode is read directly from the device via a USB feature report in
ft260_get_system_config(). If a malicious or malfunctioning USB device retu=
rns
a uart_mode >=3D 5, won't this leak kernel heap data into dev->gpio_en or c=
rash
since dev->gpio_uart_mode only has 5 elements?

> +	else
> +		dev->gpio_en |=3D FT260_GPIO_UART_DEFAULT;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822213941.9888=
2-1-michael.zaidman@gmail.com?part=3D3
