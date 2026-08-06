Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E79619E97B
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785984573; cv=none; b=awamoQdIh1i7wboRTaXJK2eWeWdHTeaM6uxZLyTqS/iUv8t0ABcYTGPOv2wFrWUPa+KM0dlydp3UfZpMslYgnwCR/WBvLXldWuBhsoVw55P+a9wIHNP0enxe+9NyuszUQ9OcKMzSWS4X+AZuzYTGGO6bSjPC6NBs11bi8oTCQhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785984573; c=relaxed/simple;
	bh=MdV4ihZYAHL/hJtQBtsHkJxLAgI0G+adcK90MioLOhA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LFql2ze57NutliZvAehSX2LhfewysNp+wQzH1901gbyarCiAN74gPctcDqNqV2HxMfgp64hl2TM4d2JYD3AAmxuaFitKdx7jxOOgEZfMqKulUVu6Q22/iE9bnT62BaLIM98eTsgEtSe9J4mcV0f/wi8lo++2WNLCPZObTV/iASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMlqNNh7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMlqNNh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D77F1F000E9;
	Thu,  6 Aug 2026 02:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785984571;
	bh=d+X5BoGBy6+PxNnfBijshtiP3HSETx5P/JtRPeNWAqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oMlqNNh7cazwyipMCe3qg7I5IPBkWGwLQpllk0JK2Fq7cNarGC8oyLivX3acAaqh2
	 ASmi6LmO7JVvsNYRu5uj6j2IUMElZTikThHfmnkvSIKEe0Jl4VwerlQc7wY01txydG
	 3aaefUL7WPBgjUOaBaL0q3HhibktHn4KCtUXIytK1S43qgWGNXm2gYsoFonQgSyUzO
	 PZF3oynaPtnf7ozxiHfqk0KZ5tWsBFseW/yb+xex8dA6KWnj/I+7Er10MWQWN8fb0V
	 DpiRYJ0vSF7G1avP009sYGW8KsoldYdlsEpuVD/+Hl+ToFgpvR2xyj+2Uhjjz6ECjZ
	 DuyIatdNDq7Rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] HID: steam: Initial 2026 Steam Controller
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260806022653.93939-3-vi@endrift.com>
References: <20260806022653.93939-1-vi@endrift.com>
 <20260806022653.93939-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 02:49:30 +0000
Message-Id: <20260806024931.8D77F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The removal of the explicit query workaround in `steam_write_set=
tings` can cause driver initialization to fail on subsequent driver binds o=
r module reloads due to lingering reports.

Pre-existing issues:
- [High] Use-After-Free due to HID events triggering work re-queuing during=
 teardown because `hid_hw_stop` is called after `cancel_work_sync`.
- [High] Concurrent execution of `steam_register` leads to resource leaks a=
nd Use-After-Free/Double-Free on error paths due to missing locking.
- [High] Race condition in teardown functions (`steam_battery_unregister`, =
`steam_input_unregister`, etc.) leads to double-free of device components.
--

--- Patch [2]: [PATCH v2 2/6] HID: steam: Initial 2026 Steam Controller sup=
port ---
commit 4e3ca92dc2f8afcf2d70cdcfce3822923a4ccbfc
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Initial 2026 Steam Controller support

This brings support for the 2026 Steam Controller, comparably featureful to
the existing support for the Steam Deck.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 967f12c7a599a..6476fbdc58886 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c

[ ... ]

> @@ -489,16 +615,7 @@ static int steam_write_settings(struct steam_device =
*steam,
>  	}
>  	va_end(args);
> =20
> -	ret =3D steam_send_report(steam, cmd, 2 + cmd[1]);
> -	if (ret < 0)
> -		return ret;
> -
> -	/*
> -	 * Sometimes a lingering report for this command can
> -	 * get read back instead of the last set report if
> -	 * this isn't explicitly queried
> -	 */
> -	return steam_recv_report(steam, cmd, 2 + cmd[1]);
> +	return steam_send_report(steam, cmd, 2 + cmd[1]);

[Severity: Medium]
By removing the explicit steam_recv_report() call here, could a lingering
report be left in the device buffer?

If the module is later reloaded or the driver rebound, steam_probe() will
call steam_get_conn_status() which expects a wireless state report.

>  }

[ ... ]

> -/*
> - * This command requests the wireless adaptor to post an event
> - * with the connection status. Useful if this driver is loaded when
> - * the controller is already connected.
> - */
> -static inline int steam_request_conn_status(struct steam_device *steam)
> +static int steam_get_conn_status(struct steam_device *steam)
>  {
> +	int ret =3D 0;
> +	u8 cmd[] =3D {ID_DONGLE_GET_WIRELESS_STATE};
> +	u8 reply[3] =3D {};
> +	u8 report_id;
> +
> +	if (steam->quirks & STEAM_QUIRK_IBEX)
> +		report_id =3D REPORT_ID_FEATURES_DONGLE;
> +	else
> +		report_id =3D 0;
> +
>  	guard(mutex)(&steam->report_mutex);
> -	return steam_send_report_byte(steam, ID_DONGLE_GET_WIRELESS_STATE);
> +	ret =3D steam_send_report_id(steam, cmd, sizeof(cmd), report_id);
> +	if (ret < 0)
> +		return ret;
> +	ret =3D steam_recv_report_id(steam, reply, sizeof(reply), report_id);
> +	if (ret < 0)
> +		return ret;
> +	if (reply[0] !=3D ID_DONGLE_GET_WIRELESS_STATE || reply[1] < 1) {
> +		hid_err(steam->hdev, "%s: invalid reply (%*ph)\n", __func__,
> +				(int)sizeof(reply), reply);
> +		return -EIO;
> +	}
> +
> +	return reply[2];
>  }

[Severity: Medium]
Does this function read the lingering ID_SET_SETTINGS_VALUES report instead=
 of
the expected status?

Because this lacks a retry mechanism, it appears this would fail the
reply[0] !=3D ID_DONGLE_GET_WIRELESS_STATE check and return -EIO, breaking
device initialization.

[ ... ]

> @@ -1149,51 +1377,42 @@ static int steam_register(struct steam_device *st=
eam)
>  	 * another client send a get_connection_status command, for example.
>  	 * The battery and serial number are set just once per device.
>  	 */
> -	if (!steam->serial_no[0]) {
> -		/*
> -		 * Unlikely, but getting the serial could fail, and it is not so
> -		 * important, so make up a serial number and go on.
> -		 */
> -		if (steam_get_serial(steam) < 0)
> -			strscpy(steam->serial_no, "XXXXXXXXXX",
> -					sizeof(steam->serial_no));
> -
> -		ret =3D steam_get_attributes(steam);
> -		if (ret < 0)
> -			hid_err(steam->hdev,
> -				"%s:steam_get_attributes failed with error %d\n",
> -				__func__, ret);
> +	if (steam->serial_no[0])
> +		return 0;

[Severity: High]
This is a pre-existing issue, but does this check allow concurrent executio=
n?

If a wireless connect event triggers steam_work_connect_cb() simultaneously
with steam_probe() invoking steam_get_conn_status(), could both threads
evaluate steam->serial_no[0] as empty because there is no locking here?

If so, both could proceed to allocate and register input devices and
batteries.

Could this potentially overwrite the pointers and leak the first set, or
cause a use-after-free when one thread fails and runs the error cleanup
path on resources the other thread just allocated?

[ ... ]

> -	if (do_add) {
> -		mutex_lock(&steam_devices_lock);
> -		if (list_empty(&steam->list))
> -			list_add(&steam->list, &steam_devices);
> -		mutex_unlock(&steam_devices_lock);
> -	}
> +	mutex_lock(&steam_devices_lock);
> +	if (list_empty(&steam->list))
> +		list_add(&steam->list, &steam_devices);
> +	mutex_unlock(&steam_devices_lock);
>  	return 0;
> =20
>  steam_register_sensors_fail:

[Severity: High]
This is a pre-existing issue, but does the teardown sequence in
steam_battery_unregister() and steam_input_unregister() have a race conditi=
on?

If these unregister functions are called concurrently (for example, if
steam_register() fails on one thread while steam_work_connect_cb()
processes a disconnect event on another), both threads could read the
same component pointer within the RCU read-side critical section before
either thread executes RCU_INIT_POINTER(..., NULL).

Would this cause both threads to call power_supply_unregister() and
devm_kfree() on the exact same pointer, leading to a double-free?

[ ... ]

[Severity: High]
This is a pre-existing issue, but can the sequence in steam_remove() lead to
a use-after-free?

drivers/hid/hid-steam.c:steam_remove() {
    ...
    cancel_work_sync(&steam->work_connect);
    ...
    hid_hw_stop(hdev);
}

Because hid_hw_stop() is called after cancel_work_sync(), the HID transport=
 can
still deliver events during this window.

If an event like REPORT_ID_WIRELESS_EVENT arrives, steam_raw_event() will c=
all
steam_do_connect_event(), which calls schedule_work(&steam->work_connect),
re-queuing the work after it was cancelled.

Once steam_remove() returns and devres frees the steam_device structure,
will the workqueue run steam_work_connect_cb() on the freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806022653.9393=
9-1-vi@endrift.com?part=3D2
