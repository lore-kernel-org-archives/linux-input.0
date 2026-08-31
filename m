Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB9F184
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788134720; cv=none; b=d/L73Ud7v2xWviOBOGCs7lPeM+Y81doeRIDB39hy/m4ygMFnfKrO9k5F0MZBKlsuN+D58o5gGrI1QslbydGxVrfsc8ZIOmcC8Z6ZjoAT8UWb6wf8RMYQtR1Z0woa0l5WzYctiBX18oUJ/gswoztOQyzS7BazV2R+gwjaReQn/jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788134720; c=relaxed/simple;
	bh=XjvYvWM9JmUb/mfudSUxT4n3461kiBahkAD7bIAWE8c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H9O/sqMOG80F5aY/H8W5iSdM1LZ1bn+uJuwvhhCz2r4DEH78mESX7KeAkyJ86Vdy50NSyk1UnhZ3rX5AIQhjcDkOz4/QaJGKr0G1vS3O+m62PK0MkPf08flMhvBxar2fXDQ5+cW5WYc+Kp3beZXCJH3oTI5LydcJzrzRDM8D9ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxcuULbe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxcuULbe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F061D1F000E9;
	Mon, 31 Aug 2026 00:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788134719;
	bh=HpPy7fS+hkwsOa1PNy2/9Ksf3q7llyeCv8o+trImB88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IxcuULbeLylbXIi7z91rSLlQVRMYahrYOoWM/7o0gXwXK6GMYRR3lA9DK7ip6+WRO
	 Lq57jHjStzjlM3UlIJO/NnU7wekzXrjqoxHQq0pYMnv2BPmjvmlRzt4DhA2TvWquH1
	 NBfPj7saISQsRuxbGGwbeB1fgZsvDIUJKxhdEOeDEHsFWHloleuBDSV3/Ix/z/Yuoa
	 DD1SOYAgqRGaAcSIDg34DreGwfCA45DPjwVTq1e0MM/DqFty5OCGfSlfRTITDmXh+/
	 nbzhYrv4AwgAIddwjsv4YEizpNIF7sB1LODQhkTQEL36yIoqQvpgdiXPjph7frT1pC
	 rMU+x/phHET8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/13] HID: asus: add support for gamepad mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260830234320.114356-12-denis.benato@linux.dev>
References: <20260830234320.114356-1-denis.benato@linux.dev>
 <20260830234320.114356-12-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 00:05:18 +0000
Message-Id: <20260831000518.F061D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The driver fails to restore the user-configured gamepad mode dur=
ing a reset resume, leaving the hardware and software state out of sync.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the allocated `a=
lly_config` structure is never assigned to `ally_drvdata.config`, causing a=
ll sysfs configuration attributes to immediately return `-ENODEV`.
--

commit 1fb61822e5f0cd86a15f0eb20ff193c1240573e5
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for gamepad mode

ROG Ally devices can emulate either a mouse+keyboard (desktop mode)
or an gamepad device (xbox360 controller in ROG ally and a custom
DInput device on newer models): add support for switching the current
controller mode.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 61330ae082b16..9ed6c605df888 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> +static ssize_t gamepad_mode_store(struct device *dev, struct device_attr=
ibute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct ally_handheld *ally =3D drvdata->rog_ally;
> +	struct ally_config *cfg;
> +	u8 mode_byte;
> +	int mode;
> +	int ret;
> +
> +	if (!ally)
> +		return -ENODEV;
> +
> +	cfg =3D ally_get_config(ally);
> +	if (!cfg)
> +		return -ENODEV;

[Severity: High]
This isn't a bug introduced by this patch, but will this !cfg check always
evaluate to true, blocking all sysfs functionality?

Every sysfs attribute relies on ally_get_config(), which attempts to return
ally->config. Because ally->config is implicitly initialized to NULL (via t=
he
global ally_drvdata) and never populated with the allocated ally_cfg pointe=
r,
all sysfs attributes immediately reject access with -ENODEV.

Looking at the probe path where the shared ally_drvdata state is populated
after a successful interface probe, the config pointer assignment is entire=
ly
omitted:

drivers/hid/hid-asus.c:hid_asus_ally_probe() {
    ...
		ally_cfg =3D ally_config_create(hdev, &ally_drvdata);
		if (IS_ERR(ally_cfg)) {
			...
		}

		ret =3D hid_asus_ally_init(hdev, &ally_drvdata);
		if (ret < 0) {
			...
		}

		spin_lock_irqsave(&ally_data_lock, flags);
		ally_drvdata.cfg_hdev =3D hdev;
        /* missing: ally_drvdata.config =3D ally_cfg; */
		spin_unlock_irqrestore(&ally_data_lock, flags);
    ...
}

This disables the entirety of the newly added gamepad configuration feature=
s.

> +
> +	mode =3D sysfs_match_string(ally_gamepad_mode_text, buf);
> +	if (mode < 0) {
> +		hid_err(hdev, "Unknown gamepad mode\n");
> +		return mode;
> +	}

[ ... ]

> +/**
> + * ally_apply_gamepad_mode() - Re-send the recorded gamepad mode to the =
hardware
> + * @hdev: HID device
> + * @ally: ally handheld structure
> + * @cfg: ally config
> + *
> + * Re-send the gamepad mode currently recorded in the configuration to t=
he
> + * hardware: during probe that is the default mode, while a reset resume
> + * restores whatever the user last wrote instead of overwriting it. The
> + * shared state is accessed under the lock, as sysfs is already live.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static int ally_apply_gamepad_mode(struct hid_device *hdev,
> +				   struct ally_handheld *ally,
> +				   struct ally_config *cfg)
> +{
> +	scoped_guard(mutex, &cfg->config_mutex)
> +		return ally_set_gamepad_mode(ally, hdev, cfg->gamepad_mode);
> +}
> +

[Severity: Medium]
Does the driver fail to restore the user-configured gamepad mode during a
reset resume?

The documentation for ally_apply_gamepad_mode() explicitly outlines its
design intent for restoring the mode after a reset resume, but it appears
unwired in hid_asus_ally_init(), which only restores the Xbox controller mo=
de:

drivers/hid/hid-asus.c:hid_asus_ally_init() {
    ...
	if (cfg->xbox_controller_enabled) {
		ret =3D ally_set_xbox_controller(hdev, ally, cfg, true);
		if (ret < 0)
			hid_warn(hdev, "Failed to restore Xbox controller mode: %d\n",
				 ret);
	}

	return 0;
}

Without a call to ally_apply_gamepad_mode() here, if the system suspends,
the MCU powers off and loses its gamepad mode setting. On resume, the hardw=
are
reverts to its default mode while the sysfs driver state (and cfg->gamepad_=
mode)
incorrectly claims the user's previously configured mode is still active.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830234320.1143=
56-1-denis.benato@linux.dev?part=3D11
