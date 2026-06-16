Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D693CF050
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 05:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587207; cv=none; b=qwTKogQzXaWwMlxFYBOXpVpeGTT4PWjJV90wLsDVpKoLnxKbJMARsrKNUcJ7KTqXC3g1/1GzvtiD8jpWRkjNwLnMLZ78Fzm2w4bK+9WkohkMsO2bTN7neKyl9Lr291hGgKThAIZMqaDjJT0eZhMw9rkdqdB0uLXghUCus6Cavp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587207; c=relaxed/simple;
	bh=XDxdN+UfF96wiPjltLWnLrlEpfkwgCHnorpq2dlKDNk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pzr8z9dm98e6EHsxdd4Y8iFpVOYGpZb5H9JjmJNraURiOT0SUnHAclD196MIhI0ur4OpjMRAUbi7Tji274h6Tnb508yPp6R2p+5OtinXPVFHOtlKd7ibdQt8oAvtQgLER2BCBQZc0hky/WCgxAZt1GCW4GziA/Frrr2fNd1Jxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uxy/uogo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uxy/uogo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439B31F000E9;
	Tue, 16 Jun 2026 05:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781587206;
	bh=8svkxE95neSdJq3BYbQdEt2nVW9wrnPwud+w9Y50ja0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uxy/uogoJfzLcYEkSvDAY/F9j0ZLO9eR1weR1v0weA/37pqQuXgyaphNQMDwpwbwu
	 5uJnkwdoRDmsd5EAxV6yiG0aZIFD/JX/mtIzzKrdjtnlZ0qHZ5GFqG780OBlYIGN9/
	 hgsxRe6GlKaYXfJOeW2Wb542l93wYF/QlpmxGrAv9W7weuBTBEWoV0mynlCoMlRDPE
	 XiRlv+pMGZ2p58ClbBRb8PXkh8Znffeu++jLQ3uh584JfHooCbOCFX7f3yu0oOGkBi
	 no+5D7aK4k0RSOrQm9UNVqoqixZ6TC2FduIQ6+jFB63ae5RMEMULodGtKXoJQjmKuX
	 cnkpiq4uim7dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] Input: mms114 - replace udelay with usleep_range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260616050912.1531241-4-dmitry.torokhov@gmail.com>
References: <20260616050912.1531241-4-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 05:20:05 +0000
Message-Id: <20260616052006.439B31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition in `mms114_suspend` releases touches before disabli=
ng the hardware IRQ, potentially leaving touches stuck active.
- [High] Failure in `mms114_resume()` leads to unbalanced `disable_irq()` a=
nd `regulator_disable()`, causing kernel warnings and state corruption.
- [High] Copy-paste error in `mms114_setup_regs` writes the X resolution to=
 the Y resolution register, breaking touchscreen coordinates mapping.
- [High] Hardware data bytes are read directly into a struct containing C b=
itfields, leading to endian-dependent memory layout corruption.
--

commit 4b0151507f5071f8f96d0af3ccffe9ae30a17c92
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: mms114 - replace udelay with usleep_range

The driver currently uses udelay(MMS114_I2C_DELAY) (50us) to ensure a
mandatory delay between I2C transfers in __mms114_read_reg() and
mms114_write_reg().

Both functions invoke underlying I2C core operations (i2c_transfer,
i2c_master_send) which acquire mutexes and sleep. Furthermore, the
interrupt handler mms114_interrupt() is registered as a threaded IRQ
handler. Since the entire execution path is fully sleepable,
busy-waiting with udelay() for 50us unnecessarily wastes CPU cycles.

Replace udelay() with usleep_range() to allow the CPU to enter low-power
states or execute other tasks during the delay.

> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscre=
en/mms114.c
> index c2e006ac11960..c59aec8f2febe 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
> @@ -116,7 +116,7 @@ static int __mms114_read_reg(struct mms114_data *data=
, u8 reg,
>  			"%s: i2c transfer failed (%d)\n", __func__, error);
>  		return error < 0 ? error : -EIO;
>  	}
> -	udelay(MMS114_I2C_DELAY);
> +	usleep_range(MMS114_I2C_DELAY, MMS114_I2C_DELAY + 50);
> =20
>  	return 0;
>  }

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed a potential race condition in t=
he
suspend path.

drivers/input/touchscreen/mms114.c:mms114_suspend() {
...
	/* Release all touch */
	for (id =3D 0; id < MMS114_MAX_TOUCH; id++) {
		input_mt_slot(input_dev, id);
		input_mt_report_slot_inactive(input_dev);
	}

	input_mt_report_pointer_emulation(input_dev, true);
	input_sync(input_dev);

	guard(mutex)(&input_dev->mutex);

	if (input_device_enabled(input_dev))
		mms114_stop(data);
...
}

Because mms114_stop() disables the hardware IRQ after input_sync() has repo=
rted
the release events, is it possible for a hardware interrupt to fire between
the synthetic release and the actual IRQ disable?

Since the interrupt handler runs as a concurrent kernel thread and does not
share a lock with this early part of the suspend path, the touch could be
reported as active again right before the system sleeps. Would this leave t=
he
touch stuck active indefinitely upon resume?

[Severity: High]
This isn't a bug introduced by this patch, but the resume error handling
might lead to unbalanced resource disabling.

drivers/input/touchscreen/mms114.c:mms114_resume() {
...
	if (input_device_enabled(input_dev)) {
		error =3D mms114_start(data);
		if (error)
			return error;
	}
...
}

If mms114_start() fails (e.g. due to I2C communication failure), it disables
the regulators and returns an error without enabling the IRQ. However, the
input device remains logically open.

If userspace subsequently closes the device, or another suspend cycle occur=
s,
mms114_stop() will be called unconditionally:

drivers/input/touchscreen/mms114.c:mms114_stop() {
...
	disable_irq(client->irq);

	error =3D regulator_disable(data->io_reg);
...
}

Will this unconditionally call disable_irq() and regulator_disable() on
resources that are already disabled, triggering warnings and corrupting
regulator reference counts?

[Severity: High]
This is a pre-existing issue, but I spotted a potential copy-paste error
during resolution configuration.

drivers/input/touchscreen/mms114.c:mms114_setup_regs() {
...
	val =3D props->max_x & 0xff;
	error =3D mms114_write_reg(data, MMS114_X_RESOLUTION, val);
	if (error < 0)
		return error;

	val =3D props->max_x & 0xff;
	error =3D mms114_write_reg(data, MMS114_Y_RESOLUTION, val);
...
}

Should the second register write use props->max_y instead of props->max_x?

Writing the X resolution to MMS114_Y_RESOLUTION might truncate the hardware=
's
internal Y resolution, breaking touch tracking and coordinate mapping on the
Y axis for screens where the dimensions differ.

[Severity: High]
This isn't a bug introduced by this patch, but there might be an endianness
problem with the touch data structure.

drivers/input/touchscreen/mms114.c:
...
struct mms114_touch {
	u8 id:4, reserved_bit4:1, type:2, pressed:1;
	u8 x_hi:4, y_hi:4;
	u8 x_lo;
	u8 y_lo;
	u8 width;
	u8 strength;
	u8 reserved[2];
} __packed;
...

This struct is used to map raw byte stream data from the I2C hardware. Since
the memory layout of C bitfields is compiler and endian-dependent, will the=
se
bitfields be reversed on big-endian architectures?

This could result in incorrect parsing of touch coordinates, IDs, and event
types.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616050912.1531=
241-1-dmitry.torokhov@gmail.com?part=3D4
