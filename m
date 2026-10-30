Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793401223;
	b=hko/4d3X5tGZatLPwfJPCaQ6+1hCoTt6KlZjGa2kDEMq74rXRYKCD9kwdjxiqQFpwqzE
	 DN4JvZcDFfo7btrqKTaUZpIhcibD0zX2G8mrGlI4EdNUcwZjjkFIvZ3iaZNsjJ9Yoay8+
	 XIIbtmzkTuKXDHsGO+kuHTFEiyKuh5lTvhxj5qsy0/xDmTNTB1kL3YsmmpgNDMZ4ZA9T+
	 hrlf/vEyK3WByIFxoWrsnTsNjZ1zNCTJrSYM+wVZLYnYBp4CU7G5ghZ9aY0g9Bgt/shRX
	 Tvj3EbaI/6PbtTjOc+TAeEf3hoMGJ/WqjiECifbzRwmU2EolXQvcvpDiGkboCq0S73w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793401223;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5jIcfC6i5IDlFmKO8MPaxHrkwq1ePYWBHajN0TY2iqg=;
	b=fT3MhH6Exz7aQV/HLQpfyG87W0pSnUDA+1WLDcQrqdm+Bivk/DvAC9d65l2psGOwXFEn
	 wWfVMKqraEMfxJhPIWreWWIZs8ipTnns4BcHAYIP4pgJjaVGTbDihpYbqp1OOiAmFnwV3
	 fPoH72iKOe20Y9cliOQLxCt/R1ElaMTvBuktzmGgNyrqLdQIAvHDzR/BR6eZfRLBwsc6F
	 uGSALnk9/NI65wMXRg1Vf39EFnT5Stwxj5nsiJ/Wp2BTPp61gYlob6f5i2zQzGoUHn8f2
	 ZFVG6T2KQ/0YiZbN3iohAUN5xrnwg4CkhmEwWNQHT7P2zblcd7QBOXtEO6KsXR2Sxfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BvGvZYSj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95FA606A31C;
	Fri, 30 Oct 2026 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BvGvZYSj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EED91F000C1;
	Fri, 30 Oct 2026 23:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793401222;
	bh=5jIcfC6i5IDlFmKO8MPaxHrkwq1ePYWBHajN0TY2iqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BvGvZYSjgZd6slhgnjSodai4L5GvO64eINMdE0OIM4xfvDq3EwW0UGHHx6WREsWB0
	 3PEqY0FExiYEE5/Gc/RiQGwkCndcYebqFWCP13xt0EaxG+moXsuOfKFS6PAJcHTqSb
	 7kwXzXbWigbb4R5DSShFVl+HSbx9HeEKIWWslyrfCa3sjapPrjyLu05wXVLnMR7sWi
	 kbHWqSFuCGITEodKVSfC46gnF7Ex1sLdQZdL6RoYdqFzFAXqkyICwFU9C8gtIue+8x
	 LE9dn9aDsnsS2t1i9cf49eEJxZ/VSIf9pCwV4se2kDCGi3FWQRAKiTcyj/IjggYKeI
	 rKMSB9hl9ns9A==
Message-ID: <sashiko-outbox-191611@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/15] HID: ft260: add serial driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261030223637.86907-2-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
 <20261030223637.86907-2-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 23:00:22 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] HID: ft260: broken minor index allocation and bounds check in ft26=
0_uart_add_port()
- [High] HID: ft260: use-after-free of hdev and xmit_fifo across ft260_remo=
ve()
- [High] HID: ft260: unsynchronized transmit loop and infinite loop in ft26=
0_uart_transmit_chars()
- [High] HID: ft260: use-after-free and double free in ft260_probe() on FT2=
60_IFACE_NONE
- [High] HID: ft260: unguarded UART report in ft260_raw_event() on I2C inte=
rface
- [High] HID: ft260: sleeping in atomic context in ft260_uart_write()
- [Medium] HID: ft260: race in ft260_uart_probe() registering tty before hw=
 config
--

commit bd086b64065aa177dfdec81fc03e141758ca2307
Author: Christina Quast <contact@christina-quast.de>

HID: ft260: add serial driver

This commit adds a TTY serial driver (/dev/ttyFTx) for the UART interface
of FTDI FT260 USB HID devices, supporting termios configuration and serial
data transfers alongside the existing I2C interface support.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 64c9c940db46e..982e2ca7a2de6 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c

[ ... ]

> @@ -1001,51 +1101,478 @@ static const struct attribute_group ft260_attr_g=
roup =3D {
>  	}
>  };
> =20
> -static int ft260_probe(struct hid_device *hdev, const struct hid_device_=
id *id)
> +/***
> + * START Serial dev part
> + */
> +static DEFINE_MUTEX(ft260_uart_list_lock);
> +static LIST_HEAD(ft260_uart_device_list);
> +
> +static struct ft260_device *ft260_dev_by_index(int index)
> +{
> +	struct ft260_device *port;
> +
> +	list_for_each_entry(port, &ft260_uart_device_list, device_list) {
> +		if (index =3D=3D port->index)
> +			return port;
> +	}
> +	return NULL;
> +}
> +
> +static int ft260_uart_add_port(struct ft260_device *port)
>  {
> +	int index =3D 0, ret =3D 0;
>  	struct ft260_device *dev;
> -	struct ft260_get_chip_version_report version;
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
> +	list_add_tail(&port->device_list, &ft260_uart_device_list);
> +	mutex_unlock(&ft260_uart_list_lock);
> +
> +	return ret;
> +}

[Severity: High]
As reported by Sashiko on v1 [1], can ft260_uart_add_port() in
drivers/hid/hid-ft260.c assign duplicate minor indices or exceed
UART_COUNT_MAX?

The loop in ft260_uart_add_port() searches for the lowest unused index by
breaking as soon as dev->index !=3D index, which assumes ft260_uart_device_=
list
is kept sorted in ascending order of index. However, the new port is always
appended at the end of the list with list_add_tail(&port->device_list,
&ft260_uart_device_list) instead of being inserted before dev
(&dev->device_list).

If port 0 and port 1 are probed (list: [0, 1]), port 0 is removed (list:
[1]), and a third UART device is probed, it gets index 0 and is appended to
the tail (list: [1, 0]). When a fourth UART device is probed, the loop sees
dev->index =3D=3D 1 !=3D 0 on the first entry, breaks immediately, and assi=
gns a
duplicate index 0.

In ft260_uart_probe(), tty_port_register_device_attr() then calls
tty_port_link_device(), which overwrites ft260_tty_driver->ports[0] with the
new port before device_register() fails with -EEXIST. The error path in
ft260_probe() frees the new port via tty_port_put(&dev->port), leaving
ft260_tty_driver->ports[0] as a dangling pointer to freed memory while the
first /dev/ttyFT0 remains registered.

In addition, ft260_uart_add_port() does not check whether index >=3D
UART_COUNT_MAX (4), so probing a fifth UART device passes index =3D=3D 4 to
tty_port_register_device_attr() -> tty_port_link_device() and triggers
WARN_ON(index >=3D driver->num).

> +
> +static void ft260_uart_port_put(struct ft260_device *port)
> +{
> +	tty_port_put(&port->port);
> +}
> +
> +static void ft260_uart_port_remove(struct ft260_device *port)
> +{
> +	timer_delete_sync(&port->wakeup_timer);
> +
> +	mutex_lock(&ft260_uart_list_lock);
> +	list_del(&port->device_list);
> +	mutex_unlock(&ft260_uart_list_lock);
> +
> +	tty_port_tty_vhangup(&port->port);
> +
> +	spin_lock(&port->write_lock);
> +	kfifo_free(&port->xmit_fifo);
> +	spin_unlock(&port->write_lock);
> +}

[Severity: High]
As reported by Sashiko on v1 [2], does freeing port->xmit_fifo in
ft260_uart_port_remove() and stopping port->hdev in ft260_remove() cause a
use-after-free when TTY operations race with or follow device removal?

Although struct ft260_device lives until ft260_uart_port_destroy(),
ft260_uart_port_remove() frees port->xmit_fifo during ft260_remove(), and t=
he
HID core frees port->hdev once ft260_remove() returns:

drivers/hid/hid-ft260.c:ft260_remove() {
	if (dev->ft260_is_serial) {
		timer_delete_sync(&dev->wakeup_timer);
		cancel_work_sync(&dev->wakeup_work);
		tty_port_unregister_device(&dev->port, ft260_tty_driver,
					   dev->index);
		ft260_uart_port_remove(dev);
	}
	...
	hid_hw_close(hdev);
	hid_hw_stop(hdev);
}

If tty_open() has completed ft260_uart_install() (obtaining a port reference
from ft260_uart_device_list and dropping tty_mutex) before
ft260_uart_port_remove() runs, but has not yet reached tty_port_tty_set() in
tty_port_open(), port->port.tty is still NULL when tty_port_tty_vhangup() is
called. When tty_open() continues into ft260_uart_open() -> tty_port_open()
-> ft260_uart_activate():

drivers/hid/hid-ft260.c:ft260_uart_activate() {
	...
	spin_lock(&port->write_lock);
	kfifo_reset(&port->xmit_fifo);
	spin_unlock(&port->write_lock);

	ft260_uart_change_speed(port, &tty->termios, NULL);
	clear_bit(TTY_IO_ERROR, &tty->flags);
}

it resets the freed xmit_fifo, calls ft260_uart_change_speed() on the
stopped/freed port->hdev, ignores the error return, clears TTY_IO_ERROR, and
lets subsequent writes and termios changes proceed on a disconnected device.

Even for an already-opened TTY, concurrent or subsequent calls to
ft260_uart_set_termios() (which does not check tty_io_error()) or in-flight
ft260_uart_write() / ft260_uart_transmit_chars() calls can dereference the
freed port->hdev and port->xmit_fifo without any disconnect check or
synchronization against ft260_remove(). Because __kfifo_free() sets
fifo->data =3D NULL and fifo->mask =3D 0, kfifo_unused() evaluates to 1 when
in =3D=3D out, causing a racing kfifo_in_locked() in ft260_uart_write() to
memcpy() into a NULL fifo->data pointer.

Should kfifo_free(&port->xmit_fifo) be deferred to ft260_uart_port_destroy(=
),
with a disconnect flag and lock protecting all port->hdev accesses in the
TTY callbacks?

[ ... ]

> +static int ft260_uart_transmit_chars(struct ft260_device *port)
> +{
> +	struct hid_device *hdev =3D port->hdev;
> +	struct kfifo *xmit =3D &port->xmit_fifo;
> +	struct tty_struct *tty;
> +	struct ft260_uart_write_request_report *rep;
> +	int len, data_len, ret =3D 0;
> +
> +	tty =3D tty_port_tty_get(&port->port);
> +
> +	data_len =3D kfifo_len(xmit);
> +	if (!tty || !data_len) {
> +		ret =3D -EINVAL;
> +		goto tty_out;
> +	}
> +
> +	rep =3D (struct ft260_uart_write_request_report *)port->write_buf;
> +
> +	do {
> +		len =3D min(data_len, FT260_WR_DATA_MAX);
> +
> +		rep->report =3D FT260_UART_DATA_REPORT_ID(len);
> +		rep->length =3D len;
> +
> +		len =3D kfifo_out_locked(xmit, rep->data, len, &port->write_lock);
> +
> +		ret =3D ft260_hid_output_report(hdev, (u8 *)rep, len + sizeof(*rep));
> +		if (ret < 0) {
> +			hid_err(hdev, "Failed to start transfer, ret %d\n", ret);
> +			goto tty_out;
> +		}
> +
> +		data_len -=3D len;
> +		port->icount.tx +=3D len;
> +	} while (data_len > 0);

[Severity: High]
As reported by Sashiko on v1 [3], what happens in ft260_uart_transmit_chars=
()
if two threads transmit concurrently, or if xmit_fifo is drained or reset
while ft260_hid_output_report() is blocking?

First, port->write_buf is shared across the port without any lock protecting
it across the blocking ft260_hid_output_report() call, so concurrent callers
(for example, normal write vs line discipline echo) will corrupt rep->repor=
t,
rep->length, and rep->data.

Second, rep->report and rep->length are computed from data_len before
kfifo_out_locked() dequeues the data. If another thread consumes bytes from
xmit_fifo (or ft260_uart_activate() resets the fifo, or
ft260_uart_port_remove() frees it), kfifo_out_locked() can return fewer byt=
es
than rep->length, including 0.

When kfifo_out_locked() returns len =3D=3D 0:
1. rep->length still holds the stale non-zero length, violating the
   __counted_by(length) annotation on rep->data and sending a malformed
   2-byte report header with a non-zero length field.
2. If ft260_hid_output_report() succeeds, data_len -=3D 0 leaves data_len
   greater than 0, causing the do-while (data_len > 0) loop to spin
   indefinitely.

Also, if ft260_hid_output_report() fails mid-loop, the chunk already removed
by kfifo_out_locked() is lost and any remaining bytes stay in xmit_fifo
while ft260_uart_write() still returns the full queued count. Note that whi=
le
a subsequent patch in the series separates i2c_wr_buf and uart_wr_buf, the
unlocked uart_wr_buf use, pre-dequeue rep->length assignment, and infinite
loop when kfifo_out_spinlocked() returns 0 remain present.

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
> +	if (ret < 0)
> +		hid_dbg(hdev, "Failed to transmit chars: %d\n", ret);
> +
> +	return len;
> +}

[Severity: High]
Can ft260_uart_write() sleep in atomic context here?

The struct tty_operations write() callback contract in
include/linux/tty_driver.h specifies that write() may not sleep, and standa=
rd
line disciplines (such as N_PPP, N_SLIP, N_GSM0710, N_SLCAN, and N_MCTP)
invoke tty->ops->write() while holding spinlocks or running in softirq
context.

However, ft260_uart_write() synchronously calls:

ft260_uart_transmit_chars()
  -> ft260_hid_output_report()
       -> kmemdup(..., GFP_KERNEL)
       -> hid_hw_output_report()

which performs a GFP_KERNEL allocation and blocks waiting for synchronous U=
SB
URB completion. Should transmission from xmit_fifo be deferred to a
workqueue item instead of running synchronously in ft260_uart_write()?

[ ... ]

> +static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device=
 *dev)
> +{
> +	struct ft260_configure_uart_request req;
> +	int ret;
> +	struct device *devt;
> +
> +	INIT_WORK(&dev->wakeup_work, ft260_uart_do_wakeup);
> +	// FIXME: Do I need that if I have cancel_work_sync?
> +	// FIXME: are all kfifo access secured by lock? with irq or not?
> +	dev->reschedule_work =3D false;
> +	/* Work not started at this point */
> +	timer_setup(&dev->wakeup_timer, ft260_uart_start_wakeup, 0);
> +
> +	tty_port_init(&dev->port);
> +	dev->port.ops =3D &ft260_uart_port_ops;
> +
> +	ret =3D ft260_uart_add_port(dev);
> +	if (ret) {
> +		hid_err(hdev, "failed to add port\n");
> +		goto err_port;
> +	}
> +	devt =3D tty_port_register_device_attr(&dev->port,
> +					     ft260_tty_driver,
> +					     dev->index, &hdev->dev,
> +					     dev, NULL);
> +	if (IS_ERR(devt)) {
> +		hid_err(hdev, "failed to register tty port\n");
> +		ret =3D PTR_ERR(devt);
> +		goto err_register_tty;
> +	}
> +	hid_info(hdev, "Registering device /dev/%s%d\n",
> +		ft260_tty_driver->name, dev->index);
> +
> +	/* Send Feature Report to Configure FT260 as UART 9600-8-N-1 */
> +	req.report	=3D FT260_SYSTEM_SETTINGS;
> +	req.request	=3D FT260_SET_UART_CONFIG;
> +	req.flow_ctrl	=3D FT260_UART_CFG_FLOW_CTRL_NONE;
> +	put_unaligned_le32(9600, &req.baudrate);
> +	req.data_bit	=3D FT260_UART_CFG_DATA_BITS_8;
> +	req.parity	=3D FT260_UART_CFG_PAR_NO;
> +	req.stop_bit	=3D FT260_UART_CFG_STOP_ONE_BIT;
> +	req.breaking	=3D FT260_UART_CFG_BREAKING_NO;
> +
> +	ret =3D ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));

[Severity: Medium]
In ft260_uart_probe(), the port is added to ft260_uart_device_list and
registered via tty_port_register_device_attr() before the initial 9600-8-N-1
FT260_SET_UART_CONFIG feature report is sent to the hardware.

If userspace (such as udev or ModemManager reacting to the KOBJ_ADD uevent)
opens /dev/ttyFTx and configures termios before ft260_hid_feature_report_se=
t()
runs here, won't ft260_uart_probe() overwrite the userspace UART settings in
hardware with 9600-8-N-1? Should the initial hardware configuration happen
before publishing and registering the TTY device?

> +	if (ret < 0) {
> +		hid_err(hdev, "ft260_hid_feature_report_set failed: %d\n",
> +			ret);
> +		goto err_hid_report;
> +	}
> +
> +	return 0;
> +
> +err_hid_report:
> +	tty_port_unregister_device(&dev->port, ft260_tty_driver, dev->index);
> +err_register_tty:
> +	ft260_uart_port_remove(dev);
> +err_port:
> +	timer_delete_sync(&dev->wakeup_timer);
> +	return ret;
> +}
> +
> +static int ft260_probe(struct hid_device *hdev, const struct hid_device_=
id *id)
> +{
> +	struct ft260_device *dev;
> +	struct ft260_get_chip_version_report version;
> +	int ret;
> +
> +	if (!hid_is_usb(hdev))
> +		return -EINVAL;
> +
> +	/* We cannot used devm_kzalloc here, because port has to survive until
> +	 * destroy function call
> +	 */
> +	dev =3D kzalloc_obj(*dev, GFP_KERNEL);
> +	if (!dev) {
> +		ret =3D -ENOMEM;
> +		goto alloc_fail;
> +	}
> +	hid_set_drvdata(hdev, dev);
> +	mutex_init(&dev->lock);
> +	spin_lock_init(&dev->read_lock);
> +	init_completion(&dev->wait);
> +
> +	ret =3D hid_parse(hdev);
> +	if (ret) {
> +		hid_err(hdev, "failed to parse HID\n");
> +		goto hid_fail;
> +	}
> +
> +	ret =3D hid_hw_start(hdev, 0);
> +	if (ret) {
> +		hid_err(hdev, "failed to start HID HW\n");
> +		goto hid_fail;
> +	}
> +
> +	ret =3D hid_hw_open(hdev);
> +	if (ret) {
> +		hid_err(hdev, "failed to open HID HW\n");
> +		goto err_hid_stop;
> +	}
> +
> +	ret =3D ft260_hid_feature_report_get(hdev, FT260_CHIP_VERSION,
> +					   (u8 *)&version, sizeof(version));
> +	if (ret < 0) {
> +		hid_err(hdev, "failed to retrieve chip version\n");
> +		goto err_hid_close;
> +	}
> +
> +	hid_info(hdev, "chip code: %02x%02x %02x%02x\n",
> +		 version.chip_code[0], version.chip_code[1],
> +		 version.chip_code[2], version.chip_code[3]);
> +
> +	ret =3D ft260_get_interface_type(hdev, dev);
> +	if (ret <=3D FT260_IFACE_NONE)
> +		goto err_hid_close;

[Severity: High]
What happens in ft260_probe() if ft260_get_interface_type() returns
FT260_IFACE_NONE (0)?

In ft260_get_interface_type(), ret is initialized to the return value of
ft260_get_system_config(hdev, &cfg), which is 0 on success:

drivers/hid/hid-ft260.c:ft260_get_interface_type() {
	...
	ret =3D ft260_get_system_config(hdev, &cfg);
	if (ret < 0)
		return ret;
	...
	switch (cfg.chip_mode) {
	case FT260_MODE_ALL:
	case FT260_MODE_BOTH:
		...
		break;
	case FT260_MODE_UART:
		...
		break;
	case FT260_MODE_I2C:
		...
		break;
	}

	return ret;
}

If cfg.chip_mode does not match any of the switch cases,
ft260_get_interface_type() returns 0 (FT260_IFACE_NONE). In ft260_probe(),
the check if (ret <=3D FT260_IFACE_NONE) jumps to err_hid_close with ret =
=3D=3D 0:

err_hid_close:
	hid_hw_close(hdev);
err_hid_stop:
	hid_hw_stop(hdev);
hid_fail:
	kfree(dev);
alloc_fail:
	return ret;

This frees dev while leaving hdev drvdata pointing to it, and returns 0
(probe success) to the HID core. When ft260_remove() is later called on
device unbind or disconnect, it retrieves the dangling dev pointer from
hid_get_drvdata(hdev), accesses freed memory, and calls kfree(dev) a second
time.

[ ... ]

> @@ -1157,9 +1835,17 @@ static int ft260_raw_event(struct hid_device *hdev=
, struct hid_report *report,
>  		if (complete_read)
>  			complete(&dev->wait);
> =20
> -	} else {
> -		hid_err(hdev, "unhandled report %#02x\n", xfer->report);
> +		return 0;
> +
> +	} else if (xfer->length > FT260_RD_DATA_MAX) {
> +		hid_err(hdev, "received data too long (%d)\n", xfer->length);
> +		return -EBADR;
> +	} else if (xfer->report >=3D FT260_UART_REPORT_MIN &&
> +		   xfer->report <=3D FT260_UART_REPORT_MAX) {
> +		return ft260_uart_receive_chars(dev, xfer->data, xfer->length);
>  	}

[Severity: High]
Can ft260_raw_event() dereference a NULL pointer if a UART report (ID
0xF0..0xFE) arrives on an I2C interface?

When an interface is probed as I2C (dev->ft260_is_serial is false),
ft260_uart_probe() is not called, so tty_port_init(&dev->port) never runs
and dev->port.buf.tail remains NULL. However, ft260_raw_event() dispatches
reports in FT260_UART_REPORT_MIN..FT260_UART_REPORT_MAX to
ft260_uart_receive_chars() without checking dev->ft260_is_serial:

ft260_raw_event()
  -> ft260_uart_receive_chars()
       -> tty_insert_flip_string(&port->port, data, length)
            -> __tty_insert_flip_string_flags()
                 -> __tty_buffer_request_room()

If a malformed or malicious USB device (or HID-BPF program) sends a UART
input report on the I2C interface, __tty_buffer_request_room() will
dereference NULL port->buf.tail. Should ft260_raw_event() verify
dev->ft260_is_serial before calling ft260_uart_receive_chars()?

[1] https://lore.kernel.org/r/20260822213941.98882-2-michael.zaidman@gmail.=
com
[2] https://lore.kernel.org/r/20260822215615.2D8541F000E9@smtp.kernel.org
[3] https://lore.kernel.org/r/20260822215615.2D8541F000E9@smtp.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030223637.8690=
7-1-michael.zaidman@gmail.com?part=3D1
