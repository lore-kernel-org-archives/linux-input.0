Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D836326928;
	Thu, 30 Jul 2026 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441647; cv=none; b=bA+4huhsJOz9ZQZBkopHd6lwj6g4amGWrnx50cUPvG/4qnTOhS2jPD4quoq9Nk/uZ+z9HY8kgBX6Pn/wT6wyPrp8VpN1ySGz6XgubedapBaa9rbeZY/vqOPUiDpn++G68nmKsRYOSPJ8F0WvN15KJozmpGDGR/XU6eIWQTaNHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441647; c=relaxed/simple;
	bh=UOvLgXOOi45j8zP+aFGHYnXv4GW2hGuPgOjhWWo7JU8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gLLOhIO0Wymfb8OnH9QIVKwbby1pyDSATPDe+cFCNvePEW0OcTjwv/OzOMEQsLdH0kCStkVpSC27Oj1okhKFuPm+ne9PS/8PgxeBJ/jgIjqMWIr1QQ6VZP8EVlmFgF7fU7orMnoHrozXQgMssH2jp1pVZEaxFRhImdXjhXmYUPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxoM6kc0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxoM6kc0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4282B1F000E9;
	Thu, 30 Jul 2026 20:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785441641;
	bh=Pka+rjf1pyY0+8KUe7zlVHBVyCfeueZooJFQfuEc+yI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UxoM6kc0ts/1fXYOsIcI2z60JX9Mwur2YWq9AT0ltXRxETTNnPywRS4JQpZkPTEpj
	 ueLIVrB+d2iKu88cEwX64/vh1s/Xmav1GJ0uSLQMCttjZndZkKY+XLLoyhH9+g0/1l
	 aSo2PH12acMXnX3oIEWKk/tfV9BUm5U9nIALlxG/hEhasbYCWF89DZVvHaxo+oQaMw
	 DpX9TD4u8txPnM6csRkuTJludprZMIrjdJzwpY2ZxAJLbIcSPn28SVQkoscBQRGkt2
	 0AACJ7knkjNybqKkZB+gbXt0pkXMO0ciW5KxYUzETKNld0Mt5SVJSdF7eZtZjhPPcg
	 e9LrBj94dKm/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] Input: zinitix - add support for modes 0 and 1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260731-zinitix-modes-v2-3-ffe2ec9a9031@disroot.org>
References: <20260731-zinitix-modes-v2-0-ffe2ec9a9031@disroot.org>
 <20260731-zinitix-modes-v2-3-ffe2ec9a9031@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 20:00:40 +0000
Message-Id: <20260730200041.4282B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The input device is registered and exposed to userspace before its=
 private `read_point_status` function pointer is initialized, creating a ra=
ce condition that leads to a NULL pointer dereference in the IRQ handler.

Pre-existing issues:
- [High] The driver passes stack-allocated structs to the I2C subsystem for=
 receiving data, which can cause memory corruption or kernel panics if the =
I2C controller driver maps the buffers for DMA.
--

--- Patch [3]: [PATCH v2 3/5] Input: zinitix - add support for modes 0 and =
1 ---
commit 2caca9eabecb85f6226ee1af1cfdde1aeb2f1bc2
Author: Kaustabh Chakraborty <kauschluss@disroot.org>

Input: zinitix - add support for modes 0 and 1

Zinitix touchscreens have three modes, numbered 0 to 2. The driver
implements mode 2, and leaves out modes 0 and 1. Implement modes 0 and 1
in the driver, along with their event structs.

> diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscr=
een/zinitix.c
> index a0a89d25e25bb..aafd0b7d8edbd 100644
> --- a/drivers/input/touchscreen/zinitix.c
> +++ b/drivers/input/touchscreen/zinitix.c

[ ... ]

> @@ -440,6 +471,87 @@ static void zinitix_report_keys(struct bt541_ts_data=
 *bt541, u16 icon_events)
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
This is a pre-existing issue, but does passing this stack-allocated
event_mode0 struct to the I2C subsystem cause memory corruption or kernel
panics if the underlying I2C host controller driver maps it for DMA?

The same pattern is also present in the new zinitix_read_point_status_mode1=
()
and zinitix_read_point_status_mode2() functions.

[ ... ]

> @@ -682,13 +793,19 @@ static int zinitix_ts_probe(struct i2c_client *clie=
nt)
>  		bt541->zinitix_mode =3D DEFAULT_TOUCH_POINT_MODE;
>  	}
> =20
> -	if (bt541->zinitix_mode !=3D 2) {
> -		/*
> -		 * If there are devices that don't support mode 2, support
> -		 * for other modes (0, 1) will be needed.
> -		 */
> +	switch (bt541->zinitix_mode) {
> +	case 0:
> +		bt541->read_point_status =3D zinitix_read_point_status_mode0;

[Severity: High]
Can a fast userspace trigger a NULL pointer dereference here?

Since zinitix_init_input_dev() is called earlier in zinitix_ts_probe(),
the device is registered and exposed to userspace before
bt541->read_point_status is initialized:

zinitix_ts_probe()
    zinitix_init_input_dev()
        input_register_device()
    ...
    switch (bt541->zinitix_mode) {
    case 0:
        bt541->read_point_status =3D zinitix_read_point_status_mode0;

If userspace opens the device and an interrupt triggers before the switch
statement, zinitix_ts_irq_handler() will dereference the uninitialized
read_point_status pointer:

zinitix_ts_irq_handler()
    bt541->read_point_status(bt541, &touch_event);

> +		break;
> +	case 1:
> +		bt541->read_point_status =3D zinitix_read_point_status_mode1;
> +		break;
> +	case 2:
> +		bt541->read_point_status =3D zinitix_read_point_status_mode2;
> +		break;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-zinitix-mo=
des-v2-0-ffe2ec9a9031@disroot.org?part=3D3
