Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F8312803
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782095282; cv=none; b=G4qSZFzJJIpGSMEsqb7oTcXYFrncAmQ0ZpkrtVwirlvkU+FJF4jkft8oRTzCGdNU3DIVawDqOHOiWEunXUrPCJWpPMbqNr8Y9o8s+WZdHqUcgC4M4ByZeaNYUIg2ZasCQBOEysxrQzsJLdLtmSnKkGLEGTOsXzv80vxYZLgMwQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782095282; c=relaxed/simple;
	bh=L5lG1SZIQdKbVIKjkIZ9GQ65CPhPz3VCXkNhM+Lc8Ug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YpJSRwXl90cLq01r2x8ARn0etPzUro82Q4gZXslCJ5tcxbBMOnCc8bmZfFcF4LnKLxvQTn033i67gwVKR3+WMkU942sXeCLvHIhGos1TCFAIsgE8gfKPE6kw1chvbV93IQw27TmhpFNBoNAPxHnvvwuMt1f2cEslimyJ1qjelr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDy4p+WL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDy4p+WL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01D51F000E9;
	Mon, 22 Jun 2026 02:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782095281;
	bh=/qU2RM261ZfRn6kOXaYtzgEf3DQySc5MjHaHsI7NQxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eDy4p+WLB2ZeiGSqGz5BcwU4Qx+k3CWWbBgiedUy4DedoCMiOiO51UkA8aRHYY7Ka
	 e4v58A5zqTc878Jcy47LaEBH9E9DdTqpii436TKkICHKOdsFSfWc6k1f8Xubsvd96M
	 /8zWgba4hnWCku1gMDfi/iEI9QWxD17NbsQ2F6XGncaVtm501MCDFR/FtP/CbsddS7
	 /vGMLuo1jqmFVhlL54DEinstCUdtBaHnJTu1sbA0qhaKVFnAxIYmWmleau/2DIfkhg
	 sg3lXXwPDfrzYACO16oEL/ppz2MDpB5Zu5GIhRNA/ZYIHufF0s4yOiAH7cfZ+/U8bg
	 rFbRQBRDYnXfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: hyperx-headset: Add support for HyperX headset
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sofia Schneider" <sofia@schn.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260622021744.145340-1-sofia@schn.dev>
References: <20260622021744.145340-1-sofia@schn.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 02:28:00 +0000
Message-Id: <20260622022800.D01D51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Inverted teardown order in `hyperx_headset_remove` leads to Use-Af=
ter-Free.
- [High] Missing lock during power supply unregistration causes a data race=
 and Use-After-Free.
- [High] Missing work cancellation on `hid_hw_start` error path leads to Us=
e-After-Free.
- [Medium] Hardcoded power supply name causes sysfs collisions for multiple=
 devices or interfaces.
--

commit 435d0aab64fdcdfdde5a060312bb493c98996f6a
Author: Sofia Schneider <sofia@schn.dev>

HID: hyperx-headset: Add support for HyperX headset devices

Introduce a HID driver for HyperX Cloud III Wireless headsets,
supporting battery reporting and connection status.

> diff --git a/drivers/hid/hid-hyperx-headset.c b/drivers/hid/hid-hyperx-he=
adset.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/hid/hid-hyperx-headset.c

[ ... ]

> +static const struct power_supply_desc hyperx_headset_battery_desc =3D {
> +	.name =3D "hyperx_headset_battery",
> +	.type =3D POWER_SUPPLY_TYPE_BATTERY,

[Severity: Medium]
Does this static power supply name cause sysfs collisions?

If a user connects multiple identical headsets, or if the headset
exposes multiple HID interfaces that bind to this driver, the second
instance will fail to register with a -EEXIST error.

Could this be dynamically allocated, perhaps using devm_kasprintf with
hdev->uniq or a counter, to ensure each device gets a unique name?

> +	.properties =3D hyperx_headset_battery_props,
> +	.num_properties =3D ARRAY_SIZE(hyperx_headset_battery_props),
> +	.get_property =3D hyperx_headset_battery_get_property,
> +};

[ ... ]

> +static int hyperx_headset_probe(struct hid_device *hdev,
> +				const struct hid_device_id *id)
> +{

[ ... ]

> +	ret =3D hid_parse(hdev);
> +	if (ret !=3D 0) {
> +		hid_err(hdev, "parse failed\n");
> +		return ret;
> +	}
> +
> +	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	if (ret !=3D 0) {
> +		hid_err(hdev, "hw_start failed\n");
> +		return ret;
> +	}

[Severity: High]
Can this error path leak pending work items?

The hid_hw_start() call initializes the low-level driver, which can
immediately start receiving hardware interrupts before completing the
logical HID connection.

If a packet arrives during this window, hyperx_headset_raw_event() can
schedule drvdata->battery_work.

If hid_hw_start() fails and returns an error, the function exits without
calling cancel_work_sync(&drvdata->battery_work). The drvdata structure is
then freed by devres, leaving a pending work item that will dereference
freed memory when it executes.

Should the error path ensure background work is cancelled before returning?

> +
> +	schedule_delayed_work(&drvdata->poll_work, 0);
> +
> +	return 0;
> +}

[ ... ]

> +static void hyperx_headset_remove(struct hid_device *hdev)
> +{
> +	struct hyperx_headset_device *drvdata =3D hid_get_drvdata(hdev);
> +
> +	if (drvdata) {
> +		cancel_delayed_work_sync(&drvdata->poll_work);
> +		cancel_work_sync(&drvdata->battery_work);

[Severity: High]
Could this teardown sequence result in re-queued work?

The driver calls cancel_work_sync() before calling hid_hw_stop().
This leaves a window where the hardware is still active and can generate
interrupts after the work queues have been canceled.

If a device state change event arrives during this window,
hyperx_headset_raw_event() will call schedule_work(&drvdata->battery_work).

When hyperx_headset_remove() completes, devres frees the drvdata structure.
The incorrectly re-queued work item will execute later, dereferencing the
freed drvdata memory.

Should hid_hw_stop() be called before cancelling the work queues?

> +
> +		if (drvdata->battery) {
> +			power_supply_unregister(drvdata->battery);
> +			drvdata->battery =3D NULL;
> +		}

[Severity: High]
Is it safe to access and clear drvdata->battery here without holding
drvdata->lock?

If an interrupt arrives concurrently, hyperx_headset_raw_event() will
acquire the lock, observe a non-null drvdata->battery, and call
power_supply_changed(drvdata->battery).

Since power_supply_unregister() can concurrently drop the device reference
and free the structure, power_supply_changed() might access freed memory.

Should the pointer be cleared to null under the spinlock before
unregistering, similar to how it is handled in
hyperx_headset_battery_work()?

> +	}
> +
> +	hid_hw_stop(hdev);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622021744.1453=
40-1-sofia@schn.dev?part=3D1
