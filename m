Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21F6368D67
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 01:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786498718; cv=none; b=sISzgKpGBZ9uldfToe+gHPcRIdS0Iwp1HXSz4kuhlciNXpnSnZepYtmKAk2jXcelZP7SUhIZjP/oISW1NZP87cpYL3ZjzSc9cX5yXV2UYMUkSrrsDN87uxnmpppWUa8nqwrcRjppAxkhFB5EqoEPrcNsqUXADBeMXOwu+eYgOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786498718; c=relaxed/simple;
	bh=BgCNBkm8CL4kPrSD/tqTvMBukEGbWKyf47N9RhXS3SM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=toaI9QCWmgR9B79G1zQ8tmMd38glFgJVfC47kIcHfCfIMVwYhKXfkqSrdm3h04Vzpv8XqKDhg5UbDtB1Pwm0AOH4+7DHERNE5he0CQu8AHeGZPgrAZc4+awtEDENtK2PkcDXjyV/LBUhao75grKkXRySt5rCRhlOGyPk22wC9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYDm5dUD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYDm5dUD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386A61F000E9;
	Wed, 12 Aug 2026 01:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786498717;
	bh=iUEbFByFGwaCO6GIT2rXZy1fGiRyReQ7IPcYmpKFpxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KYDm5dUDpKj0b/TYxkneklZPcDJ96QeV5zsExSUGJy9CHyFfIg48jCxb+M1StrGO4
	 LkS4TwbDbYxIbxRoGbpaelcOiTCdQ64+qpSkvvlLz9t8W4V5snJ/upbdSWexqFJ7VF
	 saVpf5jxzkBHp1pK2pEXlJrcBTd4HZZbxZDS/H//Oh7NkPvYLJExo5VJEbqomPauXp
	 7cScWl41S53yiboFLlv9cKuo27vM1wZ/Fvi453UbHX+XIpxXCDTKS0VbOU0fNO1+JT
	 VvH40FStVe5dAaiSNGhr1YZcOl0xFA/tXPUPQBoh8i8tPsUu0ghl6OuRbtCji21ia+
	 44KVJa9DtYAzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/6] HID: steam: Clean up locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260812011401.3250968-6-vi@endrift.com>
References: <20260812011401.3250968-1-vi@endrift.com>
 <20260812011401.3250968-6-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 01:38:36 +0000
Message-Id: <20260812013837.386A61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Missing `report_mutex` protection in `steam_probe` causes HID repo=
rt interleaving and initialization failures.

Pre-existing issues:
- [High] Time-of-check to time-of-use (TOCTOU) race in `steam_unregister` l=
eads to resource leakage and Use-After-Free.
- [High] Use-After-Free or NULL pointer dereference in `steam_remove` due t=
o incorrect teardown order.
- [High] Information leak of uninitialized kernel heap memory to the USB de=
vice.
--

--- Patch [5]: [PATCH v5 5/6] HID: steam: Clean up locking ---
commit 0b18780ca8de0e3b0d434638ab8287e9b2859654
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Clean up locking

This cleans up several issues with locking behavior, including RCU accesses
not being guarded behind a lock.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 7226c0681ed18..7bb892972447f 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -620,7 +621,6 @@ static int steam_exchange_report_id(struct steam_devi=
ce *steam, u8 *cmd, int csi
>  	unsigned int retries =3D 5;
>  	int ret;
> =20
> -	guard(mutex)(&steam->report_mutex);
>  	do {
>  		ret =3D steam_send_report_id(steam, cmd, csize, report_id);
>  		if (ret < 0)

[Severity: High]
Since the guard was removed here, should callers now hold report_mutex?

This regression appears in steam_probe(), where steam_get_conn_status()
calls this without the mutex being held:

drivers/hid/hid-steam.c:steam_probe() {
    ...
    if (steam->quirks & STEAM_QUIRK_WIRELESS) {
        ...
        steam->connected =3D false;
        ret =3D steam_get_conn_status(steam);
    ...
}

Could this allow concurrent wireless events to interleave HID requests and
cause initialization failures?

[ ... ]

> @@ -1440,10 +1444,12 @@ static void steam_unregister(struct steam_device =
*steam)
>  	hid_info(steam->hdev, "Steam %s '%s' disconnected",
>  			steam->quirks & STEAM_QUIRK_DECK ? "Deck" : "Controller",
>  			steam->serial_no);
> +	mutex_lock(&steam->registration_mutex);
>  	steam->registered =3D false;
>  	steam_battery_unregister(steam);
>  	steam_sensors_unregister(steam);
>  	steam_input_unregister(steam);
> +	mutex_unlock(&steam->registration_mutex);
>  	cancel_work_sync(&steam->rumble_work);
>  	cancel_delayed_work_sync(&steam->mode_switch);
>  	cancel_delayed_work_sync(&steam->coalesce_rumble_work);

[Severity: High]
This is a pre-existing issue, but does checking the registered flag outside
this new mutex allow a time-of-check to time-of-use race?

If steam_unregister() is called concurrently from the workqueue, it might
check if (!steam->registered) and return early before the registration
finishes.

Later in steam_remove(), it completely bypasses unregistration if connected
is false, leaving registered input nodes pointing to freed memory:

drivers/hid/hid-steam.c:steam_remove() {
    ...
    if (steam->connected)
        steam_unregister(steam);
    ...
}

[Severity: High]
This is a pre-existing issue, but is there a use-after-free window in
steam_remove() during device teardown?

The client HID device is destroyed before the hardware is stopped:

drivers/hid/hid-steam.c:steam_remove() {
    ...
    hid_destroy_device(steam->client_hdev);
    ...
    hid_hw_stop(hdev);
    ...
}

If the hardware generates an interrupt in this window, could
steam_raw_event() attempt to access the freed client_hdev?

[Severity: High]
This is a pre-existing issue, but does steam_send_report_id() leak
uninitialized kernel heap memory to the USB device?

When allocating the report buffer, it uses hid_alloc_report_buf() which
relies on kmalloc(), not kzalloc():

drivers/hid/hid-steam.c:steam_send_report_id() {
    ...
    buf =3D hid_alloc_report_buf(r, GFP_KERNEL);
    if (!buf)
        return -ENOMEM;

    buf[0] =3D report_id;
    memcpy(buf + 1, cmd, size);
    ...
    ret =3D hid_hw_raw_request(steam->hdev, report_id,
            buf, max(size + 1, len),
            HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
    ...
}

Since only size bytes are copied into buf, will the remaining bytes up to
max(size + 1, len) contain uninitialized memory when sent over the bus?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812011401.3250=
968-1-vi@endrift.com?part=3D5
