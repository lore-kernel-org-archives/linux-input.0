Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ABA3128CC
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787868498; cv=none; b=DPsN5XDtRckNoOFdfn5xJJ9vpafaH6GSqnXmUUNPTZExdcdR2LgUAoQRzBxoAcoHWu1pXlBR8jr7oAKTET5rZ8jOw1iI6bAtyqSd+So+tI2uxWTnbepZtIIK82vdgOAKHuJxaUMbSQFi3y6Sp8hXoJ792Lx7rae601xUsRnV0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787868498; c=relaxed/simple;
	bh=4NZvaMgEivH19ze0KrHa5URPQF+DJXe0KL1Iof4hU0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tP2iI/ibi/ZQed/NvnyqnJ2XyfnXVxMOFVpu048YOWI0tCrtH0dSLnym2RIpaS0kiRlKIfG15BBlKp6N2uvdGlwr/gyMnlgXRQfLHN+C2/PoLKaxr9RMTimPtAMezdvRE+UAs21BUgBpydwK55hYUSzmE8XcBTD41deTg7Kyp2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkZACa4M; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkZACa4M"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-482dbc9a00bso1051306f8f.1
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 15:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787868495; x=1788473295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=12Czze317YjE4biaV1BLwood9eGVcYGSVELmZ2ehr0Q=;
        b=ZkZACa4MWqRVc/0lmyKUfN+BEO3QCsy1dGf0mBe8Zi3krYTf4Rpp+MGpPfDI1Soi0S
         NIcwitWJh0Gpu/PkYOwOgasQj39XuNdu6GscUn4RgcplqNI8pH3VROh2YLFUet9dqaji
         Gmnp2Otm5XQ31LaFJnPIBHPDIc/3GpHWyh3uD0wTnRqHPyIy6LT8U54IGllYfS3s7EUr
         aSVee/ptWVfB9mW5l+MML3d/hMCEbQ+DRW7b+y1gDk5kbbZN3fTCpSeUQrTfJqkfDZYA
         Mr9bTE1uxewFIYCM0GCdPVqQXLxV+tkeFaSE6SaGgwHLlNXG4c+B7pd201DbZVdViJPz
         iOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787868495; x=1788473295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=12Czze317YjE4biaV1BLwood9eGVcYGSVELmZ2ehr0Q=;
        b=ExP7V2dyDg8TRFIxn93TlunOgWWPsiiCRforDHNyX3lpj5pIllKfocPApErz9qRN/5
         JROuo2pk9iu+djs2hokG6J7/UMxWVsvAN1OOO5Q7PgHExD2tmvel8DND8EpUk0DVWnyn
         oMVba3ukrIJJMst7KVjBRnZn07457cQM1gdBIVRqm35PEzWKRGzqtIEkZG1YEgdfZPH2
         TwgMSN85rco5KiBNLxyPuvwV7v6+EKHgI0W35pPzGcAH+SaPlwhnjM+P5g2f4Qhglt8G
         8cJpPrR95s3z/WFYGHOrAH/7CLzkASpm5Dxvaspow5zrPlO1G8astzKSYG+4WogA+x95
         WlWw==
X-Forwarded-Encrypted: i=1; AHgh+RpD42ONVjD5dGvmi3ZbToJfiEUgz6A92lsdZR2mAEfETwrpQcb8GaYdGsA3ZE/FtNggFzUpk+jVh1l8VA==@vger.kernel.org
X-Gm-Message-State: AFuF++l/Qod1EI1R49hQJpBd5ayZNcsAIhiJ1iVWb1iXj6j5xM0dA6EL
	B/WNpw/xLNPpdcchJ2Oj/8BEc9egE7yvUQMRsv+Kjhj0TtVeOsvC/8bD9gP4UjjZ
X-Gm-Gg: AR+sD11x6E6/JaV2KPrkndkLJJI75DpeIDyNN44FkwD1VDdf11areLSebOCDtP09wgR
	JbAlHCRp7k8tXa5NCvQsFKL4T4hoKEkT1lqth23PFxL8oFFuB0aL3BffAUjwcQQnFXWjcy6jHYq
	r6O6mgu+BZ843Uzg5S20E8L4TliC2odsz5226jRt2Dfj3TeamkKXI8/MjQfsxzitygGShUUM3wj
	hVP4GMdmnYJXg9BDWQ/BtTf3aPuLXOiJCNultbL42gZxQT8yjhxd1xmnd/7ta3Fr0XvRDVIyE0u
	SFD1WYVbI3Wr9n9L4PdhrqyMWSba19mzlTPj0bhGhd2jvs5d56GO9j6bNCpOdWNQ4sIRIwGKLSc
	vxIKHcqvBI9irVpZB2f3BE69d2H66j95VgqGnB4e3HqXodMUHs6nLErzsUwc1emR0qEPfDUcEGZ
	yoqSQgTexOSSEwPWpmPFNMVyHhAOd3CdsGviwv7WIzRE9Sn6qYbmxavgTDcBQ=
X-Received: by 2002:a5d:6f0d:0:b0:47f:71a0:c060 with SMTP id ffacd0b85a97d-482eab5ff3cmr11537622f8f.2.1787868494701;
        Thu, 27 Aug 2026 15:08:14 -0700 (PDT)
Received: from m2.. ([37.142.156.156])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-482e28e899dsm12023740f8f.28.2026.08.27.15.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 15:08:13 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: linusw@kernel.org
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
	michael.zaidman@gmail.com,
	linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] HID: ft260: uart: add modem pins control via ioctl
Date: Fri, 28 Aug 2026 01:08:05 +0300
Message-ID: <20260827220805.23112-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAD++jLnKXqbV0xB3wvTF9Ri7g1MuWV6csO0MGzCtv5LBwmSr4g@mail.gmail.com>
References: <CAD++jLnKXqbV0xB3wvTF9Ri7g1MuWV6csO0MGzCtv5LBwmSr4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Aug 2026 at 10:08 +0200, Linus Walleij wrote:
> I'm not the authortative expert on modem control using GPIO,
> but what I think you should do is to
>
> select GPIOLIB
> select SERIAL_MCTRL_GPIO
>
> On Kconfig, so that gpiolib is always available and you can use
> the generic modem control helpers for modem control over GPIO.

I looked into this, and it does not work for the FT260 without
changing serial_mctrl_gpio.c first. Three blockers:

- Every GPIO access on this chip is a USB transfer, so the
  gpiochip has can_sleep = true. mctrl_gpio_set() calls
  gpiod_set_array_value() and mctrl_gpio_get() calls
  gpiod_get_value(), and gpiolib does WARN_ON(can_sleep) in both,
  so every TIOCMGET/TIOCMSET would give a WARN backtrace.

- mctrl_gpio_init() takes a struct uart_port and its IRQ handler
  needs it: uart_port_lock_irqsave(), uart_handle_dcd_change(),
  port->icount, delta_msr_wait. This UART is a plain tty_driver
  with a tty_port, so only mctrl_gpio_init_noauto() is left - and
  the FT260 GPIO lines have no interrupts anyway.

- mctrl_gpio_init_noauto() only picks up lines that exist as
  firmware properties: device_property_present(dev, "cts-gpios")
  and friends. A gpiod_add_lookup_table() table is the machine
  lookup path, so every line would be skipped, all descriptors
  would stay NULL and both helpers would silently do nothing.
  Software nodes could satisfy that check, but there is no
  PROPERTY_ENTRY_GPIO in the tree to build them with.

serial_mctrl_gpio.h is also private to drivers/tty/serial - all
eleven users are serial_core drivers in that directory.

Registering a uart_port instead was tried for this device and
turned down. Daniel Beer's 2022 FT260 UART patch was built on
serial_core and called uart_add_one_port(); Greg asked for
usb-serial, and Johan Hovold answered that "neither USB-serial or
serial (core) is a good fit for such a HID device", pointing at
Christina Quast's tty driver as the right approach - which patch
1 of this series is a port of.

  https://lore.kernel.org/lkml/638c51a2.170a0220.3af16.18f8@mx.google.com/
  https://lore.kernel.org/lkml/Y6WNl6+ySy8zcSyg@hovoldconsulting.com/

That patch left set_mctrl empty and get_mctrl returning a
constant, which is this same constraint seen from the other side:
uart_ops.set_mctrl and .get_mctrl must not sleep, while every
FT260 line access is a HID feature report over USB.

> This can be a bit delicate in this case since the gpiochip that you
> use for mctrl is also registered in this driver, so you need to
> register the gpiochip *first*, then add a look-up table for the
> GPIOs, then register this modem control.
>
> Then look in e.g. drivers/mfd/sm501.c which is an
> MFD device that register a gpiochip and then consume
> GPIOs from itself.

Agreed on the ordering, and thanks for the reference. The UART
probe currently registers the tty port before the gpiochip, so
that would have to be inverted, and the gpiochip label is built
from the HID device name, so the table would have to be built at
probe rather than being static. Both are workable; they are not
what blocks this. sm501 does not hit the sleeping problem because
its gpiochip is memory mapped.

> The core idea is that the serial modem control should look
> up the GPIOs from its own gpiochip and use the MCTRL
> library helpers, then this should result in very little and
> compact code that is easy to read.

No argument with the goal - I would rather have that than my own
TIOCM handling. But making it usable here means work inside the
serial helpers: cansleep set/get, a path that does not require a
uart_port, a lookup that works without firmware properties, and
the header moved to include/linux. That is a serial subsystem
series to agree with Greg and Jiri Slaby, so I propose keeping
the ioctl implementation in this series and doing the conversion
as a follow-up.

Even then only the set/get helpers would apply: with no GPIO
interrupts, modem status changes come from the FT260's own
interrupt status input report (0xB1), so that part stays in the
driver either way.

Thanks,
Michael
