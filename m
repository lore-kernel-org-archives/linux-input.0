Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986484;
	b=b8B0sI/KLHncHSjgAncNqepq0Y3heEyx6uIc0wOE2KDfagxGcWYStcABDLYYX+AKiOad
	 3/hi8Eru9c6bmePf78QBdYdIE5bm5afCTe8pg3jDXRbpVk4sGSt1EyIMKEwXVVaL2t0f9
	 O5tRGmulga71IZ/RESeQa66UuBTL0QseXyjn5lQyg4qVvxEG1BkVWTKiE/RHWob8Px9yU
	 MmBZwPGHZTCXSUyCSqCeKTMDDXH8JMHeug+zcZlH7t0ACTvZQKG+j4mPpALzZaXYKpD1K
	 5ZbITZDTtn3BNyLWf0FxNv2Kiy9tk7USBCxdGFt8qjbikCiZoc8Qv9WM6wNCbeZPvjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986484;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=cn+lshhcY8tFLWoGfyjNIe0PCy8NHIzlSqm5mPo9WBg=;
	b=NFSr3zKVU8mBp+B287J0MoCiNUWtEblnC4tm24gHEG1pD7B2Jfd5l/jVucsjoIfmZeju
	 lCHDUaG2LtDxsOwSKlEzSaxL1L+/cLh4vhrzjppkBYc6XOfEYHrLiwC2xFsOhnSayJAgv
	 gNdXrMIoguZUnfywgRALogiYmm+uuUHi9iZv/mFoRKKSfxjbfKhp9HZ1mCmtaDrK1xrYx
	 +wSU8xJHaJ6k9fZFjmiHWUDkKU5D+i3NAvvGMAVeUiRojzC4fkB5Ta6twKI4TaM6xuHRt
	 LCBhDMNjIPuIHpMz7mA07I2oOmtSKkzQ+FssKy5vtN7EIaX+DK+ltLxmgtedMKOO0LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9CKdsc5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4E3606A32C;
	Wed, 18 Nov 2026 07:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9CKdsc5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30801F000C4;
	Wed, 18 Nov 2026 07:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794986484;
	bh=cn+lshhcY8tFLWoGfyjNIe0PCy8NHIzlSqm5mPo9WBg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L9CKdsc5moFmrAKxMJsnGTfFAzJVQgQe9FyvDy3KRVNJ1gKdB2yEClDWc/cD0T3zx
	 Wafih6/9S1EOHkeEpfR8Bo/RkAu5WoZuZPs30UACuf5RTMjO7cEEnDMDTj0jdYygsr
	 lHtARkMqv0Ealb1Hl/Dfep5PQftDdgX3kcAtn9L1GYvucufnmmyZvAkfDt3Qf1ECee
	 JI/nUIaj8ZzmC/Ii6PfseKKurjClAt1+BtbNAO55IE9mRKB+KtKrLoLEuWfZoJxvgV
	 MAnc2kgszQ4lbRWKv4UzQvbEjxVEggNQYwxZxFncLzx9v36ku7uxfNeNRHNxOnl2GK
	 JJWczGVzSoWFA==
Message-ID: <0c96e0ee-55e7-4999-922e-bc52aa516d2e@kernel.org>
Date: Wed, 18 Nov 2026 08:21:18 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/16] HID: ft260: add serial driver
To: Michael Zaidman <michael.zaidman@gmail.com>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
 Germain Hebert <germain.hebert@ca.abb.com>,
 Christina Quast <contact@christina-quast.de>, Rio Liu <rio@r26.me>,
 Bruno Giacomazzi <brunoceg1@gmail.com>, linux-input@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Beer <daniel.beer@igorinstitute.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
 <20261117200423.19561-2-michael.zaidman@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20261117200423.19561-2-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 17. 11. 26, 21:04, Michael Zaidman wrote:
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -13,6 +13,16 @@
>   #include <linux/i2c.h>
>   #include <linux/module.h>
>   #include <linux/usb.h>
> +#include <linux/serial.h>
> +#include <linux/serial_core.h>
> +#include <linux/kfifo.h>
> +#include <linux/tty_flip.h>
> +#include <linux/minmax.h>
> +#include <linux/unaligned.h>

Sort these.

> @@ -236,6 +314,22 @@ MODULE_DEVICE_TABLE(hid, ft260_devices);
>   struct ft260_device {
>   	struct i2c_adapter adap;
>   	struct hid_device *hdev;
> +
> +	bool ft260_is_serial;
> +	struct list_head device_list;
> +
> +	/* tty_port lifetime is equal to device lifetime */
> +	struct tty_port port;
> +	unsigned int index;
> +	struct kfifo xmit_fifo;

Why not to use port.xmit_fifo?

> +	/* write_lock: lock to serialize access to xmit fifo */
> +	spinlock_t write_lock;
> +	struct uart_icount icount;
> +
> +	struct timer_list wakeup_timer;
> +	struct work_struct wakeup_work;
> +	bool reschedule_work;
> +
>   	struct completion wait;
>   	struct mutex lock;
>   	u8 write_buf[FT260_REPORT_MAX_LENGTH];
> @@ -379,7 +473,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
>   
>   	ret = ft260_hid_output_report(hdev, data, len);
>   	if (ret < 0) {
> -		hid_err(hdev, "%s: failed to start transfer, ret %d\n",
> +		hid_dbg(hdev, "%s: failed to start transfer, ret %d\n",
>   			__func__, ret);
>   		ft260_i2c_reset(hdev);
>   		return ret;
> @@ -609,7 +703,7 @@ static int ft260_i2c_write_read(struct ft260_device *dev, struct i2c_msg *msgs)
>   		else
>   			read_off = *msgs[0].buf;
>   
> -		pr_info("%s: off %#x rlen %d wlen %d\n", __func__,
> +		ft260_dbg("%s: off %#x rlen %d wlen %d\n", __func__,

There should be likely a separate patch with the above two hunks.

>   			read_off, rd_len, wr_len);
>   	}
>   
> @@ -826,7 +920,7 @@ static int ft260_get_system_config(struct hid_device *hdev,
>   	return 0;
>   }
>   
> -static int ft260_is_interface_enabled(struct hid_device *hdev)
> +static int ft260_get_interface_type(struct hid_device *hdev, struct ft260_device *dev)

Switch int to the enum then?

>   {
>   	struct ft260_get_system_status_report cfg;
>   	struct usb_interface *usbif = to_usb_interface(hdev->dev.parent);
> @@ -843,21 +937,27 @@ static int ft260_is_interface_enabled(struct hid_device *hdev)
>   	ft260_dbg("i2c_enable: 0x%02x\n", cfg.i2c_enable);
>   	ft260_dbg("uart_mode:  0x%02x\n", cfg.uart_mode);
>   
> +	dev->ft260_is_serial = false;
> +
>   	switch (cfg.chip_mode) {
>   	case FT260_MODE_ALL:
>   	case FT260_MODE_BOTH:
> -		if (interface == 1)
> -			hid_info(hdev, "uart interface is not supported\n");
> -		else
> -			ret = 1;
> +		if (interface == 1) {
> +			ret = FT260_IFACE_UART;
> +			dev->ft260_is_serial = true;
> +		} else {
> +			ret = FT260_IFACE_I2C;
> +		}
>   		break;
>   	case FT260_MODE_UART:
> -		hid_info(hdev, "uart interface is not supported\n");
> +		ret = FT260_IFACE_UART;
> +		dev->ft260_is_serial = true;
>   		break;
>   	case FT260_MODE_I2C:
> -		ret = 1;
> +		ret = FT260_IFACE_I2C;
>   		break;
>   	}
> +
>   	return ret;
>   }
>   
> @@ -1001,51 +1101,478 @@ static const struct attribute_group ft260_attr_group = {
>   	}
>   };
>   
> -static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
> +/***
> + * START Serial dev part
> + */
> +static DEFINE_MUTEX(ft260_uart_list_lock);
> +static LIST_HEAD(ft260_uart_device_list);

Is IDR or IDA not a better fit?

> +
> +static struct ft260_device *ft260_dev_by_index(int index)
> +{
> +	struct ft260_device *port;
> +
> +	list_for_each_entry(port, &ft260_uart_device_list, device_list) {
> +		if (index == port->index)
> +			return port;
> +	}
> +	return NULL;
> +}
> +
> +static int ft260_uart_add_port(struct ft260_device *port)
>   {
> +	int index = 0, ret = 0;
>   	struct ft260_device *dev;
> -	struct ft260_get_chip_version_report version;
> +
> +	spin_lock_init(&port->write_lock);

Should this be initialized when the port is allocated. This is confusing.

> +	if (kfifo_alloc(&port->xmit_fifo, FIFO_SIZE, GFP_KERNEL))
> +		return -ENOMEM;

tty_port_alloc_xmit_buf() then? Is PAGE_SIZE too much? Then refactor 
tty_port_alloc_xmit_buf() to allow size to be passed ;).

> +
> +	mutex_lock(&ft260_uart_list_lock);

guard()

> +	list_for_each_entry(dev, &ft260_uart_device_list, device_list) {
> +		if (dev->index != index)
> +			break;
> +		index++;
> +	}
> +
> +	port->index = index;
> +	list_add_tail(&port->device_list, &ft260_uart_device_list);
> +	mutex_unlock(&ft260_uart_list_lock);
> +
> +	return ret;
> +}
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

scoped_guard() × 2.

> +}
...
> +static int ft260_uart_transmit_chars(struct ft260_device *port)
> +{
> +	struct hid_device *hdev = port->hdev;
> +	struct kfifo *xmit = &port->xmit_fifo;
> +	struct tty_struct *tty;
> +	struct ft260_uart_write_request_report *rep;
> +	int len, data_len, ret = 0;
> +
> +	tty = tty_port_tty_get(&port->port);

scoped_guard(tty_port_tty)

> +
> +	data_len = kfifo_len(xmit);
> +	if (!tty || !data_len) {
> +		ret = -EINVAL;
> +		goto tty_out;
>   	}
>   
> -	ret = hid_hw_start(hdev, 0);
> +	rep = (struct ft260_uart_write_request_report *)port->write_buf;
> +
> +	do {
> +		len = min(data_len, FT260_WR_DATA_MAX);
> +
> +		rep->report = FT260_UART_DATA_REPORT_ID(len);
> +		rep->length = len;
> +
> +		len = kfifo_out_locked(xmit, rep->data, len, &port->write_lock);
> +
> +		ret = ft260_hid_output_report(hdev, (u8 *)rep, len + sizeof(*rep));
> +		if (ret < 0) {
> +			hid_err(hdev, "Failed to start transfer, ret %d\n", ret);
> +			goto tty_out;
> +		}
> +
> +		data_len -= len;
> +		port->icount.tx += len;
> +	} while (data_len > 0);
> +
> +	len = kfifo_len(xmit);
> +	if ((FIFO_SIZE - len) > TTY_WAKEUP_WATERMARK)
> +		tty_wakeup(tty);
> +
> +	ret = 0;
> +
> +tty_out:
> +	tty_kref_put(tty);
> +	return ret;
> +}

> +static ssize_t ft260_uart_write(struct tty_struct *tty, const u8 *buf,
> +				 size_t count)
> +{
> +	struct ft260_device *port = tty->driver_data;
> +	struct hid_device *hdev = port->hdev;
> +	int len, ret;
> +
> +	len = kfifo_in_locked(&port->xmit_fifo, buf, count, &port->write_lock);

So you put it into kfifo, and:

> +	ft260_dbg("count: %zu, len: %d", count, len);
> +
> +	ret = ft260_uart_transmit_chars(port);

remove it from the fifo immediately? What's the reason to do this double 
copy?

Oh, the fifo can have more than fits into the HW fifo? Did I miss where 
ft260_uart_transmit_chars() is called to send the remaining bits?

> +	if (ret < 0)
> +		hid_dbg(hdev, "Failed to transmit chars: %d\n", ret);
> +
> +	return len;
> +}
...
> +static int ft260_uart_change_speed(struct ft260_device *port,
> +				   struct ktermios *termios,
> +				    struct ktermios *old)
> +{
> +	struct hid_device *hdev = port->hdev;
> +	unsigned int baud;
> +	struct ft260_configure_uart_request req;
> +	int ret;
> +
...
> +	baud = tty_termios_baud_rate(termios);
> +	if (baud == 0 || baud < FT260_UART_CFG_BAUD_MIN || baud > FT260_UART_CFG_BAUD_MAX) {
> +		struct tty_struct *tty = tty_port_tty_get(&port->port);

scoped_guard()

> +
> +		hid_err(hdev, "Invalid baud rate %d\n", baud);
> +		baud = 9600;
> +		if (tty) {
> +			tty_encode_baud_rate(tty, baud, baud);
> +			tty_kref_put(tty);
> +		}
> +	}
> +	put_unaligned_le32(baud, &req.baudrate);
> +
> +	if (termios->c_cflag & CRTSCTS)
> +		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_RTS_CTS;
> +	else
> +		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_OFF;
> +
> +	ft260_dbg("Configured termios: flow control: %d, baudrate: %d, ",
> +		  req.flow_ctrl, baud);
> +	ft260_dbg("data_bit: %d, parity: %d, stop_bit: %d, breaking: %d\n",
> +		  req.data_bit, req.parity,
> +		  req.stop_bit, req.breaking);
> +
> +	req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_NONE;
> +	req.breaking = FT260_UART_CFG_BREAKING_NO;
> +
> +	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
> +	if (ret < 0)
> +		hid_err(hdev, "ft260_hid_feature_report_set failed: %d\n", ret);
> +
> +	return ret;
> +}

> +static int ft260_uart_proc_show(struct seq_file *m, void *v)
> +{
> +	int i;
> +
> +	seq_printf(m, "ft260 info:1.0 driver%s%s revision:%s\n",
> +			"", "", "");

Does HID require wrap at 80 cols? This should be on one line these days.

> +	for (i = 0; i < UART_COUNT_MAX; i++) {
> +		struct ft260_device *port = ft260_uart_port_get(i);
> +
> +		if (port) {

Perhaps invert the condition, add a "continue" and save one indent level?

> +			seq_printf(m, "%d: uart:FT260", i);
> +			if (capable(CAP_SYS_ADMIN)) {
> +				seq_printf(m, " tx:%d rx:%d",
> +						port->icount.tx, port->icount.rx);
> +				if (port->icount.frame)
> +					seq_printf(m, " fe:%d",
> +							port->icount.frame);
> +				if (port->icount.parity)
> +					seq_printf(m, " pe:%d",
> +							port->icount.parity);
> +				if (port->icount.brk)
> +					seq_printf(m, " brk:%d",
> +							port->icount.brk);
> +				if (port->icount.overrun)
> +					seq_printf(m, " oe:%d",
> +							port->icount.overrun);
> +				if (port->icount.cts)
> +					seq_printf(m, " cts:%d",
> +							port->icount.cts);
> +				if (port->icount.dsr)
> +					seq_printf(m, " dsr:%d",
> +							port->icount.dsr);
> +				if (port->icount.rng)
> +					seq_printf(m, " rng:%d",
> +							port->icount.rng);
> +				if (port->icount.dcd)
> +					seq_printf(m, " dcd:%d",
> +							port->icount.dcd);
> +			}
> +			ft260_uart_port_put(port);
> +			seq_putc(m, '\n');
> +		}
>   	}
> +	return 0;
> +}
...
> +static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
> +{
> +	struct ft260_configure_uart_request req;
> +	int ret;
> +	struct device *devt;
> +
> +	INIT_WORK(&dev->wakeup_work, ft260_uart_do_wakeup);
> +	// FIXME: Do I need that if I have cancel_work_sync?
> +	// FIXME: are all kfifo access secured by lock? with irq or not?

YOU FIX then :).

> +	dev->reschedule_work = false;
> +	/* Work not started at this point */
> +	timer_setup(&dev->wakeup_timer, ft260_uart_start_wakeup, 0);
> +
> +	tty_port_init(&dev->port);
> +	dev->port.ops = &ft260_uart_port_ops;
> +
> +	ret = ft260_uart_add_port(dev);
> +	if (ret) {
> +		hid_err(hdev, "failed to add port\n");
> +		goto err_port;
> +	}
> +	devt = tty_port_register_device_attr(&dev->port,
> +					     ft260_tty_driver,
> +					     dev->index, &hdev->dev,
> +					     dev, NULL);
> +	if (IS_ERR(devt)) {
> +		hid_err(hdev, "failed to register tty port\n");
> +		ret = PTR_ERR(devt);
> +		goto err_register_tty;
> +	}
> +	hid_info(hdev, "Registering device /dev/%s%d\n",
> +		ft260_tty_driver->name, dev->index);
> +
> +	/* Send Feature Report to Configure FT260 as UART 9600-8-N-1 */
> +	req.report	= FT260_SYSTEM_SETTINGS;
> +	req.request	= FT260_SET_UART_CONFIG;
> +	req.flow_ctrl	= FT260_UART_CFG_FLOW_CTRL_NONE;
> +	put_unaligned_le32(9600, &req.baudrate);
> +	req.data_bit	= FT260_UART_CFG_DATA_BITS_8;
> +	req.parity	= FT260_UART_CFG_PAR_NO;
> +	req.stop_bit	= FT260_UART_CFG_STOP_ONE_BIT;
> +	req.breaking	= FT260_UART_CFG_BREAKING_NO;
> +
> +	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
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
> +static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
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

multiline comments are introduced by /* on its own line.
"used" -> "use".

> +	 */
> +	dev = kzalloc_obj(*dev, GFP_KERNEL);
> +	if (!dev) {
> +		ret = -ENOMEM;
> +		goto alloc_fail;
> +	}
> +	hid_set_drvdata(hdev, dev);
> +	mutex_init(&dev->lock);
> +	spin_lock_init(&dev->read_lock);
> +	init_completion(&dev->wait);
> +
> +	ret = hid_parse(hdev);
> +	if (ret) {
> +		hid_err(hdev, "failed to parse HID\n");
> +		goto hid_fail;
> +	}
> +
> +	ret = hid_hw_start(hdev, 0);
> +	if (ret) {
> +		hid_err(hdev, "failed to start HID HW\n");
> +		goto hid_fail;
> +	}
> +
> +	ret = hid_hw_open(hdev);
> +	if (ret) {
> +		hid_err(hdev, "failed to open HID HW\n");
> +		goto err_hid_stop;
> +	}
> +
> +	ret = ft260_hid_feature_report_get(hdev, FT260_CHIP_VERSION,
> +					   (u8 *)&version, sizeof(version));
> +	if (ret < 0) {
> +		hid_err(hdev, "failed to retrieve chip version\n");
> +		goto err_hid_close;
> +	}
> +
> +	hid_info(hdev, "chip code: %02x%02x %02x%02x\n",
> +		 version.chip_code[0], version.chip_code[1],
> +		 version.chip_code[2], version.chip_code[3]);

Is this dump useful?

> +
> +	ret = ft260_get_interface_type(hdev, dev);
> +	if (ret <= FT260_IFACE_NONE)
> +		goto err_hid_close;
> +
> +	hid_set_drvdata(hdev, dev);
> +	dev->hdev = hdev;
> +
> +	if (!dev->ft260_is_serial) {

Inverting the condition would make more sense for me.

> +		ret = ft260_i2c_probe(hdev, dev);
> +		if (ret)
> +			goto err_hid_close;
> +	} else {
> +		ret = ft260_uart_probe(hdev, dev);
> +		if (ret)
> +			goto err_uart;
> +	}
> +
> +	return 0;
> +
> +err_uart:
> +	hid_hw_close(hdev);
> +	hid_hw_stop(hdev);
> +	tty_port_put(&dev->port);
> +	return ret;
> +
>   err_hid_close:
>   	hid_hw_close(hdev);
>   err_hid_stop:
>   	hid_hw_stop(hdev);
> +hid_fail:
> +	kfree(dev);
> +alloc_fail:
>   	return ret;
>   }
>   

> @@ -1171,7 +1857,62 @@ static struct hid_driver ft260_driver = {
>   	.raw_event	= ft260_raw_event,
>   };
>   
> -module_hid_driver(ft260_driver);
> -MODULE_DESCRIPTION("FTDI FT260 USB HID to I2C host bridge");
> +static int __init ft260_driver_init(void)
> +{
> +	int ret;
> +
> +	ft260_tty_driver = tty_alloc_driver(UART_COUNT_MAX,
> +		TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
> +	if (IS_ERR(ft260_tty_driver)) {
> +		pr_err("tty_alloc_driver failed: %d\n",
> +			(int)PTR_ERR(ft260_tty_driver));

Why the cast? Use %ld.

> +		return PTR_ERR(ft260_tty_driver);
> +	}
> +
> +	ft260_tty_driver->driver_name = "ft260_ser";
> +	ft260_tty_driver->name = "ttyFT";
> +	ft260_tty_driver->major = 0;
> +	ft260_tty_driver->minor_start = 0;
> +	ft260_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
> +	ft260_tty_driver->subtype = SERIAL_TYPE_NORMAL;
> +	ft260_tty_driver->init_termios = tty_std_termios;
> +	ft260_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
> +	ft260_tty_driver->init_termios.c_ispeed = 9600;
> +	ft260_tty_driver->init_termios.c_ospeed = 9600;
> +	tty_set_operations(ft260_tty_driver, &ft260_uart_ops);
> +
> +	ret = tty_register_driver(ft260_tty_driver);
> +	if (ret) {
> +		pr_err("tty_register_driver failed: %d\n", ret);
> +		goto err_reg_driver;
> +	}
> +
> +	ret = hid_register_driver(&(ft260_driver));
> +	if (ret) {
> +		pr_err("hid_register_driver failed: %d\n", ret);
> +		goto err_reg_hid;
> +	}
> +
> +	return 0;
> +
> +err_reg_hid:
> +	tty_unregister_driver(ft260_tty_driver);
> +err_reg_driver:
> +	tty_driver_kref_put(ft260_tty_driver);
> +
> +	return ret;
> +}
thanks,
-- 
js
suse labs
