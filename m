Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F52F3A9627
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 01:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786066656; cv=none; b=iO98vq4OfWvTZofm1ZLfzsvM/IUT782J2waLswEEhUiP9jvnZJbeWROF0+n7eORIbduBrVB60bARfG+QdQB7ubKmfdAtC2Aj+kMeykuVuenAmrxSBnAdSnocyZGQwfC5HY8sd1UFFJCDoliwN1yHgQbllss3OhFktdiQLvFg19s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786066656; c=relaxed/simple;
	bh=JmdJ2uS7Eho6htRpFImU2homHTeul4klGD0v2lLO+iY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PKArh5QZ0fuK/ARe2MApRkFls6DSqK5uF3UhB/NAOJW9r82vQjwKBGf2x11yEMXCTv7AQprmSEHQPN/l8OAbUsNZ9LnE7YPBVxRKw4IhZNkuUfM7pOFd4y/8aD5LJzM5E2qudCh7/FSkUc3Vm5Mu9g6691uT+nL/pici+TohpEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRFWjtsA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRFWjtsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD99A1F00ACA;
	Fri,  7 Aug 2026 01:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786066644;
	bh=at12G86QqXd6hutjMzC+5HWgT3ZSfONWyDntq53kusI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PRFWjtsASmMxVY8lZaFjFoimJ/zeDzlV2ojeGK5i4wNU/92BuseRWdFssOhaJkuu4
	 LGSXNgQoqjWf/ilWTRO31vrYTU0aRyPQEhaq7M0WPDucuGmb991hqcCu47Xn7Wd3XY
	 k6703ajJwFO81rDIkkJy+JtnYEc9g+mR7SfZLvkjGrsD8tHDMRfMP+9Z2Z/xEtEaw3
	 Tkd04I8+j607XlCfN6w2hLBROoSeP/MwgvAlVGg8zxX86kCdTjdwVG0yctkR0obL8G
	 CTDF89gso2YFNcBJW/ok3vqGzHJAeMjuHdHWeSAxKlFnSYlRRUTuxenMhnjUOGgKh7
	 quV5mi8I5RErw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] HID: flydigi: add support for vader 5 pro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260807012334.58737-2-denis.benato@linux.dev>
References: <20260807012334.58737-1-denis.benato@linux.dev>
 <20260807012334.58737-2-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 01:37:23 +0000
Message-Id: <20260807013723.DD99A1F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Unconditional scheduling of `rumble_work` in `flydigi_gamepad_clos=
e()` leads to a Use-After-Free during `devm` teardown.
- [High] Early HID reports cause a NULL pointer dereference because `fd->ga=
mepad` is accessed before it is initialized.
- [High] The HID `raw_event` handler attempts to acquire a mutex and perfor=
m synchronous USB control transfers from an interrupt context, triggering a=
 system panic.
- [High] The `output_buf` array is embedded in `struct flydigi_device` with=
out cache-line alignment, violating DMA API requirements.
- [High] Incoming HID raw events can reschedule `acquire_work` after it has=
 been explicitly canceled in `flydigi_remove()`, leading to a Use-After-Fre=
e.
- [Low] Canceling `acquire_work` before setting `gamepad_open` to false lea=
ks an armed timer.
- [Low] Negating a signed 16-bit sensor axis value can produce an integer t=
hat exceeds the configured `ABS` maximum.
--

--- Patch [1]: [PATCH 1/2] HID: flydigi: add support for vader 5 pro ---
commit 01b1533a1ac56f03f32a4b26cb0c7795d18213a6
Author: Denis Benato <denis.benato@linux.dev>

HID: flydigi: add support for vader 5 pro

The Flydigi Vader Pro 5 is a gamepad with additional buttons
and a gyroscope that is connected wireless to a PC via its
own dongle so it's always a USB device: add support for it
by following the enstablished pattern of spawning two evdevs
that share the same uniqid so that SDL can match the two and
expose them as a single controller.

> diff --git a/drivers/hid/hid-flydigi.c b/drivers/hid/hid-flydigi.c
> new file mode 100644
> index 0000000000000..48129f429f3c2
> --- /dev/null
> +++ b/drivers/hid/hid-flydigi.c

[ ... ]

> +struct flydigi_device {
> +	struct hid_device *hdev;
> +	struct input_dev *gamepad;
> +	struct input_dev *sensors;
> +
> +	struct mutex output_mutex;
> +	spinlock_t lock;
> +	u8 output_buf[FLYDIGI_REPORT_SIZE];
> +	u8 output_report_id;

[Severity: High]
Is this embedded DMA buffer cache-line aligned?

On architectures that are not hardware cache-coherent, passing an unaligned
embedded buffer to the USB subsystem for DMA can cause memory corruption on
adjacent fields (like output_report_id or lock).

[ ... ]

> +static void flydigi_gamepad_close(struct input_dev *dev)
> +{
> +	struct flydigi_device *fd =3D input_get_drvdata(dev);
> +
> +	cancel_delayed_work_sync(&fd->acquire_work);

[Severity: Low]
Is it possible for the worker to re-arm itself here?

If the worker is running when cancel_delayed_work_sync() is called, it waits
for the worker to finish. However, because gamepad_open is still true at th=
is
point, the worker could evaluate the flag as true and call
schedule_delayed_work(), leaking an armed timer after the device is closed.

> +
> +	{
> +		guard(spinlock_irqsave)(&fd->lock);
> +
> +		fd->gamepad_open =3D false;
> +		fd->strong =3D 0;
> +		fd->weak =3D 0;
> +	}
> +
> +	schedule_work(&fd->rumble_work);
> +}

[Severity: High]
Does this unconditionally schedule the work item during teardown?

Because the input device is allocated with devm_input_allocate_device(), the
device is automatically unregistered by devres after flydigi_remove() retur=
ns.
The input core will call this close() callback during that unregistration if
the device was open.

Since this schedules the work right as devres is freeing the fd structure,
can this lead to a Use-After-Free when the worker thread executes?

[ ... ]

> +static void flydigi_report_gamepad(struct flydigi_device *fd, const u8 *=
data)
> +{
> +	struct input_dev *gamepad =3D fd->gamepad;
> +	s16 axis;
> +	int hat_x;
> +	int hat_y;
> +
> +	flydigi_map_hat(data[FLYDIGI_OFF_DPAD_ABXY], &hat_x, &hat_y);
> +	input_report_abs(gamepad, ABS_HAT0X, hat_x);

[Severity: High]
Can gamepad be NULL here?

In flydigi_probe(), hid_hw_open() is called before flydigi_register_gamepad=
().
Calling hid_hw_open() starts the hardware polling, allowing an early
FLYDIGI_CMD_INPUT event to trigger flydigi_raw_event() and subsequently
flydigi_report_gamepad().

Since fd->gamepad is assigned only at the end of flydigi_register_gamepad(),
will this early hardware polling cause a NULL pointer dereference here?

[ ... ]

> +static void flydigi_report_sensors(struct flydigi_device *fd, const u8 *=
data)
> +{
> +	struct input_dev *sensors =3D fd->sensors;
> +
> +	if (!sensors)
> +		return;
> +
> +	input_event(sensors, EV_MSC, MSC_TIMESTAMP,
> +		    ktime_to_us(ktime_get_boottime()));
> +
> +	/* Accelerometer */
> +	input_report_abs(sensors, ABS_X,
> +			 (s16)get_unaligned_le16(&data[FLYDIGI_OFF_ACCEL_X]));
> +	input_report_abs(sensors, ABS_Y,
> +			 (s16)get_unaligned_le16(&data[FLYDIGI_OFF_ACCEL_Y]));
> +	input_report_abs(sensors, ABS_Z,
> +			 -(s16)get_unaligned_le16(&data[FLYDIGI_OFF_ACCEL_Z]));

[Severity: Low]
Can this negation produce an out-of-bounds value?

If the raw 16-bit sensor value is exactly -32768, casting it to s16 and
negating it will yield 32768 due to C integer promotion rules, which exceeds
the declared ABS maximum of 32767.

[ ... ]

> +static int flydigi_raw_event(struct hid_device *hdev, struct hid_report =
*report,
> +			     u8 *data, int size)
> +{
> +	struct flydigi_device *fd =3D hid_get_drvdata(hdev);
> +	const u8 *payload =3D data;

[ ... ]

> +	switch (payload[2]) {
> +	case FLYDIGI_CMD_INPUT:
> +		flydigi_report_gamepad(fd, payload);
> +		flydigi_report_sensors(fd, payload);
> +		break;
> +	case FLYDIGI_CMD_INFO:
> +	case FLYDIGI_CMD_STATUS:
> +	case FLYDIGI_CMD_ACQUIRE:
> +	case FLYDIGI_CMD_HAPTIC:
> +		/* Expected replies/acks to commands sent by this driver. */
> +		break;
> +	case FLYDIGI_CMD_STATUS_UPDATE:
> +		flydigi_send_status_request(fd);

[Severity: High]
Can this execute a sleeping USB control transfer in an atomic context?

This function is called from an URB completion handler, but
flydigi_send_status_request() eventually calls flydigi_send_output() which
acquires a blocking mutex and calls hid_hw_raw_request(). Does this cause
a scheduling while atomic panic?

> +		schedule_delayed_work(&fd->acquire_work, 0);

[Severity: High]
Does this re-arm acquire_work during device removal?

In flydigi_remove(), cancel_delayed_work_sync(&fd->acquire_work) is called
before hid_hw_stop(). If the hardware sends a FLYDIGI_CMD_STATUS_UPDATE
packet in this small window, this will unconditionally re-schedule the work.

If the gamepad was not open, can this leave the work queued after fd is
freed, resulting in a Use-After-Free?

> +		break;
> +	default:
> +		hid_dbg(hdev, "unhandled command: cmd=3D%02x sz=3D%d\n",
> +			payload[2], len);
> +		break;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807012334.5873=
7-1-denis.benato@linux.dev?part=3D1
