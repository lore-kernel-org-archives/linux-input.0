Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781C64EE859
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535290; cv=none; b=CJL69dWY6bzf9VWuqPL3REK5a5K21Rj3YSjeamw0IG9X57oAlzqCSWOTN6sL0hE2js9RjVmVRiljMPNR3KPKtjctdbGJGCkerpSyPyVAPZxfTt916B4GiSuBNq/6/ZDInxbzHTBUEtyXOeZMjOpavKSSQQebt4yrgWjwesw5DR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535290; c=relaxed/simple;
	bh=02hHFY1HyHlZDNDGmL5audzm7rNjqBwuIRKVW6/yjKs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Shl6zKtn5Uv+R9rZho8cJ1D0NOOIrQy8rPT94oZ41laV436kR9E0KLv9j+kyKNiPNcNoNn414frs8YeAwe9Phfi10F5Zx5oh8dl+jQUNgJxNmci89t3e1s+sna9OsUdANAovIkuojQlS1PSG1BergnNWYkmvtG6xUm4F0K5cEOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGtbDKAt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGtbDKAt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23ADB1F00A3D;
	Fri,  4 Sep 2026 15:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788535289;
	bh=xVeSFsigQTrVCjJscSWGuHJvNosxclHzlsCmWN/S9og=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TGtbDKAtLfZbHAqgjD2j5iqWQncUHFX1A0veusmPcXvaOGYq9CaNUQeZSrrCfVnhz
	 Rp0DQvdfg9cJhAnWjVKHwYkLDY/Z96GW5Sz5Mf2vF55P3024hN8HdGmM5nFJQR5ZJa
	 Dm87MF93LwvCtM5L/E8gx7DW7PGfAlfVGXU4b/3RFkk7IT+H6AUM9xor+g+d6ICAjh
	 XkG0ZEONDHYW20Zw41u7sjefqPmdOvGT3CgYm39SA+vx8+GdIF+vIvC2AGXuvi7voV
	 VCDGbRsJ3j3+xRR5GrbSwRXxHJ/2qYGiGVzTAxxfTAsM69iyTKkrXJlRl7v0xSwhEf
	 FwIp2PQoHm8Eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/13] HID: asus: add gamepad configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260904145845.184887-5-denis.benato@linux.dev>
References: <20260904145845.184887-1-denis.benato@linux.dev>
 <20260904145845.184887-5-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:21:28 +0000
Message-Id: <20260904152129.23ADB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] State initialization and restoration logic errors corrupt user set=
tings on re-probe.
- [Medium] Sysfs attributes are exposed to userspace before the device data=
 is fully linked, causing spurious -ENODEV errors.
--

commit 396e8f687c336ca0b0f9ddcf54fbc96925c6f82f
Author: Denis Benato <denis.benato@linux.dev>

    HID: asus: add gamepad configuration
   =20
    Add the base configuration structures for the gamepad configuration,
    detect capabilities and initialize the device in a known state.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 129cec7e27ec4..4714ebb4a5435 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -610,6 +662,272 @@ static u8 *ally_alloc_cmd(u8 cmd, const u8 *payload=
, u8 payload_size)
[ ... ]
> +	for (sysfs_i =3D 0; sysfs_i < ARRAY_SIZE(ally_attr_groups); sysfs_i++) {
> +		ret =3D sysfs_create_group(&hdev->dev.kobj,
> +					 &ally_attr_groups[sysfs_i]);
> +		if (ret < 0) {
> +			hid_err(hdev, "Failed to create sysfs group '%s': %d\n",
> +				ally_attr_groups[sysfs_i].name ?: "", ret);
> +			goto ally_config_create_sysfs_err;
> +		}
> +	}

[Severity: Medium]
Will this expose sysfs attributes to userspace before the device data is fu=
lly
linked?

Since ally_drvdata.config is not assigned until later in hid_asus_ally_prob=
e(),
if a userspace tool like udev reads an attribute in this window,
ally_get_config() will return NULL, causing a spurious -ENODEV error.

> +
> +	/* So far the only hardware this is supported is the Ally 1 */
> +	if (cfg->xbox_controller_support) {
> +		ret =3D ally_set_xbox_controller(hdev, ally, cfg, true);
> +		if (ret < 0)
> +			hid_warn(hdev, "Failed to set default Xbox controller mode: %d\n",
> +				ret);
> +	}
> +
> +	cfg->initialized =3D true;

[Severity: High]
Does this code unconditionally overwrite the user's previously saved prefer=
ence
back to true on every probe?

Because this block is outside the `if (!cfg->initialized)` check above, it
seems it will force the hardware and software state to true whenever the de=
vice
suspends/resumes or re-enumerates, destroying any saved settings.

[ ... ]
> @@ -882,6 +1201,20 @@ static int hid_asus_ally_init(struct hid_device *hd=
ev, struct ally_handheld *all
>  	if (ret < 0)
>  		hid_err(hdev, "Ally failed to init force-feedback off: %d\n", ret);
> =20
> +	cfg =3D ally_get_config(ally);
> +	if (!cfg)
> +		return 0;

[Severity: High]
Will this silently fail to restore cached user settings to the hardware dur=
ing
probe?

Because hid_asus_ally_init() is called before ally_drvdata.config is publis=
hed
in hid_asus_ally_probe(), ally_get_config() will return NULL here, causing =
it
to bail out early.

> +
> +	/* The MCU may have just been reset: restore the cached state. */
> +	guard(mutex)(&cfg->config_mutex);
> +
> +	if (cfg->xbox_controller_enabled) {
> +		ret =3D ally_set_xbox_controller(hdev, ally, cfg, true);
> +		if (ret < 0)
> +			hid_warn(hdev, "Failed to restore Xbox controller mode: %d\n",
> +				 ret);
> +	}
> +
>  	return 0;
>  }

[Severity: High]
If the hardware reset to true but the user had disabled the Xbox controller
(cfg->xbox_controller_enabled =3D=3D false), does this incorrectly fail to =
restore
the state to false?

It looks like this code only restores the state if it was true, and hardcod=
es
the value passed to ally_set_xbox_controller() to true instead of passing
cfg->xbox_controller_enabled.

[ ... ]
> @@ -1023,6 +1360,14 @@ static struct ally_handheld *hid_asus_ally_probe(s=
truct hid_device *hdev)
>  			return ERR_PTR(ret);
>  		}
> =20
> +		ally_cfg =3D ally_config_create(hdev, &ally_drvdata);
> +		if (IS_ERR(ally_cfg)) {
> +			hid_err(hdev, "Failed to create Ally cfg: %ld\n",
> +				PTR_ERR(ally_cfg));
> +			ally_put_udev_if_orphaned();
> +			return ERR_PTR(PTR_ERR(ally_cfg));
> +		}
> +
>  		ret =3D hid_asus_ally_init(hdev, &ally_drvdata);
>  		if (ret < 0) {
>  			ally_put_udev_if_orphaned();
> @@ -1030,6 +1375,7 @@ static struct ally_handheld *hid_asus_ally_probe(st=
ruct hid_device *hdev)
>  		}
> =20
>  		spin_lock_irqsave(&ally_data_lock, flags);
> +		ally_drvdata.config =3D ally_cfg;

[Severity: High]
This publishes the configuration pointer to the shared state after
hid_asus_ally_init() has already run, which hides it from the initialization
function above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904145845.1848=
87-1-denis.benato@linux.dev?part=3D4
