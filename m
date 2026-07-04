Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196C82F290A
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 06:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145462; cv=none; b=a6osIm5RbUElZ2WtUXLpSDaBeLjMRZyu/O0MA5aAxBc00EzRxJ+RwaCS/BIN/Au1bDVj99L46gppELrS8WEn7/0ZynqVQxeXoHB/MnR5KCdNcH1D3E7EBf99ZYdwGpTg0h52csskxJY2OChZoT3/5md0J0t0F0a2+JMwptc5Kk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145462; c=relaxed/simple;
	bh=cCu9gRSFuwhixroicsCe04CR3Mcy9qJyjdzPkbVnlLM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PClLzlI0l8Uqtn+vl6eNzgbFZ7mAeeZ1YnNNZSeVROP0cgbi+YeZ++Xxs3i4Fs9xH/YopaVeuXS1dxaPgtZnoNhpxfFhpRfopDuNx22bujs2CBAnrmG7HMI5IR4CD1xdozEY6gXf5MHnZXBsJJOHr71j6RfQwdt5HPZmSjVKy1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKsCOEVQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKsCOEVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53381F000E9;
	Sat,  4 Jul 2026 06:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783145461;
	bh=2WIDKTUCZwy5P3ItVsjpFsBMykMo/Uhp6fYrCRceZhA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kKsCOEVQXMxWKYhTORPIFNbcQAonxIDl2Wf+y9+m7jLt4LzAhUGbloDKOk2jMsSyA
	 w46slii0Esij1uxKXjZFegP0y+i1QjD3fTxFnb48Lo6GXqtUgu4b8EmcuphIKLY0gH
	 mHLLqX7dMMdOnQ+RpbQ8cIBUYJjQqXA+dzxW8JdZPHILPZS1sqYzwAnW1+rl0/8oBf
	 qAbxXEGN3d38PSjZo5/9d1EIxhzWCDTfAmnka71oIg41b5LTX03THrceIqZSVjfLlu
	 3T0ufug6h29n1w8hb1J+bXEvXISkIqvwbFOZ0qzraZqw6C8vG2SOXE/QVWh+hhX8rv
	 h5qFcdWpsprcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] Input: mms114 - fix multi-touch slot corruption
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260704060115.353049-1-dmitry.torokhov@gmail.com>
References: <20260704060115.353049-1-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 06:11:00 +0000
Message-Id: <20260704061100.C53381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `mms114_start()` fails during system resume, subsequent device =
close or suspend causes unbalanced `disable_irq()` and `regulator_disable()=
` calls, leaving the touchscreen permanently broken.
- [High] The suspend callback releases all touches before disabling the dev=
ice interrupt, creating a race window where touches can get permanently stu=
ck.
- [High] Stack-allocated buffers are passed directly to I2C transfer functi=
ons, which can cause DMA mapping failures or memory corruption.
--

commit 6a55987ddd51d1330fd1636cd3e72b4d910ea42b
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: mms114 - fix multi-touch slot corruption

This commit fixes a multi-touch slot corruption bug in the mms114 driver.
When the touchscreen controller reports a touch ID of 0, the driver
calculates the slot ID as touch->id - 1, which underflows to UINT_MAX. The
driver fixes this by rejecting touch reports with ID 0.

> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscre=
en/mms114.c
> index 006dded17eb80..23e0283bc6b8b 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
> @@ -248,7 +248,7 @@ static void mms114_process_mt(struct mms114_data *dat=
a, struct mms114_touch *tou
>  	unsigned int x;
>  	unsigned int y;
> =20
> -	if (touch->id > MMS114_MAX_TOUCH) {
> +	if (touch->id =3D=3D 0 || touch->id > MMS114_MAX_TOUCH) {
>  		dev_err(&client->dev, "Wrong touch id (%d)\n", touch->id);
>  		return;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but I have a question about the
error handling in mms114_resume().

If mms114_start() fails (e.g. mms114_setup_regs() returns an error) it clea=
ns
up the regulators but doesn't call enable_irq():

static int mms114_start(struct mms114_data *data)
{
...
	error =3D mms114_setup_regs(data);
	if (error < 0) {
		regulator_disable(data->io_reg);
		regulator_disable(data->core_reg);
		return error;
	}

	enable_irq(client->irq);
	return 0;
}

In mms114_resume(), the error is passed back up but the input device remains
logically open:

static int mms114_resume(struct device *dev)
{
...
	if (input_device_enabled(input_dev)) {
		error =3D mms114_start(data);
		if (error)
			return error;
	}
...
}

Because the input device is still logically enabled, won't a subsequent
suspend or input_close call mms114_stop(), which unconditionally calls
disable_irq() and regulator_disable()? Does this cause an unbalanced IRQ
disable depth that permanently masks the interrupt?

[Severity: High]
This is a pre-existing issue, but I noticed a potential race condition in
mms114_suspend().

The suspend callback releases all active touch slots before stopping the
device and disabling the interrupt:

static int mms114_suspend(struct device *dev)
{
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

If a touch interrupt fires between the synthetic slot release and the call =
to
mms114_stop() (which disables the IRQ), could the physical touches be repor=
ted
as active again just as the device is suspended, leaving the touches
permanently stuck on resume?

[Severity: High]
This isn't a bug introduced by this patch, but there seem to be multiple
places where stack-allocated buffers are used for I2C transfers.

For example, in __mms114_read_reg(), a single byte stack variable is passed:

static int __mms114_read_reg(struct mms114_data *data, u8 reg,
			     unsigned int len, void *val)
{
...
	u8 buf =3D reg;
...
	xfer[0].buf =3D &buf;
...
	error =3D i2c_transfer(client->adapter, xfer, 2);
...
}

Similarly in mms114_write_reg():

static int mms114_write_reg(struct mms114_data *data, u8 reg, u8 val)
{
...
	u8 buf[2];

	buf[0] =3D reg;
	buf[1] =3D val;

	error =3D i2c_master_send(client, buf, 2);
...
}

And in mms114_interrupt():

	struct mms114_touch touch[MMS114_MAX_TOUCH];
...
	error =3D __mms114_read_reg(data, MMS114_INFORMATION, packet_size, touch);
...

Since many I2C controllers use DMA, doesn't passing stack memory to
i2c_transfer() risk DMA mapping failures or memory corruption when
CONFIG_VMAP_STACK is enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704060115.3530=
49-1-dmitry.torokhov@gmail.com?part=3D1
