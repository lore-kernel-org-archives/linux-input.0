Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA6D484228
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633373; cv=none; b=JZKbexiR8tI33CYJFLHaZzgKb86ZLdW06hW7p8dAnZeCGeBLzCAJMWV5TmmRVEbUPXDMZM0Io/1lvs7Sg+hywpuqpkySfhP0VZSz7Aj1PsLzUtS/07tBxqxXkMW+vQOKdwlfi0JhzB/m+mv3byYJVqYmsxnOsyWjKedsyba/fu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633373; c=relaxed/simple;
	bh=9j3rmb3/GU4DEluxKKGFxJfR1FwP78INOtiCNwRNFME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JwKk0TnVyd/UafeofIgxLk6m/jyKX9reBEOcxHceFDehuSjbP+VczOS6IxuHNKf27+45mRQQbZ0MwFbK/lFGgoo7ZhknLocuTHxStHN2bfH+Hnn3jbNcniBTmHioWQ56VW2LJp5MD/bBNcH2FVCvDY1r3rCTChCslgeGWy+abh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIBW52Qa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIBW52Qa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D9E1F00A3A;
	Thu, 13 Aug 2026 15:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633371;
	bh=KBX3ZYmceaK2CCpw6xFx/OSNCH/L3d487TkOQ5UE4gg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TIBW52QawWZs+GYTFnJda77YiFvMU9COcgxRV7TmIOcidJlqaK96tAuBJfVodWhYr
	 MZ4W9S2XSmpMhuvlYsTdaL0OU79DaiYYo5dpNTSEyFNSF6ZfHdWs2kpvOs6adFzBxB
	 tFGDVIOxWLACfPnbuus9WiTEK5VZHpnRJMEd3izfRX2WtuxIutNcqRQi++Yy4KclyA
	 IsCs0vY3zG6adPSXDTXMphs4FTf6E8iYvPIMTf2K2VjfYh/E4uZZDr1iZuQc8No5cm
	 jTtbOBMTA+gd5M4nrsphX2vD8cb/6mRKux6mvmnAY9xp4/PUhGsYV0nfxL//mVTUuj
	 8yPtsiRkrlRBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/12] HID: asus: add joysticks anti-deadzone
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260813144736.2477941-8-denis.benato@linux.dev>
References: <20260813144736.2477941-1-denis.benato@linux.dev>
 <20260813144736.2477941-8-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:02:50 +0000
Message-Id: <20260813150250.F0D9E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Concurrent sysfs writes to left and right anti-deadzone attribut=
es can desynchronize the hardware state from the software state due to a Ti=
me-of-Check to Time-of-Use (TOCTOU) race condition.

Pre-existing issues:
- [High] The `config_mutex` inside `struct ally_config` is used without bei=
ng initialized.
- [High] Sysfs attribute callbacks can dereference a NULL `ally->config` po=
inter if a concurrent device removal occurs.
--

--- Patch [7]: [PATCH 07/12] HID: asus: add joysticks anti-deadzone configu=
ration ---
commit d78f09e927da53af9bf7a52457ad40ae819eb0ce
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add joysticks anti-deadzone configuration

ROG Ally devices allow configuring the anti-deadzone parameter for
the resistive joysticks devices as over time those develops drift.
This commit exposes relevant sysfs attributes to allow userspace to
configure the anti-deadzone.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index eb735ec8f065c..8ed10c5b22ab5 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -1155,6 +1155,165 @@ static struct device_attribute dev_attr_right_joy=
stick_outer_threshold =3D
>  static struct device_attribute dev_attr_right_joystick_outer_threshold_r=
ange =3D
>  	__ATTR(outer_threshold_range, 0444, right_joystick_outer_threshold_rang=
e_show, NULL);
> =20
> +/**
> + * ally_set_anti_deadzone - Set anti-deadzone values for joysticks
> + * @hdev: HID device
> + * @left_adz: Left joystick anti-deadzone value (0-100)
> + * @right_adz: Right joystick anti-deadzone value (0-100)
> + *
> + * Return: 0 on success, negative on failure
> + */
> +static int ally_set_anti_deadzone(struct hid_device *hdev, u8 left_adz, =
u8 right_adz)
> +{
> +	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct ally_handheld *const ally =3D drvdata->rog_ally;
> +	const u8 payload[] =3D { left_adz, right_adz };
> +	int ret;
> +
> +	u8 *buf __free(kfree) =3D ally_alloc_cmd(CMD_SET_ANTI_DEADZONE, payload=
, sizeof(payload));
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	if (!ally->config->anti_deadzone_support) {
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but could this dereference a NULL pointer?

If a concurrent device removal occurs, the remove() callback explicitly sets
ally->config =3D NULL. Since the sysfs groups are managed by devres, they a=
re
removed after the remove() callback completes, leaving a race window.

A concurrent sysfs access could pass the initial check in
left_joystick_anti_deadzone_store(), get interrupted while the remove path
nullifies ally->config, and then crash here when ally_set_anti_deadzone()
directly dereferences it.

> +		hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret =3D ally_dev_set_report(hdev, buf, ROG_ALLY_REPORT_SIZE);
> +	if (ret < 0) {
> +		hid_err(hdev, "Failed to set anti-deadzone values: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
[ ... ]
> +static ssize_t left_joystick_anti_deadzone_store(struct device *dev, str=
uct device_attribute *attr,
> +						 const char *buf, size_t count)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct ally_handheld *const ally =3D drvdata->rog_ally;
> +	u8 value;
> +	int ret;
> +
> +	if (!ally || !ally->config)
> +		return -ENODEV;
> +
> +	if (!ally->config->anti_deadzone_support) {
> +		hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret =3D kstrtou8(buf, 10, &value);
> +	if (ret || value > 100)
> +		return -EINVAL;
> +
> +	ret =3D ally_set_anti_deadzone(hdev, value, ally->config->right_anti_de=
adzone);
> +	if (ret)
> +		return ret;
> +
> +	scoped_guard(mutex, &ally->config->config_mutex)
> +		ally->config->left_anti_deadzone =3D value;

[Severity: Medium]
Could this result in a Time-of-Check to Time-of-Use (TOCTOU) race condition?

If two threads concurrently write to the left and right anti-deadzone
attributes, they could locklessly read the opposite joystick's state from
ally->config, send conflicting commands to the hardware, and then sequentia=
lly
acquire config_mutex to update the software cache. Depending on which hardw=
are
request reaches the device last, the hardware might drop one of the updates,
but the software cache would reflect both new values, causing a permanent
desynchronization.

[Severity: High]
This is a pre-existing issue, but I noticed config_mutex inside
struct ally_config is used here without being initialized.

Looking at ally_config_create(), it is allocated with devm_kzalloc():

    cfg =3D devm_kzalloc(&hdev->dev, sizeof(*cfg), GFP_KERNEL);
    if (!cfg)
        return ERR_PTR(-ENOMEM);

Because the memory is zeroed but mutex_init() is never called, the wait
queue list head (wait_list) is not initialized. Could this cause a kernel
crash in the mutex slow path if there is contention or if
CONFIG_DEBUG_MUTEXES is enabled?

> +
> +	return count;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813144736.2477=
941-1-denis.benato@linux.dev?part=3D7
