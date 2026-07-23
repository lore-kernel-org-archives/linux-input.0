Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3678375ADC;
	Thu, 23 Jul 2026 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784835224; cv=none; b=dR3+53PBGN5Yx2Y2qu5LpHhcQx+mKOjzTd8aM447GJ1ReV2pLyJdEGpYFwlJIRx3TF4qWq97sEWogh/G/+ODdfbs1rFHnvdrO1PdT6lkH/VsN8gkadPs9Q24napwYq5cONzJx2RELXbh+JpqanSPd4AZZgxllkrZbexTklLLlZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784835224; c=relaxed/simple;
	bh=SaxkG8zv2Uva8saHNvS/nIJ+tcHK7z4L9XVKbWCq9uI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RAYggiRZk4Rf0S6VIsLAUqnuo26aflQf9aw1kPAKBPivyqmTdvxXJwvMNJ+nOlUnaEqXwFlUhR6U9WlHli6sLQOhfi1pvcGY6gPJMY0KVD+wyhV+Yfc5Etm18W4srXFLgHs7zL3hH9wovmqF1aRF/p7ISB5vnR3Vd8q1wItI8ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbUrE9vd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbUrE9vd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3171F000E9;
	Thu, 23 Jul 2026 19:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784835221;
	bh=bjmT4oIIaIsaoP2xWnwCppFgkL4eCmTKZTac6B5XzRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DbUrE9vdXJuwQPk9nqLfmH2+Fx/ucfIgi6ccRm4eP2Oue43B8P7UfxtnRpwCX3mdU
	 7RU4+5SeCbUIcyClKoREdCsCKjv1Zmz7XpXryr2uKtCIx0WZPUngQgrwmX579PEpA3
	 P6TZ14Ns0qx4DfcpQMdGOZrg6DYsMvlfcvgGHJvL1Y4s9f57Scs//K9keGIsFjsSGs
	 6ob8UWdjsAVR1CGAxIshU6VNKFlVtrsglSGXk0yxsgc5kcVRGRdJHR1hRFsp2tcB4Q
	 6/JHFtbuyrFDbF0Ns/agn3ZAAj42QgORPRWK/eLP8fnQsM3ee2avZrYu2E8dP7tNHA
	 kBx83bRzjn9yA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] Input: zinitix - add support for modes 0 and 1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260724-zinitix-modes-v1-3-f6df7d86a878@disroot.org>
References: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org>
 <20260724-zinitix-modes-v1-3-f6df7d86a878@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 19:33:40 +0000
Message-Id: <20260723193341.1D3171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The input device is registered and exposed to userspace before its=
 driver private data (`zinitix_mode`) is fully parsed and initialized, crea=
ting a race condition.
- [High] Stack-allocated buffers are passed to I2C transfer functions, whic=
h is unsafe and can lead to memory corruption or kernel panics if the I2C a=
dapter relies on DMA.
--

--- Patch [3]: [PATCH 3/5] Input: zinitix - add support for modes 0 and 1 -=
--
commit 0a0b84e68f36f7bf2e3b751801c1b10ca100ae2e
Author: Kaustabh Chakraborty <kauschluss@disroot.org>

Input: zinitix - add support for modes 0 and 1

This commit implements support for touchscreen modes 0 and 1 in the zinitix
driver by introducing mode-specific event structures. It maintains a common
canonical event structure and adds functions to convert mode-specific event
data into this common format.

> diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscr=
een/zinitix.c
> index fdcb80f52c917..42010f23445e3 100644
> --- a/drivers/input/touchscreen/zinitix.c
> +++ b/drivers/input/touchscreen/zinitix.c

[ ... ]

> @@ -440,6 +470,103 @@ static void zinitix_report_keys(struct bt541_ts_dat=
a *bt541, u16 icon_events)
>  				 bt541->keycodes[i], icon_events & BIT(i));
>  }
> =20
> +static int zinitix_read_point_status_mode0(struct bt541_ts_data *bt541,
> +					   struct touch_event *event)
> +{
> +	struct touch_event_mode0 event_mode0;
> +	int ret;
> +	int i;
> +
> +	ret =3D zinitix_read_data(bt541->client, ZINITIX_POINT_STATUS_REG,
> +				&event_mode0, sizeof(struct touch_event_mode0));

[Severity: High]
This isn't a bug introduced by this patch, but does passing stack-allocated
buffers to I2C transfer functions risk memory corruption?

Looking at zinitix_read_point_status_mode0(), the stack-allocated
event_mode0 structure is passed via zinitix_read_data() to i2c_master_recv(=
).
Because kernel stacks are typically virtually mapped with CONFIG_VMAP_STACK
and are not physically contiguous, if the underlying I2C controller driver
attempts to DMA-map this memory, it can lead to memory corruption or kernel
panics.

This pattern is pre-existing in the driver, but the new mode implementations
continue to use it.

> +	if (ret)
> +		return ret;

[ ... ]

> @@ -682,13 +808,9 @@ static int zinitix_ts_probe(struct i2c_client *clien=
t)
>  		bt541->zinitix_mode =3D DEFAULT_TOUCH_POINT_MODE;
>  	}
> =20
> -	if (bt541->zinitix_mode !=3D 2) {
> -		/*
> -		 * If there are devices that don't support mode 2, support
> -		 * for other modes (0, 1) will be needed.
> -		 */
> +	if (bt541->zinitix_mode > 2) {
>  		dev_err(&client->dev,
> -			"Malformed zinitix,mode property, must be 2 (supplied: %d)\n",
> +			"Malformed zinitix,mode property, must be 0, 1, or 2 (supplied: %d)\n=
",
>  			bt541->zinitix_mode);

[Severity: High]
This is a pre-existing issue, but could parsing and validating zinitix_mode
after the input device is registered cause a race condition with userspace?

In zinitix_ts_probe(), zinitix_init_input_dev() is called earlier, which
registers the input device and makes it available to userspace. If userspace
opens the device immediately (e.g., via udev uevents), the hardware might
be initialized with an uninitialized zinitix_mode (0 instead of the intended
mode) before this device property parsing executes. This can lead to the
interrupt handler processing garbage data.

Would it be better to read and validate the "zinitix,mode" property before
calling zinitix_init_input_dev()?

>  		return -EINVAL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-zinitix-mo=
des-v1-0-f6df7d86a878@disroot.org?part=3D3
