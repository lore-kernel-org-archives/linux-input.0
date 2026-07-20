Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127973112C0
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 03:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784518054; cv=none; b=IQCll1brYjjknKKab8KSzNRWMWQ3qewaZEJbIcUYK5AIeiE9MX/YhqbgQIpbeUNuh2FuoMfggkdTy7HLvGii3gj6F3f4AMvKk4M/rUogSCR8tJN6gjYj1FF0nb9xPUdnL6CepCANR7QGc6ttt73F0sfRp0KmAAfmj2DKuQyTBYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784518054; c=relaxed/simple;
	bh=ntGFTx/61RwOoh3sl3o3icgPgbPPsltSPoRrsahwwtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d1xk2VpvapplpDbk/8qtlTyPDBLMjnwmu0Q1VHQqlIdyQD1m+12s/jXLh3R5w+en6zR5ZNv4nbQw72it2meSrk+4+evgExdLQoWltP0yXmxbD53B2MIrfmCX7bXW+n/nfQ+4sEqdA6/4NkFqPfNpi80SCA+8Djelu6WSfmYXoI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1Y8OCi/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1Y8OCi/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E0A1F000E9;
	Mon, 20 Jul 2026 03:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784518052;
	bh=buwA6G4gjarntRQ0HLJkwKf4Cj22NNhohN86XgbjIT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m1Y8OCi/JnjN6UQdqBsIUMQTuHmhOkjgySyNLe9zImQmNfYpH3O5qMDGqc8FWwMUv
	 5xW3IftvH2E6xknG4fO4CRaOQDB3rpJ1IHccChwf0I3+ixqf98EsCRoTXJkYaU3/dq
	 l95T+mYPRYOL4rdgVzYDfhN+SZF1dw4GQsg8/L1NIoPzJoY0ge4ruqGWIm1qNqrnpc
	 CVFfwpOk6COkqvSSCoVdIbZm6azvaQwf3XJ5IGOCrs1vpJ/rtgrL04eZQTwj2zPCTw
	 ann4PDz87PnxyJJGBjMLSG/s6DWVlcmngRZCR8Pg/P00wWEa4fp4xhp34nbdJ2B2Zr
	 4Hwm6MuXRzVbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/4] HID: hid-msi: Add MSI Claw configuration driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260720031549.2272658-2-derekjohn.clark@gmail.com>
References: <20260720031549.2272658-1-derekjohn.clark@gmail.com>
 <20260720031549.2272658-2-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 03:27:32 +0000
Message-Id: <20260720032732.75E0A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Delayed generic ACKs from a previous timed-out command can false=
ly complete a subsequent command expecting a specific ACK, leading to silen=
t state corruption.
- [Medium] Mixing `goto`-based error handling with scope-based `__free()` c=
leanup in the same function.
- [Medium] Sysfs attributes can spuriously return `-ENODEV` immediately aft=
er creation because they are exposed before `gp_registered` is set to true.
--

--- Patch [1]: [PATCH v13 1/4] HID: hid-msi: Add MSI Claw configuration dri=
ver ---
commit 12a4a941e97290e1a15080092de490d5782eef1c
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add MSI Claw configuration driver

Adds configuration HID driver for the MSI Claw series of handheld PC's.
In this initial patch add the initial driver outline and attributes for
changing the gamepad mode, M-key behavior, and add a WO reset function.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/hid/hid-msi.c
[ ... ]
> +static int claw_raw_event(struct claw_drvdata *drvdata, struct hid_repor=
t *report,
> +			  u8 *data, int size)
> +{
[ ... ]
> +	switch (cmd_rep->cmd) {
> +	case CLAW_COMMAND_TYPE_GAMEPAD_MODE_ACK:
> +		ret =3D claw_gamepad_mode_event(drvdata, cmd_rep);
> +		if (drvdata->waiting_cmd =3D=3D CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE) {
> +			drvdata->cmd_status =3D ret;
> +			complete(&drvdata->send_cmd_complete);
> +		}
> +
> +		break;
> +	case CLAW_COMMAND_TYPE_ACK:
> +		if (drvdata->orphan_ack_pending) {
> +			drvdata->orphan_ack_pending =3D false;
> +			complete(&drvdata->orphan_ack_complete);
> +			break;
> +		}
> +
> +		if (drvdata->waiting_cmd =3D=3D CLAW_COMMAND_TYPE_NONE) {
> +			dev_warn(&drvdata->hdev->dev, "Got unexpected ACK from MCU, ignoring\=
n");
> +			break;
> +		}
> +
> +		drvdata->cmd_status =3D 0;
> +		complete(&drvdata->send_cmd_complete);

[Severity: Medium]
When claw_raw_event() receives a generic ACK, it only verifies that
waiting_cmd is not CLAW_COMMAND_TYPE_NONE before calling
complete(&drvdata->send_cmd_complete).

If a previous command with timeout =3D=3D 0 timed out, __claw_hw_output_rep=
ort()
clears orphan_ack_pending.

If the generic ACK for that command arrives later while a new command is
waiting (e.g., waiting for GAMEPAD_MODE_ACK), this logic will accept the
generic ACK and falsely complete the new command.

Could this lead to silent state corruption where commands finish early with=
out
receiving their actual payloads?

[ ... ]
> +static int __claw_hw_output_report(struct hid_device *hdev, u8 index, u8=
 *data,
> +				   size_t len, unsigned int timeout)
> +{
> +	unsigned char *dmabuf __free(kfree) =3D NULL;
[ ... ]
> +	ret =3D hid_hw_output_report(hdev, dmabuf, CLAW_PACKET_SIZE);
> +	if (ret < 0)
> +		goto err;
> +
> +	ret =3D ret =3D=3D CLAW_PACKET_SIZE ? 0 : -EIO;
> +	if (ret)
> +		goto err;

[Severity: Medium]
This function uses the scope-based __free(kfree) cleanup for dmabuf, but al=
so
uses manual goto err labels for error handling.

The cleanup subsystem guidelines specify that using goto and cleanup helpers
like __free() in the same function creates confusing ownership semantics an=
d is
an anti-pattern.

Could we use a scope-based guard for the state machine cleanup, or stick
entirely to manual goto cleanup?

[ ... ]
> +static void cfg_setup_fn(struct work_struct *work)
> +{
[ ... ]
> +	/* Add sysfs attributes after we get the device state */
> +	ret =3D device_add_group(&drvdata->hdev->dev, &claw_gamepad_attr_group);
> +	if (ret) {
> +		dev_err(&drvdata->hdev->dev,
> +			"Failed to setup device, can't create gamepad attrs: %d\n", ret);
> +		return;
> +	}
> +	scoped_guard(spinlock_irqsave, &drvdata->registration_lock)
> +		/* Pairs with smp_load_acquire in attribute show/store functions */
> +		smp_store_release(&drvdata->gp_registered, true);

[Severity: Medium]
The sysfs attributes are exposed to userspace by device_add_group() before
gp_registered is set to true.

If an automated userspace tool reacts to the sysfs creation event and acces=
ses
the attributes in this small timing window, the attribute show/store functi=
ons
will observe gp_registered =3D=3D false and return -ENODEV.

Would it be better to set gp_registered to true before calling
device_add_group(), and revert it to false if the addition fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720031549.2272=
658-1-derekjohn.clark@gmail.com?part=3D1
