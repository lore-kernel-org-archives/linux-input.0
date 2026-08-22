Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721B936C0D6
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435776; cv=none; b=rb9RCoGgqT0aSQiEW4Y0A7csglQ42a7V5FLVSwwYzq1iPyv6gmYvNNmOntDuo4A/Ya9T393TSs0R2XtmgrgCPZy3qjuXyUj/HoX26sgQePM+WOqk+Ee9ypS8jwnIOLlP1rsFWbm+aCp1p6qMX6zywjFekx6ZCkeIHNkcHGrLsrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435776; c=relaxed/simple;
	bh=uiwmfQHBJLLp7lBsUu3WO7p5FqAsnH7x4G1dnmrn+WQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VOKbe+aL1A268CCgBdjCn6kCiro1n4dZiKVrOwP5/P6cmc1kt0gzCiJL9qfKhoFGT6urIKAG9zNaY7UflcHORE52+Di1S+bqfWFGPIU/gjmtFmEgvVbkE8tmwZZNFI6Ks7aK6iYArPzOGU0mQQ5KUrf1ciROnBvgoKTPI976A6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpHtyWSa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpHtyWSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8541F000E9;
	Sat, 22 Aug 2026 21:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787435775;
	bh=nLa2GSWZIX6aM25f9b7De/WpXcR3qWgkOx74r+77pBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HpHtyWSaM7xkHeDtvHwUkqt6mV13QrBcLYx1VGEj9k1NYLGYc4BQrZSqqwaqmd1ld
	 v3aBN1y9I8id8B9pWYY15QTn6ycnjZkONKJ3h3+pu40P7w6NBiP6/ezRPVa8dZG/C7
	 1bmip4IAMiPPiA5EM6zJyR6OqjDtOTp0Q5xsKZOzUFYEyos9LVpL28ZF3or8t9rSuQ
	 142JrIKGHaCwsgius5f3Znt4Z5Ngjt59YMCeXyXkCdd2QbTaX1l4fnl2Wy7/Taozrl
	 A5KrRNBGk6mPf/Z4/g/h5QbLNQs/DPrA53dGGzLjZJ0QhrtxD+6+QEr0F1sJHAHrIU
	 cOi8Zw959yyug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/13] HID: ft260: uart: bring-up fixes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260822213941.98882-3-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
 <20260822213941.98882-3-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 21:56:14 +0000
Message-Id: <20260822215615.2D8541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [High] Double free and Use-After-Free of `ft260_device` in the `ft260_uar=
t_probe` error paths.
- [High] Missing synchronous timer cancellation for the wakeup workaround l=
eads to a Use-After-Free in `ft260_remove()`.
- [Medium] The hoisted HID report length check in `ft260_raw_event` incorre=
ctly filters `FT260_UART_INTERRUPT_STATUS` reports, leading to kernel log s=
pam.
- [Medium] The power-saving workaround timer is permanently stopped if the =
baud rate transitions from <=3D 4800 to > 4800.

Pre-existing issues:
- [Critical] Incorrect teardown ordering in `ft260_remove()` frees `dev` be=
fore calling `hid_hw_stop()`, leading to a Use-After-Free if a HID event ar=
rives.
- [High] Premature `kfifo_free()` leads to a NULL pointer dereference on co=
ncurrent TTY writes.
- [High] Lockless use of the shared `port->uart_wr_buf` leads to data corru=
ption on concurrent TTY writes.
- [High] The UART write path incorrectly returns 0 on partial transmission =
failures, causing the TTY layer to duplicate previously sent data.
--

--- Patch [2]: [PATCH 02/13] HID: ft260: uart: bring-up fixes ---
commit b2841c4c6f0b518f0cd8b8780996e8cb92c70332
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: uart: bring-up fixes

Fix the UART path so the serial interface added previously works
reliably in practice. This squashes the contiguous UART bring-up
fixes that followed the initial serial-driver addition.

Link: https://lore.kernel.org/all/20240210215147.77629-1-michael.zaidman@gm=
ail.com/

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 3faedfc5c4136..b6c408267a685 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c

[ ... ]

> @@ -1177,10 +1177,9 @@ static void ft260_uart_port_remove(struct ft260_de=
vice *port)
>  	list_del(&port->device_list);
>  	mutex_unlock(&ft260_uart_list_lock);
> =20
> -	spin_lock(&port->write_lock);
> +	spin_lock(&port->xmit_fifo_lock);
>  	kfifo_free(&port->xmit_fifo);
> -	spin_unlock(&port->write_lock);
> +	spin_unlock(&port->xmit_fifo_lock);
> =20
>  	mutex_lock(&port->port.mutex);
> -	port->reschedule_work =3D false;
>  	tty_port_tty_hangup(&port->port, false);
>  	mutex_unlock(&port->port.mutex);

[Severity: High]
This is a pre-existing issue, but can this lead to a NULL pointer dereferen=
ce
on concurrent terminal writes?

In ft260_uart_port_remove(), kfifo_free() is executed while the port is
still accessible. The tty_port_tty_hangup() executes asynchronously.

If a concurrent userspace writer is active during this window,
ft260_uart_write() will acquire the spinlock and call kfifo_in_spinlocked().
Since kfifo_free() sets the internal buffer to NULL but leaves the mask
logic at 0, kfifo_avail() will calculate the available space as 1 byte,
causing a memcpy of 1 byte into the NULL buffer.

[ ... ]

> @@ -1244,14 +1244,14 @@ static int ft260_uart_transmit_chars(struct ft260=
_device *port)
>  		goto tty_out;
>  	}
> =20
> -	rep =3D (struct ft260_uart_write_request_report *)port->write_buf;
> +	rep =3D (struct ft260_uart_write_request_report *)port->uart_wr_buf;
> =20
>  	do {
> -		len =3D min(data_len, FT260_WR_DATA_MAX);
> +		len =3D min(data_len, FT260_WR_UART_DATA_MAX);
> =20
>  		rep->report =3D FT260_UART_DATA_REPORT_ID(len);
>  		rep->length =3D len;
> =20
> -		len =3D kfifo_out_locked(xmit, rep->data, len, &port->write_lock);
> +		len =3D kfifo_out_spinlocked(xmit, rep->data, len, &port->xmit_fifo_lo=
ck);
> =20
> -		ret =3D ft260_hid_output_report(hdev, (u8 *)rep, len + sizeof(*rep));
> -		if (ret < 0) {
> -			hid_err(hdev, "Failed to start transfer, ret %d\n", ret);
> +		ret =3D ft260_hid_output_report(hdev, (u8 *)rep, len + 2);
> +		if (ret < 0)

[Severity: High]
This is a pre-existing issue, but does this lockless use of the shared
uart_wr_buf lead to data corruption?

ft260_uart_transmit_chars() writes the report ID, length, and payload
directly into the shared port->uart_wr_buf without holding any driver-level
lock.

Since ft260_uart_write() can be called concurrently by multiple threads,
they could simultaneously overwrite port->uart_wr_buf, interleaving their
payloads before ft260_hid_output_report() is executed.

[ ... ]

> @@ -1286,26 +1286,26 @@ static ssize_t ft260_uart_write(struct tty_struct=
 *tty, const u8 *buf,
>  				 size_t cnt)
>  {
>  	struct ft260_device *port =3D tty->driver_data;
> -	struct hid_device *hdev =3D port->hdev;
> -	int len, ret;
> +	ssize_t len, ret, diff;
> =20
> -	len =3D kfifo_in_locked(&port->xmit_fifo, buf, count, &port->write_lock=
);
> -	ft260_dbg("count: %zu, len: %d", count, len);
> +	len =3D kfifo_in_spinlocked(&port->xmit_fifo, buf, cnt,
> +				  &port->xmit_fifo_lock);
> +	ft260_dbg("count: %zu, len: %zd", cnt, len);
> =20
>  	ret =3D ft260_uart_transmit_chars(port);
>  	if (ret < 0) {
> -		hid_dbg(hdev, "Failed to transmit chars: %d\n", ret);
> +		ft260_dbg("failed to transmit %zd\n", ret);
>  		return 0;
>  	}

[Severity: High]
This is a pre-existing issue, but does returning 0 here cause the terminal
layer to duplicate previously sent data?

If ft260_hid_output_report() fails halfway through a transmission,
ft260_uart_transmit_chars() returns a negative error code. This function
catches it and returns 0, which the terminal layer interprets as 0 bytes
accepted and retries writing the entire original buffer.

Because prior chunks were already extracted from the FIFO and successfully
transmitted, retrying the entire buffer results in those successful chunks
being added to the FIFO again, duplicating data on the wire.

[ ... ]

> @@ -1371,11 +1371,17 @@ static int ft260_uart_change_speed(struct ft260_d=
evice *port,
>  	if (baud =3D=3D 0 || baud < FT260_CFG_BAUD_MIN || baud > FT260_CFG_BAUD=
_MAX) {
>  		struct tty_struct *tty =3D tty_port_tty_get(&port->port);
> =20
> -		hid_err(hdev, "Invalid baud rate %d\n", baud);
> +		hid_err(hdev, "invalid baud rate %d\n", baud);
>  		baud =3D 9600;
>  		tty_encode_baud_rate(tty, baud, baud);
>  		tty_kref_put(tty);
>  	}
> +
> +	if (baud > FT260_UART_EN_PW_SAVE_BAUD)
> +		wakeup_workaraund =3D true;
> +
> +	ft260_uart_wakeup_workaraund_enable(port, wakeup_workaraund);
> +
>  	put_unaligned_le32(cpu_to_le32(baud), &req.baudrate);

[Severity: Medium]
Does this permanently stop the power-saving workaround timer if the baud ra=
te
transitions from 4800 or below to a higher rate?

When the baud rate is lowered, ft260_uart_change_speed() sets
reschedule_work to false, and the timer naturally stops when it next fires.
If the baud rate is later raised above 4800, this correctly sets
reschedule_work to true, but lacks a call to mod_timer() to restart the
stopped timer.

[ ... ]

> @@ -1726,15 +1768,12 @@ static int ft260_probe(struct hid_device *hdev, c=
onst struct hid_device_id *id)
>  	spin_lock_init(&dev->read_lock);
>  	init_completion(&dev->wait);
> =20
> -	if (!dev->ft260_is_serial) {
> +	if (ret =3D=3D FT260_IFACE_I2C)
>  		ret =3D ft260_i2c_probe(hdev, dev);
> -		if (ret)
> -			goto err_hid_close;
> -	} else {
> +	else
>  		ret =3D ft260_uart_probe(hdev, dev);
> -		if (ret)
> -			goto err_hid_close;
> -	}
> +	if (ret)
> +		goto err_hid_close;

[Severity: High]
Can this error path trigger a double free and use-after-free of the
ft260_device structure?

If ft260_uart_probe() fails (e.g., during ft260_hid_feature_report_set),
it jumps to err_register_tty and calls ft260_uart_port_remove(dev). This
function drops the port refcount by calling ft260_uart_port_put(dev).

The error path then falls through to err_port_put and calls
ft260_uart_port_put(dev) a second time, underflowing the refcount and
freeing dev.

Finally, the error propagates back to ft260_probe(), which unconditionally
jumps to err_hid_close and calls kfree(dev) on the already-freed structure.

[ ... ]

> @@ -1755,13 +1794,12 @@ static void ft260_remove(struct hid_device *hdev)
>  	if (!dev)
>  		return;
> =20
> -	if (dev->ft260_is_serial) {
> -		// FIXME:
> +	if (dev->iface_type =3D=3D FT260_IFACE_UART) {
>  		cancel_work_sync(&dev->wakeup_work);

[Severity: High]
Does this teardown path omit cancelling the wakeup timer?

The driver arms dev->wakeup_timer but fails to synchronously stop it.
Here, cancel_work_sync(&dev->wakeup_work) is called, but
timer_delete_sync(&dev->wakeup_timer) is missing.

The port shutdown gracefully sets reschedule_work to false but doesn't
cancel the pending timer. If the timer fires in the window after the port
is destroyed (and dev is freed), the timer handler will dereference
freed memory.

>  		tty_port_unregister_device(&dev->port, ft260_tty_driver,
>  					   dev->index);
>  		ft260_uart_port_remove(dev);

[Severity: Critical]
This is a pre-existing issue, but does this teardown ordering free the
device structure while the hardware is still active?

ft260_uart_port_remove(dev) is called to tear down the port. If the port
is not open, this drops the final reference and immediately frees dev.

However, hid_hw_stop(hdev) is not called until after this teardown.
If a device interrupt arrives during this window, the core invokes
ft260_raw_event(), which fetches the now-freed dev and passes it to
ft260_uart_receive_chars(), causing a use-after-free.

> -		/* dev still needed, so we will free it in _destroy func */
> +		/* dev is still needed, so we will free it in _destroy func */
>  	} else {
>  		sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
>  		i2c_del_adapter(&dev->adap);

[ ... ]

> @@ -1784,6 +1822,12 @@ static int ft260_raw_event(struct hid_device *hdev=
, struct hid_report *report,
>  		return -1;
>  	}
> =20
> +	if (xfer->length > size - offsetof(struct ft260_input_report, data)) {
> +		hid_err(hdev, "report %#02x: length %d exceeds HID report size\n",
> +			xfer->report, xfer->length);
> +		return -1;
> +	}
> +

[Severity: Medium]
Does this hoisted boundary check misinterpret the status byte of the UART
interrupt report, causing valid reports to be dropped?

For FT260_UART_INTERRUPT_STATUS (0xB1) reports, the byte at offset 1 is the
actual interrupt status bitmap, not a length.

If an unpadded 2-byte report is received, size is 2, making size minus offs=
et
equal 0. If any status bit is set (status > 0), the check incorrectly
triggers, rejects the report, and spams the kernel log with hid_err
messages whenever the UART receives data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822213941.9888=
2-1-michael.zaidman@gmail.com?part=3D2
