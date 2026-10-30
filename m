Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793401395;
	b=g04L7dXmPj1Pt8C3fTc23NRv1lTKFkHSRNM3ieYtH6lctu6OnIO8WM3oRAL/E+jNmtDD
	 EevRXmfjumO4n0RPYEaCJmqu4TORoS299aeqRwF7d8x54AKlyQ+7BLchfyq0YgLFgnAvK
	 qQG9GGBlOj6UjbmroxqRhvQRThIntC6/H0c8dMgwXha2KyRJddhvZvZ0FaGx0xosdVQrl
	 /x4YAi05VmuZ64iEIk5MSQorZ/u0kOdwDs8gaT0oKVni2m8Rmgw1svUPIdu/apKsY+vbL
	 CD/wNbGh8Fig+jowF38/rRJvA6xOPTNVchtyn8V7wM59ZY6+cpJ8H7igaDWJp50/eIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793401395;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W2UmZSWclkhhavpuxs42JKM0kzMM2/tca2oq13k49x0=;
	b=b5XmbecTclh2F0rZI3m2S/kdbkJBCxR3kIv95k69aRcUQN5jOWTrUN7tkzust0hMe8SX
	 nfszu+Th+YlAaLtff+fzHzbuusJYBl4yHapUZyzkti6GIV2N683Krl4Bw/iWYN1Ok8Gxb
	 xYdW46nlh2pQ/HWdRC/cjHHNdtuK5aIyVuEK9VzLbABcRwtycVHvJnrPyzwY6JRItU0k3
	 U1I3IqCW8tj7SGjD8v4sUK5NCYsbEsAfQm14R9EKOcxpAJNHV6cRnCI40nXNZsB17p2kw
	 0zUSQ1nvBMkNL7HQRMXcPCnZBLnQrK2jgF+pPS0NziVd1ceISUARnGdN/sLQaDNsJEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eCPCYp3d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D334A606A31A;
	Fri, 30 Oct 2026 23:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eCPCYp3d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B841F000C1;
	Fri, 30 Oct 2026 23:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793401394;
	bh=W2UmZSWclkhhavpuxs42JKM0kzMM2/tca2oq13k49x0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eCPCYp3dnRLVfRvstXyZ8Mk/R4EgOn7wdusVJhMemjcQaPlVX3t2ohsFHrRWuTiY4
	 AQK5nKLbO7nAccjGtJXEGl/n7tn/ZixAKuy0/DqelpBzip1THu1EDwV5fuatZSm0Xv
	 8yyt0SbIxsIdRt9Y2NBtw3SWXRe+d568+v8BvPTzboMOz40cDLKhBTjHNWnyhKpRY0
	 KARpbpL/FFkL7lDaDALDPYKn1MnsloC3EbzEXelRmzQDxkYTdvAPHpqdU6IC4nu2qa
	 q7T4x0/n/ASkhJGw8az9H6+nfV9O9LOERpOLANPze5P+rKBzClQgAGawbC030QCtYv
	 k740sSj9Y3x+Q==
Message-ID: <sashiko-outbox-191615@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/15] HID: ft260: uart: fix the serial driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261030223637.86907-3-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
 <20261030223637.86907-3-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 23:03:13 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] HID: ft260: invalid report ID 0xFF in ft260_uart_transmit_chars()
- [High] HID: ft260: race and infinite loop in ft260_uart_transmit_chars()
- [High] HID: ft260: wakeup timer and work teardown race in ft260_remove()
- [High] HID: ft260: broken index allocation and bounds check in ft260_uart=
_add_port()
- [High] HID: ft260: UAF and double free when ft260_get_interface_type() re=
turns 0
- [High] HID: ft260: missing iface_type check for UART reports in ft260_raw=
_event()
- [Medium] HID: ft260: unconditional wakeup timer in ft260_uart_port_activa=
te()
- [Medium] HID: ft260: ft260_uart_probe() registers TTY device before confi=
guring UART
- [Low] HID: ft260: unneeded ft260_uart_wakeup() prototype and changelog mi=
smatches
--

commit 120d1c2c1f711fdf1a272089095a3cbf1a2d1d34
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: uart: fix the serial driver

This commit updates the FT260 serial driver to separate the UART and I2C TX
buffers, adjust the power-save wakeup timer logic, validate HID input report
lengths against the received report size, and clean up interface detection =
and
FIFO handling.

>     HID: ft260: uart: fix the serial driver
>    =20
>     Fix the serial driver added by the previous patch, a port of
>     Christina Quast's v4, so that it works reliably on hardware.
>    =20
>     The UART and I2C paths shared write_buf without proper separation,
>     so concurrent use could corrupt transfers on both channels. Give
>     UART its own TX buffer. The write request report is now built in
>     that fixed per-port buffer, so its payload member becomes a fixed
>     FT260_WR_UART_DATA_MAX (62) array rather than a __counted_by()
>     flexible array, which describes a runtime-counted allocation this
>     path no longer makes.
>    =20
>     The FT260 enters power-save after ~5s idle, which drops RX data at
>     higher baud rates. Keep a timed dummy wakeup, but only when needed:
>     skip it below 4800 baud and when EEPROM disables power-save; wake
>     earlier before RX; avoid configuring baud or disabling the workaround
>     twice; and arm the timer when a tty session starts.
>    =20
>     The received report length was validated against the actual HID report
>     size only on the I2C path. The UART path instead bounded the
>     device-supplied length against FT260_RD_DATA_MAX (180), which is the
>     maximum I2C read payload, not a bound on the report buffer. As a UART
>     payload cannot exceed FT260_WR_UART_DATA_MAX (62) bytes, a report
>     claiming more would make ft260_uart_receive_chars() push data past the
>     end of the report buffer into the tty flip buffer. Validate the length
>     against the received report size once, before dispatching on the repo=
rt
>     type, and drop the two now-redundant FT260_RD_DATA_MAX checks.
>    =20
>     Also fix RX data loss after reopening the device, improve TX
>     throughput, simplify HID interface-type detection, use kfifo_avail
>     for write-room, and ignore spurious UART interrupt status (0xb1)
>     reports instead of treating them as errors.
>    =20
>     Also includes UART cleanup and refactoring to match the rest of the
>     driver style: replace the kfifo_*_locked aliases with
>     kfifo_*_spinlocked, and drop the parentheses around single-value
>     defines, which coding-style asks for only when the value is an
>     expression.
>    =20
>     This replaces the UART bring-up fix series:
>     https://lore.kernel.org/all/20240210215147.77629-1-michael.zaidman@gm=
ail.com/
>    =20
>     Do not treat UART interrupt status (0xB1) as a payload length. When
>     re-enabling the power-save wakeup workaround after a baud change,
>     re-arm the timer (reported by Sashiko).
>    =20
>     Report 0xE1 is defined as FT260_UART_RI_DCD_STATUS, but AN_394 section
>     4.3 lists 0xE2 for "UART RI and DCD Status". Correct the value. The
>     macro has no user, because the DCD and RI levels arrive in the 0xB1
>     interrupt report, which ft260_raw_event() handles.
>    =20
>     Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

[Severity: Low]
This isn't a bug in the code, but does the commit message match what the pa=
tch
does here?

The changelog mentions waking earlier before RX, but
FT260_WAKEUP_NEEDED_AFTER_MS remains 4800 ms and ft260_uart_wakeup() is only
called from the periodic ft260_uart_do_wakeup() work handler.

The last paragraph also states that DCD and RI levels arrive in the 0xB1
interrupt report, which ft260_raw_event() handles, whereas ft260_raw_event()
ignores FT260_UART_INTERRUPT_STATUS (0xB1) and returns 0.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 982e2ca7a2de6..c859486cb28c8 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
[ ... ]
> @@ -38,11 +34,14 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messa=
ges");
>  			pr_info("%s: " format, __func__, ##arg);	  \
>  	} while (0)
> =20
> -#define FT260_REPORT_MAX_LENGTH (64)
> -#define FT260_I2C_DATA_REPORT_ID(len) (FT260_I2C_REPORT_MIN + (len - 1) =
/ 4)
> -#define FT260_UART_DATA_REPORT_ID(len) (FT260_UART_REPORT_MIN + (len - 1=
) / 4)
> +#define FT260_REPORT_MAX_LEN 64
> +#define FT260_DATA_REPORT_ID(min, len) (min + (len - 1) / 4)
> +#define FT260_I2C_DATA_REPORT_ID(len) \
> +		FT260_DATA_REPORT_ID(FT260_I2C_REPORT_MIN, len)
> +#define FT260_UART_DATA_REPORT_ID(len) \
> +		FT260_DATA_REPORT_ID(FT260_UART_REPORT_MIN, len)
> =20
> -#define FT260_WAKEUP_NEEDED_AFTER_MS (4800) /* 5s minus 200ms margin */
> +#define FT260_WAKEUP_NEEDED_AFTER_MS 4800 /* 5s minus 200ms margin */
> =20
>  /*
>   * The ft260 input report format defines 62 bytes for the data payload, =
but
> @@ -55,8 +54,9 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging message=
s");
>   * of I2C for potentially troublesome amounts of time, we select the max=
imum
>   * read payload length to be 180 bytes.
>   */
> -#define FT260_RD_DATA_MAX (180)
> -#define FT260_WR_DATA_MAX (60)
> +#define FT260_RD_DATA_MAX 180
> +#define FT260_WR_I2C_DATA_MAX 60
> +#define FT260_WR_UART_DATA_MAX 62

[Severity: High]
When ft260_uart_write() calls ft260_uart_transmit_chars() with 61 or more
bytes in xmit_fifo, len is clamped to FT260_WR_UART_DATA_MAX (62):

    len =3D min(data_len, FT260_WR_UART_DATA_MAX);
    rep->report =3D FT260_UART_DATA_REPORT_ID(len);

For len =3D 61 or 62, (len - 1) / 4 evaluates to 15, so
FT260_UART_DATA_REPORT_ID(len) produces 0xF0 + 15 =3D 0xFF.

Since the valid UART data report IDs end at FT260_UART_REPORT_MAX (0xFE, wh=
ich
carries 57 to 62 payload bytes), won't setting rep->report to 0xFF cause
transfers of 61 or 62 bytes to fail with an invalid HID report ID?

[ ... ]
> @@ -937,27 +951,25 @@ static int ft260_get_interface_type(struct hid_devi=
ce *hdev, struct ft260_device
>  	ft260_dbg("i2c_enable: 0x%02x\n", cfg.i2c_enable);
>  	ft260_dbg("uart_mode:  0x%02x\n", cfg.uart_mode);
> =20
> -	dev->ft260_is_serial =3D false;
> +	dev->power_saving_en =3D cfg.power_saving_en;
> =20
>  	switch (cfg.chip_mode) {
>  	case FT260_MODE_ALL:
>  	case FT260_MODE_BOTH:
> -		if (interface =3D=3D 1) {
> +		if (interface =3D=3D 1)
>  			ret =3D FT260_IFACE_UART;
> -			dev->ft260_is_serial =3D true;
> -		} else {
> +		else
>  			ret =3D FT260_IFACE_I2C;
> -		}
>  		break;
>  	case FT260_MODE_UART:
>  		ret =3D FT260_IFACE_UART;
> -		dev->ft260_is_serial =3D true;
>  		break;
>  	case FT260_MODE_I2C:
>  		ret =3D FT260_IFACE_I2C;
>  		break;
>  	}
> =20
> +	dev->iface_type =3D ret;
>  	return ret;
>  }

[Severity: High]
If cfg.chip_mode does not match any of the four cases in
ft260_get_interface_type(), ret remains 0 (from ft260_get_system_config()),
which equals FT260_IFACE_NONE.

In ft260_probe(), hid_set_drvdata(hdev, dev) is called before
ft260_get_interface_type(), and the check:

    ret =3D ft260_get_interface_type(hdev, dev);
    if (ret <=3D FT260_IFACE_NONE)
        goto err_hid_close;

jumps to err_hid_close with ret =3D=3D 0. That error path frees dev via kfr=
ee(dev)
and returns 0 from ft260_probe().

Won't returning 0 cause the driver core to treat probe as successful, leadi=
ng
to a use-after-free and double free of dev when ft260_remove() later retrie=
ves
dev from hid_get_drvdata(hdev)?

[ ... ]
> @@ -1101,12 +1113,36 @@ static const struct attribute_group ft260_attr_gr=
oup =3D {
>  	}
>  };
> =20
> -/***
> - * START Serial dev part
> - */
>  static DEFINE_MUTEX(ft260_uart_list_lock);
>  static LIST_HEAD(ft260_uart_device_list);
> =20
> +static void ft260_uart_wakeup(struct ft260_device *dev);

[Severity: Low]
This isn't a bug, but is this forward declaration of ft260_uart_wakeup()
needed? Its only caller is ft260_uart_do_wakeup(), which is defined right
below ft260_uart_wakeup().

[ ... ]
> @@ -1123,8 +1159,8 @@ static int ft260_uart_add_port(struct ft260_device =
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

[Severity: High]
In ft260_uart_add_port(), the minor index search assumes
ft260_uart_device_list is sorted by index, but new ports are appended to the
tail of the list without checking UART_COUNT_MAX:

    mutex_lock(&ft260_uart_list_lock);
    list_for_each_entry(dev, &ft260_uart_device_list, device_list) {
        if (dev->index !=3D index)
            break;
        index++;
    }

    port->index =3D index;
    list_add_tail(&port->device_list, &ft260_uart_device_list);
    mutex_unlock(&ft260_uart_list_lock);

If ports 0 and 1 are added, port 0 is removed, and a new port A is probed,
port A gets index 0 and is placed at the tail (making the list order [1, 0]=
).
If another port B is then probed, the first entry has dev->index =3D=3D 1 !=
=3D 0, so
the loop breaks immediately and assigns index 0 to port B as well.

When ft260_uart_probe() then calls tty_port_register_device_attr(),
tty_port_link_device() overwrites ft260_tty_driver->ports[0] with &devB->po=
rt
before tty_register_device_attr() fails with -EEXIST and frees devB, leaving
ft260_tty_driver->ports[0] dangling for ft260_uart_install() ->
tty_standard_install(). Also, if more than UART_COUNT_MAX (4) ports are
probed, index >=3D UART_COUNT_MAX triggers WARN_ON(index >=3D driver->num) =
in
tty_port_link_device().

Should ft260_uart_add_port() insert before dev->device_list to keep the list
sorted and return an error when index >=3D UART_COUNT_MAX?

[ ... ]
> @@ -1217,30 +1253,24 @@ static int ft260_uart_transmit_chars(struct ft260=
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
>  			goto tty_out;
> -		}
> =20
>  		data_len -=3D len;
>  		port->icount.tx +=3D len;
>  	} while (data_len > 0);
> =20
> -	len =3D kfifo_len(xmit);
> -	if ((FIFO_SIZE - len) > TTY_WAKEUP_WATERMARK)
> -		tty_wakeup(tty);
> -
>  	ret =3D 0;
> =20
>  tty_out:

[Severity: High]
As reported by Sashiko on v1 [1], ft260_uart_transmit_chars() builds outgoi=
ng
reports in the shared per-port buffer port->uart_wr_buf without holding a l=
ock
across the loop while ft260_hid_output_report() sleeps.

If two threads enter ft260_uart_write() -> ft260_uart_transmit_chars()
concurrently (or if kfifo_reset() runs in ft260_uart_port_activate()):

1. Both threads can overwrite port->uart_wr_buf concurrently before kmemdup=
()
   in ft260_hid_output_report() copies it.
2. Because rep->report and rep->length are set from data_len before
   kfifo_out_spinlocked(), a racing thread draining xmit_fifo can cause
   kfifo_out_spinlocked() to return fewer bytes than rep->length, or 0 byte=
s.
3. If kfifo_out_spinlocked() returns 0, ft260_hid_output_report() sends a
   2-byte report with a non-zero rep->length and data_len -=3D 0 never
   terminates the while (data_len > 0) loop.

Also, with tty_wakeup(tty) removed here, what wakes up a writer waiting for
write room after xmit_fifo fills up?

[ ... ]
> @@ -1503,53 +1537,68 @@ static void ft260_uart_start_wakeup(struct timer_=
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
> -		mod_timer(&port->wakeup_timer, jiffies +
> -			  msecs_to_jiffies(FT260_WAKEUP_NEEDED_AFTER_MS));
> -	}
> +	/*
> +	 * The port setting may remain intact after session termination.
> +	 * Then, when reopening the port without configuring the port
> +	 * setting, we need to retrieve the baud rate from the device to
> +	 * reactivate the wakeup workaround if needed.
> +	 */
> +	ret =3D ft260_get_uart_settings(port->hdev, &cfg);
> +	if (ret)
> +		return ret;
> +
> +	baudrate =3D get_unaligned_le32(&cfg.baudrate);
> +	if (baudrate > FT260_UART_EN_PW_SAVE_BAUD)
> +		ft260_uart_wakeup_workaraund_enable(port, true);
> +
> +	ft260_dbg("configured baudrate =3D %d", baudrate);
> +
> +	mod_timer(&port->wakeup_timer, jiffies +
> +		  msecs_to_jiffies(FT260_WAKEUP_NEEDED_AFTER_MS));
> =20
>  	return 0;
>  }

[Severity: Medium]
In ft260_uart_port_activate(), mod_timer(&port->wakeup_timer, ...) is now
called unconditionally rather than only when port->reschedule_work is true.
Also, if baudrate <=3D FT260_UART_EN_PW_SAVE_BAUD on the first open after
ft260_uart_probe() enabled the workaround, port->reschedule_work remains tr=
ue.

Should ft260_uart_port_activate() pass baudrate > FT260_UART_EN_PW_SAVE_BAUD
directly to ft260_uart_wakeup_workaraund_enable() and guard mod_timer() with
if (port->reschedule_work), as in ft260_uart_change_speed()?

[ ... ]
> @@ -1641,10 +1689,10 @@ static int ft260_uart_probe(struct hid_device *hd=
ev, struct ft260_device *dev)
>  		ret =3D PTR_ERR(devt);
>  		goto err_register_tty;
>  	}
> -	hid_info(hdev, "Registering device /dev/%s%d\n",
> +	hid_info(hdev, "registering device /dev/%s%d\n",
>  		ft260_tty_driver->name, dev->index);
> =20
> -	/* Send Feature Report to Configure FT260 as UART 9600-8-N-1 */
> +	/* Configure UART to 9600n8 */
>  	req.report	=3D FT260_SYSTEM_SETTINGS;
>  	req.request	=3D FT260_SET_UART_CONFIG;
>  	req.flow_ctrl	=3D FT260_UART_CFG_FLOW_CTRL_NONE;
> @@ -1656,8 +1704,7 @@ static int ft260_uart_probe(struct hid_device *hdev=
, struct ft260_device *dev)
> =20
>  	ret =3D ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
>  	if (ret < 0) {
> -		hid_err(hdev, "ft260_hid_feature_report_set failed: %d\n",
> -			ret);
> +		hid_err(hdev, "failed to configure uart: %d\n", ret);
>  		goto err_hid_report;
>  	}

[Severity: Medium]
In ft260_uart_probe(), tty_port_register_device_attr() exposes /dev/ttyFT* =
to
userspace before ft260_hid_feature_report_set() configures the UART to 9600=
n8.

Since ft260_uart_port_activate() now reads the active UART settings from the
chip via ft260_get_uart_settings() instead of calling
ft260_uart_change_speed(), can a userspace process opening the port
immediately after registration read uninitialized UART settings or have its
termios changes overwritten by the 9600n8 feature report in
ft260_uart_probe()?

[ ... ]
> @@ -1765,7 +1812,7 @@ static void ft260_remove(struct hid_device *hdev)
>  	if (!dev)
>  		return;
> =20
> -	if (dev->ft260_is_serial) {
> +	if (dev->iface_type =3D=3D FT260_IFACE_UART) {
>  		timer_delete_sync(&dev->wakeup_timer);
>  		cancel_work_sync(&dev->wakeup_work);
>  		tty_port_unregister_device(&dev->port, ft260_tty_driver,
> @@ -1779,7 +1826,7 @@ static void ft260_remove(struct hid_device *hdev)
>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);
> =20
> -	if (dev->ft260_is_serial)
> +	if (dev->iface_type =3D=3D FT260_IFACE_UART)
>  		ft260_uart_port_put(dev);
>  	else
>  		kfree(dev);

[Severity: High]
As reported by Sashiko on v1 [2], is the teardown ordering of wakeup_timer =
and
wakeup_work safe against concurrent TTY operations during removal?

In ft260_remove() and ft260_uart_port_remove():

    ft260_remove()
        timer_delete_sync(&dev->wakeup_timer);
        cancel_work_sync(&dev->wakeup_work);
        tty_port_unregister_device(&dev->port, ft260_tty_driver, dev->index=
);
        ft260_uart_port_remove(dev)
            timer_delete_sync(&port->wakeup_timer);
            list_del(&port->device_list);
            tty_port_tty_vhangup(&port->port);

Because port->reschedule_work is only cleared when tty_port_tty_vhangup()
invokes ft260_uart_port_shutdown():

1. If wakeup_timer fires between cancel_work_sync() in ft260_remove() and
   timer_delete_sync() in ft260_uart_port_remove(), ft260_uart_start_wakeup=
()
   schedules wakeup_work, which is never cancelled afterwards (and the
   err_hid_report error path in ft260_uart_probe() never calls
   cancel_work_sync() at all).
2. Until list_del() and tty_port_tty_vhangup() complete, a concurrent
   ft260_uart_change_speed() or ft260_uart_port_activate() can set
   port->reschedule_work =3D true and re-arm wakeup_timer via mod_timer() a=
fter
   timer_delete_sync() has already run, leaving the timer or work active af=
ter
   hid_hw_stop() and ft260_uart_port_put() free dev.

Should timer_delete_sync(&port->wakeup_timer) and
cancel_work_sync(&port->wakeup_work) happen after list_del() and
tty_port_tty_vhangup() have finished shutting down the port?

> @@ -1797,6 +1844,13 @@ static int ft260_raw_event(struct hid_device *hdev=
, struct hid_report *report,
[ ... ]
> @@ -1837,12 +1884,11 @@ static int ft260_raw_event(struct hid_device *hde=
v, struct hid_report *report,
> =20
>  		return 0;
> =20
> -	} else if (xfer->length > FT260_RD_DATA_MAX) {
> -		hid_err(hdev, "received data too long (%d)\n", xfer->length);
> -		return -EBADR;
>  	} else if (xfer->report >=3D FT260_UART_REPORT_MIN &&
>  		   xfer->report <=3D FT260_UART_REPORT_MAX) {
>  		return ft260_uart_receive_chars(dev, xfer->data, xfer->length);
> +	} else if (xfer->report =3D=3D FT260_UART_INTERRUPT_STATUS) {
> +		return 0;
>  	}
>  	hid_err(hdev, "unhandled report %#02x\n", xfer->report);

[Severity: High]
In ft260_probe(), tty_port_init(&dev->port) is only called on the UART path=
 in
ft260_uart_probe(). When dev->iface_type =3D=3D FT260_IFACE_I2C, dev->port =
is left
zero-initialized with dev->port.buf.tail =3D=3D NULL.

If an input report in the range FT260_UART_REPORT_MIN..FT260_UART_REPORT_MAX
arrives on an I2C interface, ft260_raw_event() calls
ft260_uart_receive_chars() -> tty_insert_flip_string(&port->port, ...), whi=
ch
dereferences port->port.buf.tail in __tty_buffer_request_room().

Should ft260_raw_event() check that dev->iface_type =3D=3D FT260_IFACE_UART=
 before
dispatching UART reports to ft260_uart_receive_chars()?

[1] https://lore.kernel.org/r/20260822215615.2D8541F000E9@smtp.kernel.org
[2] https://lore.kernel.org/r/20260822215615.2D8541F000E9@smtp.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030223637.8690=
7-1-michael.zaidman@gmail.com?part=3D2
