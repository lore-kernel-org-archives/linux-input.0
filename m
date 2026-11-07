Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794030004;
	b=r9gE40ZB3kvIovk13vou8YwqNTsK9+6mp6XJm2A7M8aMKG8GCuZLmlmeodNW3Gbj4Y4m
	 +0FiK7B5wEZCX67MOjG6mbeUDzGc+beu60yahLiDALRdzKiPcUqQbBCdwJZlyWVcV4yJN
	 P9EZyB9xl/sMV1HQ1m+7P34un8OtvlxzvL0HiRIaLQkpwBFclLyMdtyY6PaYTX/qpU0Mb
	 vVDx0aSy/X5Rj9SOvoyk+Zy0j2A4bNcRktxbwGQNWLvWI85o7B5UYEY5CWdmKD2UuNOK5
	 AvAqp2uJEmBTgAS55bW2EtaQshoQnkkTHa8ENTd3/YLsQRkXYDqPHV1Yug2owWgUstA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794030004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5annG2fvVlnsulvtrTFDzAUzwH4cadPN91b6RtVuR1k=;
	b=MbIH5dP8mRBqjRMf1UDq0L0LIA+XnN9Jl7+9PWSMgy3FyLhyGgO7G+lxoKU3fG4AgfpM
	 XzqqrA4bJB32hHVHqOi6uUEzBk7Ieh9+IBc2O4ng6A+hrY+z2hP1vZ2psB5rSOBkydvb0
	 I65q6NnYRnY0wTFjPvf+/H/nGwB4eQnQGha/Spuv8LFlAkA/ciA3oy+3IQRV9AvwCiP3s
	 H1CkvzR2zgJMlvX46t/P44+5Y1QrBr3ywdAEO3iyQnqWD3w267JSV1daIeTFehLcFH7Td
	 r4SEUvnFxYM8LsamrBJmy9LFbKmtPoSwcgKhOtOqLdSI4zdD0sOafVk3OuwMnp8F9OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hExX9b0A;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BDC606A326
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 05:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52BDC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hExX9b0A
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso12837085e9.3
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 21:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794030003; x=1794634803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5annG2fvVlnsulvtrTFDzAUzwH4cadPN91b6RtVuR1k=;
        b=hExX9b0Af+UmHkztr6jmVgIRovMHS/XWW0pYuXiml1i75KIHgDGnSRx2ILMynfoa+Y
         DCK0R+J+nANMRLR/PyF8L9/xyb9sB68+FhzINOCvGmGof1RiWB37RkbEML6tMxdlXAK6
         +MH+fBP20NxWBGkLzQ0fltN+KckJt9PwN14DGVYbZnkalxSITcL22dHTX5MordUYqxGw
         86o6Wq/X00TQLmojrvDD5yDoJt4BybHZijKHNZHgqxxgP4E3O1dWU7GR3gq5z83BcuVO
         Mom1WddpoDZqJTndITedgrtlramzp/0yt63WbdM+dQdVqNSou1R18ZKpNsQiBMbuHrsa
         yZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794030003; x=1794634803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5annG2fvVlnsulvtrTFDzAUzwH4cadPN91b6RtVuR1k=;
        b=oZ/jtzMGfmgG5XgJBBV/4K0TnAJ4gZ4hw2btMN1iWUxVe2yiTi8wEd/SMepAlVcd3B
         gYJX5K7dp7b2iEhlUFNSsATd6RXfuRoJyEz8ne2I1B0FwFS7+lYcjEPsEPlRi17XJjfY
         2R886JywXezKiy5hlBmm06tSkaRrrs/HlgDuD6n0MvU4Olob6Wjii1e9rFVv3lAEsbXq
         GntmTb5+WSq074FRbbjIoXYbCO+Ru8y0zJJVVhioMqoKjX1OC1YinU8beBkIF7mw2w8q
         RUE+8R5E+w07OJgZZefoiMDavH0I2Ol6If/VH1fJFFgKsCFRe7mr0dqAle2DhkYONEdH
         Cryw==
X-Forwarded-Encrypted: i=1; AKwUvBydBy72LDI1VtIJECoH5XG2hrF31Nn3FaV80jFLGu7yacjaEwBFS5O1WXHBcoOKZaxq7w/Wts83vPu6pA==@vger.kernel.org
X-Gm-Message-State: APuU4Z82GId5PS9KnKkOq6iLVKxL95lcCd+7yS07+vWc3tzOb9KcCWxU
	67Um+gZIKegI+vsPNVAgogR4JcwqIRYXWmO4zFE7FTvotFJgPVNv2/0e
X-Gm-Gg: AYBFou1FqxbIL3CEZu5GHmVqlPqLerGVuu+DUkVG1TjLlNZDro4e06yOWoyrTD1tDpv
	HU1Ds4wVOHA4qGNIu6L7Kwh/jK+sKbKorzoOdUp4tsye4NrnB/cjX04h6QLLEtYiRPm9xfBrWZ8
	NVwXWAOnyOcYU7Vq7Gs0VLk+tLsPGz+xPl4FE4i2D7S/nogZ6/K9s8k2HvOuHdQQ2WkB+HZ5Zhw
	D6QRKjOaazQoot+3panZemNit8U0NZwl7kzN2YQK/OfwUu6Au73xWcV1tokvMsBlC34Klfn/6f2
	dUS4pM9vY58+md0nPBZaw7cJ0G46fkcQzxXreFfSLhg0V6PDGeOP3okVkSssLsnZuyAzY+GKSa4
	p78X9Xly1mY4OeTXNiJdDV+iZO7WtFDG97YaLw/DZ2uHm69pUrmVKDldy2dQmrokyej1mYf3OOU
	cA/n6ymgdavcBMRU2CRgAudzKuLj9ZSRa7dYt65jaK8ftZs03ms8CYixuIAIqkWQ/S7mie1oFm6
	POam5BRf72ouW/7q7YqehJDEMxDeUeBAssIf0H//Gl4DoMmQkaxytrpq8TYEPJkrU2AQLMXLjcj
	NPv1X5vPqMLlMOoQImEJmVH9GVtp1LrQp7h2OEtTk4L8Ce8uyC9jj/gZ8v6VwguaHe0KSfBiF/A
	vwCSXhfnvN2H+WKhQFFcQO7eACfkA1D+TaTlYIIGPmDwyzl8T
X-Received: by 2002:a05:600c:4f4a:b0:4a2:1196:db0e with SMTP id 5b1f17b1804b1-4b6e017248dmr80520265e9.30.1794030002378;
        Fri, 06 Nov 2026 21:40:02 -0800 (PST)
Received: from DESKTOP-KHFMJSR ([194.9.62.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7bcfcbfsm7712057f8f.43.2026.11.06.21.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 21:40:01 -0800 (PST)
From: Vecheslav Filatov <harepro29@gmail.com>
To: ojeda@kernel.org,
	dmitry.torokhov@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-input@vger.kernel.org,
	Vecheslav Filatov <harepro29@gmail.com>
Subject: [PATCH v6 0/2] rust: input: add input/serio abstractions and port Gravis Stinger driver
Date: Sat,  7 Nov 2026 10:39:51 +0500
Message-ID: <20261107053953.471972-1-harepro29@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces safe Rust abstractions for Linux input
devices (struct input_dev) and the serio (Serial I/O) bus subsystem,
along with a port of the legacy Gravis Stinger serial gamepad driver
to safe Rust.

Changes in v6:
  - Developer identity: updated author and Signed-off-by to developer's
    real name (Vecheslav Filatov) across all commits to adhere to the
    Linux Kernel Developer's Certificate of Origin (DCO).
  - serio: eliminated constructor function-call syntax for
    bindings::irqreturn by directly pattern-matching Driver::interrupt()
    return values to canonical constants bindings::irqreturn::IRQ_NONE
    and bindings::irqreturn::IRQ_HANDLED, ensuring flawless compilation
    across all bindgen configurations (both type-alias and newtype).

Changes in v5:
  - serio: decoupled child device allocation and publication in Driver
    lifecycle (init -> start -> attach). Child input devices are
    allocated and configured before opening the port, but only registered
    via Driver::start() after serio_open() succeeds. This prevents
    premature registration and spurious uevents on probe failures.
  - serio: added C wrappers rust_helper_serio_pause_rx() and
    rust_helper_serio_continue_rx() to safely attach child devices in
    Driver::attach() under hardware RX pause, eliminating races with
    concurrent interrupts without sleeping.
  - serio: removed redundant Device::as_device() method and made
    Device::as_raw() crate-private (pub(crate)), relying on the standard
    AsRef<device::Device> implementation.

Changes in v4:
  - Makefile: restored analog.o and db9.o in joystick Makefile
    that were inadvertently removed during previous revisions.
  - serio: eliminated concurrent borrow_mut() and aliasing data races
    between connect_callback() and interrupt_callback() by initializing
    and registering the input device prior to serio_open().
  - serio: mapped interrupt return codes without missing constants.
  - serio & stinger: formatted all module imports in strict vertical
    style with trailing // comments.
  - serio: annotated Registration::drop() and Driver::disconnect() with
    #[inline].

Changes in v3:
  - input: added AllocatedDevice::set_phys_from_parent() to dynamically
    format the physical device path ("%s/input0") in an owned kernel
    heap buffer.
  - input: managed parent device reference counts in set_parent(), drop(),
    and register() using get_device()/put_device() to avoid dangling
    pointers and reference leaks.
  - input: eliminated manual cleanup duplication in register() by checking
    to_result() before mem::forget(self).
  - input: implemented Send and Sync for AllocatedDevice, added #[inline]
    on small methods, and formatted imports vertically.
  - serio: integrated serio::Device with kernel device abstractions via
    AsBusDevice, impl_device_context_deref!, and AsRef<device::Device>.
  - stinger: restored userspace-visible device name ("Gravis Stinger")
    and dynamic phys path, preserving udev and EVIOCGNAME compatibility.
  - stinger: maintained module name "stinger.ko" using Kbuild object
    aliasing under CONFIG_JOYSTICK_STINGER_RUST.

Changes in v2:
  - Combined serio subsystem abstractions and Gravis Stinger driver
    port into a single patch (2/2).
  - Retained original C driver (stinger.c) under CONFIG_JOYSTICK_STINGER
    and introduced CONFIG_JOYSTICK_STINGER_RUST to avoid regressions on
    architectures and configurations without Rust support.
  - Ensured IS_REACHABLE() guards for C helpers and #[cfg(CONFIG_* = "y")]
    for rust/kernel modules to prevent unresolved symbols.

Vecheslav Filatov (2):
  rust: input: add input device abstractions
  rust: serio: add serio bus abstractions and port Gravis Stinger driver

 drivers/input/joystick/Kconfig         |  14 ++
 drivers/input/joystick/Makefile        |   3 +
 drivers/input/joystick/stinger_rust.rs | 191 +++++++++++++++
 rust/bindings/bindings_helper.h        |   2 +
 rust/helpers/helpers.c                 |   2 +
 rust/helpers/input.c                   |  22 ++
 rust/helpers/serio.c                   |  27 ++
 rust/kernel/input.rs                   | 253 +++++++++++++++++++
 rust/kernel/lib.rs                     |   4 +
 rust/kernel/serio.rs                   | 328 +++++++++++++++++++++++++
 10 files changed, 846 insertions(+)
 create mode 100644 drivers/input/joystick/stinger_rust.rs
 create mode 100644 rust/helpers/input.c
 create mode 100644 rust/helpers/serio.c
 create mode 100644 rust/kernel/input.rs
 create mode 100644 rust/kernel/serio.rs

-- 
2.56.0
