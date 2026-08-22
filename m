Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C353148B4
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787436053; cv=none; b=WipOU7ixb6E+tqzAcbXTNErXfde/0OHvBh4sA46hfaBmiMIUaGawbEqKc3JROK3WlnjXq7TYZWrJNo1d+bGEl2ViZveEinHZMeIayIvquKKnOGabM5l0D4OCOVo9bXju8yJ5dnn2Oj4qMqLVYGUFRlobK7w1paezXR6usstt5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787436053; c=relaxed/simple;
	bh=t93g61Kg0lWh6fphbcRvzdnkX/jDTREExETvR9LiU4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fDVqauufFJANNFDXLsVQgHpFSgTiaTvLPPBHMmgNxqh27FNuLVE/sknAaEHn+dfmTKsOB+tDHWxFb6+lyK0o4r7rx9vKkA1jGcfs2ilKQJspxUrnPUJQQEb2wvSy2a1vyomWeQBK7zA0yKSH4NvMHZ/a/JryR9babW7FEcEJxyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d479mkip; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d479mkip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9C51F00A3A;
	Sat, 22 Aug 2026 22:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787436051;
	bh=zpl73PVhwzbXcGi0kFgunLZuRc3x1/Tr777HHfPQ5Ps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d479mkipU6NJsN+cfAEkbP4HcL2EebthV+5UUzniFdl672OhClr2gzUDuhV7mEF+v
	 BdUyRNDMFypau8+0gyUd92DytHQW0fbAGmX+sGrLNPBuebp1w46efQ3d3HPGNB6MLJ
	 DmPWqaQQBkfddUIGz/yDodsnsnFkbveFMF6XyCbzGsQM+RTFo8hUlkz3YlZdJR3HmW
	 rcLBorENwv+XH0+bL3y2OY/N34ck0iAK1SNK/eihUK/cbRf0R0yMEQdbyaepUq9fc4
	 YvCrUqcqrIMehg2sgcWsbbarNDetKF5+oXshgsXsnMkWBehkxYvgwq6F7ViIyDuRts
	 WKBdkhT8r/sEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/13] HID: ft260: add serial driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260822213941.98882-2-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
 <20260822213941.98882-2-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 22:00:50 +0000
Message-Id: <20260822220051.3E9C51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [Critical] Use-After-Free of `hdev` and `xmit_fifo` if TTY operations occ=
ur after device removal.
- [High] Double free of the `dev` structure in the `ft260_probe()` error pa=
th.
- [High] Incorrect teardown ordering of the wakeup timer and workqueue crea=
tes a Use-After-Free race condition.
- [High] Device structure is freed before stopping the HID hardware, causin=
g a Use-After-Free in the input report handler.
- [High] Opening an unregistered or disconnected FT260 TTY node crashes the=
 kernel due to a missing NULL check.
- [Medium] Flawed TTY port index allocator logic generates duplicate indice=
s, leading to sysfs collisions.
- [Medium] TTY data duplication due to incorrect return value in `ft260_uar=
t_write()`.
- [Medium] Crashing dereference of `tty` in `ft260_uart_change_speed()` if =
the TTY is simultaneously closed.
- [Medium] Baud rate configuration is double-swapped on big-endian architec=
tures, resulting in incorrect hardware configuration.
--

--- Patch [1]: [PATCH 01/13] HID: ft260: add serial driver ---
commit 2a24dbd449641441b22e899b0125b7e38412d4d3
Author: Christina Quast <contact@christina-quast.de>

HID: ft260: add serial driver

Add a TTY serial interface (/dev/ttyFTx) for FT260 USB HID devices,
providing baud rate configuration, data transfer, and termios settings
without requiring userspace HID report formatting.

Ported from: https://lore.kernel.org/all/20231218093153.192268-1-contact@ch=
ristina-quast.de/
The follow-up v5 series stalled without being applied: https://lore.kernel.=
org/linux-input/20240216-ft260_review5-v5-1-36db44673ac7@christina-quast.de/

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 64c9c940db46e..3faedfc5c4136 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -1001,6 +1090,583 @@ static const struct attribute_group ft260_attr_gr=
oup =3D {

[ ... ]

> +static int ft260_uart_add_port(struct ft260_device *port)
> +{
> +	int index =3D 0, ret =3D 0;
> +	struct ft260_device *dev;
> +
> +	spin_lock_init(&port->write_lock);
> +	if (kfifo_alloc(&port->xmit_fifo, FIFO_SIZE, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	mutex_lock(&ft260_uart_list_lock);
> +	list_for_each_entry(dev, &ft260_uart_device_list, device_list) {
> +		if (dev->index !=3D index)
> +			break;
> +		index++;
> +	}
> +
> +	port->index =3D index;
> +	list_add(&port->device_list, &ft260_uart_device_list);
> +	mutex_unlock(&ft260_uart_list_lock);

[Severity: Medium]
Will this allocate duplicate indices when multiple devices are plugged in?

The iteration expects the list to be in ascending order to find a hole, but
list_add() prepends devices to the head, making the list descending. When
plugging in a third device, the loop will encounter index 1 first, mismatch
with index =3D 0, break early, and assign index 0 again, causing a sysfs
name collision.

[ ... ]

> +static void ft260_uart_port_remove(struct ft260_device *port)
> +{
> +	timer_delete_sync(&port->wakeup_timer);
> +
> +	mutex_lock(&ft260_uart_list_lock);
> +	list_del(&port->device_list);
> +	mutex_unlock(&ft260_uart_list_lock);
> +
> +	spin_lock(&port->write_lock);
> +	kfifo_free(&port->xmit_fifo);
> +	spin_unlock(&port->write_lock);
> +
> +	mutex_lock(&port->port.mutex);
> +	port->reschedule_work =3D false;
> +	tty_port_tty_hangup(&port->port, false);
> +	mutex_unlock(&port->port.mutex);
> +
> +	ft260_uart_port_put(port);
> +}

[Severity: Critical]
Can a use-after-free occur if userspace continues writing to the TTY after
device removal?

ft260_uart_port_remove() is called during teardown and synchronously frees
xmit_fifo. However, if userspace holds the TTY file open, the dev structure
remains alive. Subsequent writes to the TTY will call ft260_uart_write(),
which writes to the freed xmit_fifo and calls ft260_hid_output_report() usi=
ng
the freed port->hdev.

[ ... ]

> +static int ft260_uart_open(struct tty_struct *tty, struct file *filp)
> +{
> +	int ret;
> +	struct ft260_device *port =3D tty->driver_data;
> +
> +	ret =3D tty_port_open(&port->port, tty, filp);

[Severity: High]
If port was NULL during ft260_uart_install(), won't this dereference NULL w=
hen
evaluating &port->port?

[ ... ]

> +static ssize_t ft260_uart_write(struct tty_struct *tty, const u8 *buf,
> +				 size_t count)
> +{
> +	struct ft260_device *port =3D tty->driver_data;
> +	struct hid_device *hdev =3D port->hdev;
> +	int len, ret;
> +
> +	len =3D kfifo_in_locked(&port->xmit_fifo, buf, count, &port->write_lock=
);
> +	ft260_dbg("count: %zu, len: %d", count, len);
> +
> +	ret =3D ft260_uart_transmit_chars(port);
> +	if (ret < 0) {
> +		hid_dbg(hdev, "Failed to transmit chars: %d\n", ret);
> +		return 0;
> +	}
> +
> +	ret =3D kfifo_len(&port->xmit_fifo);
> +	if (ret > 0) {
> +		hid_dbg(hdev, "Failed to  all kfifo data bytes\n");
> +		ft260_dbg("return: %d", len - ret);
> +		return len - ret;
> +	}
> +
> +	return len;
> +}

[Severity: Medium]
Does this logic silently duplicate data in the byte stream?

If kfifo_in_locked accepts all bytes, but ft260_uart_transmit_chars cannot
transmit them all immediately (leaving some in the FIFO), this function
returns len - kfifo_len(). The TTY layer assumes the difference was rejected
and will re-submit those bytes on the next call, appending them to the FIFO
again.

[ ... ]

> +static int ft260_uart_change_speed(struct ft260_device *port,
> +				   struct ktermios *termios,
> +				    struct ktermios *old)
> +{
> +	struct hid_device *hdev =3D port->hdev;
> +	unsigned int baud;
> +	struct ft260_configure_uart_request req;
> +	int ret;

[ ... ]

> +	baud =3D tty_termios_baud_rate(termios);
> +	if (baud =3D=3D 0 || baud < FT260_CFG_BAUD_MIN || baud > FT260_CFG_BAUD=
_MAX) {
> +		struct tty_struct *tty =3D tty_port_tty_get(&port->port);
> +
> +		hid_err(hdev, "Invalid baud rate %d\n", baud);
> +		baud =3D 9600;
> +		tty_encode_baud_rate(tty, baud, baud);
> +		tty_kref_put(tty);
> +	}

[Severity: Medium]
Can tty_port_tty_get(&port->port) return NULL if the TTY is simultaneously
closed?

If it does, passing NULL to tty_encode_baud_rate() will unconditionally
dereference it and crash the kernel.

> +	put_unaligned_le32(cpu_to_le32(baud), &req.baudrate);

[Severity: Medium]
Is the baud rate being double-swapped on big-endian architectures?

The put_unaligned_le32() macro implicitly handles CPU-to-LE32 conversion
internally. Calling cpu_to_le32(baud) first will swap the bytes on
big-endian platforms, and then put_unaligned_le32() will swap them a second
time, writing the baud rate to the hardware in big-endian format.

[ ... ]

> +static int ft260_uart_install(struct tty_driver *driver, struct tty_stru=
ct *tty)
> +{
> +	int idx =3D tty->index;
> +	struct ft260_device *port =3D ft260_uart_port_get(idx);
> +	int ret =3D tty_standard_install(driver, tty);
> +
> +	if (ret =3D=3D 0)
> +		/* This is the ref ft260_uart_port get provided */
> +		tty->driver_data =3D port;

[Severity: High]
Can this assign a NULL pointer if the device is disconnected before being
opened?

If the port was already removed, ft260_uart_port_get(idx) returns NULL.
This code does not check if port is NULL before assigning it to
tty->driver_data, which allows the open sequence to continue with a NULL
device context.

[ ... ]

> +static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device=
 *dev)
> +{
> +	struct ft260_configure_uart_request req;
> +	int ret;
> +	struct device *devt;

[ ... ]

> +	/* Send Feature Report to Configure FT260 as UART 9600-8-N-1 */
> +	req.report	=3D FT260_SYSTEM_SETTINGS;
> +	req.request	=3D FT260_SET_UART_CONFIG;
> +	req.flow_ctrl	=3D FT260_CFG_FLOW_CTRL_NONE;
> +	put_unaligned_le32(cpu_to_le32(9600), &req.baudrate);

[Severity: Medium]
Is this also double-swapped on big-endian architectures?

[ ... ]

> @@ -1010,20 +1676,26 @@ static int ft260_probe(struct hid_device *hdev, c=
onst struct hid_device_id *id)

[ ... ]

> -err_i2c_free:
> -	i2c_del_adapter(&dev->adap);
>  err_hid_close:
>  	hid_hw_close(hdev);
>  err_hid_stop:
>  	hid_hw_stop(hdev);
> +hid_fail:
> +	kfree(dev);
> +alloc_fail:
>  	return ret;
>  }

[Severity: High]
Is it possible to double free the dev structure here?

If ft260_uart_probe() fails, it calls ft260_uart_port_remove(), which
drops the TTY port's reference count to 0, triggering
ft260_uart_port_destroy() and freeing dev.

The error then propagates back to ft260_probe(), which jumps to
err_hid_close and then unconditionally executes kfree(dev) at the
hid_fail label.

> @@ -1100,8 +1755,18 @@ static void ft260_remove(struct hid_device *hdev)
>  	if (!dev)
>  		return;
> =20
> -	sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
> -	i2c_del_adapter(&dev->adap);
> +	if (dev->ft260_is_serial) {
> +		// FIXME:
> +		cancel_work_sync(&dev->wakeup_work);
> +		tty_port_unregister_device(&dev->port, ft260_tty_driver,
> +					   dev->index);
> +		ft260_uart_port_remove(dev);
> +		/* dev still needed, so we will free it in _destroy func */

[Severity: High]
Is there a use-after-free race condition during device unplug?

If the timer fires after cancel_work_sync(&dev->wakeup_work) but before
timer_delete_sync(&port->wakeup_timer) runs in ft260_uart_port_remove(),
the timer callback ft260_uart_start_wakeup() can observe
dev->reschedule_work =3D=3D true and dynamically re-queue the work.

The work would then remain queued after the device is destroyed.

> +	} else {
> +		sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
> +		i2c_del_adapter(&dev->adap);
> +		kfree(dev);
> +	}
> =20
>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);

[Severity: High]
Does this free dev while the HID hardware is still active?

By calling kfree(dev) before hid_hw_stop(hdev), incoming hardware reports
can still be dispatched to ft260_raw_event(). That handler calls
hid_get_drvdata(hdev) and will dereference the freed dev structure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822213941.9888=
2-1-michael.zaidman@gmail.com?part=3D1
