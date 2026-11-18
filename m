Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019986;
	b=p84aIp7B84+WK0DlqSWAqt+dopRqZ1kuZLabl9r2aS81lULnwGpx4ex2HvqUE2WIl8qr
	 40wpLLduVre7fbACGjG+ZKkc3LLnP1M5xKcZT8vo3d0tXZGI1y/p9xNH3bFzglznlvud3
	 cwpfjOzgiEHUXMEMnGrmuagoKVgWiEywUToiAIKGdgOHg6XrE1vBvk+xZ4ncp/gNVX/ei
	 MvYXT5tHd3avW9OU2Tp8CFqYxODw6CfmTw+iBMT+r6D76AghHjjQBm1Kr4vdklL0gDxJ6
	 Ou3fTbmncpMvTQvu/958+Kj8DWcOl6UBUdx1qj6kB25OLpAGYF+DyPgX/GdyKw1JgPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bSJ+G4tJP1ziQCyl9adMQoFUq25zcxEzpQxCBYIzK6k=;
	b=HwR7K+CdhPu8aVknYXTCbxgzuD5kuMinanxF3cNb241aSU5ypMirSUJqfmSCJ7BDxsXS
	 rjw8kNjMJ3mFa2bKSnS9JshFT7bvr7YEs6pbVv5kuHxSztECoq8fwZFFSyQiESRwExE4t
	 ELTH/SFJFcvimOqmi12bkmAnyPIoL71Ocf0WVP0J62VGAw6i5zA5YdSnD+HZRrCKsDhf1
	 y1sEpcmhUBUbqNvAPRDKuU1m7PN7Neq55SFUq3jSuHU/V9Cy791BuJBYW33oeRwMCHEiO
	 l2FfR0Df5FVltTRndp3cCkZkKv1JnIdFAIqMF0Udz4tgkhxCwaQNUW0lwa5CyFny3UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WJ3ZlJkG;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253DE606A331
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 16:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 253DE606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WJ3ZlJkG
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4a358881793so624673f8f.0
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 08:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795019984; x=1795624784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bSJ+G4tJP1ziQCyl9adMQoFUq25zcxEzpQxCBYIzK6k=;
        b=WJ3ZlJkGwMnNkvsIqG4plTgvw2A+K2rreocPB2CyyiOWrntgd8SDOOMIY+k94X7C6L
         3ORbkuquBSAjI3lhCF+xnkq6wSwOLZo/IcB0XcROOd2DMyh2hz6i50GfRkpLOGZOiNO/
         DXKJBfnJo5pBt5QeslY+HpaOcub9ZeCSUhS5eRT6Mk+liiHG63meMM0ckJGfe6mr2XUq
         eTG5RLmaOFICTkX/WNnRmEOoF6cLzuZkFr/Elx3+9+2S113zfbhvZ6ycZdLSmSffQfv4
         zFWNp74W64SQJFS7CaFSQXdwYUAqxsCYL1IQiOlSKtKVh/4kopk1WabQdRZWf3DpZt/Z
         tOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019984; x=1795624784;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bSJ+G4tJP1ziQCyl9adMQoFUq25zcxEzpQxCBYIzK6k=;
        b=WbCYDpZnuWw67cP6xxuoBy+wJd08VGxnflclfnTDa055AZbO9Jr995AGD987AFCBe+
         OB1YggkWrjcudPIaqJhKVSa/VPa7KnwFLWU95++c4iQFqcyWVsNKyHPXFu9dQy4usCBe
         p2lMycseVLqtYlDtFNZAYl1dpLh4FMFCaTTLCb7yLM35jPklOYRfVPY5RwcucTlpI4WN
         QT0/Qhbh4toT/sY3ns6pmXMtabPO/3wCFz7aB0EEyldHumSToyYYpjC18g4lL5olD5cb
         BfDaUoksZ8Mg2xigGsnXTE1rEuSyIxszPB4Sih/zlzTK4TRVNqkH1DEmnNl5E/3Gdyl0
         RvXg==
X-Forwarded-Encrypted: i=1; AL+hErHCBc/Mo806m9ewD45VpML3UlFO9PdVvKaNv5HwKDKGSFhB5Bj+g6vvRdU7I1L8j3v8spf77EK59XiO7g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/ajYNeNAFklwyqVmjKAxjK2CWpe6N7Tbhyu7kxqZUDTVIIZdji
	sEqZ7zxKIMoJucHolKG2mL3bIvrHX7O6nYBacuUK/bJZMrSpyVurVICn
X-Gm-Gg: AZFdTZfPA/R5SBVTCM/oDa4fXZBQdMHeXwaERlfULVRBCs3rSGyCpLdecJiNpeXIRzI
	bwtqCJAnjvqPgIiX2jRPhtLT5rUdn/z/C7s/kY9CsXEcHPAWczWMB8xsRqjG59m23AwTxVfl8Bg
	5RNCW48ZWNJ+tvVYujX6404Y9EuwMKDv1T26pk71yWLYygkIz4bCoT8s4PkGZyc8cYqLeAZuWiw
	TQh/oNYnooBJCTkJATAoaTDelMW/PKSaTEIlQPJNG1g1PcKZEBxyy4qyj5deaOWO/WMPWrN59qZ
	208zXUwhDCB57F1v5a8QSos1YNWbK5qam/wR+VjXYLLdoXwviDtmA4v/9ZVOXMmapXDvRk4xEPp
	XkHZHfsTaUSaZDtDlNF3sUUkd/qqhaane7H0N17nd3zsZeYSf/9adrApJn4aQxgKuTB5OhQ4WEo
	ve3AHXi/Ii3lXwD623IjS8XK8th8sRPldJfdvVrN27LIkpEAFqkeoYDuNjvgIULRqE7fQ8mEGFu
	yGnob0SoP75QLZhi0G8di6jEMk0654M0KcG4TKoZCewUT253G493gXdq6WLNBlUWW/3pxm80ij9
	bnZsim9U8bFmGIhfPy0UcOQbiMj//A==
X-Received: by 2002:a05:6000:24c7:b0:4a4:ee9f:a3d2 with SMTP id ffacd0b85a97d-4a63eac5b4bmr6887128f8f.55.1795019984273;
        Wed, 18 Nov 2026 08:39:44 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a65560ab64sm5420535f8f.25.2026.11.18.08.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:39:43 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	Daniel Beer <daniel.beer@igorinstitute.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/16] HID: ft260: add serial driver
Date: Wed, 18 Nov 2026 18:38:50 +0200
Message-ID: <20261118163935.28515-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0c96e0ee-55e7-4999-922e-bc52aa516d2e@kernel.org>
References: <0c96e0ee-55e7-4999-922e-bc52aa516d2e@kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 18, 2026 at 08:21:18AM +0100, Jiri Slaby wrote:

Thank you for the review.

First a question about where the fixes go. Patch 1/16 is Christina's
v4 serial driver [1], ported to the current kernel. It also has a few
fixes to her code; its commit message lists them. Patch 2/16 is my
own patch. It has the fixes her code needed on hardware and the fixes
for the review of the patch 1 code. Jiri Kosina agreed to this layout
in June; "As agreed with Jiri" in the cover letter means him. The goal
is that Christina stays the author of the code she wrote, and the
fixes on top of it are mine.

Some of your points are already fixed in patch 2. The others I will
fix in v5. Are you fine with the v5 fixes for the patch 1 code also
going in patch 2? Patch 1 then stays as it is, except for the two I2C
hunks that you asked to move out (see below).

[1] https://lore.kernel.org/all/20231218093153.192268-1-contact@christina-quast.de/

>> +#include <linux/serial.h>
>> +#include <linux/serial_core.h>
>> +#include <linux/kfifo.h>
>> +#include <linux/tty_flip.h>
>> +#include <linux/minmax.h>
>> +#include <linux/unaligned.h>
>
> Sort these.

Will do in v5. Patches 3, 4, 8 and 11 also add includes out of order.
Patch 2 sorts the list, and the later patches add their includes in
order.

>> +	struct kfifo xmit_fifo;
>
> Why not to use port.xmit_fifo?

v5 uses port.xmit_fifo, with tty_port_alloc_xmit_buf(). More on the
size below.

>> -		hid_err(hdev, "%s: failed to start transfer, ret %d\n",
>> +		hid_dbg(hdev, "%s: failed to start transfer, ret %d\n",
[...]
>> -		pr_info("%s: off %#x rlen %d wlen %d\n", __func__,
>> +		ft260_dbg("%s: off %#x rlen %d wlen %d\n", __func__,
>
> There should be likely a separate patch with the above two hunks.

Agreed. In v5 both hunks leave patch 1. The pr_info() to ft260_dbg()
change goes in patch 6, which lowers the severity of other I2C
messages. The hid_err() stays: patch 6 keeps it for transport
failures.

>> -static int ft260_is_interface_enabled(struct hid_device *hdev)
>> +static int ft260_get_interface_type(struct hid_device *hdev, struct ft260_device *dev)
>
> Switch int to the enum then?

I would like to keep int. The function also returns the negative errno
of ft260_get_system_config(). The enum has no negative values, so GCC
gives it an unsigned type, and a "ret < 0" check in the caller would
not see the error.

>> +static DEFINE_MUTEX(ft260_uart_list_lock);
>> +static LIST_HEAD(ft260_uart_device_list);
>
> Is IDR or IDA not a better fit?

Yes, an IDR. The driver needs the lowest free index and also the port
for an index, so an IDA alone is not enough. v5 uses idr_alloc() and
idr_find() in place of the list walks, as cdc-acm does.

>> +	spin_lock_init(&port->write_lock);
>
> Should this be initialized when the port is allocated. This is confusing.

In v5 it moves to ft260_uart_probe(), next to the other UART setup
(INIT_WORK(), timer_setup(), tty_port_init()), before the port is
added. The other choice is ft260_probe(), where the port is
allocated. But ft260_probe() allocates the struct for each
interface, I2C or UART, and only the UART code uses this lock.

>> +	if (kfifo_alloc(&port->xmit_fifo, FIFO_SIZE, GFP_KERNEL))
>> +		return -ENOMEM;
>
> tty_port_alloc_xmit_buf() then? Is PAGE_SIZE too much? Then refactor
> tty_port_alloc_xmit_buf() to allow size to be passed ;).

Yes. Patch 2 already sets the FIFO size to PAGE_SIZE, so
tty_port_alloc_xmit_buf() fits as it is, and tty_port_destructor()
frees the buffer.

>> +	mutex_lock(&ft260_uart_list_lock);
>
> guard()

Patch 16 converts all mutex_lock() calls in the driver to guards, this
one included. The guards are in the last patch on purpose: I also
maintain an out-of-tree version of this driver for kernels older than
6.5, which do not have linux/cleanup.h, and it can leave that patch
out.

>> +	mutex_lock(&ft260_uart_list_lock);
>> +	list_del(&port->device_list);
>> +	mutex_unlock(&ft260_uart_list_lock);
>> +
>> +	tty_port_tty_vhangup(&port->port);
>> +
>> +	spin_lock(&port->write_lock);
>> +	kfifo_free(&port->xmit_fifo);
>> +	spin_unlock(&port->write_lock);
>
> scoped_guard() × 2.

Patch 2 moves the list_del() to the port destructor, and patch 16
puts it in scoped_guard(). The spin_lock() pairs on this lock, now
xmit_fifo_lock, are not converted yet. In v5 patch 2 makes all users
of the lock take it with irqsave: a line discipline can call ->write
from softirq (ppp_async does, from a tasklet), and ->write takes this
lock. Patch 16 then puts them in guards, together with the other
spinlock of the driver, read_lock.

>> +	tty = tty_port_tty_get(&port->port);
>
> scoped_guard(tty_port_tty)

Will do in v5 in patch 16, here and in ft260_uart_change_speed().
These are the only two tty_port_tty_get() calls in the driver.

>> +	len = kfifo_in_locked(&port->xmit_fifo, buf, count, &port->write_lock);
>
> So you put it into kfifo, and:
>
>> +	ft260_dbg("count: %zu, len: %d", count, len);
>> +
>> +	ret = ft260_uart_transmit_chars(port);
>
> remove it from the fifo immediately? What's the reason to do this double
> copy?
>
> Oh, the fifo can have more than fits into the HW fifo? Did I miss where
> ft260_uart_transmit_chars() is called to send the remaining bits?

Patch 2 changes this. In patch 1, ft260_uart_transmit_chars() sends
the rest in a loop in the same call, but the send sleeps, and ->write
must not sleep. From patch 2 on, ft260_uart_write() only copies the
data into the kfifo and schedules tx_work. The work sends the kfifo in
reports of up to 60 bytes until it is empty. So the copy is needed:
the data waits in the kfifo until the work sends it.

>> +	seq_printf(m, "ft260 info:1.0 driver%s%s revision:%s\n",
>> +			"", "", "");
>
> Does HID require wrap at 80 cols? This should be on one line these days.

Patch 2 puts it on one line.

>> +		if (port) {
>
> Perhaps invert the condition, add a "continue" and save one indent level?

Will do in v5.

>> +	// FIXME: Do I need that if I have cancel_work_sync?
>> +	// FIXME: are all kfifo access secured by lock? with irq or not?
>
> YOU FIX then :).

Patches 2 and 3 remove both comments. The answers:

The reschedule_work flag is needed. cancel_work_sync() runs only when
the device goes away. The flag switches the wakeup workaround on and
off while the port is in use, when the chip has power saving enabled:
it is set above 4800 baud and cleared at port shutdown. The timer
arms again, and the work sends its report, only while the flag is
set.

No. Even at the end of the series, ft260_uart_write_room() and
ft260_uart_chars_in_buffer() read the kfifo with no lock, and four
paths take the lock with spin_lock(). In v5 every access takes it,
with irqsave.

>> +	/* We cannot used devm_kzalloc here, because port has to survive until
>> +	 * destroy function call
>
> multiline comments are introduced by /* on its own line.
> "used" -> "use".

Patch 2 fixes both.

>> +	hid_info(hdev, "chip code: %02x%02x %02x%02x\n",
>> +		 version.chip_code[0], version.chip_code[1],
>> +		 version.chip_code[2], version.chip_code[3]);
>
> Is this dump useful?

I would like to keep it. It was in the driver before this series, and
it is the only place that prints the chip version.

>> +	if (!dev->ft260_is_serial) {
>
> Inverting the condition would make more sense for me.

Already done in patch 2.

>> +		pr_err("tty_alloc_driver failed: %d\n",
>> +			(int)PTR_ERR(ft260_tty_driver));
>
> Why the cast? Use %ld.

Will do in v5.

Thanks,
Michael
