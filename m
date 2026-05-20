Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B3F3290A6
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 03:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779249532; cv=none; b=ODGqspfBuQWw4V/69X1Kl0TsD5Pf9541JLzeQjUqm3AvSYacA1V4II+5VMm0LthyHHHmCdgzICA4H4U6jVrYYUMxVHKFYsXPgJf2Cqn9XEslb+3RlZiQUJi/6ubH20ymlF1hQD2pLo+wHU5EO1wYbqTL0BO0CTxE5MeJQc8Zu80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779249532; c=relaxed/simple;
	bh=q+2WsEb0184Pq5hwPDRixUGuBJs3xywFYmHCM+CqfKo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sMTtDk+R1uNO2bcbxx6nBVJ6Rf8MHIxYwtJMsUnfk9hnwBVGacOpFiTQYwjhqPbW7xSm/NemYsl/SkXNor6CqtB+P7DQ6QmRyUhkwQxx8I2HoSuxnWwpZ65SUaVC1ckMnEqdgyvLHKNS5z8ARb9G4GtVAWl/kIpgYtE3IwG+cSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZslzXz43; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZslzXz43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3B41F000E9;
	Wed, 20 May 2026 03:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779249527;
	bh=qrNdHWzilLw27tw0x3O8MTZYAcy20MYvmwVhiAWpFqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZslzXz43sfyark7UbYDIB1XzANBSBUWOR0rEIy9GZwrzzzHwKtuoB4fUnw4xLmzQK
	 3wC2XQYRc2LUkWhxJva35NUvc7NGxPU8k/Z4dFLNKwBG10mZDU2AvqDcXOhiyROmC9
	 n5frK0XLWcjTc8xHOZxkOU6JT6FFK/4oaaVILXjjVFhbQGxPNxlMfHdU80kr7YsW1S
	 04j9wmd7vrt2p9Kzu8GUlEAwVxOxCqhyR9UJp3ETSKNeD+hbBZ9QRz9kdlSRsLDKqJ
	 j70XK13iNhvguI/iZkgVtMPe9Y/vOe+xRAjOf6xZQm1z6BvPq3FVQcyKDu5ldIk1lV
	 j8DUt68SM2M7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/4] HID: hid-msi: Add Rumble Intensity Attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260520013158.3633277-5-derekjohn.clark@gmail.com>
References: <20260520013158.3633277-5-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 03:58:46 +0000
Message-Id: <20260520035847.2A3B41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of sysfs attributes can lead to premature com=
mand completion and stale reads because untracked generic ACKs from zero-ti=
meout commands hijack pending wait completions.
- [High] A race condition during module removal can lead to a Use-After-Fre=
e of `drvdata` due to improper teardown ordering of the `rgb_queue` delayed=
 work.
--

commit efccc9e9df435fd90fd3e39aab88962809dcbfde
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add Rumble Intensity Attributes

Adds intensity adjustment for the left and right rumble motors.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 61917902e38d3..4adc5588618df 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> @@ -919,6 +951,154 @@ static ssize_t button_mapping_options_show(struct d=
evice *dev,
>  }
>  static DEVICE_ATTR_RO(button_mapping_options);
> =20
> +static ssize_t rumble_intensity_left_store(struct device *dev,
> +					   struct device_attribute *attr,
> +					   const char *buf, size_t count)
> +{

[ ... ]

> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DAT=
A,
> +				    (u8 *)&report, sizeof(report), 25);
> +	if (ret)
> +		return ret;
> +
> +	/* MCU will not send ACK until the USB transaction completes. ACK is se=
nt
> +	 * immediately after and will hit the stale state machine, before the n=
ext
> +	 * command re-arms the state machine. Timeout 0 ensures no deadlock wai=
ting
> +	 * for ACK that ill never come.
> +	 */
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NULL=
, 0, 0);

[Severity: High]
This is a pre-existing issue, but using timeout 0 here appears to leave an
untracked generic ACK in the hardware pipeline.

If another thread concurrently triggers a hardware command (like a sysfs
show/store) that waits for an ACK, could the claw_raw_event() handler
unconditionally consume this delayed generic ACK to complete the new
command's wait?

Since the generic ACK handler doesn't verify drvdata->waiting_cmd, this
might cause the new command to return prematurely before its actual data
arrives, leading to stale sysfs reads or dropped configuration writes.

> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}

[ ... ]

> @@ -1557,6 +1748,7 @@ static int claw_probe(struct hid_device *hdev, u8 e=
p)
>  	spin_lock_init(&drvdata->mode_lock);
>  	spin_lock_init(&drvdata->profile_lock);
>  	spin_lock_init(&drvdata->frame_lock);
> +	spin_lock_init(&drvdata->rumble_lock);
>  	init_completion(&drvdata->send_cmd_complete);
>  	INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
>  	INIT_DELAYED_WORK(&drvdata->cfg_setup, &cfg_setup_fn);

[Severity: High]
This is a pre-existing issue not introduced by this patch, but while
reviewing the driver's workqueue lifecycle, I noticed a potential race
condition during module removal.

In claw_remove(), if cancel_delayed_work_sync(&drvdata->rgb_queue) is called
before setting drvdata->rgb_registered to false, could a concurrent sysfs
write to the LED brightness file cause a use-after-free?

Since the LED class device is managed via devres, it remains accessible. A
write could invoke claw_led_brightness_set(), check that rgb_registered is
still true, and re-arm the delayed work timer after it was cancelled. When
devres later frees drvdata, the timer would fire and access freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520013158.3633=
277-1-derekjohn.clark@gmail.com?part=3D4
