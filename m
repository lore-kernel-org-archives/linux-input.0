Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2073655CD;
	Thu,  1 Oct 2026 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859186; cv=none; b=ANCt+t9oQV6M5Qq6SjS2b3n8J5i9RdpENbTHYJky0YkRfIPJJwMFiwRyIQW++UUV5368GANsF61MkRZL6bCnu1obijScmxHDg9/PXk6cT98wrj6NFNOL/ICjYKuezOp4whKfg/ETLFoq6EtdAbGLhdrBnf0RIj9O2qnozGS5OYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859186; c=relaxed/simple;
	bh=MKZglIRW+KpCg0FTYxB6LSBb+cWPkHrRpBHNiXLgbRY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hwm47lwXxPiko/gPE9872MadhvCDaQuk5W25HMAmtfJiMJKsGAZn051NFX6Rpbzyf/c2xBujk40GNo1E3CjyPFZD+vfV2eWXJNe3g6JaMyzFS69OoeWgcULh4bPKgEGhbIsUrD04m/jeKGmm+qjSH1M5z2L7BT4vfgqoOFGZMNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feb/ERcK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feb/ERcK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E001F000FF;
	Thu,  1 Oct 2026 12:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790859184;
	bh=wEdikNaUhfzH4ln9GA5Ebh/DMz1IjUEWakQ+5s9lWMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=feb/ERcK+Rx/y5E4aK7wiB2gVguyv7wxJ69i7Vi6e+coj4wcaYg6aH522G/7xJ8iq
	 0ygAhXVT4oeGi/ou4yO3eeLtBIr8vAwACnBrprSUwYJm9Qo4HZkw3rzkCkno837Iaf
	 OjSKkmQtsQzFGZT0OHAiASzEE7FkxQVsZzcdP+6XR9Rb+WX6LuZmQXY7IEx1V66leo
	 ZxkLacR/MVZnzryZUYMdmHRvT0QYqoq2sOzSIzf7nQ6yt9N5D67D/StJODswGRko4f
	 UpZuCUTgWxqeTrzwI1oWwJTi1n9Mo3OzjjFQZvkcyeeIXCytDwv6ROhGm8InhZyAX8
	 XH/1+TqWshN8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] Input - aw8695: Add driver for AW8695 haptics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Griffin Kroah-Hartman" <griffin.kroah@fairphone.com>
Cc: conor+dt@kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20261001-aw8695_haptic_fp4_driver-v2-2-1bd38b1943de@fairphone.com>
References: <20261001-aw8695_haptic_fp4_driver-v2-0-1bd38b1943de@fairphone.com>
 <20261001-aw8695_haptic_fp4_driver-v2-2-1bd38b1943de@fairphone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:53:03 +0000
Message-Id: <20261001125304.10E001F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] input: aw8695: request IRQ before hardware is initialized
- [Medium] input: aw8695: race between haptic work and device suspend
--

commit e001ac586c0b070dafa130dff509a98526cd1941
Author: Luca Weiss <luca.weiss@fairphone.com>

Input - aw8695: Add driver for AW8695 haptics

Add a driver for interfacing with the Awinic AW8695 LRA Haptic Driver.
The chip supports multiple modes of which only RAM mode is implemented,
allowing playback of a basic sine wave.

> diff --git a/drivers/input/misc/aw8695.c b/drivers/input/misc/aw8695.c
> new file mode 100644
> index 0000000000000..507c3081f3b81
> --- /dev/null
> +++ b/drivers/input/misc/aw8695.c

[ ... ]

> +	err =3D devm_request_threaded_irq(dev, client->irq, NULL, aw8695_irq,
> +		IRQF_ONESHOT, NULL, haptics);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to request interrupt\n");
> +
> +	INIT_WORK(&haptics->play_work, aw8695_haptics_play_work);
> +
> +	haptics->input_dev->name =3D "aw8695";
> +	haptics->input_dev->close =3D aw8695_close;
> +
> +	input_set_drvdata(haptics->input_dev, haptics);
> +	input_set_capability(haptics->input_dev, EV_FF, FF_RUMBLE);
> +
> +	err =3D input_ff_create_memless(haptics->input_dev, NULL,
> +				      aw8695_haptics_play);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to create FF dev\n");
> +
> +	err =3D aw8695_init(haptics);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to init aw8695\n");

[Severity: Medium]
Could this request and enable the interrupt before the hardware is brought =
out
of reset and configured?

If the IRQ line is floating or asserted by the device before reset, the
interrupt could fire immediately. Since the hardware isn't initialized yet,
the unhandled I2C read failures in the interrupt handler might fail to clear
the interrupt, leading to an interrupt storm and the kernel disabling the I=
RQ
line.

Should this be moved after aw8695_init() and aw8695_ram_init() to ensure the
chip is prepared?

[ ... ]

> +static int aw8695_suspend(struct device *dev)
> +{
> +	struct aw8695_data *haptics =3D dev_get_drvdata(dev);
> +
> +	if (haptics->suspend)
> +		return 0;
> +
> +	aw8695_stop(haptics);
> +	haptics->suspend =3D true;
> +	return 0;
> +}

[Severity: Medium]
Could this leave a race condition window open where the background worker c=
an
reactivate the hardware?

If a haptic effect schedules play_work, and the system suspends before the
work completes, they could race:

1. aw8695_haptics_play_work() reads haptics->suspend as false, but is
   preempted.
2. aw8695_suspend() executes, calls aw8695_stop(), sets
   haptics->suspend =3D true, and the underlying I2C adapter suspends.
3. The work thread resumes and calls aw8695_play_sine().

This would perform I2C writes on a suspended bus, potentially leading to bus
errors or timeouts.

Should this call cancel_work_sync(&haptics->play_work) before returning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-aw8695_hap=
tic_fp4_driver-v2-0-1bd38b1943de@fairphone.com?part=3D2
