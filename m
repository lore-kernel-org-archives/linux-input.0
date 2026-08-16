Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6C33CCFD2
	for <linux-input@vger.kernel.org>; Sun, 16 Aug 2026 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786878323; cv=none; b=GDTuMYrWlwrAWQbqvgshvb8osug9tUQ1CA4/Sbwvc1UP3okxnMGQ/kb37AVvMplkHY36tUISUAM0mm/eJ5hE3Zwzfi5pPc7oXSbnopUoZEiTPSACYG05VH1s3mLpoBrJiB1aUArmnNWUF86MNHTlCR2C+s/+bWhp9wiXvvVTn4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786878323; c=relaxed/simple;
	bh=Lk4av7lOTY62VTyO+JNCFiLZnJQ2a2nMIpY9B7hjhUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mYFIpHTz2N46VV/KDlRvMRnpn2pkFAPo3TU4Y/Itde645oHY5DIRr7BKc7W2rN1xtcfJ+AxXo2G4iyhSqOdw0M4LRXciCKO/HOKYvMwyMflsezJtNSWJimWXO9HiB12zZVJdo3pcf/kLvxNOskKzKb4V7PxZ50lhbRkpsmf4IBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmstrLg8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmstrLg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB7E1F000E9;
	Sun, 16 Aug 2026 11:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786878321;
	bh=IDrBZ9+LpCpWI+QZLBc8zniZykUvo3FpgkqJw/2TZWY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GmstrLg8+ZaUVzzgHScpdAN1sy+6KD1IYSDnBup7giJpU3hyiDfak8umLW/1SKOF+
	 vW0tIMjA0GlSJkWIATxswCKQkj7R2dwN+w1/t1eAjKI1CURjHm8CAsKGUFtgRIDodj
	 Y27RRpOyNSckscP6PNGbx7cXRf41z+AigHVN3PVQ7eMZbDEcC5IfcyZ5kgt9Y+3Pg9
	 veNaKL2LEbxmVRdkjw/rDC2YlhZ6ByvultmxK5NlPGrQoR1XiiizmRbArjP96Ghwgb
	 +26RIIFeR5hdKWn1r/AKA00nneY5kBVCkS0d4wYRQXLmR3+oMSV6ys2UtL9hXj8Z8W
	 dxZx9D9pBG/xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] HID: pulsar: add driver for Pulsar gaming mice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolas Koesling" <nikolas@koesling.info>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260816105423.47305-1-nikolas@koesling.info>
References: <20260816105423.47305-1-nikolas@koesling.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 11:05:21 +0000
Message-Id: <20260816110521.8DB7E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] The `drvdata` structure is freed before the battery power supp=
ly is unregistered, leading to a Use-After-Free vulnerability if userspace =
reads battery properties during device removal.
- [Medium] The fallback logic for non-Pulsar devices during battery initial=
ization is bypassed on command timeout.
- [Low] Syntax error in the `model` buffer size will prevent compilation.
--

--- Patch [1]: [PATCH v6] HID: pulsar: add driver for Pulsar gaming mice ---
commit 0c76abb72f725f692e295af15d27ebb1d0e0b2a5
Author: Nikolas Koesling <nikolas@koesling.info>

    HID: pulsar: add driver for Pulsar gaming mice

This commit introduces a new HID driver for Pulsar wireless gaming mice
and related devices. It exposes battery level, voltage, and charging
status through the power supply framework.

> diff --git a/drivers/hid/hid-pulsar.c b/drivers/hid/hid-pulsar.c
> new file mode 100644
> index 0000000000000..a6ff6e436d407
> --- /dev/null
> +++ b/drivers/hid/hid-pulsar.c
> @@ -0,0 +1,763 @@
[ ... ]
> +struct pulsar_battery {
> +	struct power_supply *ps;
> +	struct power_supply_desc desc;
> +	char name[48];
> +	char model[MAX(32, sizeof((struct hid_device){}).name)];

[Severity: Low]
Does this compile? It looks like the sizeof operator is applied to the=20
compound literal itself, which yields a size_t value, making the subsequent=
=20
.name access a syntax error.

[ ... ]
> +static void pulsar_init_work(struct work_struct *work)
> +{
> +	struct pulsar_data *drvdata;
> +	struct hid_device *hdev;
> +	struct power_supply_config psy_cfg;
> +	int ret;
> +	u8 data[DEV_INFO_LEN];
> +
> +	drvdata =3D container_of(work, struct pulsar_data, init_work.work);
> +	hdev =3D drvdata->hdev;
> +
> +	ret =3D read_device_info(drvdata, data);
> +	if (ret =3D=3D -ETIMEDOUT) {
> +		if (drvdata->init_retries--) {
> +			hid_dbg(hdev,
> +				"device info read timed out, retrying (%u left)\n",
> +				drvdata->init_retries);
> +			schedule_delayed_work(&drvdata->init_work,
> +					      msecs_to_jiffies
> +					      (INIT_DELAY_MSEC));
> +			return;
> +		}
> +		hid_err(hdev, "device info read timed out, giving up\n");
> +		return;

[Severity: Medium]
If a non-Pulsar device ignores the CMD_INFO request and times out, will it
skip the fallback logic?

The fallback logic for devices that fail to read info is located in the=20
if (ret < 0) block below, which safely defaults to assigning hdev->name.=20
If the command times out instead, it returns directly here, preventing=20
the device from registering a battery at all.

> +	}
> +	if (ret < 0) {
[ ... ]
> +register_battery:
> +	init_power_supply_desc(drvdata);
> +
> +	psy_cfg =3D (struct power_supply_config) {.drv_data =3D drvdata };
> +	drvdata->battery.ps =3D
> +	    devm_power_supply_register(&hdev->dev, &drvdata->battery.desc,
> +				       &psy_cfg);

[Severity: Critical]
Can this cause a use-after-free during device removal?

Because devm_power_supply_register() is called asynchronously from a workqu=
eue
rather than directly during the probe sequence, the devres allocation attac=
hes
to the main device devres group instead of the HID probe devres group.

During unbind, the HID core will release the probe devres group and free
drvdata. However, the power supply remains registered until the main device
devres group is released later.=20

If userspace reads a sysfs property during this window, battery_get_propert=
y()
could dereference the freed drvdata.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816105423.4730=
5-1-nikolas@koesling.info?part=3D1
