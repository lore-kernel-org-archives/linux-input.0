Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608218;
	b=PenP2mBOg4pLth/xdAQQVfCUgpzMgCIX1b45IYFjklY0BGKTmeL32HFX8fys5VpFo4pO
	 URQK992N9EzCDEeUsEEnlw5/r3xpRXt2d9+kOFIaxZgdFvlGWj6VrYPc1lkxyM6d+zxc5
	 YLL7K3BJOGiaT2WnQXflI1hLmpK02lhrtkQrCv2MIhwBfY4vhphW5jsmEsQ+7EYB8wJTJ
	 x++ckFz7Atonz9kncgZnW/RIbwI5we7OZkvxpoxcXm9ikS+Ae6q3B6s85UA9ykliSoDGa
	 GPK3IDGNjqtGZgjpzADeYZZw2ig93HG2woUhZUEFdB/9ye0P4GD85xSQzITp4NZfkBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608218;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g10VoaCYMKyb5FsiUJlrZ9rdtpE5BRKWKUxHVHR5qco=;
	b=0YiL8aL/KZlUMBlb72pctJmY3Y3wj52vqTAVdvMlI9J3jFc6FUVftLFEi71ycuj2N0mI
	 HlY8/q5/2bSHUc/eOB/WMhbCieHHCMzZ+KKItNobwAQ+3FWPvO0JnuqABnnzlR2E/doHI
	 uVSUPBFTGfuaOB6SvBSdOYjgOunebqWFc68qZPaOqY3lmJQWLqh/r+WF+GjI4kgiSu06C
	 BWes/VA6fWrAORi36L00Heo1z8dIqMhteiJLfeKjF7cqkdCrX1DpjEXQK0G0qTpUnKkG0
	 FGYlC4yEvzWBTuxBPRxF3RFaStuSmyJnguhoEQv1k4Rf1ZloEMHLgW5n6wgmsazE2Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SFf9/E9C";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9D606A319
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFf9/E9C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178231F000C2;
	Wed, 21 Oct 2026 18:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792608218;
	bh=g10VoaCYMKyb5FsiUJlrZ9rdtpE5BRKWKUxHVHR5qco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SFf9/E9Cf+J9dezU7Wn7DBuJ4yh5J+eNKEU2niwdiKqsP6YTVFi60UTrZmZ2m2u1y
	 i0v3TKZuLmeafIYG3Ncw2Ss2huLhJfxRxVAl3/j9m8rDiB4vwhkx0GgJiQcEjf7wiS
	 fZh0arnl1VawDcWcvnovTOnnTWCL9hsm6DMQAn+RaTzVS3RdESaiS8DeRNVN5EbDNG
	 /1na4HkffOg/OttFUC4H5k2B7J92bJIHb14fUSJF7m7yUAUdLGvdqjafOW485Gf6F4
	 ApEHq0DTb1eSz70jpqTA2qUJxm79CGdzLfQHqAP0RYCBF9SL9U5rNSzSNOhU4aAryc
	 OWNRPVobbiTNQ==
Message-ID: <sashiko-outbox-180559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] HID: hp: Add support for HyperX headset devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sofia Schneider" <sofia@schn.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261021183205.13866-1-sofia@schn.dev>
References: <20261021183205.13866-1-sofia@schn.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 18:43:37 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] HID: hp: wireless_status not initialized when headset is off in =
hp_probe()
- [Medium] HID: hp: battery state not polled on connect in hp_raw_event()
--

commit eff0223529a8e019e0454a1c8760eff7536e4ec0
Author: Sofia Schneider <sofia@schn.dev>

HID: hp: Add support for HyperX headset devices

This commit introduces the hid-hp driver for HyperX Cloud III Wireless
headsets, polling the device to report battery capacity, charging state,
and USB wireless connection status.

> diff --git a/drivers/hid/hid-hp.c b/drivers/hid/hid-hp.c
> new file mode 100644
> index 0000000000000..32164b3c8e04a
> --- /dev/null
> +++ b/drivers/hid/hid-hp.c
> @@ -0,0 +1,398 @@

[ ... ]

> +static void hp_headset_battery_work(struct work_struct *work)
> +{
> +	struct hp_headset_device *drvdata =3D
> +		container_of(work, struct hp_headset_device, battery_work);
> +	struct power_supply_config battery_cfg =3D { .drv_data =3D drvdata };
> +	struct power_supply *ps;
> +	unsigned long flags;
> +	bool connected;
> +
> +	spin_lock_irqsave(&drvdata->lock, flags);
> +	connected =3D drvdata->is_connected;
> +	ps =3D drvdata->battery;
> +	spin_unlock_irqrestore(&drvdata->lock, flags);
> +
> +	hp_headset_set_wireless_status(drvdata->hdev, connected);
> +
> +	if (connected && !ps) {
> +		ps =3D power_supply_register(&drvdata->hdev->dev,
> +					   &drvdata->battery_desc,
> +					   &battery_cfg);
> +		if (IS_ERR(ps)) {
> +			hid_err(drvdata->hdev, "power_supply_register failed\n");
> +			return;
> +		}
> +
> +		power_supply_powers(ps, &drvdata->hdev->dev);
> +
> +		spin_lock_irqsave(&drvdata->lock, flags);
> +		drvdata->battery =3D ps;
> +		spin_unlock_irqrestore(&drvdata->lock, flags);
> +	} else if (!connected && ps) {
> +		spin_lock_irqsave(&drvdata->lock, flags);
> +		drvdata->battery =3D NULL;
> +		spin_unlock_irqrestore(&drvdata->lock, flags);
> +
> +		power_supply_unregister(ps);
> +	}
> +}

[ ... ]

> +static void
> +hp_headset_parse_connected_event(struct hp_headset_device *drvdata, u8 *=
data)
> +{
> +	unsigned long flags;
> +	bool state_changed =3D false;
> +	bool connected =3D (data[2] =3D=3D 1);
> +
> +	spin_lock_irqsave(&drvdata->lock, flags);
> +
> +	if (drvdata->is_connected !=3D connected) {
> +		drvdata->is_connected =3D connected;
> +		state_changed =3D true;
> +	}
> +
> +	spin_unlock_irqrestore(&drvdata->lock, flags);
> +
> +	if (state_changed)
> +		schedule_work(&drvdata->battery_work);
> +}

[Severity: Medium]
When the headset is turned on after hp_probe() has already run, the device
sends a connection report handled by:

  hp_raw_event()
    -> hp_headset_parse_connected_event()
      -> schedule_work(&drvdata->battery_work)

In that path, hp_headset_battery_work() registers drvdata->battery without
sending HYPERX_CMD_GET_BATTERY or HYPERX_CMD_GET_CHARGING and without
rescheduling drvdata->poll_work. Because hp_probe() initializes
drvdata->battery_level to 100 and drvdata->is_charging to false (and
disconnected battery replies with state1 =3D=3D 0 && state2 =3D=3D 0 are ig=
nored in
hp_headset_parse_battery_event()), the newly registered power supply will
report dummy (100% / POWER_SUPPLY_STATUS_FULL) or stale values until the
next 2-minute poll interval expires.

Also, during hp_headset_poll_work(), HYPERX_CMD_GET_CONNECTED is sent
immediately before HYPERX_CMD_GET_BATTERY and HYPERX_CMD_GET_CHARGING. If
those battery and charging replies arrive in hp_raw_event() while
hp_headset_battery_work() is still inside power_supply_register() before
drvdata->battery =3D ps is assigned, hp_headset_parse_battery_event() and
hp_headset_parse_charging_event() see drvdata->battery as NULL and skip
power_supply_changed().

Should connecting the headset trigger an immediate battery and charging
query (for example via mod_delayed_work() on drvdata->poll_work or after
power_supply_register() completes in hp_headset_battery_work())?

> +
> +static int hp_probe(struct hid_device *hdev, const struct hid_device_id =
*id)
> +{
> +	struct hp_headset_device *drvdata;
> +	struct power_supply *ps;
> +	unsigned long flags;
> +	int ret;
> +
> +	drvdata =3D devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +	drvdata->hdev =3D hdev;
> +	drvdata->is_connected =3D false;
> +	drvdata->is_charging =3D false;
> +	drvdata->battery_level =3D 100;
> +	spin_lock_init(&drvdata->lock);
> +	hid_set_drvdata(hdev, drvdata);

[ ... ]

> +	ret =3D hid_hw_open(hdev);
> +	if (ret) {
> +		hid_err(hdev, "hw_open failed\n");
> +		goto err_stop_hw;
> +	}
> +
> +	schedule_delayed_work(&drvdata->poll_work, 0);
> +
> +	return 0;

[Severity: Medium]
What happens to the USB interface wireless_status sysfs attribute if the
USB dongle is probed while the headset is powered off?

In hp_probe(), drvdata->is_connected is initialized to false, and
hp_headset_set_wireless_status() is only called from
hp_headset_battery_work(). When the initial hp_headset_poll_work() queries
HYPERX_CMD_GET_CONNECTED and the receiver reports data[2] =3D=3D 0
(connected =3D=3D false), hp_headset_parse_connected_event() sees:

	if (drvdata->is_connected !=3D connected) {
		drvdata->is_connected =3D connected;
		state_changed =3D true;
	}

Since drvdata->is_connected is already false, state_changed remains false
and drvdata->battery_work is never scheduled. As a result,
usb_set_wireless_status(intf, USB_WIRELESS_STATUS_DISCONNECTED) is never
called, leaving intf->wireless_status at USB_WIRELESS_STATUS_NA and keeping
the wireless_status sysfs attribute hidden until the headset is turned on
and then off.

Would it make sense to call hp_headset_set_wireless_status(hdev, false)
during hp_probe()?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021183205.1386=
6-1-sofia@schn.dev?part=3D1
