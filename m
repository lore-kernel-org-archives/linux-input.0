Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55CE2765E2
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 21:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435498; cv=none; b=lQ/mc6HVjKu6C5dxWVvtZMYHLxko5v3g/wvuHRIyPUkeM48/f/Hp+yes85D8AEJwhn4ZpE+RPUDP1lz1MadqlGbBZre1aE22I692wON0SLQ29aPWxj12wDEVir2WhK9IER4573c43Nap1uWOXT/tRJOsS7XmZThXy3xyPYOFwZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435498; c=relaxed/simple;
	bh=Ed2Yn+u8VgeFp4DFyDaYGdNNkkhDd+9lmMAkjFk2oAA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K3b0UspF/lO/msw9npidVFcMvaBsmgsUXZcLWt0DJSFlxIAkJm5dy3z+fsBvjbT0fT2VSw2OUzKKacXK//7we4SN6hUPb7iaW5gqUslMo7NwMrKKLEtTmHUrr+OcNJ6Lkcy5ebJkwc+Gdbq0N/BdW02+38rUFfyi3UAnomYTEtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIiqY7eZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIiqY7eZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51EB1F000E9;
	Sat, 22 Aug 2026 21:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787435495;
	bh=4b3tItlC9vZO8eyeo9NUkHPbrELzEkV6h5I6r0w0nOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NIiqY7eZT/GF7yBPhaHeIjetUDU87QI5G/CbmgFmHQ1PPB4j/kqaPt5n84Jv5HqC4
	 ahMRgyxcLvqYK4oPkEpI+OfWV+ufU0e+KazsUtZjrVprRCqx/akOnY3D9abtiO430V
	 vbqTJhGF7KFgjWbFH/fDQ+O3KZiHuOmFYagb9Y7JHTBywkUl0vTlS9NUJPRXVGt/0/
	 FuH0N/au4LHtJDigy/Jy0XulrJzXHVrjdC6LlPNCO/7NnKcSoWqo5I4sesTha5Zr5p
	 zy7lxjMZPKwTZw43lR4bMTK+ewnh9QhI2tGc5E+siG4w2YMDN9fXJWmc06dDmr1V2U
	 FiB38fzMjQD5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/13] HID: ft260: i2c: reduce driver module loading
 time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260822213941.98882-5-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
 <20260822213941.98882-5-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 21:51:34 +0000
Message-Id: <20260822215134.D51EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] The dynamic I2C read timeout incorrectly applies a 25ms timeout fo=
r last-chunk reads up to 180 bytes, causing spurious timeouts for chunks > =
60 bytes.
- [High] Delayed USB HID reports from prematurely timed-out I2C transaction=
s corrupt subsequent I2C transfers.

Pre-existing issues:
- [Critical] Double free of `dev` on UART probe error path.
- [High] The driver frees its private data before stopping hardware I/O, al=
lowing asynchronous incoming HID reports to cause a use-after-free.
- [High] Race condition in teardown sequence of wakeup timer and workqueue =
leads to Use-After-Free on device unplug.
- [High] A malicious USB device can cause a divide-by-zero kernel panic by =
reporting a 0 Hz clock.
--

--- Patch [4]: [PATCH 04/13] HID: ft260: i2c: reduce driver module loading =
time ---
commit ce4834500e105e8a3ed2770b588049de28ffe3cf
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: i2c: reduce driver module loading time

The commit adjusts the I2C read timeout to depend on the amount of data
being read. This is intended to reduce the module loading time significantl=
y,
lowering the lm75 address range scan time to about 200ms.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index cc3b8f5791dea..4435a39fce239 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
[ ... ]
> @@ -732,10 +739,12 @@ static int ft260_i2c_read(struct ft260_device *dev,=
 u8 addr, u8 *data,
>  		flag =3D 0;	/* no fresh START - continue current transaction */
>  	do {
>  		if (len <=3D rd_data_max) {
> +			timeout =3D FT260_RD_ONE_REPORT_TO;

[Severity: High]
Does this logic aggressively override the timeout to 25ms for the final
chunk of any transfer, even if that chunk is 180 bytes long?

If an I2C read request is made where the final chunk is between 61 and 180
bytes (e.g., a 240-byte read), the condition if (len <=3D rd_data_max)
correctly matches the final chunk, but erroneously assigns it the
FT260_RD_ONE_REPORT_TO (25ms) timeout instead of the required 75ms.

As noted in the commit message, a 180-byte chunk physically requires about
27ms of wire time at 60kHz. A 25ms timeout is guaranteed to expire before t=
he
hardware finishes, which could lead to a deterministic failure (-ETIMEDOUT)
on any I2C read larger than 60 bytes.

>  			rd_len =3D len;
>  			if (want_stop)
>  				flag |=3D FT260_FLAG_STOP;
>  		} else {
> +			timeout =3D FT260_RD_MULTI_REPORT_TO;
>  			rd_len =3D rd_data_max;
>  		}
>  		rd_data_max =3D FT260_RD_DATA_MAX;
[ ... ]
> @@ -762,8 +771,8 @@ static int ft260_i2c_read(struct ft260_device *dev, u=
8 addr, u8 *data,
>  			goto ft260_i2c_read_exit;
>  		}
> =20
> -		timeout =3D msecs_to_jiffies(5000);
> -		if (!wait_for_completion_timeout(&dev->wait, timeout)) {
> +		timeout_jiffies =3D msecs_to_jiffies(timeout);
> +		if (!wait_for_completion_timeout(&dev->wait, timeout_jiffies)) {

[Severity: High]
Will the drastic reduction of the timeout bounds without a concurrent
mechanism to purge the HID input queue or use sequence numbers expose the
driver to data corruption?

If a premature timeout occurs in ft260_i2c_read() due to the reduced bounds,
it causes the function to clear dev->read_buf and return. However, the USB
host controller may still receive the delayed response.

When a subsequent I2C read starts, it repopulates dev->read_buf. Since
ft260_raw_event() lacks sequence numbers, could it blindly copy the stale
delayed USB report into the new buffer and call complete(), allowing the new
transaction to complete with invalid data?

>  			ret =3D -ETIMEDOUT;
>  			ft260_i2c_reset(hdev);
>  			goto ft260_i2c_read_exit;

[Severity: High]
This isn't a bug introduced by this patch, but does the driver free its
private data before stopping hardware I/O, allowing asynchronous incoming H=
ID
reports to cause a use-after-free?

In ft260_remove():

	} else {
		// ...
		kfree(dev);
	}

	hid_hw_close(hdev);
	hid_hw_stop(hdev);

During device unplug, the driver unconditionally frees its private dev
structure before calling hid_hw_stop(hdev). Because the hardware and the USB
interrupt IN endpoint remain active until hid_hw_stop() is called, an
incoming HID report during this window will be dispatched to
ft260_raw_event(), which will attempt to acquire dev->read_lock on the
already freed dev memory.

[Severity: Critical]
This isn't a bug introduced by this patch, but is there a double free of dev
on the UART probe error path?

In ft260_probe():

hid_fail:
	kfree(dev);
alloc_fail:

If ft260_uart_probe() fails, it jumps to the error path and calls
ft260_uart_port_remove(dev). This triggers tty_port_put(), which drops the
final reference and calls ft260_uart_port_destroy(), explicitly freeing dev
via kfree(port).

The function then returns a failure code to ft260_probe(), which follows its
own error path to hid_fail where it executes kfree(dev) a second time on the
same pointer.

[Severity: High]
This isn't a bug introduced by this patch, but is there a race condition in
the teardown sequence of the wakeup timer and workqueue that leads to a
use-after-free on device unplug?

In ft260_remove():

	cancel_work_sync(&dev->wakeup_work);
	tty_port_unregister_device(&dev->port, ft260_tty_driver, dev->index);
	ft260_uart_port_remove(dev);

The cancel_work_sync() is executed before timer_delete_sync() (called within
ft260_uart_port_remove()), which fails to guarantee the workqueue will rema=
in
empty.

Because the timer can fire between these two calls, ft260_uart_start_wakeup=
()
can erroneously call schedule_work() to re-enqueue the work. Once unbind
completes and dev is freed via the TTY destructor, the pending work executes
and accesses freed memory.

[Severity: High]
This isn't a bug introduced by this patch, but can a malicious USB device
cause a divide-by-zero kernel panic by reporting a 0 Hz clock?

In ft260_hid_output_report_check_status():

	/* transfer time =3D 1 / clock(KHz) * 9 bits * bytes */
	usec =3D len * 9000 / dev->clock;

The unvalidated clock value read from the hardware is used directly as a
divisor. If a malicious or malfunctioning USB device responds to the
FT260_I2C_STATUS feature request in ft260_xfer_status() with a report.clock
value of 0, the driver saves this to dev->clock without validation.
Subsequent calls will divide by dev->clock to calculate delay timings,
immediately crashing the kernel.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822213941.9888=
2-1-michael.zaidman@gmail.com?part=3D4
