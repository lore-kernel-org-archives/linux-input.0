Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4083B71C3
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 02:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895986; cv=none; b=sa+VC4TIS2yx339xvin8nwnaeYN4fTxkgNaAs7XSx+5tuknwL9WE6Hg68shC5Sx3369qjbz6IEj3bwrhq2qcKFnJu5iN//y77UNQ2VziHf52/6LwFPC9PENjowIpAOMwM/QQhIESx3BCh1cNsGfcZQHP+vFAk8Y+RBbyAv0gyrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895986; c=relaxed/simple;
	bh=5oftAmBpB3eHComzMwtACqJI+fFXiMAsaSlkvWwUdFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PQLXqqLwmPcxbZbYMzfo3iTDVs0spObS1VYK1S7BAS6wmFFmSRNKAKhGjQT+hKwaCtpn8Gk8JrENHEMD+bhSIcV/BpIY68KfJkW1O8VYao2Rf5G04tbOckXUgB4WGldkpx4V0CstWGRBrpHn+jK9DE2wRgRLH7YEX7Exk1unBXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQzi5qcB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQzi5qcB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E551F000E9;
	Wed,  5 Aug 2026 02:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785895984;
	bh=vlZ7V/wvO5u1ECW/ux15JFKncbG+qU/jqOVHfd8pzmc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dQzi5qcBktaJxWHTvZkP2uTX3/FvgcIeJTr9z28jBj+UeeWQ+LwJbezdNuDUSLr0Q
	 jINfSulUv5wgLFV72r8m11f7G3uBxtIaXDqC1SN+3RWoim6Sba2w/UM+u5TQ6IyagN
	 r7s8EmvVcCEdEMRG4Ivswy3EPHhr7TkiB3ZaRttl75NizYRflv3sxw3DbXbT/sdEJJ
	 l4GVU0EEj/mEqmSG3Gj4IsEfwCe9SLZM+bpnSZr4Ddm8an8uPK6O+OsRz+6ly7ljRf
	 E4vyIF2CBGDMK3bpVvl3KObyV5PlSobkA35KVk0XcIhAV5FLnSLK0lJ051AaFEQFgc
	 44r/sKp+iW1hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] HID: steam: Initial 2026 Steam Controller support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260805015116.3884465-2-vi@endrift.com>
References: <20260805015116.3884465-1-vi@endrift.com>
 <20260805015116.3884465-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 02:13:03 +0000
Message-Id: <20260805021304.37E551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Battery registration fails due to thermal zone name length limits =
if the device serial number is long.
- [Medium] Incorrect initialization of battery temperature results in repor=
ting 0.2 =C2=B0C.
- [Low] Duplicate error logging block introduced in steam_recv_report_id.

Pre-existing issues:
- [High] Probe failure leaves a registered power supply with dangling devm =
pointers.
- [High] Unbinding the driver while the device is active can lead to a Use-=
After-Free in steam_work_connect_cb.
--

--- Patch [1]: [PATCH 1/5] HID: steam: Initial 2026 Steam Controller suppor=
t ---
commit 10f5a4093529f8973ab3200723fc61d0c419c6bb
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Initial 2026 Steam Controller support

This brings support for the 2026 Steam Controller, comparably featureful to
the existing support for the Steam Deck.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 6199f67f3c4cd..111e57926d049 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c

[ ... ]

> @@ -378,21 +459,38 @@ static int steam_recv_report(struct steam_device *s=
team,
>  		return -ENOMEM;
> =20
>  	/*
> -	 * The report ID is always 0, so strip the first byte from the output.
> +	 * The report ID is consistent, so strip the first byte from the output.
>  	 * hid_report_len() is not counting the report ID, so +1 to the length
>  	 * or else we get a EOVERFLOW. We are safe from a buffer overflow
>  	 * because hid_alloc_report_buf() allocates +7 bytes.
>  	 */
> -	ret =3D hid_hw_raw_request(steam->hdev, 0x00,
> -			buf, hid_report_len(r) + 1,
> -			HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> +	if (!(steam->quirks & STEAM_QUIRK_IBEX))
> +		len +=3D 1;
> +
> +	/*
> +	 * Sometimes the wireless controller fails with EPIPE
> +	 * when sending a feature report.
> +	 * Doing a HID_REQ_GET_REPORT and waiting for a while
> +	 * seems to fix that.
> +	 */
> +	do {
> +		ret =3D hid_hw_raw_request(steam->hdev, report_id,
> +				buf, len,
> +				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> +		if (ret !=3D -EPIPE)
> +			break;
> +		msleep(20);
> +	} while (--retries);
>  	if (ret > 0) {
>  		/* Remove the report ID from the return buffer */
>  		ret--;
>  		size =3D min(size, ret);
>  		memcpy(data, buf + 1, size);
>  	}
> +
>  	kfree(buf);
> +	if (ret < 0)
> +		hid_err(steam->hdev, "%s: error %d\n", __func__, ret);
> =20
>  	if (ret < 0)
>  		hid_err(steam->hdev, "%s: error %d\n", __func__, ret);

[Severity: Low]
Is this error logging block accidentally duplicated? There are two identical
checks and hid_err() calls sequentially in steam_recv_report_id(), which wi=
ll
cause the exact same error message to be printed twice upon a single
hid_hw_raw_request() failure.

[ ... ]

> @@ -854,19 +1051,35 @@ static int steam_battery_register(struct steam_dev=
ice *steam)
>  	int ret;
> =20
>  	steam->battery_desc.type =3D POWER_SUPPLY_TYPE_BATTERY;
> -	steam->battery_desc.properties =3D steam_battery_props;
> -	steam->battery_desc.num_properties =3D ARRAY_SIZE(steam_battery_props);
> +	if (steam->quirks & STEAM_QUIRK_IBEX) {
> +		steam->battery_desc.properties =3D steam_ibex_battery_props;
> +		steam->battery_desc.num_properties =3D ARRAY_SIZE(steam_ibex_battery_p=
rops);
> +		/*
> +		 * Ibex needs a shorter name as it has a temperature and the
> +		 * thermal zone name length limit is 20 characters. It's more
> +		 * ambiguous sounding, so let's only use it when needed.
> +		 */
> +		steam->battery_desc.name =3D devm_kasprintf(&steam->hdev->dev,
> +				GFP_KERNEL, "steam-%s",
> +				steam->serial_no);

[Severity: High]
Will this name exceed the 20-character maximum permitted for a thermal zone
device type if the serial number is long?

Because STEAM_SERIAL_LEN is 21, a serial number of 14 characters or
longer combined with the "steam-" prefix will exceed 20 characters. This
causes thermal_zone_device_register_with_trips() to return -EINVAL,
resulting in power_supply_register() and steam_battery_register() failing
entirely.

> +	} else {
> +		steam->battery_desc.properties =3D steam_battery_props;
> +		steam->battery_desc.num_properties =3D ARRAY_SIZE(steam_battery_props);
> +		steam->battery_desc.name =3D devm_kasprintf(&steam->hdev->dev,
> +				GFP_KERNEL, "steam-controller-%s-battery",
> +				steam->serial_no);
> +	}
>  	steam->battery_desc.get_property =3D steam_battery_get_property;
> -	steam->battery_desc.name =3D devm_kasprintf(&steam->hdev->dev,
> -			GFP_KERNEL, "steam-controller-%s-battery",
> -			steam->serial_no);
>  	if (!steam->battery_desc.name)
>  		return -ENOMEM;
> =20
>  	/* avoid the warning of 0% battery while waiting for the first info */
>  	spin_lock_irqsave(&steam->lock, flags);
> -	steam->voltage =3D 3000;
> +	steam->battery_voltage =3D 3000;
>  	steam->battery_charge =3D 100;
> +	steam->battery_current =3D 0;
> +	steam->battery_temp =3D 200;

[Severity: Medium]
Does this initialize the default temperature to 0.2 degrees Celsius?

In steam_battery_get_property(), this value is divided by 100:
val->intval =3D temp / 100;

Since the power supply subsystem expects POWER_SUPPLY_PROP_TEMP in tenths
of a degree Celsius, returning 2 represents 0.2 C. If the intended default
temperature was 20.0 C, should this be initialized to 20000?

> +	steam->battery_status =3D POWER_SUPPLY_STATUS_UNKNOWN;
>  	spin_unlock_irqrestore(&steam->lock, flags);
> =20
>  	battery =3D power_supply_register(&steam->hdev->dev,

[ ... ]

> @@ -1149,51 +1380,42 @@ static int steam_register(struct steam_device *st=
eam)
> -	spin_lock_irqsave(&steam->lock, flags);
> -	client_opened =3D steam->client_opened;
> -	spin_unlock_irqrestore(&steam->lock, flags);
> +	/* ignore battery errors, we can live without it */
> +	if (steam->quirks & (STEAM_QUIRK_WIRELESS | STEAM_QUIRK_IBEX))
> +		steam_battery_register(steam);
> =20
> -	if (!client_opened) {
> -		steam_set_lizard_mode(steam, lizard_mode);
> -		ret =3D steam_input_register(steam);
> -		if (ret !=3D 0)
> -			goto steam_register_input_fail;
> -		ret =3D steam_sensors_register(steam);
> -		if (ret !=3D 0)
> -			goto steam_register_sensors_fail;
> -	}
> +	steam_set_lizard_mode(steam, lizard_mode);
> +	ret =3D steam_input_register(steam);
> +	if (ret !=3D 0)
> +		goto steam_register_input_fail;
> +	ret =3D steam_sensors_register(steam);
> +	if (ret !=3D 0)
> +		goto steam_register_sensors_fail;

[Severity: High]
This is a pre-existing issue, but does this error path leave the battery
registered if steam_input_register() or steam_sensors_register() fails?

If steam_register() fails, steam_probe() jumps to the err_hw_close label,
which bypasses steam_unregister(). Because steam_probe() returns an error,
devres will free the steam_device structure.

Since the battery was not unregistered, it remains active in sysfs, and any
subsequent userspace read of the battery's properties will dereference the
freed steam_device pointer, causing a kernel use-after-free.

[ ... ]

> @@ -1989,8 +2462,84 @@ static int steam_raw_event(struct hid_device *hdev,
>  		return 0;
> =20
>  	if (steam->client_opened)
> -		hid_input_report(steam->client_hdev, HID_FEATURE_REPORT,
> -				data, size, 0);
> +		hid_input_report(steam->client_hdev, report->type, data, size, 0);
> +
> +	/* Ibex uses a different report format */
> +	if (steam->quirks & STEAM_QUIRK_IBEX) {
> +		if (report->type !=3D HID_INPUT_REPORT)
> +			return 0;
> +
> +		switch (report->id) {
> +		case REPORT_ID_INPUT:
> +			if (size !=3D 54)

[ ... ]

> +		case REPORT_ID_WIRELESS_EVENT:
> +			if (size !=3D 2)
> +				return 0;
> +			switch (data[1]) {
> +			case WIRELESS_EVENT_DISCONNECT:
> +				steam_do_connect_event(steam, false);
> +				break;
> +			case WIRELESS_EVENT_CONNECT:
> +				steam_do_connect_event(steam, true);
> +				break;
> +			}
> +			break;

[Severity: High]
This is a pre-existing issue, but can this lead to a use-after-free during
driver unbind?

When the driver is unbound, steam_remove() cancels the steam->work_connect
work item and calls steam_unregister(), but hid_hw_stop() is not called
until the very end.

In this window, the device can still stream data and trigger
steam_raw_event(), which can call steam_do_connect_event(). This
reschedules steam->work_connect back onto the workqueue. Once
steam_remove() returns, devres frees the steam_device structure, causing
the scheduled work item to execute steam_work_connect_cb() on freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805015116.3884=
465-1-vi@endrift.com?part=3D1
