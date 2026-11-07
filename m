Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046875;
	b=KbmRNNtQjV2C5ipvdRSFCn4Gu9Cp3nXyPMQsrzz7r4auAR49BGvP5rrt7olQkH6JrCEv
	 6d/WR78SkXJA7St4PlFzIOuGOSMuDiJ6wnNh8g/Jbx3QF0ovOPsfGsYGDoq7lc6fegZsA
	 tLwwLEP8pLsvoJ2vZZRlMeNEBfTENzWX26pO0lihEF0XMhfjekeQJNlno9FGiSZWEiq1I
	 lxkPoGwuT/mCs/Jn8O3dNvrf3j/QcwC+0IrDuSbeTvp54jgK51T4WiBsxxeu29OsojBtO
	 MTkpEBPqhLhjn4/1mTEcM/tuaYGKFnhczNEhJTTZkB5ng0oCZtFn4SjfbKf61OE7JjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LDHwQayjQZoBatzm/D3sDrIKUNM4uoVNqAbYnc4szmE=;
	b=Hxax/pBnUqKXZe1xpPiQAO1opJ8IA+Ty/sFMRvfHBNEuvDn20v9+73UddUGkwnXE3eCW
	 7L4Sr8ZLOOaXywrqKDN6+By25C8u6c4tY6Pqyv7+faRc3omUBD4gVNkzD0VWJz/fJGsxB
	 tMdACzSjZCeZs2ouJO9Pk1Uz53nN+nTY3Gk3MrzLxrk2VoPxKtyIRzefIDLdO20YVCJQ4
	 YKsOmq/o5a5icDBYOStNTKm/HY2bm6YvMPGol3ZmKqazeCnSm8yUhXWZLh1kO/JmXVU1q
	 DHIwwdJLckQfQSq0qBi47Nl6mNhgyfLXIkZtCZLAV9f8y7rfVcuP0fwf9Y9xawVhUCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hhtqWN8f;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA79606D809
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 10:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FA79606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hhtqWN8f
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so18518915e9.3
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2026 02:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794046873; x=1794651673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LDHwQayjQZoBatzm/D3sDrIKUNM4uoVNqAbYnc4szmE=;
        b=hhtqWN8fb6jM7mj/2uk4PCdxJgEue1nu9SkwfyvW9bQb3Sg28X55cwFKVk0v87Srzk
         jPTFNRnynM+ZTcBkVXB3gdwcZGThW2F5Yd1EZwUT2N1j8SV89S3OSXP7IP6PtTyx0IZ2
         ueaJlxi5xqO+SQywcXgKqHoPXWgnFxJc2WbANshak43JVmOmPLJP2I8Vjpc5U+NzYYqP
         BL2WP5mGFgCF3GRjiDM9pEjPYt2qFgYXIm2p2m9yDk7juTKRVq3FpgNyHpUTJFNUJiRg
         H9Io6K223amru7lS7NbGIqvd7zuH8419quQ8v3MrpwrMMn+5v03+eSRFFpuqKNqytqJ9
         YJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794046873; x=1794651673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LDHwQayjQZoBatzm/D3sDrIKUNM4uoVNqAbYnc4szmE=;
        b=v7G2USlccT/R4EGmfAllVlS9MKMwSnLXnzzEL1CoNV0LKRzbt4+DfpILKJt8kFv0O3
         sajOCX6fjN9MCfkwOrTeJ7IIH4pZI1ufJfSP4mehqss2RyoQFXD/TfnImpsdTU8g7oNd
         N5apjc8faRjK53IW6Ad5vD7fQSPhBr27HH9ZibUzhf6ySwFWhp09zJtqrWAh3F73P2lb
         StIxyyvMU/RPJOYpoCp5N/OxXutrPtzq08YScd05HrpD9eDSV16zqwutHqrNapWNtM7L
         DuLNZwjHm5MVz4OR7llgg8CJaeLyCzczFjYqNInTSf3c0EnLy9u6KrhxMFzmhlTODxzj
         myvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxg3wg8Gm2hccTjdR4OIlTjmxyB8Cagdj27rv77s83a6n4wWJ+ruUlNdh/3We9kKYN2IG6jD3G2D3oF9Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z/wM2P7Lgxv12Fe2Cec8MhUGJcBKCWiFpAzGuM/Nfg5EuFarPaA
	oYsVJBuyE/svPUCV9HPUwaNRN54nFbZPXxW+M1wkeT9Sk/TevZ6/7aN3
X-Gm-Gg: AYBFou1nktnVmZkgUGsKGg/Z6wmsUSJDpliYGTV0a0D/phMSU+i5S5xTrt2Wtr6SqJD
	v1Nulwfi2KpCqlZUosqMHNpmh+dZS1GuVDiCulQq/euzx/bUBMuiYffZgmWrrwOOs6A2uk4mhcp
	M25nk/ewBssrnNHFgMXMIHNldwWdv/t8ulzO2urepci7sVmogkoeFynT3yXkBAAcf9GcW2UEz31
	svwxAYHs8Egd7Wf/W8b8Jbu+6FqiNjbPyNHXOYSVwBXrvC2R208PhQWdCsXWUcQI9Z60605rvq4
	Ff/ELa0NRHFpshnL939wKK3PCWIYMpUdkmOQiGgXxjdSd1pc6Zb7IDH9AkUaUeoAdI8Ce2U3Yuv
	++KY9gzht2dWkLcsNQNUPDTDwiviUu1k2aF1wcTW0ZiWGEWPSqMw6x+vihuSKsM8i/hkRI9RsNe
	6vcGsRd+qrVRL1jIKXAAJ5PfGLHKgWJvalIxlwTdmJDCro0owozuexlJeDZ9q9sMiwrXTepyi/P
	6Zkoo63MGBWsudRv7C+pcYxhsH7aW6VAM/m5wvRm/CDZOfHXJr+igTwSaJivy5TBbXz3OpNVSd2
	AzhBl+Elp9h7b4dZyWa0smmyFooD19SQY32dDsdxUwcgWw2AOYGZ7HYXfsTtMhrxuwJy4a72mO6
	+vOa0UsgTpQxKLdVVa2qUU13YpzWVUR0hl8AAGOVnmMDscZFi
X-Received: by 2002:a05:600c:1991:b0:4a1:fa33:441a with SMTP id 5b1f17b1804b1-4b6dc30ae76mr86407205e9.2.1794046872821;
        Sat, 07 Nov 2026 02:21:12 -0800 (PST)
Received: from DESKTOP-KHFMJSR ([194.9.62.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3283ec3sm51888285e9.12.2026.11.07.02.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 02:21:12 -0800 (PST)
From: Vecheslav Filatov <harepro29@gmail.com>
To: ojeda@kernel.org,
	dmitry.torokhov@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-input@vger.kernel.org,
	Vecheslav Filatov <harepro29@gmail.com>
Subject: [PATCH v9 0/2] rust: input: add input/serio abstractions and port Gravis Stinger driver
Date: Sat,  7 Nov 2026 15:21:04 +0500
Message-ID: <20261107102106.546041-1-harepro29@gmail.com>
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

Changes in v9:
  - serio: updated Registration::interrupt_callback() to map IRQ
    return codes using module-level constants.

Changes in v8:
  - serio: simplified IRQ return constants to module-level definitions
    with direct crate::bindings import without extra wrapper modules.

Changes in v7:
  - serio: scoped the lifetime of borrowed mut data inside
    connect_callback() to drop before calling serio_continue_rx(),
    preventing aliasing violations with incoming interrupts.
  - joystick: added RUSTFLAGS_stinger_rust.o := --crate-name stinger
    in Makefile to ensure built-in modpost device table aliases match
    the canonical module name "stinger".

Changes in v6:
  - Developer identity: updated author and Signed-off-by to developer's
    real name (Vecheslav Filatov) across all commits in compliance with
    the Developer's Certificate of Origin (DCO).

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
 drivers/input/joystick/Makefile        |   4 +
 drivers/input/joystick/stinger_rust.rs | 191 +++++++++++++++
 rust/bindings/bindings_helper.h        |   2 +
 rust/helpers/helpers.c                 |   2 +
 rust/helpers/input.c                   |  22 ++
 rust/helpers/serio.c                   |  27 ++
 rust/kernel/input.rs                   | 253 +++++++++++++++++++
 rust/kernel/lib.rs                     |   4 +
 rust/kernel/serio.rs                   | 335 +++++++++++++++++++++++++
 10 files changed, 854 insertions(+)
 create mode 100644 drivers/input/joystick/stinger_rust.rs
 create mode 100644 rust/helpers/input.c
 create mode 100644 rust/helpers/serio.c
 create mode 100644 rust/kernel/input.rs
 create mode 100644 rust/kernel/serio.rs

-- 
2.56.0
