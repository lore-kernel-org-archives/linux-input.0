Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699436;
	b=D5jtkDP8mEF0RcGsl9pc4iNLwI9HwZxSVT3RIUvg74jlbp3m10p+K42OBc6qj59A/+6W
	 ozxXJiHrDW620DbAtpIPG3jXn3Q8wTs83t6CCisaBYesloonmGgkccnjErJDh0Fgf3q8w
	 KPVgGYOaT3w2/GwHxtnIjTgl8cnGSviLhgDMcv1G/sacrpjc0+E0OYOLiT9E91Sft8ZK9
	 AT5hQ9Rvh6rZN/2W1SpMax7U2akjzJI8pMDWOgewCb7q6kRpS9vJst09kFDS01J/Ljt2u
	 s4jnDEJwWzTIa7unl1J8dsE75UbWfO39GY/dKBMG0OGneFXn055793MMzO3e+w+E17A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699436;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4uUAVhdHL8M8KltpxvsIZ9Z8R7zTvb1KAh8WtNZOyH4=;
	b=v5AfKl7V3et7g8kH+dbzTAevuzwzHAS8ciyojmRK5KZn/aQRxJqxaYuOJZQRwmjKo/fj
	 HhlO9XTkECR/kIucB13H+BQEJcgYtqlVwPMjQASn+6/pqJ5JRE+m32xOTZdPpDMzfjEPY
	 9NSw9pie0n+z6Wfz2CdBqmk9s6/cjJ+5G3ffeRAIF5JHhfUUiQdoYu83TKk2b/kZ03mLK
	 oVvx8odJ3rO8J7vSn6HcKd1H8BleX+KQW43jlB0qTT4qdSQHpLmq0G+95HurKu3MOxns6
	 g7NrS8HtA+YBkoRsQ2IUl4zf4zpxBXD2U6mY72p1Ij46JyzAHPk/Onb72DeZZ4Ww+1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tr1gXFyN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4709606A323;
	Sat, 14 Nov 2026 23:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tr1gXFyN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3821F000C4;
	Sat, 14 Nov 2026 23:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794699436;
	bh=4uUAVhdHL8M8KltpxvsIZ9Z8R7zTvb1KAh8WtNZOyH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tr1gXFyNbYKkpJpYSQ7C3jgq0khkg6XK+VtPx0poph3fHmI+XjMxoPcdY43To593q
	 KeOpsuKz/06mr2/9s2sOQibkwa3FaIRb9TY4EnkmlxiKSDCFTo9+R1rzFbWJ0rFFyM
	 SdyFO5FhnD/tmIe2agctdmOm3cLByv119FGKDnxCjqTBMX4vn8j9UC9BVT6Hm0uYpG
	 sZxKEk6LIF4aLebUDxwIQ273lK93uGkW020jNEPVvZmiOWs1hUJgWq7BwsYWQICLqW
	 93pPBIGGogqywYLO9KUNN3HYSMq2Tba54JqWI4zFJP2v+kLtdQVQpwAz3+bC/Xj72e
	 IhKrgCw+KXMcw==
Message-ID: <sashiko-outbox-215115@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/16] HID: ft260: uart: fix the serial driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114230800.1344401-3-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
 <20261114230800.1344401-3-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:37:15 +0000
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
- [High] HID: ft260: undrained xmit_fifo on TX error or remove hangs tty
  drain and vhangup
- [High] HID: ft260: race between tty open/reopen and ft260_remove()
  causes hdev UAF
- [High] HID: ft260: premature list_del() in ft260_uart_port_remove()
  causes index reuse
- [Medium] HID: ft260: missing UART_COUNT_MAX check in
  ft260_uart_add_port()
--

commit 4759b9dbc3d5fe28cb8dc19ab0c19093471e2b92
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: uart: fix the serial driver

This commit fixes buffer sharing, power-save wakeup handling, input report
validation, TX work queueing, and port lifecycle management in the FT260
UART driver.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 982e2ca7a2de6..8d72a22d7a079 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c

[ ... ]

> @@ -1123,8 +1161,8 @@ static int ft260_uart_add_port(struct ft260_device =
*port)
>  	int index =3D 0, ret =3D 0;
>  	struct ft260_device *dev;
> =20
> -	spin_lock_init(&port->write_lock);
> -	if (kfifo_alloc(&port->xmit_fifo, FIFO_SIZE, GFP_KERNEL))
> +	spin_lock_init(&port->xmit_fifo_lock);
> +	if (kfifo_alloc(&port->xmit_fifo, XMIT_FIFO_SIZE, GFP_KERNEL))
>  		return -ENOMEM;
> =20
>  	mutex_lock(&ft260_uart_list_lock);
> @@ -1135,7 +1173,8 @@ static int ft260_uart_add_port(struct ft260_device =
*port)
>  	}
> =20
>  	port->index =3D index;
> -	list_add_tail(&port->device_list, &ft260_uart_device_list);
> +	/* Before the first gap, or at the end: the list stays sorted */
> +	list_add_tail(&port->device_list, &dev->device_list);
>  	mutex_unlock(&ft260_uart_list_lock);
> =20
>  	return ret;

[Severity: Medium]
Can ft260_uart_add_port() assign port->index >=3D UART_COUNT_MAX when more
than four FT260 UART interfaces are probed?

ft260_tty_driver is allocated with UART_COUNT_MAX (4) ports, but
ft260_uart_add_port() never checks index against UART_COUNT_MAX before
adding the port and returning 0.  ft260_uart_probe() then passes
dev->index to tty_port_register_device_attr() -> tty_port_link_device(),
which hits WARN_ON(index >=3D driver->num).

> @@ -1148,7 +1187,12 @@ static void ft260_uart_port_put(struct ft260_devic=
e *port)
> =20
>  static void ft260_uart_port_remove(struct ft260_device *port)
>  {
> -	timer_delete_sync(&port->wakeup_timer);
> +	/*
> +	 * Shut down, not delete: a tty call before the hangup below
> +	 * must not re-arm the timer.
> +	 */
> +	timer_shutdown_sync(&port->wakeup_timer);
> +	cancel_work_sync(&port->wakeup_work);
> =20
>  	mutex_lock(&ft260_uart_list_lock);
>  	list_del(&port->device_list);
>  	mutex_unlock(&ft260_uart_list_lock);

[Severity: High]
Does removing port->device_list in ft260_uart_port_remove() allow a newly
probed FT260 to reuse port->index while an open file descriptor still
keeps the old tty_struct in ft260_tty_driver->ttys[index]?

Until the last file descriptor is closed and release_tty() runs,
ft260_tty_driver->ttys[index] still points to the old hung-up tty_struct.
If the device is re-plugged before that close, ft260_uart_add_port() sees
the index as free and assigns it to the new device.  Opening the new
/dev/ttyFTx then finds the old tty_struct via tty_driver_lookup_tty() and
calls tty_reopen() -> ft260_uart_open() -> ft260_uart_port_activate() on
the old removed ft260_device, dereferencing its stopped and freed
port->hdev.

Moving list_del(&port->device_list) to ft260_uart_port_destroy() would keep
the index reserved until ft260_tty_driver->ttys[index] has been cleared.

[ ... ]

> @@ -1207,61 +1254,51 @@ static int ft260_uart_transmit_chars(struct ft260=
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
> -		if (ret < 0) {
> -			hid_err(hdev, "Failed to start transfer, ret %d\n", ret);
> -			goto tty_out;
> -		}
> +		ret =3D ft260_hid_output_report(hdev, (u8 *)rep, len + 2);
> +		if (ret < 0)
> +			break;
> =20
> -		data_len -=3D len;
>  		port->icount.tx +=3D len;
> -	} while (data_len > 0);
> -
> -	len =3D kfifo_len(xmit);
> -	if ((FIFO_SIZE - len) > TTY_WAKEUP_WATERMARK)
> -		tty_wakeup(tty);
> -
> -	ret =3D 0;
> +	}
> =20
> -tty_out:
> +	tty_wakeup(tty);
>  	tty_kref_put(tty);
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }

[Severity: High]
If ft260_hid_output_report() fails when more than 60 bytes are queued in
xmit_fifo, does breaking out of this loop leave xmit_fifo non-empty with
nothing to drain or flush it?

ft260_uart_chars_in_buffer() then continues returning a non-zero
kfifo_len(&port->xmit_fifo) forever, and ft260_uart_ops has no
.flush_buffer callback.  As a result, tcdrain() and
set_termios(TCSADRAIN/TCSAFLUSH) sleep indefinitely in
wait_event_interruptible(tty->write_wait, !tty_chars_in_buffer(tty)), and
if the device is unplugged while set_termios() is waiting with an ldisc
reference held, ft260_uart_port_remove() -> tty_port_tty_vhangup() ->
tty_ldisc_hangup() blocks forever in tty_ldisc_lock() before reaching
kfifo_free(&port->xmit_fifo):

CPU0                                  CPU1
tty_ioctl() [TCSETSW]
  ld =3D tty_ldisc_ref_wait(tty)
  ...
  set_termios()
    wait_event_interruptible(
      tty->write_wait,
      !tty_chars_in_buffer(tty))
                                      ft260_uart_port_remove()
                                        tty_port_tty_vhangup(&port->port)
                                          ...
                                          tty_ldisc_hangup()
                                            tty_driver_flush_buffer(tty)
                                            wake_up_interruptible_poll(
                                              &tty->write_wait, EPOLLOUT)
    /* xmit_fifo still non-empty,
       goes back to sleep */
                                            tty_ldisc_lock(tty,
                                              MAX_SCHEDULE_TIMEOUT)
                                              <-- hangs forever

[ ... ]

> @@ -1503,53 +1548,69 @@ static void ft260_uart_start_wakeup(struct timer_=
list *t)

[ ... ]

> -static int ft260_uart_activate(struct tty_port *tport, struct tty_struct=
 *tty)
> +static int ft260_uart_port_activate(struct tty_port *tport, struct tty_s=
truct *tty)
>  {
> +	int ret;
> +	int baudrate;
> +	struct ft260_get_uart_settings_report cfg;
> +	struct ft260_device *port =3D container_of(tport, struct ft260_device, =
port);
> +
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

[Severity: High]
Can ft260_uart_port_activate() race with ft260_remove() and dereference
port->hdev after it has been stopped and freed?

CPU0                                  CPU1
tty_open()
  tty_open_by_driver()
    tty_init_dev()
      ft260_uart_install()
        ft260_uart_port_get()
    mutex_unlock(&tty_mutex)
                                      ft260_remove()
                                        ...
                                        ft260_uart_port_remove()
                                          list_del(&port->device_list)
                                          tty_port_tty_vhangup(&port->port)
                                            /* port.tty is still NULL */
                                          kfifo_free(&port->xmit_fifo)
                                        hid_hw_close(hdev)
                                        hid_hw_stop(hdev)
                                        /* hdev freed by HID/USB core */
  ft260_uart_open()
    tty_port_open()
      ft260_uart_port_activate()
        ft260_get_uart_settings(port->hdev, ...)
          <-- use-after-free on port->hdev

The same race also happens on reopen when a second opener waits on
tty_lock_interruptible(tty) in tty_open_by_driver() while
tty_port_tty_vhangup() runs: vhangup clears the tty_port's initialized
flag, and tty_reopen() then proceeds to ft260_uart_open() ->
tty_port_open() -> ft260_uart_port_activate() after ft260_remove() has
finished.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114230800.1344=
401-1-michael.zaidman@gmail.com?part=3D2
