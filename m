Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699580;
	b=i61NWFBzy2Sgt6Y/9ow1lkMDi3tL5tHoyxJscr1Zid0Jt4FOl8lC4de10jN5SGbYfv4J
	 FPFycNz04MbDXUMF73ydXKu7B9Vy607Sns44j6myrAIQJz3OZr+ZFGCEZtZ3XsMP6cYF2
	 yzpkOqUrFHdVZOIa+wmWCfKTrtXsUb1pRK8QMI7EXu5mFgzFM1zg6ynBiymYAJk8zqEcb
	 9y+fi+vN0nFWN49nN7M6sASumkhx2PkwcmoLaTc6zNCjAYlXgqReKzfM7sRiLFNkizunJ
	 ocldxb5LgrcBFfyQoWAst9du7YdW4nicHRfmt9e7HVDoSHrseDQuCDwNqM3tRifgVOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699580;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LI9G/qfltJYghc/lTWkjbrtBN0ameZAHpKSn9LBhWmI=;
	b=vYg/ILDGcL3GN1p6PdyGwZSbaYCbSWTiMfdPTthqNfpDNLkSw426Uz/pGG0hyPyUNKCz
	 3+spTT8Ljt9rSJW5vC+Mtdyf1nPG0e+2tjpujbPi93pOF/KDyXl3ILyMk3bc8ce1YUWv8
	 7OkZxUZHFk0i7gR+7lA1IU0spu9BQLZxDQNADUd0p0S1RRMhLYH2DCQCT+mvAN++Ys//E
	 zWAkcRrgmzkEOvo+PdcgDH/53ifwpvUd1YMekdF5SHw0jXMqZ2I1h61pbCvHdMteL2yMp
	 MZkdM0tKQ3dTP9AyRVnZjmz5DrFRadNtO3E+c5cn6SVgkFfFhY/114e9Xke/yynbLMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OvSKHxNE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149CD606A323;
	Sat, 14 Nov 2026 23:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OvSKHxNE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2E91F000C4;
	Sat, 14 Nov 2026 23:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794699579;
	bh=LI9G/qfltJYghc/lTWkjbrtBN0ameZAHpKSn9LBhWmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OvSKHxNEYUs6wOseHxoUF0b7ndnjFuxeKHBj6IcFac6XMDcu5koAIO4u0YgTaX3nQ
	 mk/ssu4TMqYuGkMZq6VoP8/lWP/tCJ6MPea3+cGrEVcYTpr0VUzM3sRIUBjLgYSbUc
	 8HFsYZkC6dsHcg5bsPEltvB08QChNXjpHe64Q0l0PuDqvxd8R5CsGXOeTCFq5VSCuL
	 MFvhpvfsdTnKheKNdaSOW+aFIeyYvpkHJkcTsnrmAFA1+NVl6AffMKCaVsQwfXMa9y
	 D6yra8C70EEnGBL+ng3rz0o6eQZXo+nCSuynwyfNefGyDqWHxxker9iMDBTAc74WQi
	 AaJN17vkM806A==
Message-ID: <sashiko-outbox-215117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/16] HID: ft260: add serial driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114230800.1344401-2-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
 <20261114230800.1344401-2-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:39:38 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] HID: ft260: UAF on port->hdev and premature xmit_fifo free on
  disconnect
- [High] HID: ft260: use-after-free in ft260_uart_activate() on remove
  race
- [Medium] HID: ft260: missing UART_COUNT_MAX check in
  ft260_uart_add_port()
--

commit 0485244a5cc12377d97264627f49ff95e6a060c7
Author: Christina Quast <contact@christina-quast.de>

HID: ft260: add serial driver

This commit adds a TTY serial driver (/dev/ttyFTx) for the UART interface
of FT260 USB HID devices.

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
> +static int ft260_uart_add_port(struct ft260_device *port)
>  {
> +	int index =3D 0, ret =3D 0;
>  	struct ft260_device *dev;
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

[Severity: Medium]
Does ft260_uart_add_port() need to check if index >=3D UART_COUNT_MAX before
adding the port?  When a fifth FT260 UART interface is probed,
ft260_uart_probe() passes dev->index =3D=3D 4 to
tty_port_register_device_attr(), which triggers a WARN_ON(index >=3D
driver->num) in tty_port_link_device() because ft260_tty_driver was
allocated with UART_COUNT_MAX (4) lines.

While commit "HID: ft260: uart: fix the serial driver" fixes the unsorted
list insertion here, the missing UART_COUNT_MAX bounds check remains at
the end of the series.

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
Can freeing port->xmit_fifo in ft260_uart_port_remove() and leaving
port->hdev accessible after ft260_remove() cause a use-after-free?

struct ft260_device stays alive until the final tty_port reference is
dropped in ft260_uart_cleanup() -> ft260_uart_port_destroy(), whereas
ft260_remove() calls ft260_uart_port_remove(), hid_hw_close(hdev), and
hid_hw_stop(hdev), after which usbhid_disconnect() -> hid_destroy_device()
frees hdev.  If a process keeps an open file descriptor across
ft260_remove() and reopens it (for example via /proc/self/fd/<fd>),
tty_open_by_driver() takes the tty_reopen() path into tty_port_open() ->
ft260_uart_activate(), which resets the already freed port->xmit_fifo and
calls ft260_uart_change_speed() -> ft260_hid_feature_report_set() on the
freed port->hdev.  Because ft260_uart_activate() also ignores the return
value of ft260_uart_change_speed() and clears TTY_IO_ERROR, the reopen
succeeds and subsequent ft260_uart_write() and ft260_uart_set_termios()
calls operate on the freed FIFO and freed hdev as well.

Commit "HID: ft260: uart: fix the serial driver" and commit "HID: ft260:
uart: add modem pins control via ioctl" add a port->removed flag for the
modem control ioctls, but ft260_uart_port_activate() and
ft260_uart_change_speed() still do not check port->removed and
port->xmit_fifo is still freed in ft260_uart_port_remove() rather than
ft260_uart_port_destroy().

[ ... ]

> +static int ft260_uart_install(struct tty_driver *driver, struct tty_stru=
ct *tty)
> +{
> +	int idx =3D tty->index;
> +	struct ft260_device *port =3D ft260_uart_port_get(idx);
> +	int ret;
> +
> +	if (!port)
> +		return -ENODEV;
> +
> +	ret =3D tty_standard_install(driver, tty);
>  	if (ret) {
> +		ft260_uart_port_put(port);
>  		return ret;
>  	}
> =20
> +	tty->driver_data =3D port;
> +	return 0;
> +}

[ ... ]

> +static int ft260_uart_activate(struct tty_port *tport, struct tty_struct=
 *tty)
> +{
> +	struct ft260_device *port =3D
> +		container_of(tport, struct ft260_device, port);
> +
> +	/*
> +	 * Set the TTY IO error marker - we will only clear this
> +	 * once we have successfully opened the port.
> +	 */
> +	set_bit(TTY_IO_ERROR, &tty->flags);
> +
> +	spin_lock(&port->write_lock);
> +	kfifo_reset(&port->xmit_fifo);
> +	spin_unlock(&port->write_lock);
> +
> +	ft260_uart_change_speed(port, &tty->termios, NULL);
> +	clear_bit(TTY_IO_ERROR, &tty->flags);
> +
> +	if (port->reschedule_work) {
> +		mod_timer(&port->wakeup_timer, jiffies +
> +			  msecs_to_jiffies(FT260_WAKEUP_NEEDED_AFTER_MS));
> +	}
> +
> +	return 0;
> +}

[Severity: High]
What prevents ft260_uart_activate() from running after ft260_remove() when
tty_open() races with disconnect?

CPU0                                  CPU1
tty_open()
  tty_init_dev()
    ft260_uart_install()
      ft260_uart_port_get()
      tty->driver_data =3D port
                                      usbhid_disconnect()
                                        hid_destroy_device()
                                          ft260_remove()
                                            ft260_uart_port_remove()
                                              list_del(&port->device_list)
                                              tty_port_tty_vhangup(&port->p=
ort)
                                              kfifo_free(&port->xmit_fifo)
                                            hid_hw_close(hdev)
                                            hid_hw_stop(hdev)
                                          kfree(hdev)
  ft260_uart_open()
    tty_port_open()
      tty_port_tty_set()
      ft260_uart_activate()
        kfifo_reset(&port->xmit_fifo)
        ft260_uart_change_speed()
          ft260_hid_feature_report_set(port->hdev, ...)
                                      <-- use-after-free on port->hdev

Between ft260_uart_install() and tty_port_open(), port->port.tty is still
NULL, so tty_port_tty_vhangup() in ft260_uart_port_remove() sees no tty to
hang up.  tty_open() then enters ft260_uart_activate(), resets the freed
port->xmit_fifo, dereferences the freed port->hdev, and clears
TTY_IO_ERROR so the open succeeds on the removed device.  Even after commit
"HID: ft260: uart: fix the serial driver" and commit "HID: ft260: uart:
add modem pins control via ioctl", ft260_uart_port_activate() still does
not check whether the device was removed under a lock synchronized with
disconnect.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114230800.1344=
401-1-michael.zaidman@gmail.com?part=3D1
