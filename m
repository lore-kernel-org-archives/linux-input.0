Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E56AEED8
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 00:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966636; cv=none; b=f+EowUn/SCz9qJH7QKSpdj/cvW8jS+0ykJvAQTUsxw/rB8QgvcdVvuu+8d1lk5YxRhGB13F46e74ORzk1cQKu7R4EHz/g2HB7jf6EsfUu1wYolGvCP2VrEODp7u9J86sLEswENe0wwIS4aLrbtqon6Qsmd5XWZdndU7XkqG80GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966636; c=relaxed/simple;
	bh=JWt4JpJtshTXnmHauafmJ9YUhbrkHNo2BL1ZdJkoFdk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J4WjCVBiZIMrG9BeMtco/XrqzfE7H1T0nUMAHNWPrXC73Aj48v3Q5OMz+6pzU5SLcfCvmJJeqo6IgrKpXfpzrkPJsTtr+lG5PXBJ3tWBZkPHR70LmjPB81e89hCQYtNeCW3RfJRnAuLV+4nZLV137YKe/cQr0fCAi16KVNWoGAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpPbcL/H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpPbcL/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52A11F00893;
	Tue,  9 Jun 2026 00:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966635;
	bh=a7TGn1iUTeLokFbCt4KcOrij7KpSJwDV94m8tiapVRE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UpPbcL/HvT8W/s15Dcotv113iBwQeqexEAVpWs04tnG2HRDPwdMhjsqk/4rH03/9I
	 lhuLo0A6BG6I0oQbat3qwPs0EBiIuyTU4AQdt65T5774hRlC//AFzEQ86RqdPehEPA
	 5LCIu0EGj7UFW+cgQVl/p8W8faVhFQQBuDqRKUBAlV6OsELYO1pBMkbzFL1QNjXd0S
	 +W64tXO65ddX+sZwfp5WZNY76uBLFYFykCPNLGCU4e8RxbJQkL8rOJD/PcwVQoGqu7
	 N4y9T9uoIw4ePNmqCtkj3cHMtQYKcHhjf+3QZd4KCWdWcwfv9Ywq0YXxyV7StfRMqu
	 hYDbpKa3Y+/qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: cyapa: fix runtime PM refcount leak in
 cyapa_update_rt_suspend_scanrate()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260609004617.175476-1-vulab@iscas.ac.cn>
References: <20260609004617.175476-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 00:57:14 +0000
Message-Id: <20260609005714.E52A11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] System suspend and resume callbacks unconditionally dereference `c=
yapa->input->mutex`, leading to a kernel crash if the device is bound but n=
ot operational.
- [High] Explicitly unregistering a `devm`-managed input device during firm=
ware updates leads to devres leaks and use-after-free on driver unbind.
- [High] The driver calls the core helper `input_device_enabled()` without =
holding `input_dev->mutex`, violating core locking rules.
--

commit fd1e73fff3322eda5030f5978379f809f689c870
Author: Wentao Liang <vulab@iscas.ac.cn>

Input: cyapa: fix runtime PM refcount leak in cyapa_update_rt_suspend_scanr=
ate()

The commit fixes a runtime PM reference leak in
cyapa_update_rt_suspend_scanrate(). It adds a missing
pm_runtime_put_sync_autosuspend() call on the error path when
mutex_lock_interruptible() fails.

Cc: stable@vger.kernel.org
Fixes: 672865080a8f ("Input: cyapa - add runtime power management support")

> diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
> index 47000c30e4d8b..c1c23fcf494a9 100644
> --- a/drivers/input/mouse/cyapa.c
> +++ b/drivers/input/mouse/cyapa.c
> @@ -901,8 +901,10 @@ static ssize_t cyapa_update_rt_suspend_scanrate(stru=
ct device *dev,
>  	pm_runtime_get_sync(dev);
> =20
>  	error =3D mutex_lock_interruptible(&cyapa->state_sync_lock);
> -	if (error)
> +	if (error) {
> +		pm_runtime_put_sync_autosuspend(dev);
>  		return error;
> +	}
> =20
>  	cyapa->runtime_suspend_sleep_time =3D min_t(u16, time, 1000);
>  	cyapa->runtime_suspend_power_mode =3D

[Severity: High]
This isn't a bug introduced by this patch, but looking at cyapa_suspend() a=
nd
cyapa_resume(), they unconditionally acquire the input device mutex:

drivers/input/mouse/cyapa.c:cyapa_suspend() {
    ...
    error =3D mutex_lock_interruptible(&cyapa->input->mutex);
    ...
}

drivers/input/mouse/cyapa.c:cyapa_resume() {
    ...
    mutex_lock(&cyapa->input->mutex);
    ...
}

Could this lead to a kernel crash if the trackpad is not operational during
probe (e.g., stuck in bootloader mode) or during a firmware update?

In this scenario, cyapa_create_input_dev() is skipped and cyapa->input rema=
ins
NULL. Since cyapa_probe() still returns 0, the device is successfully bound
and the suspend/resume callbacks will dereference the NULL cyapa->input poi=
nter.

[Severity: High]
This is a pre-existing issue, but does cyapa_update_fw_store() leak devres
memory and cause a use-after-free on driver unbind?

cyapa_create_input_dev() allocates the input device using a devm wrapper:

    input =3D devm_input_allocate_device(dev);

This automatically queues a devres action to unregister the device upon dri=
ver
unbind. However, cyapa_update_fw_store() explicitly calls:

    input_unregister_device(cyapa->input);

This unregisters and frees the device, but the devres action attached to the
parent device is not cancelled.

When the driver is eventually unbound, will the devres framework attempt to
execute input_unregister_device() on the already-freed cyapa->input pointer?

[Severity: High]
This is a pre-existing issue, but does cyapa_enable_irq_for_cmd() call
input_device_enabled() without holding the input device mutex?

drivers/input/mouse/cyapa.c:cyapa_enable_irq_for_cmd() {
    ...
    if (!input || !input_device_enabled(input)) {
    ...
}

The input subsystem requires input_device_enabled() to be called while hold=
ing
input_dev->mutex. This function is invoked from multiple sysfs attribute
handlers, such as cyapa_calibrate_store(), while only holding the driver's
internal state_sync_lock.

Could this cause a lockdep splat upon sysfs interaction?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609004617.1754=
76-1-vulab@iscas.ac.cn?part=3D1
