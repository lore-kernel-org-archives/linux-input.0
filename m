Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794948588;
	b=NtrvoJ/saExdLENrb7mol5zA+CK55ETN40dbThc4MUwOnG2GZQXWC2IQ7ArKrrGG0J3w
	 of2M9Y6aESrm0F6SJNdxqfZtr5Q5ZiUAie9q9DCMhC0xt74PCbwNdSgNzrvVMxHTXLPkp
	 LA7pl9oRc4QJkW0S1r+gUPMKMF29x7CNe477rhCRLU39rn7LTnd4+ng+viwL1eOfkaAJO
	 ekkxgV4V1wfy6auHH8L+NKp3eG8ezSc3TuWjJDJz2Lay1TCy6Phy9FyLOkOrhI8sc6zjF
	 qgbxM3wkp4v3zIzzmwzE+wmIOxfSCcj1MOPwezK3cOTeup5ot0vYKKXlKFe7bk2JbQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794948588;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=720dfNJISPP/iVv5PHTKYzYUFpkJFSxhwXtB1bfhBZk=;
	b=niH50fHln0QHQ6vNuzik4cmneqWEIcKeG9MvVEI/MQHx41vdM1JkfNRzPTGVe7ii5kAC
	 uUFsHYDbDZeWHeg9Q2jom/XTzRBMYQWBr63oJIOzCj1zW2noriNBZY8cl1QQZb2hx6okQ
	 DFtXz54dWguiHDPsGlUnUNy5XtrLjU3F6pdBwC3ePsZSmFlSMpFzcrdO7m+JLlVhLWJzZ
	 unwkj/46QMt2xppwQegJVW7zA3QAjvzmDMDQbbqzxyBXOEGgCjwp1JGfpn1vimOI7O97a
	 gBGzZf2b7V1reQv0S1F8fnxeISFyqmMz60s0Mnc2QtrUApB3hcRObq/zAEdr4/3LfmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JSElPS3o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F41606A31C;
	Tue, 17 Nov 2026 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JSElPS3o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13941F000C4;
	Tue, 17 Nov 2026 20:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794948588;
	bh=720dfNJISPP/iVv5PHTKYzYUFpkJFSxhwXtB1bfhBZk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JSElPS3o3JGZ3xiedIFQJimWgWOyIROPIuMhS3uEJx6D3+uGBMqM3Cw9M2K60v7+S
	 dsEnbeLnPyuVwpPY8Qb3U9VqxPqK6q+7gdB6vYQ8vZmx7OBkWW16HW2h54SqWIQHB+
	 7QuOyq7ul/rJGUxPHuJI6JAFKhjrxTLOu7JZoLA1+aOiXdhK0Lb4Glyq1Fe4KyeWv3
	 Lwbf54TYZzL0VbxM5d/EQrWFk6NfKHMO4kd9cqivGE6ZsIY22csA7FQGzh4gyCQQVN
	 mr9//crIpbw2s3suldDU+Rv41Dj9a3fWx6fryJHfUrxcDKqyRdbqR5BQIhjsbtNJ9c
	 GfUHCrpWM47Zw==
Message-ID: <sashiko-outbox-219657@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/16] HID: ft260: uart: fix serial driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117200423.19561-3-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
 <20261117200423.19561-3-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:49:47 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] HID: ft260: stale saved termios after hotplug in
  ft260_uart_port_activate()
- [Medium] HID: ft260: IRQ-unsafe spin_lock() on xmit_fifo_lock in UART
  paths
- [Medium] HID: ft260: unlocked xmit_fifo reads in write_room and
  chars_in_buffer
- [Medium] HID: ft260: premature port publication in ft260_uart_probe()
  and missing tty_port_install()
--

commit 38fb4dc5976e5403c2faec8851d4e9985224e696
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: uart: fix serial driver

This commit fixes buffer sharing, power-save wakeup handling, report length
validation, port lifecycle management, and asynchronous TX handling in the
FT260 UART driver.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 982e2ca7a2de6..869e7b924b30a 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
[ ... ]
> @@ -1207,61 +1274,56 @@ static int ft260_uart_transmit_chars(struct ft260=
_device *port)
>  	struct kfifo *xmit =3D &port->xmit_fifo;
>  	struct tty_struct *tty;
>  	struct ft260_uart_write_request_report *rep;
> -	int len, data_len, ret =3D 0;
> +	int len, ret =3D 0;
> =20
>  	tty =3D tty_port_tty_get(&port->port);
> +	if (!tty)
> +		return -EINVAL;
> =20
> -	data_len =3D kfifo_len(xmit);
> -	if (!tty || !data_len) {
> -		ret =3D -EINVAL;
> -		goto tty_out;
> -	}
> -
> -	rep =3D (struct ft260_uart_write_request_report *)port->write_buf;
> -
> -	do {
> -		len =3D min(data_len, FT260_WR_DATA_MAX);
> +	rep =3D (struct ft260_uart_write_request_report *)port->uart_wr_buf;
> =20
> +	while ((len =3D kfifo_out_spinlocked(xmit, rep->data,
> +					   FT260_WR_UART_DATA_MAX,
> +					   &port->xmit_fifo_lock)) > 0) {
>  		rep->report =3D FT260_UART_DATA_REPORT_ID(len);
>  		rep->length =3D len;
> =20
> -		len =3D kfifo_out_locked(xmit, rep->data, len, &port->write_lock);
> -
> -		ret =3D ft260_hid_output_report(hdev, (u8 *)rep, len + sizeof(*rep));
> +		ret =3D ft260_hid_output_report(hdev, (u8 *)rep, len + 2);
>  		if (ret < 0) {
> -			hid_err(hdev, "Failed to start transfer, ret %d\n", ret);
> -			goto tty_out;
> +			/* Nothing sends the rest, and tcdrain() waits */
> +			spin_lock(&port->xmit_fifo_lock);
> +			kfifo_reset(xmit);
> +			spin_unlock(&port->xmit_fifo_lock);
> +			break;
>  		}
[ ... ]
> @@ -1271,18 +1333,16 @@ static int ft260_uart_receive_chars(struct ft260_=
device *port,
>  }
> =20
>  static ssize_t ft260_uart_write(struct tty_struct *tty, const u8 *buf,
> -				 size_t count)
> +				 size_t cnt)
>  {
>  	struct ft260_device *port =3D tty->driver_data;
> -	struct hid_device *hdev =3D port->hdev;
> -	int len, ret;
> +	ssize_t len;
> =20
> -	len =3D kfifo_in_locked(&port->xmit_fifo, buf, count, &port->write_lock=
);
> -	ft260_dbg("count: %zu, len: %d", count, len);
> +	len =3D kfifo_in_spinlocked(&port->xmit_fifo, buf, cnt,
> +				  &port->xmit_fifo_lock);
> +	ft260_dbg("count: %zu, len: %zd", cnt, len);
> =20
> -	ret =3D ft260_uart_transmit_chars(port);
> -	if (ret < 0)
> -		hid_dbg(hdev, "Failed to transmit chars: %d\n", ret);
> +	schedule_work(&port->tx_work);
> =20
>  	return len;
>  }

[Severity: Medium]
Can taking port->xmit_fifo_lock with plain spin_lock() deadlock against
ft260_uart_write()?

ft260_uart_write() and ft260_uart_transmit_chars() use
kfifo_in_spinlocked() and kfifo_out_spinlocked(), which acquire
port->xmit_fifo_lock with spin_lock_irqsave() because tty->ops->write can
be called from softirq or timer context by a line discipline.  However, the
error path in ft260_uart_transmit_chars(), ft260_uart_flush_buffer(),
ft260_uart_port_activate(), and ft260_uart_port_remove() take
port->xmit_fifo_lock with plain spin_lock():

ft260_uart_flush_buffer()
  spin_lock(&port->xmit_fifo_lock)
  <softirq>
    ft260_uart_write()
      kfifo_in_spinlocked(..., &port->xmit_fifo_lock)
        spin_lock_irqsave(&port->xmit_fifo_lock)  <-- spins forever

>  static unsigned int ft260_uart_write_room(struct tty_struct *tty)
>  {
>  	struct ft260_device *port =3D tty->driver_data;
> =20
> -	return FIFO_SIZE - kfifo_len(&port->xmit_fifo);
> +	return kfifo_avail(&port->xmit_fifo);
>  }
> =20
>  static unsigned int ft260_uart_chars_in_buffer(struct tty_struct *tty)
> @@ -1301,15 +1361,33 @@ static unsigned int ft260_uart_chars_in_buffer(st=
ruct tty_struct *tty)
>  	return kfifo_len(&port->xmit_fifo);
>  }
> =20
> +static void ft260_uart_flush_buffer(struct tty_struct *tty)
> +{
> +	struct ft260_device *port =3D tty->driver_data;
> +
> +	spin_lock(&port->xmit_fifo_lock);
> +	kfifo_reset(&port->xmit_fifo);
> +	spin_unlock(&port->xmit_fifo_lock);
> +
> +	tty_wakeup(tty);
> +}

[Severity: Medium]
Can ft260_uart_write_room() and ft260_uart_chars_in_buffer() race with
kfifo_reset() and return a bogus count?

Both functions read port->xmit_fifo.kfifo.in and port->xmit_fifo.kfifo.out
without holding port->xmit_fifo_lock, while ft260_uart_flush_buffer() and
the error path in ft260_uart_transmit_chars() call kfifo_reset(), which
zeros out and in as two separate stores:

CPU0                              CPU1
ft260_uart_flush_buffer()         ft260_uart_chars_in_buffer()
  spin_lock(&port->xmit_fifo_lock)
  kfifo_reset(&port->xmit_fifo)
    fifo->out =3D 0;
                                    kfifo_len(&port->xmit_fifo)
                                      fifo->in - fifo->out
    fifo->in =3D 0;
  spin_unlock(&port->xmit_fifo_lock)

Once fifo->in and fifo->out have advanced past XMIT_FIFO_SIZE, observing
one reset index alongside one non-zero index Either inflates the count past
XMIT_FIFO_SIZE or underflows unsigned int in fifo->in - fifo->out (or in
kfifo_avail()).

[ ... ]

> @@ -1503,54 +1592,79 @@ static void ft260_uart_start_wakeup(struct timer_=
list *t)
[ ... ]
> +static int ft260_uart_port_activate(struct tty_port *tport, struct tty_s=
truct *tty)
> +{
> +	int ret;
> +	int baudrate;
> +	struct ft260_get_uart_settings_report cfg;
> +	struct ft260_device *port =3D container_of(tport, struct ft260_device, =
port);
> +
> +	mutex_lock(&port->lock);
> +	if (port->removed) {
> +		mutex_unlock(&port->lock);
> +		return -ENODEV;
> +	}
> =20
>  	set_bit(TTY_IO_ERROR, &tty->flags);
> =20
> -	spin_lock(&port->write_lock);
> +	spin_lock(&port->xmit_fifo_lock);
>  	kfifo_reset(&port->xmit_fifo);
> -	spin_unlock(&port->write_lock);
> +	spin_unlock(&port->xmit_fifo_lock);
> =20
> -	ft260_uart_change_speed(port, &tty->termios, NULL);
>  	clear_bit(TTY_IO_ERROR, &tty->flags);
> =20
> -	if (port->reschedule_work) {
> +	/*
> +	 * The port setting may remain intact after session termination.
> +	 * Then, when reopening the port without configuring the port
> +	 * setting, we need to retrieve the baud rate from the device to
> +	 * reactivate the wakeup workaround if needed.
> +	 */
> +	ret =3D ft260_get_uart_settings(port->hdev, &cfg);
> +	if (ret) {
> +		mutex_unlock(&port->lock);
> +		return ret;
> +	}
> +
> +	baudrate =3D get_unaligned_le32(&cfg.baudrate);
> +	ft260_uart_wakeup_workaraund_enable(port,
> +					    baudrate > FT260_UART_EN_PW_SAVE_BAUD);

[Severity: Medium]
Does removing ft260_uart_change_speed() from ft260_uart_port_activate()
leave tty->termios out of sync with the hardware across an unplug and
replug?

ft260_tty_driver is allocated with TTY_DRIVER_REAL_RAW |
TTY_DRIVER_DYNAMIC_DEV, without TTY_DRIVER_RESET_SAVED_TERMIOS.  When a
user configures a non-default baud rate (such as 115200), closes the tty,
and unplugs and replugs the device into the same minor index,
ft260_uart_probe() resets the chip to 9600 8N1 while
tty_port_register_device_attr() keeps the old termios in
ft260_tty_driver->termios[index].  On the next open, tty_init_termios()
restores 115200 into tty->termios, while ft260_uart_port_activate() leaves
the hardware running at 9600.

Passing TTY_DRIVER_RESET_SAVED_TERMIOS to tty_alloc_driver() resets the
saved termios to init_termios (9600 8N1) when the port is registered.

[ ... ]

> @@ -1613,38 +1736,29 @@ static int ft260_i2c_probe(struct hid_device *hde=
v, struct ft260_device *dev)
> =20
>  static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device=
 *dev)
>  {
> -	struct ft260_configure_uart_request req;
> +	struct ft260_configure_uart_request_report req;
>  	int ret;
>  	struct device *devt;
> =20
>  	INIT_WORK(&dev->wakeup_work, ft260_uart_do_wakeup);
> -	// FIXME: Do I need that if I have cancel_work_sync?
> +	INIT_WORK(&dev->tx_work, ft260_uart_tx_work);
>  	// FIXME: are all kfifo access secured by lock? with irq or not?
> -	dev->reschedule_work =3D false;
> +	ft260_uart_wakeup_workaraund_enable(dev, true);
>  	/* Work not started at this point */
>  	timer_setup(&dev->wakeup_timer, ft260_uart_start_wakeup, 0);
> =20
>  	tty_port_init(&dev->port);
>  	dev->port.ops =3D &ft260_uart_port_ops;
> +	/* The destructor unlinks it even if ft260_uart_add_port() fails */
> +	INIT_LIST_HEAD(&dev->device_list);
> =20
>  	ret =3D ft260_uart_add_port(dev);
>  	if (ret) {
>  		hid_err(hdev, "failed to add port\n");
>  		goto err_port;
>  	}
> -	devt =3D tty_port_register_device_attr(&dev->port,
> -					     ft260_tty_driver,
> -					     dev->index, &hdev->dev,
> -					     dev, NULL);
> -	if (IS_ERR(devt)) {
> -		hid_err(hdev, "failed to register tty port\n",
> -		ret =3D PTR_ERR(devt);
> -		goto err_register_tty;
> -	}
> -	hid_info(hdev, "Registering device /dev/%s%d\n",
> -		ft260_tty_driver->name, dev->index);
> =20
> -	/* Send Feature Report to Configure FT260 as UART 9600-8-N-1 */
> +	/* Configure UART to 9600n8 */
>  	req.report	=3D FT260_SYSTEM_SETTINGS;
>  	req.request	=3D FT260_SET_UART_CONFIG;
>  	req.flow_ctrl	=3D FT260_UART_CFG_FLOW_CTRL_NONE;
> @@ -1656,16 +1770,25 @@ static int ft260_uart_probe(struct hid_device *hd=
ev, struct ft260_device *dev)
> =20
>  	ret =3D ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
>  	if (ret < 0) {
> -		hid_err(hdev, "ft260_hid_feature_report_set failed: %d\n",
> -			ret);
> +		hid_err(hdev, "failed to configure uart: %d\n", ret);
> +		goto err_hid_report;
> +	}
> +
> +	devt =3D tty_port_register_device_attr(&dev->port,
> +					     ft260_tty_driver,
> +					     dev->index, &hdev->dev,
> +					     dev, NULL);

[Severity: Medium]
Can publishing dev in ft260_uart_add_port() before
tty_port_register_device_attr() allow a concurrent open to reach
tty_init_dev() before driver->ports[dev->index] is updated?

ft260_uart_install() looks up the port in ft260_uart_device_list via
ft260_uart_port_get() and calls tty_standard_install() instead of
tty_port_install(), leaving tty->port NULL so tty_init_dev() falls back to
driver->ports[idx]:

drivers/hid/hid-ft260.c:ft260_uart_install() {
	int idx =3D tty->index;
	struct ft260_device *port =3D ft260_uart_port_get(idx);
...
	ret =3D tty_standard_install(driver, tty);
}

Because ft260_uart_add_port() adds dev to ft260_uart_device_list before the
sleeping ft260_hid_feature_report_set() transfer, a concurrent open via
tty_kopen_exclusive() or the retry_open loop in tty_open() can install the
tty while driver->ports[idx] is still NULL (triggering WARN_RATELIMIT() in
tty_init_dev()) or still points to a previously removed and freed
ft260_device (since tty_port_unregister_device() does not clear
driver->ports[idx]):

CPU0                                  CPU1
ft260_uart_probe()
  ft260_uart_add_port(dev)
  ft260_hid_feature_report_set()
                                      tty_open_by_driver()
                                        tty_init_dev()
                                          ft260_uart_install()
                                            tty_standard_install()
                                          tty->port =3D driver->ports[idx];
                                          tty->port->itty =3D tty;
                                            <-- NULL deref or use-after-free
  tty_port_register_device_attr()

Calling ft260_uart_add_port() after ft260_hid_feature_report_set() and
using tty_port_install(&port->port, driver, tty) in ft260_uart_install()
avoids both problems.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200423.1956=
1-1-michael.zaidman@gmail.com?part=3D2
