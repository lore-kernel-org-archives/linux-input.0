Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D904F3E49EC
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 21:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786658275; cv=none; b=tToMKbGwi9V2QSExjgPnqenaREOktMxQw0POViSs13H1DZcVwEZVB8xWEvNIsSg1z0+j/FhodX/GpQuv98kcR/6yETNXWAq2WByDJc8TggAF+T3plnrkXyu2d6Qc/5jo90YgC3itdrIgpg+/D2xCz0LU31XJgVDHFy+JBN1+ato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786658275; c=relaxed/simple;
	bh=VJFtcuh1TB2QMMFrGK9+smcRHIvfWvrGRFvyGKjkvfE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EGzshhuv5SieOB4cClQOdv2WlTFmcCpOurS4aSbAej3N96f/M6REYrlW4bEnOf+bJc/f6HzhCXXA4jSjOVeQwgox0bCUD9PIBx6qJgOj90DyKGpuEVOSFwjQAcYPfnAB4BYo/8H6E0yH33LjhoubksYvfmul/aKyc9UGZHwwl2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUhkZt1i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUhkZt1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2701F000E9;
	Thu, 13 Aug 2026 21:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786658273;
	bh=dcuvhgdEC0DCOfxh8UuujfiWoM9Ex/hdNEJdIcwHrHY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AUhkZt1iBtAYwJZK/zYUZ2cRJq2NCSty0AaoI8iACb7vEK4Yq8LdP8gSoiTAjrxv+
	 FT0DBHA730tisQP9G5FWaU50SBYAlcrhVVPGejb0dLfLfaZzMrJcvWx9N9f4s1WGSB
	 jH6hvJOYOZ/e5c0rsr36p2IhUYofjSO0u4xcIdqMeCMvmhl8TA8G2stC4F3mTEV+bG
	 ruCdwFpibzNzUHoDA0o70P1HLR6IyWSp2V2nOi4HTnDkG3i+XWWFeiMQhIPH3F4ZA5
	 ZKTM3I2dtP602mw3uHZ88HBjotd9d/p+XPq1PylZkmiWv9phTFsY800zSBhWrKFhYg
	 oQZxWLFMdTyzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: pulsar: add driver for Pulsar gaming mice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolas Koesling" <nikolas@koesling.info>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260318205503.64420-1-nikolas@koesling.info>
References: <20260318205503.64420-1-nikolas@koesling.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 21:57:52 +0000
Message-Id: <20260813215753.4E2701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect teardown order allows `power_uevent_work` to be re-queue=
d after cancellation, causing Use-After-Free.
- [High] Manual destruction of `lock_cmd` mutex races with devres power sup=
ply unregistration, causing Use-After-Destroy.
--

--- Patch [1]: [PATCH] HID: pulsar: add driver for Pulsar gaming mice ---
commit 312ad5774c1622addffac4566b25aa23172cdfd6
Author: Nikolas Koesling <nikolas@koesling.info>

HID: pulsar: add driver for Pulsar gaming mice

Add a HID driver for Pulsar wireless gaming mice (X2 V2, X2H, X2A,
Xlite V3). The driver exposes battery level, voltage, and charging
status through the power supply framework. It supports wired, 1kHz,
and 4kHz wireless dongle connections.

> diff --git a/drivers/hid/hid-pulsar.c b/drivers/hid/hid-pulsar.c
> new file mode 100644
> index 0000000000000..2720b9f18b08d
> --- /dev/null
> +++ b/drivers/hid/hid-pulsar.c
[ ... ]
> +static int pulsar_probe(struct hid_device *hdev, const struct hid_device=
_id *id)
> +{
[ ... ]
> +	schedule_delayed_work(&drvdata->init_work, 0);
> +
> +	return 0;
> +
> +err_open:
> +	cancel_work_sync(&drvdata->power_uevent_work);
> +	hid_hw_stop(hdev);

[Severity: High]
Does this error path cancel the work while the hardware is still active?

If an incoming HID report triggers pulsar_raw_event() after this
cancel_work_sync() but before hid_hw_stop(), it will unconditionally queue
power_uevent_work again:

pulsar_raw_event() {
    ...
    if (data[6] =3D=3D EVENT_PWR && data[USB_PAYLOAD_LEN - 1] =3D=3D EVENT_=
PWR_CHK) {
        schedule_work(&drvdata->power_uevent_work);
    ...
}

The probe function would then return, and devres would automatically free
drvdata. When the workqueue subsequently executes the queued work, could
this lead to a use-after-free when accessing drvdata in
power_uevent_work_handler()?

> +	return ret;
> +}
> +
> +static void pulsar_remove(struct hid_device *hdev)
> +{
> +	struct pulsar_data *drvdata;
> +
> +	drvdata =3D hid_get_drvdata(hdev);
> +	if (!drvdata) {
> +		hid_hw_stop(hdev);
> +		return;
> +	}
> +
> +	atomic_set(&drvdata->stopping, 1);
> +	cancel_delayed_work_sync(&drvdata->init_work);
> +	cancel_work_sync(&drvdata->power_uevent_work);

[Severity: High]
Similar to the probe error path, is it safe to cancel work here before
calling hid_hw_stop(hdev)?

Because the underlying hardware transport (and interrupts) remains active
until hid_hw_stop() is called, an incoming HID report could queue
power_uevent_work again after cancellation, leading to a use-after-free
when devres cleans up drvdata.

> +
> +	/* wait for active device i/o (exec_cmd) */
> +	mutex_lock(&drvdata->lock_cmd);
> +	hid_hw_close(hdev);
> +	mutex_unlock(&drvdata->lock_cmd);
> +
> +	hid_hw_stop(hdev);
> +	mutex_destroy(&drvdata->lock_cmd);

[Severity: High]
Is it safe to manually destroy this mutex here before devres unregisters
the power supply?

Because the power supply is registered via devm_power_supply_register(),
devres does not unregister it until after pulsar_remove() completely
finishes.

During this window, a concurrent sysfs read can invoke:
battery_get_property() -> read_power() -> exec_cmd()

While exec_cmd() has an atomic_read(&drvdata->stopping) check, a sysfs
thread could pass that check just before stopping is set to 1, and then get
scheduled out.

When that thread resumes, could it attempt to lock the destroyed mutex,
resulting in a use-after-destroy?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260318205503.6442=
0-1-nikolas@koesling.info?part=3D1
