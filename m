Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E0B37F759
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759487; cv=none; b=eEJGlBADmpGKftkW/lmm6v6VLYBpQCZtl/Qs6j2LEnb6EhQxfg8Jg4Dd2qCsuuQcn/rJodSTiualcZ96Rxl4Ncz8aWAMUi2rJiG+qzDGIF0ANaYiRIcc43UmMBaLZHTqqUf5MpySro521F7JAzndywkOP1ou94iuXZ26qEixG/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759487; c=relaxed/simple;
	bh=olrJ92nHXI77CgZh/KL6DPZDYCyM5bR7E3U1qJW5Bs0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uEaa+zDjvmpYnXBCjO+o9sNplCy7lvd+9OBB3V4UM5ogxIDoNNCX4QfrvR3JA3m2U9DpDEajtDZAuDpQzWCy3xUgUNKeHaaxVfr642JiAGgAN4YQwASaiFji3V5FBDN//Venf1veIAnxdAK8DeFQ5vUNfafxT9wNmVWalQsQeWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPSfqvuU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPSfqvuU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAD8C2BCB3;
	Thu, 14 May 2026 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778759487;
	bh=olrJ92nHXI77CgZh/KL6DPZDYCyM5bR7E3U1qJW5Bs0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VPSfqvuUlQ1H4Pv9Yi3UfcV7p+QDm/W9TNiITJgAXJHH4IJYLx9MGCw/VxhBCMYgJ
	 uQjxsCZXKHddk6qVrywtV/K7hSFSSlf+cJkonTPyYGjeIinplkNz2gXZ6gOT81d8/2
	 fVkTP6ljOFFmu3FkJDMB+JN4Idryknpmx/GBLmKWDnW/oqMNT9sxiFqMPwtA/aqZWe
	 X9Mt/C9adtsxe2GB8N1TDc/2udvKk667fqt4g0BTkUCS6OEKrq8cAxWa7fWnxdp2zA
	 ABkDmnah0GK4LlYxdUjqchiNdhD/HLrqw8BRlIJngOivpEhDBO7RLjrOGALJ9/76NZ
	 0r3ppVS06xuFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] HID: hid-msi: Add MSI Claw configuration driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260513231445.3213501-2-derekjohn.clark@gmail.com>
References: <20260513231445.3213501-2-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 11:51:26 +0000
Message-Id: <20260514115126.BCAD8C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The `guard(mutex)` macro in `claw_hw_output_report` is scoped to a=
n `if` block, prematurely releasing the lock before the critical section.
- [High] The driver publishes `drvdata` via `hid_set_drvdata()` before full=
y initializing its mutex and completion objects, creating a race condition.
- [Medium] An invalid, uninitialized gamepad mode (0) may be sent to the ha=
rdware during system resume.
- [Medium] The 8ms timeout used in `claw_hw_output_report()` is vulnerable =
to jiffies rounding, leading to spurious read failures.
- [Medium] The commit message claims probe checks MCU RAM address variances=
, but the implementation is missing.
--

commit 13b388de96d7484eee908adeed127e8086fc289e
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add MSI Claw configuration driver

This commit adds a configuration HID driver for the MSI Claw series of
handheld PCs. It provides support for switching the gamepad mode and changi=
ng
the behavior of the M-keys.

>     Additionally, the MCU RAM address for writing configuration data has
>     changed twice. Checks are done during probe to enumerate these varian=
ces.

The commit message states that checks are done during probe to enumerate MCU
RAM address variances.

Looking at claw_probe() and msi_probe(), there does not appear to be any co=
de
that checks firmware versions or handles these variances.

Was this functionality dropped during refactoring, or should the commit mes=
sage
be updated?

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> new file mode 100644
> index 0000000000000..8915942af15e6
> --- /dev/null
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> +static int claw_hw_output_report(struct hid_device *hdev, u8 index, u8 *=
data,
> +				 size_t len, unsigned int timeout)
> +{
> +	unsigned char *dmabuf __free(kfree) =3D NULL;
> +	u8 header[] =3D { CLAW_OUTPUT_REPORT_ID, 0, 0, 0x3c, index };
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	size_t header_size =3D ARRAY_SIZE(header);
> +	int ret;
> +
> +	if (header_size + len > CLAW_PACKET_SIZE)
> +		return -EINVAL;
> +
> +	/* We can't use a devm_alloc reusable buffer without side effects durin=
g suspend */
> +	dmabuf =3D kzalloc(CLAW_PACKET_SIZE, GFP_KERNEL);
> +	if (!dmabuf)
> +		return -ENOMEM;
> +
> +	memcpy(dmabuf, header, header_size);
> +	if (data && len)
> +		memcpy(dmabuf + header_size, data, len);
> +
> +	/* Don't hold a mutex when timeout=3D0, those commands cause USB discon=
nect */
> +	if (timeout) {
> +		guard(mutex)(&drvdata->cfg_mutex);
> +		reinit_completion(&drvdata->send_cmd_complete);
> +	}

Does this drop the lock too early?

The guard() macro releases the lock at the end of its enclosing scope.
Because it is declared inside the if (timeout) block, the mutex will be
released immediately at the closing brace, leaving hid_hw_output_report() a=
nd
the subsequent wait unprotected against concurrent access.

> +
> +	dev_dbg(&hdev->dev, "Send data as raw output report: [%*ph]\n",
> +		CLAW_PACKET_SIZE, dmabuf);
> +
> +	ret =3D hid_hw_output_report(hdev, dmabuf, CLAW_PACKET_SIZE);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ret =3D=3D CLAW_PACKET_SIZE ? 0 : -EIO;
> +	if (ret)
> +		return ret;
> +
> +	if (timeout) {
> +		ret =3D wait_for_completion_interruptible_timeout(&drvdata->send_cmd_c=
omplete,
> +								msecs_to_jiffies(timeout));

Could this timeout evaluate to 1 jiffy on systems configured with HZ=3D100?

Several callers, such as gamepad_mode_show(), pass an 8ms timeout to this
function. A 1-jiffy timeout can expire almost instantaneously if the operat=
ion
begins near the end of the current tick boundary, potentially leading to
spurious -EBUSY timeouts.

[ ... ]

> +static void cfg_resume_fn(struct work_struct *work)
> +{
> +	struct delayed_work *dwork =3D container_of(work, struct delayed_work, =
work);
> +	struct claw_drvdata *drvdata =3D container_of(dwork, struct claw_drvdat=
a, cfg_resume);
> +	u8 data[2] =3D { drvdata->gamepad_mode, drvdata->mkeys_function };

If the system suspends before cfg_setup_fn() executes, or if the device rea=
d in
cfg_setup_fn() fails, could drvdata->gamepad_mode still be 0 here?

Since 0 is not a valid mode (valid modes like CLAW_GAMEPAD_MODE_XINPUT start
at 1), will this send an uninitialized configuration state to the hardware?

> +	int ret;
> +
> +	ret =3D claw_hw_output_report(drvdata->hdev, CLAW_COMMAND_TYPE_SWITCH_M=
ODE, data,
> +				    ARRAY_SIZE(data), 0);
> +	if (ret)
> +		dev_err(&drvdata->hdev->dev, "Failed to set gamepad mode settings: %d\=
n", ret);
> +}
> +
> +static int claw_probe(struct hid_device *hdev, u8 ep)
> +{
> +	struct claw_drvdata *drvdata;
> +	int ret;
> +
> +	drvdata =3D devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	hid_set_drvdata(hdev, drvdata);
> +	drvdata->hdev =3D hdev;
> +	drvdata->ep =3D ep;
> +
> +	mutex_init(&drvdata->cfg_mutex);
> +	init_completion(&drvdata->send_cmd_complete);

Is it safe to publish drvdata via hid_set_drvdata() before initializing the
mutex and completion object?

Since hid_hw_start() was already called earlier in msi_probe(), the hardware
is active. If an input report arrives right after hid_set_drvdata(), the
interrupt handler msi_raw_event() will process it and call complete() on an
uninitialized waitqueue.

> +
> +	/* For control interface: open the HID transport for sending commands. =
*/
> +	ret =3D hid_hw_open(hdev);
> +	if (ret)
> +		return ret;
> +
> +	INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
> +	INIT_DELAYED_WORK(&drvdata->cfg_setup, &cfg_setup_fn);
> +	schedule_delayed_work(&drvdata->cfg_setup, msecs_to_jiffies(500));
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513231445.3213=
501-1-derekjohn.clark@gmail.com?part=3D1
