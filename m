Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566C6383310
	for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790447244; cv=none; b=PYVykwi8SdOJuBqLZ0UKpD8KrL+26ihhrgY3IJmLY7SY94JrhJMNXpVSrftZTD7yxLg/7h4QilKNIKVOURu1gEuwMjZJMEi+F84MkEhtwLsZreTsFrM3np1+Kld04hJHE0aJyXpCb+G+FqziBHa2lA5i+Z4hA3M9qC8MP7L3tNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790447244; c=relaxed/simple;
	bh=qzwNqOoq5gIEteD6ff9IatsKKQaGCWKJS6LMm1QwduY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8O+mPZQNiKZGatUh2vlIUG1SOxhfJ2qee7fwdnqFYxoBEk3cdfabGg1TEeyrLpaCCn4yiaFewdXEaT+aFqMzND3mDeKd0c8QTfTbZjTEiVHQmGxAQUY2Tzf5Cj57qBRsVeqvty+zVYWN1MjWDXOy12HqX8UsmZ87PLs3U8KLm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pr9e0W8B; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pr9e0W8B"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so10558575e9.0
        for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 11:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790447240; x=1791052040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6zdetyxBKfTailvjdRzmjKkVNkh5L3fgaPZNlolghpE=;
        b=pr9e0W8BwBr+4bE4dLBrjXu491trlOXwULzGbiRhh/qygDhLJEC54qeUjBs2W2n6Aw
         UkLtVWVPfeZkYRjU+C1/s116TY25w8IO5AwD6WJsJMKd/e5WY1DPlWAPkVKpZo48idgL
         BLdCgX1hDaMJSh9X7nYO5ddVmod0BJc/cXyv10n1ZMaMIgMEnHtkaalociCKn3tP2j9I
         iEQW6DtA1+xMmAt0SlhXmqSb9wIaWZ7luTGM+LdW1DAcpV/meY2ZSBqsSt28G9PuHvUt
         1P4NkI7+pomYFdIZ5+O2KUwiUvnYLunvjvyyrE2ipRahtuCAmZ4R7TcU0Mb+7EZiDKrO
         251w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790447240; x=1791052040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6zdetyxBKfTailvjdRzmjKkVNkh5L3fgaPZNlolghpE=;
        b=0h8zSDP81gwH7VsZLjyK5Hay1y/Ous731fEVxbqDGJgLiQ2tPkRL8qQLHnS+BRlMB1
         ZnVoapQaOMr1TRbwzB/NhRxcahzy+8x8RVfV+2ELR82uM5p8RKkV/6VuwWEfgpiyUR1O
         FE+Ln9TGjJHLqBHRUUT4E1g+42tEQU7VUePa6epnMZfVTFV6GhUforqysq72EZaGCeMd
         wUGt3eQHlyO/hg/CClUARBeGKnp8DNHpOcjusecNNGRU/XcSJtj3dlBLr7qw7cATF3PV
         p3fY+kCKl3BRphvVH5PFYJsPKcVMNIvcx9YLuI3PnYgrtGSy7JmvGq0+ORZLCAbTtwwe
         M0CA==
X-Forwarded-Encrypted: i=1; AKwUvBxlQvgtnHwkZ3kDrvGf+xhAfkuuqLZle81tMZEnfHRWx1mziEiGQuo+931+8iWWGv/DDT660V6GxPACDw==@vger.kernel.org
X-Gm-Message-State: AFuF++kpazRfVp7QPqQ8XmY0G7QWYQ3ahA5eEcBjPvO5SevBaNiJi3VD
	q/4flvdc6tBAx4FVfdrUHNxQndtAtFKRgD/tG3qxA4Y45z4HOPV1OMfk
X-Gm-Gg: AYBFou34nIgbTpUQ1aH+3RQCUcrXMbvP9KbHt2GtV5VM20PXonaCKAE6NY55NcxbEUw
	PdCke3IYQ6l/UJQB/jH/q2Vb9H4hUKYeWshQSK8CkUzyaia6w5FPBlAJI42ad2MskVscNx0uhvt
	X01NHUYbS7j1hAeb9x/AVbBEjVZbaZq44llPdmZvp9lZoo+VwYRVl0vAiiHzNl4rwGnKvwjcht+
	vdf0Btq6XeuodIk3LigFdgjKYzBLOWU7YYh+4+zqVGceKOx3qqb4TM46n6ZS3CBITZgntQOGZW9
	UTIZtZymzFtKR3lC+QBXbwJHyusZUp5U4dtYiNdmBClwL+GmtBP2eZIJxtsLlxzDrGgBPTbG6p7
	cknI030jMGMT7Lk7rSdUMS2PuMXfddpo4X4GwJBHwDHZOIs1boV1KBrucaLm9BjczZasXty7DYI
	5CmT6wfkvPT8PitjB3s51auqY7yuW4Bws1n8WMi2cGeOtKhIIxaPUL6PMzbc2HGRdiTg95KLNzm
	x3or37E
X-Received: by 2002:a05:600c:138f:b0:49f:cbf3:551c with SMTP id 5b1f17b1804b1-49fe66cc5camr155431025e9.12.1790447240357;
        Sat, 26 Sep 2026 11:27:20 -0700 (PDT)
Received: from m2.. ([37.142.154.181])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a000901b07sm11834725e9.9.2026.09.26.11.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 11:27:19 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	brgl@kernel.org,
	germain.hebert@ca.abb.com,
	rio@r26.me,
	brunoceg1@gmail.com,
	contact@christina-quast.de,
	daniel.beer@igorinstitute.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] HID: ft260: uart: add modem pins control via ioctl
Date: Sat, 26 Sep 2026 21:27:09 +0300
Message-ID: <20260926182712.24576-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAD++jLksAPyfZz6d--n7a1KhPackigEucQJqbYiA-e9S835seA@mail.gmail.com>
References: <CAD++jLnKXqbV0xB3wvTF9Ri7g1MuWV6csO0MGzCtv5LBwmSr4g@mail.gmail.com> <20260827220805.23112-1-michael.zaidman@gmail.com> <CAD++jLksAPyfZz6d--n7a1KhPackigEucQJqbYiA-e9S835seA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

On Mon, 14 Sep 2026 at 10:57 +0200, Linus Walleij wrote:

> Can't you just patch mctrl to use gpiod_set_array_value_cansleep()
> and gpiod_get_value_cansleep()?
>
> I don't think any of the users depend on call thing this
> in atomic context.

That change is in drivers/tty/serial/serial_mctrl_gpio.c, not in
hid-ft260.c. mctrl_gpio_set() calls gpiod_set_array_value() there, and
both mctrl_gpio_get() and mctrl_gpio_get_outputs() call
gpiod_get_value(). The FT260 gpiochip sets can_sleep, so calling those
three functions from this driver warns until that file uses the
_cansleep variants.

The switch is not only a rename. serial_core.c calls ops->set_mctrl()
under uart_port_lock_irqsave() in uart_update_mctrl(), and
ops->get_mctrl() under uart_port_lock_irq() in uart_tiocmget().
imx_uart_set_mctrl() and atmel_set_mctrl() call mctrl_gpio_set() from
there, and serial8250_do_get_mctrl() calls mctrl_gpio_get() from
there. These callers do run in atomic context, so _cansleep alone
would put a sleeping call under a spinlock with interrupts off. A
sleeping gpiochip also needs the serial core to call set_mctrl and
get_mctrl outside the port lock. I will not put that in the FT260 v2
series.

> > - mctrl_gpio_init() takes a struct uart_port and its IRQ handler
> >   needs it: uart_port_lock_irqsave(), uart_handle_dcd_change(),
> >   port->icount, delta_msr_wait. This UART is a plain tty_driver
> >   with a tty_port, so only mctrl_gpio_init_noauto() is left - and
> >   the FT260 GPIO lines have no interrupts anyway.
>
> I don't understand this :D
> But hopefully the TTY/serial maintainer does.

mctrl_gpio_init() in drivers/tty/serial/serial_mctrl_gpio.c takes a
struct uart_port. Its interrupt handler, mctrl_gpio_irq_handle(), uses
that port for uart_port_lock_irqsave(), uart_handle_dcd_change(),
port->icount and delta_msr_wait.

The FT260 UART is a tty_driver with a tty_port. It has no struct
uart_port, so it cannot call mctrl_gpio_init(). The function it can
call is mctrl_gpio_init_noauto(), which takes a struct device and does
not set up that handler.

The GPIO chip in hid-ft260.c registers no interrupt callback, so there
is no GPIO interrupt for that handler to bind to.

> Using software nodes is the way to go I think,
> <linux/gpio/property.h> contains PROPERTY_ENTRY_GPIO.

You are right. PROPERTY_ENTRY_GPIO has been available in
include/linux/gpio/property.h since v6.2-rc1, and hid-ft260.c does not
use it.

mctrl_gpio_init_noauto() skips a line if the device lacks the
corresponding property, such as cts-gpios. Providing these properties
requires registering a software node using PROPERTY_ENTRY_GPIO. I will
register that node in the patch that switches this driver to the
serial_mctrl_gpio.c helpers, so it is not part of v2 either.

> include "../tty/serial/serial_mctrl_gpio.h"
>
> Otherwise we just bite the bullet and move
> drivers/tty/serial/serial_mctrl_gpio.h
> to
> include/linux/serial_mctrl_gpio.h

That move belongs to the same serial core patches, not to v2. I will
ask Greg to say if he wants the relative include instead.

> > That is a serial subsystem
> > series to agree with Greg and Jiri Slaby, so I propose keeping
> > the ioctl implementation in this series and doing the conversion
> > as a follow-up.
>
> These things have a tendency to never happen and it's
> not like we have a shortage of technical debt.

Fair point, a follow-up can stall. I will send the serial core
RFC as its own thread, after this series is merged, and I ask that it
not gate this series: it changes drivers/tty/serial, and the FT260
UART works without it. If the serial core does not take it, what
stays is ft260_uart_tiocmget() and ft260_uart_tiocmset() in
hid-ft260.c, and nothing in drivers/tty.

Thanks,
Michael
