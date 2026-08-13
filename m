Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13360296BCD
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633824; cv=none; b=U+ELsRP4O6PYfJhFENNiYr7IQiQXQ38v7ZlGKHkaLzHadPE/dhmotMKCGWtOsQoTYfQaI12BMF7zzTrWRvvLXN+BBTCFkIR84PdOIQBmAwg1WEkuGJTdaatTVe202Ha4rRfcuBrjmeFZtKs0WkUOXHCpEkN3ldNIqLOvVulCAbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633824; c=relaxed/simple;
	bh=kwF+GuNySKR40A62K2OCJqx57GIJSaOvFt+CQj6NyXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d+gzSX4z1UrZzRBP0Q7Jtcedo/5DJyde2uAtCT4eqfVmdSz9kBzZ51zthWVZ4BzHyvw3dvrg9RbyWUIcpylVXqRG4wnn9PAYY1x3NEpf1OOzO+aAEPehPO1FwvAzGDICM1s1dfcvSsJC4BWy1kFNalIPxtMPcUpSLMJ/ekoaHlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItMrAA//; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItMrAA//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F7A1F000E9;
	Thu, 13 Aug 2026 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633823;
	bh=2eP8TGe5yhqcpHsUoFH96AntxB5xMu7InyNpuKGHI3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ItMrAA//GGtiaqruklQzzrSlRhJwBSkvrCvr0+7XJplAYu1q9psyB6NA+4kj2ZNve
	 90eG/I/ZLYxh8B7GuKJ4B9OeNKm+csLb7sHL6mGSS4r/LGYx52eM4bLbBRuHtMtHNP
	 n2rBkhg0pK4+NlB6P0Vjtg4EIIR4ZGOeRIBJeELM539j2SLbVyK2uxTxashgRrq/pz
	 qBzInbls0OrPUKRHGBnlEFtuG/498osyH/bhQDR2rFs4DFP24BbHuFei0vYq5ygLlh
	 HQSeIt/1NbuBHnbxsKmT1G5IB/LbQTVPwiZUP/hQst0S+qjFMKhsDr+nlOCZvQQ+PN
	 5pU6gWzD+Z0Xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] HID: asus: add support for gamepad mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260813144736.2477941-11-denis.benato@linux.dev>
References: <20260813144736.2477941-1-denis.benato@linux.dev>
 <20260813144736.2477941-11-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:10:22 +0000
Message-Id: <20260813151022.B7F7A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Missing `hid_asus_ally_remove()` in `asus_probe()` error path =
leads to Use-After-Free.
- [High] The dynamically allocated `cfg->config_mutex` is never initialized.
- [Medium] User-configured gamepad mode is unconditionally overwritten and =
lost during device reset/resume.
- [Medium] Hardware state desynchronization due to missing lock coverage ov=
er hardware I/O in `gamepad_mode_store`.
- [Medium] Lockless modification of shared state `cfg->gamepad_mode` in `al=
ly_set_default_gamepad_mode()`.
--

--- Patch [10]: [PATCH 10/12] HID: asus: add support for gamepad mode ---
commit cfd28807a39c51dcfa8825ce30540ae3214394d4
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for gamepad mode

ROG Ally devices can emulate either a mouse+keyboard (desktop mode)
or an gamepad device (xbox360 controller in ROG ally and a custom
DInput device on newer models): add support for switching the current
controller mode.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 301fe33f66b1f..8930a246e7255 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -793,6 +807,136 @@ static ssize_t xbox_controller_store(struct device =
*dev,
> =20
>  static DEVICE_ATTR_RW(xbox_controller);
> =20
> +/**
> + * ally_set_gamepad_mode - Set the gamepad operating mode

[ ... ]

> +static ssize_t gamepad_mode_store(struct device *dev, struct device_attr=
ibute *attr,
> +				  const char *buf, size_t count)
> +{

[ ... ]

> +	/* Convert the index of the text mode array to the byte
> +	 * that will be accepted by the ally MCU.
> +	 */
> +	mode_byte =3D ally_gamepad_mode[mode];
> +
> +	ret =3D ally_set_gamepad_mode(ally, hdev, mode_byte);
> +	if (ret < 0)
> +		return ret;
> +
> +	scoped_guard(mutex, &cfg->config_mutex)
> +		cfg->gamepad_mode =3D mode_byte;

[Severity: Medium]
Can the hardware state become desynchronized from the software state here?

The hardware request ally_set_gamepad_mode() executes before acquiring
cfg->config_mutex, while the internal software state cfg->gamepad_mode
is updated only after the lock is acquired.=20

If two threads write to the sysfs attribute concurrently, might their
hardware I/O requests interleave with the mutex-protected state updates,
resulting in the hardware being set to one mode while the driver records
the other?

[Severity: High]
Is cfg->config_mutex properly initialized before it is used here?

Looking at ally_config_create(), the structure is allocated and
zero-initialized:

drivers/hid/hid-asus.c:ally_config_create() {
    ...
	cfg =3D devm_kzalloc(&hdev->dev, sizeof(*cfg), GFP_KERNEL);
	if (!cfg)
		return ERR_PTR(-ENOMEM);
    ...
}

However, mutex_init() is never called for cfg->config_mutex.

A zero-initialized mutex lacks proper lockdep linkage and wait_list
initialization.=20

Could this trigger lockdep warnings or kernel crashes when scoped_guard()
is called?

> +
> +	hid_dbg(hdev, "Set gamepad mode to %s\n", ally_gamepad_mode_text[mode]);
> +
> +	return count;
> +}
> +

[ ... ]

> +static DEVICE_ATTR_RW(gamepad_mode);
> +static DEVICE_ATTR_RO(gamepad_mode_index);
> +
> +static int ally_set_default_gamepad_mode(struct hid_device *hdev,
> +					 struct ally_handheld *ally,
> +					 struct ally_config *cfg)
> +{
> +	cfg->gamepad_mode =3D ALLY_GAMEPAD_MODE_GAMEPAD;
> +
> +	return ally_set_gamepad_mode(ally, hdev, cfg->gamepad_mode);

[Severity: Medium]
Is it safe to modify cfg->gamepad_mode directly without holding
cfg->config_mutex?

This function is called from hid_asus_ally_init() after ally_config_create()
has already successfully registered the sysfs group.=20

Since the sysfs attributes are active and exposed, could a concurrent write
from userspace interleave with this initialization?

> +}
> +
>  /**
>   * ally_set_vibration_intensity() - Set vibration intensity values

[ ... ]

> @@ -2422,6 +2568,13 @@ static int hid_asus_ally_init(struct hid_device *h=
dev, struct ally_handheld *all
>  	if (ret < 0)
>  		hid_err(hdev, "Ally failed to init force-feedback off: %d\n", ret);
> =20
> +	/* Set the default gamepad mode now that the MCU is confirmed ready */
> +	if (ally->config) {
> +		ret =3D ally_set_default_gamepad_mode(hdev, ally, ally->config);
> +		if (ret < 0)
> +			hid_warn(hdev, "Failed to set default gamepad mode: %d\n", ret);
> +	}
> +

[Severity: Medium]
Will this unconditionally overwrite the user-configured gamepad mode?

During a USB reset resume, hid_asus_ally_init() is called and invokes
ally_set_default_gamepad_mode(), which sets the state to
ALLY_GAMEPAD_MODE_GAMEPAD and writes it to the hardware.=20

Does this actively destroy the user's previously selected mode across
suspend/resume or device reset cycles?

>  	return 0;
>  }

[Severity: Critical]
Does the error path in asus_probe() leave a dangling pointer to freed memor=
y?

If asus_probe() fails after hid_asus_ally_probe() succeeds, the driver
jumps to the err_stop_hw error path:

drivers/hid/hid-asus.c:asus_probe() {
    ...
err_stop_hw:
	if (drvdata->listener.brightness_set)
		asus_hid_unregister_listener(&drvdata->listener);

	asus_worker_stop(drvdata->worker);
	hid_hw_stop(hdev);
	return ret;
}

This path cleans up core resources but fails to tear down the ally
sub-driver state.=20

The driver core's devres mechanism automatically frees ally_cfg, but the=20
static global ally_drvdata.config retains a dangling pointer to this freed
memory.

Could this lead to a use-after-free if accessed by a subsequent interface
probe or a delayed work?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813144736.2477=
941-1-denis.benato@linux.dev?part=3D10
