Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064368;
	b=K2TlyFVs9gAmsiD30ihkZf7dSlg2NpNk/BWmpu3kyTOApCDilLGI8G2lXylWF8WzXVEu
	 PZxUKhckKn2QL4MhEpeKRFkEt40JzzX1wLIw+RiOjc39ywHsjzv0ntG5EIw2JUf1GwXsF
	 dxpoloKE/tnRRL/4cTnguDBs4TSpW8VOPJXpojoobYnE7qoAoTTeHeg6di6uU6n/Jrfc2
	 qfs/0iv7p521umLO+ktCK0EeohwC3dKLitXuqTP9tqMjri119m5LgZMF75S/SknKGRWBa
	 d/dYeI6cRm1yTbZ6INXXnNdOTZDqFE3hTr5Wxd8R3Xn4t8gNq+bunGFsTLNcBmXpNiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=94lQ/zLeVCE/Dxl+IWkoK2rsoipFVucH6nX0rc6zU20=;
	b=4KltRfvxjEMZVqpItgFvWaMJ11aiXOzifUQku+9NeP0DXbRjqhnxec9c9JKhGe/CfMce
	 Jva2KzNx6Hg3K/fsIqJ6pf0VcX2zw/yooCiT+wdxIyd/Aj+fTqrI1hrmdrHhcSiB0BWA8
	 zzDIUxDPpDyZuGFhafpzJuWZ3OPd22buImsK4ktN6vfR1LUgVtEH5QjGv1HZL02Lj8Lwm
	 D8Mmi0x+Hlnt/Ad8E5bJyDnfNmWRCLyts4KqAxuo2HXSe6UpvbeOaNEHcUeRrTtYGLyPF
	 5rS7sag5y4tVS5Io2LZrXtFJiHQ6ERmvkn7xIXI32zXwhLu3J71nLI5OdLs93T9fKEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n1afktS5;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272EA606B8A2
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 15:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 272EA606B8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n1afktS5
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so12270095e9.3
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2026 07:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794064366; x=1794669166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=94lQ/zLeVCE/Dxl+IWkoK2rsoipFVucH6nX0rc6zU20=;
        b=n1afktS506R838K88N7naBWLU0ykNyT71xA/YfhgS4qir3tTlJOXbKYhaMjN2AG7fZ
         5EPrUjTUbi1IL/dZMQ3uH1XjdsbewIp3+/qFhZ6mxmF0SnzdUhvqdoz2fczUNfl3vCfp
         45+P6vPTsOHWD+JVQmqZS3H1/aXamvQ0oPizCxtT1uPAzjq4qSHIm4EubaDG8E9ijS0J
         OipztjOdqDFb/LlhiCilavBmB2VuIad/Q6BX7U6U5665R7rRHSLJnsfHeER/H2I2lRZS
         T7qMWS6BApXd86G08nvM6LfnQ8Uvp8bnD1VpFk+Wnk0DPDQ1Z+hb3KInlsbC5qChwd5R
         d6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794064366; x=1794669166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=94lQ/zLeVCE/Dxl+IWkoK2rsoipFVucH6nX0rc6zU20=;
        b=oVVdVyz62TCV2EWp3gDtnc0qDHd/Xiv84qAm8NUGbtuJHe2ALqIjE5yftq2KycFZ8P
         QImnNxRbvneg9QU+oFDV58gYBFgr+So4kAvvpW+ohqpFdgzEF+245LmvwKLHju/7SCE7
         nycrVtoV/qiInYfC17sE2pu94KFKEV5UzFJAAHyxW9+Hayna/KCwAINCpni7skbNqDd2
         oA11PkFDdUCLWoV8SQYvU8gadMqntGsz+dOIoBA4koJB7KP0Q4UW8Ean0fCpe6FTk1UP
         NrTQ9OBKeEDztKuKE4PD9SBqzJOwBM3BOaZF+JPoSCyiNussj6L6aG+vB6COvV5XfMhg
         WTzQ==
X-Gm-Message-State: APuU4Z8dM4WWpbYvFekPwO+Psyzg2RHSE6lHnLvVTttYlnLbg093EQJ8
	uLcPnt7f6qAKnXs06Yw3sF0B6+qq9olnAWH3PT8omXtscIjVI132YkG5
X-Gm-Gg: AYBFou2Q2rULZmXypQK9XH1eVBu6PElBZTIwcLif/bBG0uDx1XDASoFVwAkJX0EIkAw
	yYWYbwb3YW9RNWphlSWF7JnHqEluefIWtwiPQy2yi8Xjmri4Q9395Ip3QcrhdxggeU9kqQIK/ko
	2H4d2CHNS0CiuBbYqziW72EGkZwo5znLCT1PXdXXNxr1x9Csi+wSaDbBTRhpPlkteS/cgNAan0l
	4LdyI7lfGBTbmr777XWrFtTZEEw8ulI1GZ9xXRBqfS0ghq7CqXV75yg+kzVVGAy+wy79nY5fKVt
	zjclzPL1vfaQ2J0KsPl7FV8Ai1oMczugi37HNkabDcrscBYzu+hFGH0CFeK5zXKLb+t2sUR05JY
	uMiF5Vujc4QrFv+ziRTCTrGZ6KpbWGr6ri1uzTxsbXiQxifmgk175AYAejSEXBXI32dgr+zSCuT
	gaInvF8a2HuwdlCzPj2MYZwsyUicMIkcaIBmiDOQDz1jqlTJysOimeOo3X3LHp60ACHseQnnoYM
	Nxpq3qkAax15ezDSBr9glx9u4SJnqjs/7dBcjZmLnrIKrpkjhg9WansMdsNA1BDFDmvz+i35xzW
	Y17Gc8OACdahgOGWs34lDIocKP5m/uoPp0763++ZwEambkLsM3lhaZgI6BB3rVpivHtiLIjJn4s
	TfTTL2LMSKc51t885w5joGLBVtdZjnT4Q0YtQc3whEb7QPpyI
X-Received: by 2002:a05:600c:1391:b0:4a6:44b:2593 with SMTP id 5b1f17b1804b1-4b6dfd97b6cmr98201195e9.29.1794064366182;
        Sat, 07 Nov 2026 07:12:46 -0800 (PST)
Received: from DESKTOP-KHFMJSR ([194.9.62.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7c49082b6sm32073065e9.2.2026.11.07.07.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:12:45 -0800 (PST)
From: Vecheslav Filatov <harepro29@gmail.com>
To: dmitry.torokhov@gmail.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org
Cc: linux-input@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vecheslav Filatov <harepro29@gmail.com>
Subject: [PATCH v11 0/2] rust: input: add input/serio abstractions and port Gravis Stinger driver
Date: Sat,  7 Nov 2026 20:12:36 +0500
Message-ID: <20261107151238.607451-1-harepro29@gmail.com>
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

Changes in v11:
  - serio: changed Driver::init() parameter from &Device<device::Bound>
    to &Device (i.e. &Device<device::Normal>) and Registration::
    connect_callback() cast to Device, because serio connect callbacks
    run outside driver core really_probe() probe context without devres
    release guarantees on connection failure.
  - joystick/stinger_rust: updated StingerDriver::init() signature to
    accept &serio::Device and removed now-unused device import.

Changes in v10:
  - serio: removed wrapper module and aliases, directly mapping
    Registration::interrupt_callback() to canonical constants
    bindings::irqreturn::IRQ_NONE and bindings::irqreturn::IRQ_HANDLED.

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
    the Developer Certificate of Origin (DCO).

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
 drivers/input/joystick/stinger_rust.rs | 190 ++++++++++++++
 rust/bindings/bindings_helper.h        |   2 +
 rust/helpers/helpers.c                 |   2 +
 rust/helpers/input.c                   |  22 ++
 rust/helpers/serio.c                   |  27 ++
 rust/kernel/input.rs                   | 253 +++++++++++++++++++
 rust/kernel/lib.rs                     |   4 +
 rust/kernel/serio.rs                   | 331 +++++++++++++++++++++++++
 10 files changed, 849 insertions(+)
 create mode 100644 drivers/input/joystick/stinger_rust.rs
 create mode 100644 rust/helpers/input.c
 create mode 100644 rust/helpers/serio.c
 create mode 100644 rust/kernel/input.rs
 create mode 100644 rust/kernel/serio.rs

-- 
2.56.0

