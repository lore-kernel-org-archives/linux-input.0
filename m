Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A68338F93B
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783031686; cv=none; b=ZfsnWxWw5Y9Uq5+dvtv0bsqeFZDYqjpsJSyHLYgiaaLnrAWcbU472MtHBxtgpNNYqjACdVzugWgb7nkjmzHgwvMyDgDj+Wsjte5yVphZtRgmZ57s951kyEjR1wRvjXYTMWD854qeWcYA0jqEOdSBFq/TrD1+NezezDX3gimb8+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783031686; c=relaxed/simple;
	bh=BwACV7CH+jyzSUmKOQI10chmf4eZyOxuRrppi8Nc5jE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nFDG95D42FfOsAz4Qh+Ih5zKe4Pj9bRis+DKbJJrQaUbiXimo75OysKMq2UcHQyB6IsUwleEP8rXnKLIx5cjal7r/dElSbYDhwrFfoTyhoD2k6uE6wlCR62W6BwI70TRIzz/mXPP3cUyDmnBM8N/mlLVk2rIu7owqMNMoVqORtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNmCWH2x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNmCWH2x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13781F000E9;
	Thu,  2 Jul 2026 22:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783031680;
	bh=dYyy9WlVRU/m4GqxrB+Mze1/CE9Hb799pmMDg+DINOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HNmCWH2xducmdc8GbV2KddlJALfGWEL+zjefH4mSl2qspiUHY+d2v3lkOpFGL+xjP
	 2Sip5j0IovjMJ+dJjjUCqEhJliALbVbl9Sz1uOcnEKpT9yUqJZ7SWyjznADfTmwJ+x
	 bLc1PMRDtByuj45w2h1QD+CkTrIT8wDSm3uUyLWKIg9hV5Crw1+IGlMlnHtzvc6uUG
	 0XTk3IbGc9H3hHXp6AgRySyeAim0eENAXMFrvew0kycqPtz/IUYVRTQ8RlUoeoJlmm
	 buljyaH6U/TNLVtG0N5BT4giu5zp2+f3p1HFY50dcu9JriSKN1h3Ltr0oQ7PNqHoES
	 v6b/4Q8YiUvNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/10] HID: steam: Fully unregister controller when
 hidraw is opened
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260702222145.1863104-6-vi@endrift.com>
References: <20260702222145.1863104-1-vi@endrift.com>
 <20260702222145.1863104-6-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 22:34:39 +0000
Message-Id: <20260702223439.C13781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Repeatedly opening and closing the hidraw node causes an unbounded=
 kernel memory leak due to devm_kasprintf() allocations.
- [Medium] Unregistering and reregistering the controller on hidraw open/cl=
ose causes connection state messages to spam the kernel log.

Pre-existing issues:
- [High] Error paths in steam_probe fail to clean up the global steam_devic=
es list, leading to a use-after-free.
--

commit e81d4b5bb1894be8818d15e10c2e8f4c979081fe
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Fully unregister controller when hidraw is opened
   =20
To avoid conflicts between anything touching the hidraw and the driver we
had previously detached the evdev nodes when the hidraw is opened. However,
this isn't sufficient to avoid FEATURE reports from conflicting, so we
change to fully unregistering the controller internally, leaving only the
hidraw active until it's closed.

This also unifies the unregister and connect callbacks, as now the logic
between these two callbacks is identical.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 01b64194ec97b..546916da31f92 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c

[ ... ]

> @@ -1144,38 +1143,41 @@ static int steam_register(struct steam_device *st=
eam)
> =20
>  static void steam_unregister(struct steam_device *steam)
>  {
> +	if (!steam->serial_no[0])
> +		return;
> +
> +	hid_info(steam->hdev, "Steam Controller '%s' disconnected",
> +			steam->serial_no);

[Severity: Medium]
Will repeatedly opening the hidraw node spam the kernel log?

Opening the hidraw node triggers this unregister path, printing a
"disconnected" message. When hidraw is closed, steam_register() is called a=
nd
logs a "connected" message.

Can a user-space daemon or application opening and closing the hidraw node
overwrite important system logs?

>  	steam_battery_unregister(steam);
>  	steam_sensors_unregister(steam);
>  	steam_input_unregister(steam);
> -	if (steam->serial_no[0]) {
> -		hid_info(steam->hdev, "Steam Controller '%s' disconnected",
> -				steam->serial_no);
> -		mutex_lock(&steam_devices_lock);
> -		list_del_init(&steam->list);
> -		mutex_unlock(&steam_devices_lock);
> -		steam->serial_no[0] =3D 0;
> -	}
> +	mutex_lock(&steam_devices_lock);
> +	list_del_init(&steam->list);
> +	mutex_unlock(&steam_devices_lock);
> +	steam->serial_no[0] =3D 0;
>  }
> =20
>  static void steam_work_connect_cb(struct work_struct *work)
>  {
>  	struct steam_device *steam =3D container_of(work, struct steam_device,
>  							work_connect);
> +
>  	unsigned long flags;
>  	bool connected;
> +	bool opened;
>  	int ret;
> =20
>  	spin_lock_irqsave(&steam->lock, flags);
> +	opened =3D steam->client_opened;
>  	connected =3D steam->connected;
>  	spin_unlock_irqrestore(&steam->lock, flags);
> =20
> -	if (connected) {
> +	if (connected && !opened) {
>  		ret =3D steam_register(steam);

[Severity: High]
Does this cause a memory leak by repeatedly registering the battery?

When hidraw is opened, steam_unregister() is called, which sets
steam->serial_no[0] =3D 0.

When hidraw is closed, steam_register() sees the cleared serial number and
calls steam_battery_register():

drivers/hid/hid-steam.c:steam_register() {
    ...
	if (!steam->serial_no[0]) {
        ...
		if (steam->quirks & STEAM_QUIRK_WIRELESS)
			steam_battery_register(steam);
    ...
}

drivers/hid/hid-steam.c:steam_battery_register() {
    ...
	steam->battery_desc.name =3D devm_kasprintf(&steam->hdev->dev,
			GFP_KERNEL, "steam-controller-%s-battery",
			steam->serial_no);
    ...
}

Because devm_ allocations are bound to the physical device's lifetime, and =
the
device is never unbound during this process, will repeatedly opening and
closing hidraw cause an unbounded memory leak?

> -		if (ret) {
> +		if (ret)
>  			hid_err(steam->hdev,
>  				"%s:steam_register failed with error %d\n",
>  				__func__, ret);
> -		}
>  	} else {
>  		steam_unregister(steam);
>  	}

[ ... ]

> @@ -1453,7 +1429,6 @@ static int steam_probe(struct hid_device *hdev,
>  	cancel_delayed_work_sync(&steam->mode_switch);
>  	cancel_work_sync(&steam->rumble_work);
>  	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
> -	cancel_work_sync(&steam->unregister_work);
> =20
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but do the error paths in steam_probe() fail
to clean up the global steam_devices list?

If steam_register() fails halfway (e.g., steam_input_register() fails), it
returns an error but does not remove the device from the steam_devices list
which it added it to earlier:

drivers/hid/hid-steam.c:steam_register() {
    ...
	if (!steam->serial_no[0]) {
        ...
		mutex_lock(&steam_devices_lock);
		if (list_empty(&steam->list))
			list_add(&steam->list, &steam_devices);
		mutex_unlock(&steam_devices_lock);
	}
    ...
}

When steam_probe() receives the error, it jumps to err_hw_close, bypassing
err_steam_unregister:

drivers/hid/hid-steam.c:steam_probe() {
    ...
	} else {
		/* A wired connection is always present */
		steam->connected =3D true;
		ret =3D steam_register(steam);
		if (ret) {
			hid_err(hdev,
				"%s:steam_register failed with error %d\n",
				__func__, ret);
			goto err_hw_close;
		}
	}
    ...
}

The steam object is subsequently freed by devres, leaving a dangling pointer
in the steam_devices list.

Can a local user trigger a use-after-free by writing to the lizard_mode
module parameter (which iterates over steam_devices)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702222145.1863=
104-1-vi@endrift.com?part=3D6
