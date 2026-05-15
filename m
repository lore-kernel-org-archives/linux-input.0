Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDD93CC7FD
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 04:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778818168; cv=none; b=YTFUFy28c32A4ohqQBeaHRrAttczBdCMKjpBnEJ8VubDrSwJ0KCnWniF8qb+aexGZQ3hKKzEjRXo4feztSlOYaunxswQ7K/xeXbDrNZ/zyF/t7PVpBtZcbnbc9PluccWGCijcifIAs0MBbNZiENfKX49Zy4O625P3IBxPYNJ3cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778818168; c=relaxed/simple;
	bh=Dt4wc5ebkuefwtWc+t3KfLglpktSNPfGhCN6ibwh+XI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OrsBWPnUnkqm6RPmD1ed1bAhvLWQON5Q1MB+qISJwFJodwHd4CZR59nw6cvl2bYx7udqDC1d7xlk6+cHFwjd7a7QECyLjLKkQMKETTIbRvIaRZcTLmO+HnZKipDvToukar+Fq5g/mC1a1TfbCuJYSRpnImZV9CCsIZOIV0Bxowg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZe0oDfJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZe0oDfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBF7C2BCB0;
	Fri, 15 May 2026 04:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778818168;
	bh=Dt4wc5ebkuefwtWc+t3KfLglpktSNPfGhCN6ibwh+XI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eZe0oDfJLGbY5lfTqbhY69NZN0P1xVLzW1LtguvVpVyHRx/8k49F/mVr9rEY+C2UR
	 HgYvFqtc7vfWJDVk+riXIh5j18xrYJkwgmLK0FEdKDyUGImWWX3WsgSxirJqgszO4U
	 3YPR/HyXwWvTsl1hRlD/dKejKg/kShLKvro54GaJStjZj3szapf6sFcZIdXlVSTRlq
	 S66LbSV4kkYpKUNcrdMh976mwOdehVWV5mOH3WSnFnMKHlqMum63caloS39QBr0HC2
	 hEj0zTjUy2R/U/8neuzACqqAyIfymLpbATZcypJl3PtGdnciC3evwsTxQArnUVHwfD
	 Zp7IkSzL1ZyEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] HID: hid-msi: Add MSI Claw configuration driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260515033622.2095277-2-derekjohn.clark@gmail.com>
References: <20260515033622.2095277-2-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 04:09:27 +0000
Message-Id: <20260515040928.1DBF7C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Incorrect teardown order in `claw_remove()` creates a race conditi=
on that leaks sysfs attributes and leads to a Use-After-Free.
- [High] Unreasonably short 8ms timeout causes spurious `-EBUSY` failures o=
n `HZ=3D100` systems.
- [Medium] Read-modify-write race condition in sysfs configuration handlers=
 causes silent state corruption.
- [Medium] Missing `.suspend` callback allows hardware-interacting delayed =
works to execute during system sleep.
--

commit ce9aa923d32bac6eb56e73d413c94aa753ea00cf
Author: Derek J. Clark <derekjohn.clark@gmail.com>
Subject: HID: hid-msi: Add MSI Claw configuration driver

Adds configuration HID driver for the MSI Claw series of handheld PC's.
In this initial patch add the initial driver outline and attributes for
changing the gamepad mode, M-key behavior, and add a WO reset function.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> new file mode 100644
> index 0000000000000..89bb32f00bfc3
> --- /dev/null
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> +static ssize_t gamepad_mode_store(struct device *dev, struct device_attr=
ibute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	u8 data[2] =3D { 0x00, drvdata->mkeys_function };

Could this lead to a read-modify-write race condition if two threads write =
to
the sysfs attributes simultaneously?

They read drvdata->mkeys_function locklessly to construct the command paylo=
ad.
After the payload is prepared, claw_hw_output_report() is called, which then
acquires cfg_mutex to send the command. If two threads write concurrently,
the second one could overwrite the first one's change because it read a sta=
le
state.

Should the payload construction be performed inside the cfg_mutex critical
section?

[ ... ]

> +static ssize_t gamepad_mode_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	int ret, i;
> +
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE=
, NULL, 0, 8);

Will this 8 millisecond timeout cause spurious failures on systems configur=
ed
with a 100 hz timer tick?

On such systems, msecs_to_jiffies(8) evaluates to exactly 1 jiffy. A 1-jiffy
timeout using wait_for_completion_interruptible_timeout() can expire in und=
er
1 millisecond if the timer tick fires immediately after the wait is schedul=
ed,
which might not provide enough time for the interrupt to complete and will
return -EBUSY.

[ ... ]

> +static void claw_remove(struct hid_device *hdev)
> +{
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +
> +	if (!drvdata) {
> +		hid_hw_stop(hdev);
> +		return;
> +	}
> +
> +	device_remove_group(&hdev->dev, &claw_gamepad_attr_group);
> +	cancel_delayed_work_sync(&drvdata->cfg_setup);

Does this teardown sequence leak sysfs attributes and cause a use-after-fre=
e?

If cfg_setup_fn() is executing concurrently, device_remove_group() will do
nothing because the sysfs group has not been added yet. Then
cancel_delayed_work_sync() will wait for the work to finish.

Meanwhile, cfg_setup_fn() proceeds to call device_add_group(), adding the
sysfs attributes. When the work finishes, claw_remove() completes and drvda=
ta
is freed. The sysfs attributes remain registered to the device, and any
subsequent read or write from userspace will trigger a use-after-free when
accessing the freed drvdata pointer.

Should cancel_delayed_work_sync() happen before device_remove_group() to
ensure correct teardown order?

[ ... ]

> +static struct hid_driver msi_driver =3D {
> +	.name		=3D "hid-msi",
> +	.id_table	=3D msi_devices,
> +	.raw_event	=3D msi_raw_event,
> +	.probe		=3D msi_probe,
> +	.remove		=3D msi_remove,
> +	.resume		=3D msi_resume,
> +};

Does this driver need a suspend callback?

The cfg_setup and cfg_resume delayed works are scheduled on the standard
non-freezable system workqueue. Without a suspend callback to cancel them,
these works can execute while the system is asleep.

When they fire, they will call hid_hw_output_report() on a suspended
usb device, which could cause input/output timeouts, lockups, or inadverten=
tly
wake up the hardware.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515033622.2095=
277-1-derekjohn.clark@gmail.com?part=3D1
