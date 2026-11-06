Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996182;
	b=don8LiGBw48E0F+fOIX8nhGh64f/SUKmOqd3jgVD7GIKuLtutW0FObB0u9vJiuiaAgN6
	 f509hcSXVP2peD4DQiP3eJ+wbBROJIMUkCFep/cSbdNq/HdSFiMjBlLYJ+iBN3hZWDOqy
	 J8a9wvVwhF3jSzafhpbiNL3cHf+nSoj14wJ8ppdUvx35XS9e11NMHoRuR6JU4YG3vezYk
	 s02KexDvjSnffUO4YV+ZIQn+UyIUOMGVFJsM/cUaLaHV230ZGxr6tAnn3V/VeGb+1teOu
	 J8z6WempL8DN0dl3gUWdG5kzgETTvnS7A64yVhW9Ok5Qsa6LosOjKisnnG0OMXwvWKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H61jNpGZqjdF50P6YJtvoTcfxhYbPsYfLt5K8cgjXTM=;
	b=vKNKNtd6aQno5zxXYZyQ23FzgWlAzlUoJ47iMqFA/RrVHILhIOff25WFqZjCGet17Eho
	 Aqkj7R9VVCffvTOFeq8EIrhLdplA/DZfw/uxyBPUKemSEj6+nQGBAPjf4ccRsz79i1gj/
	 cnSKjicWO+5th/P3scQXNDStzmAeicOHIlNZK5hde8DkkbGkRkPrbFHm4ZcoRIvdssnFO
	 mH5wf323YprmAYG/4oG3c5Xrdzv+aJ5Ne2XL4fh2SugK0LxhWprr2aym8ho+a5Q/YanNt
	 ntrrWnlJpxLfn0zWideN09m65R/zq5ZdYyWdp7pucGUW9IO665Ex3LUUHphvWh5bKFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sW4HDWtj;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7D606A33B
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 20:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34A7D606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sW4HDWtj
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4919a880834so612627f8f.0
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 12:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793996181; x=1794600981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H61jNpGZqjdF50P6YJtvoTcfxhYbPsYfLt5K8cgjXTM=;
        b=sW4HDWtj5U1B1LJeS/dJD5eBY1RstADEtv/MwF5AHXSRy0CIyXCo+GYmZJa8CRZilQ
         uFtX1MyH4CC1oiZsmPun9/cPnrai3H8xR8rco7fgOk+MausVmmwAmjCYqwr3PJKuWcIb
         gT6zw8sPOVzu1arljrwq395pEcxx60OYUeqqR+cPiXECmfybyfSPMN4DA69OWwHnJ+iZ
         ENdtF2Mdat+SrOQuf5R67xrAFNz7SeSVnVNs7Ikj+gHX79SARpBhiR3S71QiX2Acrd7p
         2BQTjFZAp2K3IrWi93oJO8vBz8ic/chINupmnALMDKMler5Unyi0FGnVswZvqLzadePt
         N1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793996181; x=1794600981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H61jNpGZqjdF50P6YJtvoTcfxhYbPsYfLt5K8cgjXTM=;
        b=Va91SJcWbKSc58txISq0WLocH9doPnsRi9T1xsbAkrDIJODF4igAh4736H6/yYyw0y
         Gr9GThSM1rVEkFlSdxdZ2gf2vPDw1NmYbk9VJh8Kny2+AESortfp87gPor2CngDMDb2n
         Yk98UvAcYmjdWGiihRiWsaIHnlgwWgZz59AZq2VaTn9+rct4GPVr5TTlt9xJgPxI9KAA
         x/nUyxyXM3Yx2yzTXrx73KpgEUafF5e/pCXp4UcAYktMBYPjSu5S3NzQ7rVaWSZCo/Mk
         KXuJ44O4dhjSlMyvm1bjEaGSkmS7W9QPW0qLzhblA1dHRB94VAgatyiJ3gSfFNR5uofu
         Coxw==
X-Forwarded-Encrypted: i=1; AL+hErF95QFujuedwYtu9Yx8pXgzfzP+K7OcCOmgDeKd+lnyYcOrT4rtQin+PYBRkN5wyfqbW4OwdSTkjiRxog==@vger.kernel.org
X-Gm-Message-State: APuU4Z+JIK27VbAUlRB59WiTrjfTvSBa7QA/1bnaYUrCyOZnt+DNYL1y
	+2RI1MDXPUPXRJX3uZwGdnUCOLi6iUgmMsU3/+WwK6edx6yzeR5FV5h2
X-Gm-Gg: AYBFou34D2+VlVKUNy3RSYN9V0cTyP2cHeJK5llwl1ETeZHF03yuidTC4vnFZC+MiSJ
	qjAUNW+NaVJjV+4KuUKqe2sJ7Mh+xIUUILz0rPYb8Wxb0j5/LamMXO4FEyCgO2WpBPtl8z64Fs9
	PRE5qSljVJiAeIuUjGjFe1AOv88fEQKQRbT5zJGV2BXe+gzG2tSr0gLxCuqHeDvs+wSJdfB/0gG
	m6ijy7nzjwzAtEnR0/lei23j67G7gUxiJIwi+ysgHIWwR05ucDWV5awiqiDjVyMtu/2MoOE5qpD
	jyof9PAcYLGon71cUKj2z8mrbZoCN4AZSTJBzizWqDil+qBGInDvNYRSGzfQ0o69XrBlQh60Lkl
	KL8VpWYEx3QZKTnYFEWf16dColkcLAxxQfgOtCTVSGJJ2G2lwoIv2UR5tqVP3jqVDNIPnU4yVR2
	Wcl1wZ48tajqZ33GhK5Zk+el0zSqM5c74qKjdPsD2DKSMS5PWaV/45eL3cs6I5pkYWC08WXfKbJ
	sqp4fVGDQs2k4AuB9abvhdItc2wcBTyr8aTuQ4zQM57QMmkJ/sERiksoTM4SiwzpC85zo1R/WCy
	m/wfLQEnR2z9g60Cdg2pddx22B6QVWMIa6328brFsDGFMAVYqHN2c/N8EIt9JwJiEdUFebpLrP3
	HwmeCrP+YL/LhXyXmcQR98QGZjrJbp0FrPoiMSj/t0yBPHmBf
X-Received: by 2002:a05:6000:4810:b0:48f:bcdf:6f68 with SMTP id ffacd0b85a97d-49275a271a1mr6840008f8f.37.1793996180501;
        Fri, 06 Nov 2026 12:16:20 -0800 (PST)
Received: from DESKTOP-KHFMJSR ([194.9.62.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d3d609a3sm5849954f8f.7.2026.11.06.12.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:16:20 -0800 (PST)
From: clicedvly768 <harepro29@gmail.com>
To: ojeda@kernel.org,
	dmitry.torokhov@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-input@vger.kernel.org,
	clicedvly768 <harepro29@gmail.com>
Subject: [PATCH v2 0/2] rust: input: add input/serio abstractions and port Gravis Stinger driver
Date: Sat,  7 Nov 2026 01:14:27 +0500
Message-ID: <20261106201429.376997-1-harepro29@gmail.com>
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

This series introduces safe Rust abstractions for the Linux input and
serio (Serial I/O) subsystems and demonstrates their real-world usage
by porting the legacy Gravis Stinger serial gamepad driver to safe Rust.

Following community review, the serio bus abstractions and the Stinger
driver port have been consolidated into the second patch, while keeping
the input device abstractions in the first patch.

Motivation and Design:
- In the Rust for Linux (RfL) philosophy, device drivers should not rely
  on raw FFI and unsafe blocks. Instead, the kernel crate provides safe,
  idiomatic Rust abstractions.
- The Gravis Stinger gamepad is an ideal candidate for demonstrating safe
  Rust driver development in the input subsystem: it uses a well-defined
  4-byte serial protocol at 9600 baud, 10 buttons, and 2 analog axes.
- The ported driver (`drivers/input/joystick/stinger_rust.rs`) contains
  ZERO unsafe blocks, using RAII types (`AllocatedDevice`,
  `RegisteredDevice`, `serio::Registration`) for memory safety and
  device lifetime management.
- Non-regression: `CONFIG_JOYSTICK_STINGER_RUST` is offered alongside
  the original C driver (`stinger.c`), ensuring architectures without
  Rust (e.g. powerpc defconfigs) suffer no hardware support regressions.

Testing:
- Built with Clang/LLVM and rustc 1.85.
- Passes all strict kernel Rust checks: `make LLVM=1 rustfmtcheck`,
  `make LLVM=1 rustdoc`, and `make LLVM=1 CLIPPY=1` with zero warnings.
- Tested both built-in (`CONFIG_JOYSTICK_STINGER=y`) and loadable module
  (`CONFIG_JOYSTICK_STINGER=m`) configurations.
- Tested end-to-end in a custom QEMU virtual test environment with serial
  port loopback (`serport` line discipline `N_MOUSE` and `SERIO_STINGER`).
- Verified event reporting (`EV_KEY`, `EV_ABS`, `EV_SYN`) via `evtest`
  and an automated test suite across all 10 buttons and
  both axes (-64..64).

Changes in v2:
- Consolidated serio abstractions and Stinger driver port into patch 2/2.
- Gated built-in Rust modules and helpers with `#[cfg(CONFIG_* = "y")]`
  and `#if IS_REACHABLE(CONFIG_*)` to prevent vmlinux link failures
  when CONFIG_INPUT or CONFIG_SERIO is compiled as a module or disabled.
- Retained original `stinger.c` and introduced `JOYSTICK_STINGER_RUST`
  to avoid hardware support regressions on architectures without RUST.
- Replaced raw slice `&'static [DeviceId]` with
  `kernel::device_id::RawDeviceId` and `kernel::device_id::IdTable`
  via `kernel::serio_device_table!`, guaranteeing compile-time
  zero-sentinel termination and exporting modpost device aliases.
- Fixed module owner tracking: removed `helpers.o` registration wrappers;
  `Registration::new` now takes `&'static ThisModule` and calls
  `bindings::__serio_register_driver` with the driver's own module pointer.
- Stored `Opaque<bindings::serio_driver>` in `Pin<KBox<...>>` to avoid
  aliasing violations on C-owned memory.
- Fixed return error code sign in `connect_callback` (`to_errno()` is
  already negative).
- Reordered port opening: `serio_open` is called before publishing the
  input device to userspace.
- Reused `kernel::irq::IrqReturn` instead of duplicating a custom enum.
- Integrated `serio::Device` with generic device infrastructure:
  implemented `AsRef<device::Device>` and `Deref<Target = device::Device>`,
  and added `AllocatedDevice::set_parent()` in `input.rs` to maintain
  the sysfs device hierarchy (`&serio->dev`).
- Switched `AllocatedDevice::set_phys()` to `&'static CStr`.
- Added bounds check `axis < ABS_CNT` in `set_abs_params()`.
- Added `#[inline]` on small helper methods and used vertical imports.

clicedvly768 (2):
  rust: input: add input device abstractions
  rust: serio: add serio bus abstractions and port Gravis Stinger driver

 drivers/input/joystick/Kconfig         |  14 ++
 drivers/input/joystick/Makefile        |   4 +
 drivers/input/joystick/stinger_rust.rs | 178 +++++++++++++++++
 rust/bindings/bindings_helper.h        |   2 +
 rust/helpers/helpers.c                 |   2 +
 rust/helpers/input.c                   |  22 +++
 rust/helpers/serio.c                   |  17 ++
 rust/kernel/input.rs                   | 214 +++++++++++++++++++++
 rust/kernel/lib.rs                     |   4 +
 rust/kernel/serio.rs                   | 256 +++++++++++++++++++++++++
 10 files changed, 713 insertions(+)
 create mode 100644 drivers/input/joystick/stinger_rust.rs
 create mode 100644 rust/helpers/input.c
 create mode 100644 rust/helpers/serio.c
 create mode 100644 rust/kernel/input.rs
 create mode 100644 rust/kernel/serio.rs

-- 
2.56.0

