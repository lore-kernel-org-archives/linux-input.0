Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80E83B6362
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044047; cv=none; b=b7888bFyK1XcpSuAoGs05Bt6XsBbQRcUldS4gK2/njvLM6Ma4jXXjagIlxqoSPnHrxlcx9VvYfSvP6nv2Ch5LrbtBJM+7shnWZOG2Uij7eFl6bv4RcatADMsXpfmGTdBC5U8EW/KtVmdIHu+M3UcPx9muqqZMzcNqlxw+49uWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044047; c=relaxed/simple;
	bh=QaPSwRx+GJvLD3IMqyO8ooFs53PoUWAn+3/9tukvVa4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OPOsjUG7I2HX5fpUDkBWbK/0v+AgZf8nuFQJVTjby1wwYoi15mwWDVCy1AvtcaMQ3liABXNNQfFTIK95vXBneMCYrUeyh+2Lk/ShVTYlsCiwq5P4eNdfvVaCLFwQG58m9IFd4YY+8iC6D8m5ALuPsHhLxNdG0R/vOVm7qYHuo/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQEJjleR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQEJjleR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF051F00898;
	Fri, 29 May 2026 08:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780044044;
	bh=59Hqa/WQ47yQpT9UEtLPX5ddYLZAlZKKBGDyYH7oPoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BQEJjleRgQvUsbPJA+qL60ISQGxFlgTtM1qWTclEoSWrTI3zG4c0motJVavQ8WOkj
	 IV1GMfuLf5TTkmIWja3XRxnefidYXQggWf9ay3py9XB3kKgroob+wHJrhnfPwWYo69
	 y8B6r6t0Pkq0onyZazSLrLudMajH/hw5miRKEdlYue3+7hAXjldqw+FVcXUYQp4vI5
	 lR9IMvDtpLujJUJxDAeskNtMy43/146bmtK7ptwYRq7y1p3Rca86Z7WADxRzXgH5KO
	 0zDI+CO0WzWJ0XYzo5B4eTKYq/F5E7wA0afYj5Qd6qxjp4MMwonBM7pqlq/EU0UrXx
	 RdsS3n7L5VCew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/4] HID: hid-msi: Add M-key mapping attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260529072111.7565-3-derekjohn.clark@gmail.com>
References: <20260529072111.7565-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 08:40:43 +0000
Message-Id: <20260529084043.DCF051F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Timeout of READ_PROFILE commands leaves profile_pending dirty and =
falsely aborts subsequent requests due to unhandled stale ACKs.
- [High] Abandoning the ACK for CLAW_COMMAND_TYPE_SYNC_TO_ROM leaves a stal=
e ACK in the USB input queue, falsely completing subsequent commands.
- [High] Unsafe spinlock acquisition without disabling interrupts in HID ra=
w_event callback causes deadlocks.
--

commit ae4697cc229899bfbbf1b0ea18f1f026bc1b15e7
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add M-key mapping attributes

This commit adds attributes to allow remapping the M-keys with up to 5 valu=
es
when the device is in macro mode. When mapped, these events can fire from
the xpad device or the evdev interfaces provided by the input core.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 3a176f44f2c43..f099d6cb7ea8d 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> @@ -137,6 +321,39 @@ static int claw_gamepad_mode_event(struct claw_drvda=
ta *drvdata,
>  	return 0;
>  }
> =20
> +static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_=
command_report *cmd_rep)
> +{
> +	enum claw_profile_ack_pending profile;
> +	struct claw_mkey_report *mkeys;
> +	u8 *codes, key;
> +	int i;
> +
> +	scoped_guard(spinlock, &drvdata->profile_lock)
                     ^^^^^^^^

[Severity: High]
Could this cause a deadlock?

HID raw_event callbacks can be invoked from process context with IRQs
enabled (e.g., when input is simulated via the uhid character device).

If an actual hardware interrupt (such as a USB URB completion) occurs on
the same CPU while the lock is held in process context, the interrupt handl=
er
will invoke raw_event and attempt to reacquire profile_lock, resulting
in a deadlock.

Should this use spinlock_irqsave instead?

> +		profile =3D drvdata->profile_pending;
> +
> +	switch (profile) {
> +	case CLAW_M1_PENDING:

[ ... ]

> +		dev_dbg(&drvdata->hdev->dev,
> +			"Got profile event without changes pending from command: %x\n",
> +			cmd_rep->cmd);
> +		return -EINVAL;
> +	}
> +	scoped_guard(spinlock, &drvdata->profile_lock)
                     ^^^^^^^^

[Severity: High]
Same question here, could this deadlock if interrupted by a hardware
interrupt on the same CPU?

> +		drvdata->profile_pending =3D CLAW_NO_PENDING;
> +
> +	return 0;
> +}

[ ... ]

> +static int claw_mkey_store(struct device *dev, const char *buf, u8 mkey)
> +{

[ ... ]

> +set_buttons:
> +	scoped_guard(mutex, &drvdata->rom_mutex) {
> +		ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DA=
TA,
> +					    (u8 *)&report, sizeof(report), 25);
> +		if (ret)
> +			return ret;
> +		/* MCU will not send ACK until the USB transaction completes. ACK is s=
ent
> +		 * immediately after and will hit the stale state machine, before the =
next
> +		 * command re-arms the state machine. Timeout 0 ensures no deadlock wa=
iting
> +		 * for ACK that ill never come.
> +		 */
> +		ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NUL=
L, 0, 0);

[Severity: High]
If the ACK for CLAW_COMMAND_TYPE_SYNC_TO_ROM is abandoned, could it leave a
stale ACK in the USB input queue?

If userspace rapidly writes to the sysfs attributes (e.g., configuring
button_m1 then button_m2), the second write would acquire rom_mutex, send
WRITE_PROFILE_DATA, and set waiting_for_ack =3D true.

When the late ACK from the preceding SYNC_TO_ROM command arrives,
claw_raw_event() might process it as a generic CLAW_COMMAND_TYPE_ACK and
prematurely complete the wait for the new WRITE_PROFILE_DATA command.

The driver might then immediately send the next SYNC_TO_ROM while the MCU
may still be processing the profile data, potentially leading to dropped
configurations or MCU instability.

> +	}
> +
> +	return ret;
> +}

[ ... ]

> +static int claw_mkey_show(struct device *dev, char *buf, enum claw_key_i=
ndex m_key)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);

[ ... ]

> +	guard(mutex)(&drvdata->profile_mutex);
> +	scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
> +		drvdata->profile_pending =3D (m_key =3D=3D CLAW_KEY_M1) ? CLAW_M1_PEND=
ING
> +								  : CLAW_M2_PENDING;
> +
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFILE,
> +				    (u8 *)&report, sizeof(report), 25);
> +	if (ret)
> +		return ret;

[Severity: High]
If claw_hw_output_report() times out, could this leave profile_pending
dirty?

If it returns early without resetting drvdata->profile_pending to
CLAW_NO_PENDING, and another process subsequently invokes claw_mkey_show()
for a different key, it would overwrite profile_pending and begin waiting
for a new ACK.

If the late ACK from the initial timed-out request arrives during this
window, claw_profile_event() processes it, detects an address mismatch
(since it evaluates against the new profile_pending state), and returns
-EINVAL.

claw_raw_event() would then blindly propagate this error to cmd_status and
call complete(), falsely aborting the valid, ongoing read.

> +
> +	for (i =3D 0; i < CLAW_KEYS_MAX; i++) {
> +		name =3D mkey_mapping_code_to_name(codes[i]);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529072111.7565=
-1-derekjohn.clark@gmail.com?part=3D2
