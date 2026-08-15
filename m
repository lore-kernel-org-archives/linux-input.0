Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1692D594F
	for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 22:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786833853; cv=none; b=Q9bQ2v45GtKE0VASqIFOsoxUC/kg67/ESFLdP/gAq63p+ndtAP5EH+ooOU2nZhjnAbOwy8jGBfBiNhBmcRioSA3p31AixQ04zYFSFwm2el2JqfWdsnef+xVpPycCFEf5aqcTb3d0aLGuwBT/5a8XDl3TWq6cDNt557VwVSn9lmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786833853; c=relaxed/simple;
	bh=XilJCNLNUgxiOpoWyKh8sLTGnj6q3CqX/kSix/YuexU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nKViA0rHtpMlHUMENTRLGE82FojhM643zFnV0h1IjCIRq4nmL5Un/Wf2dYVGlmrSgSORda9KZL9Fz9FOVfri79uXizt6feu2Iwybh/9yzGONBWGm+eixYeTcu23sFHnQ+cXJKKPc60Wv3hTiZ0BCZhtxBLjyBk3EpsD30pJTv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLGTVENe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLGTVENe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD791F000E9;
	Sat, 15 Aug 2026 22:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786833852;
	bh=SODXTl1F4BmUtVq6TcjhymxsLsXcO6LQt0D6X9RzG4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mLGTVENeH+1u8vfPBvO+0G47dO4m4Np5faxPr6EF9v8GNG/q94JCdAVdxlGEvppzl
	 ia7xCLo2T25cHP9XX48l12p4UIZFIs19hPmjrxL7TYVU9jPMLmagIJPoxezdIzK99Y
	 UQ4BIf559yVSLP0xc/HKtzt8SkbKvsxLWltfuNmpxXgS1Z2i28qMZIeqYVAdcx7beE
	 7IWESXKRIXBsDIfWIUAxH2AUuTMoWKMcLhXCi9LQip0nc//mRIMbt7UrYjA2Etmvv2
	 9WuxXl/VVe/J2DDwkRSz6Z89CAoNU+4XBRjHiAm21JAizZ8/aTlnxl3tZlEJrD5rEk
	 +6JSB/mTk3HtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] HID: pulsar: add driver for Pulsar gaming mice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolas Koesling" <nikolas@koesling.info>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260815222446.47989-1-nikolas@koesling.info>
References: <20260815222446.47989-1-nikolas@koesling.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 22:44:11 +0000
Message-Id: <20260815224412.1AD791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Battery state cache invalidation fails during the first 60 secon=
ds of system uptime.
- [Medium] Power supply sysfs name collision when multiple devices are conn=
ected to different USB buses.
- [Low] The driver fails to compile because it uses the MAX() macro for an =
array bound at file scope.
--

--- Patch [1]: [PATCH v4] HID: pulsar: add driver for Pulsar gaming mice ---
commit 2186fd2a13ddd34f0c6ef2388857c37ac08cf8aa
Author: Nikolas Koesling <nikolas@koesling.info>

HID: pulsar: add driver for Pulsar gaming mice

Add a HID driver for Pulsar wireless gaming mice (X2 V2, X2H, X2A,
Xlite V3). The driver exposes battery level, voltage, and charging
status through the power supply framework. It supports wired, 1kHz,
and 4kHz wireless dongle connections.

> diff --git a/drivers/hid/hid-pulsar.c b/drivers/hid/hid-pulsar.c
> new file mode 100644
> index 0000000000000..84df69a7fe443
> --- /dev/null
> +++ b/drivers/hid/hid-pulsar.c
> @@ -0,0 +1,758 @@
[ ... ]
> +struct pulsar_battery {
> +	struct power_supply *ps;
> +	struct power_supply_desc desc;
> +	char name[48];
> +	char model[MAX(32, sizeof((struct hid_device){}).name)];

[Severity: Low]
Will this cause a compilation error? The MAX() macro in the kernel is
implemented using statement expressions, which are strictly forbidden in
integer constant expressions in C. Using MAX() to define an array bound at
file scope usually results in a "statement expression not allowed at file
scope" compiler error.

[ ... ]
> +static void power_uevent_work_handler(struct work_struct *work)
> +{
> +	struct pulsar_data *drvdata;
> +	int ret;
> +
> +	drvdata =3D container_of(work, struct pulsar_data, power_uevent_work);
> +
> +	if (atomic_read(&drvdata->stopping))
> +		return;
> +
> +	down_write(&drvdata->lock_bat);
> +	drvdata->battery.last_read =3D 0;
> +	drvdata->battery.last_status =3D 0;
> +	up_write(&drvdata->lock_bat);

[Severity: Medium]
Does this reliably invalidate the cache shortly after system boot?

In read_power(), cache validity is checked using ktime_get_ns() (time since
boot) compared against MAX_BATTERY_AGE_NS (60s):

read_power() {
        now =3D ktime_get_ns();
        ...
        need_power =3D battery->available &&
            (now - battery->last_read >=3D MAX_BATTERY_AGE_NS);
}

If the system uptime is under 60 seconds, now - 0 will be less than
60 seconds. Could this cause the check to evaluate to false and silently sk=
ip
reading power updates for the first minute of uptime?

[ ... ]
> +static int pulsar_probe(struct hid_device *hdev, const struct hid_device=
_id *id)
> +{
[ ... ]
> +	INIT_DELAYED_WORK(&drvdata->init_work, pulsar_init_work);
> +	drvdata->init_retries =3D INIT_RETRIES;
> +
> +	snprintf(drvdata->battery.name, sizeof(drvdata->battery.name),
> +		 "pulsar_%s_battery", usbdev->devpath);
> +
> +	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);

[Severity: Medium]
Could this cause a sysfs name collision if identical devices are plugged in=
to
multiple USB host controllers?

The usbdev->devpath property is only unique within a single USB bus tree. If
multiple mice are connected to the same relative port numbers on different
buses (e.g., both yield devpath "1" or "1.2"), this will generate identical
names like "pulsar_1_battery".

Would this cause devm_power_supply_register() to fail for the second device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815222446.4798=
9-1-nikolas@koesling.info?part=3D1
