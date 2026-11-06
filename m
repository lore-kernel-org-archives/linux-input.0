Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794004245;
	b=qwRlI/oT2aLs9BJeqz6xRlcJ8WpAAsU7W6Jj/n852QgPLcG9Ga6ZfX/wPgi5IUoZJZL8
	 kXwA9yFC1KXIyRo0fLUWhO+Qw8ZQ9nCxNJKv/izAg6+HVAvwv3Pb1htwUPH2lk8p8+ThE
	 KrFfqLhG1KtCa+ImLwOen4LQ5Otqgj8Tot/h4egaAPO312PZs1uC0Ga5uEodu2NisjfyQ
	 hvN7yAnx1UNLb13KmB94z42rTEC1LJz/J/AjEyBVmtOeFuX2CimBuH+KRYbszsggGr/wF
	 GwWEW4tP29P6e1pkiTJcIYCGypaG3DmsrZtTayzIw8nPZSMdinWTx2GBtIWCF2userQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794004245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3Wc9u5hs9bPs9BVBlW4FrmuLwiUyoR2WnleMZeaplMU=;
	b=x+mwYGMb2BAeuXNQ/JOtxbK6KXxJfu7F3C2rCyjs91rn2EACatuS8LbkW0OLEbBMcgM6
	 SZBfeAnfFt1Xurpo+V29bpzx5LKjR0zSC89N5IcGeNFciZ2jzhil8BLdLjwJoTsZqQDh0
	 xXU8+wxIC/pgfzVJjsmHCh8CDzEj2mxBUevVyLtTYaBUIvmr3RpO3AamvzAW0Py5iMxvv
	 PAniXif6IVPok54oGuKw/OfAbWyGhA5/AYqYSFvF9pXF10jjyovfpIhSfKDjk9MzT22Pn
	 Ahv6ps6xZyTUxtM8GV8skSlk8dkyPlBB7Zf8onq15FaI5kn/MOlPnHyt/C1ME38Buuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jgUhOGCA;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F6606A32D
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 22:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 571F6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jgUhOGCA
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48dee593f18so982161f8f.3
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 14:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794004243; x=1794609043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Wc9u5hs9bPs9BVBlW4FrmuLwiUyoR2WnleMZeaplMU=;
        b=jgUhOGCADoYR3d1N1lVPq8+U21W4+fOPITxXTHlSWe8XrT+OjOmeD9KaU2c7QNmdJd
         wpdtNPo+fIrTjIEy/TkoA/UCQfI36RIKD9y7oWaB2gHkIyHx2TsBWYFSoK94J3fXb9F4
         24Njdnq54epZRFMiDJtP9PZgqqHknsMhCa75sDe4ZlsbJMU0UwUzAUfG09WCpGMLZXgS
         oq+vkO6PGwI4/6gFj1EvW4J76WcVFZsRCo1vOqkyhBGyIy31DIiICZUva+GJ+ps9tnNB
         KNlhW/7C1ZqXULDG3bpVcjYZuBjOhlt/hM7CA5qpeabBQ7nX0JIUNV5AwttvvYiQ3mqD
         qRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794004243; x=1794609043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Wc9u5hs9bPs9BVBlW4FrmuLwiUyoR2WnleMZeaplMU=;
        b=mpYVkO8iuteiKrK01jZ64hpxwiQ0c7OoZAEUWVmtZ15VDBHh3TuemzN98BWBmfwRU+
         c+NUddZDrDMxwwOPx1m6JRPa9SMKM5QUfPvUuDnmXe9kO9OyVE/Vma5RvzBnlLfR30/Z
         uyzKZLehNP3b0IuTOTbZw2cE9720HmREGqXB8COA7OMMVxuyTm4SogHsEN0uw6N3zZw9
         I3u8XZDFsFNU/K5vqjN0RfSU9rcb52HMPzGlTW4Ar1EO8mmeIR4SN49l4x7SJfHcO4O3
         2ioAA/bjT/ke4fNR8VL8cDEee6PwhJzFFPgN5kCGBJy9zFjvvCIWbniPSruQQAoxUJes
         HiGQ==
X-Forwarded-Encrypted: i=1; AL+hErEnoAKvEBh1w2SWOGW9VhPx6JC5IH9DMTIfABjH6yLjrevBcifuhSp24gX0eypasUSkQCyxcj9xP1XzgA==@vger.kernel.org
X-Gm-Message-State: APuU4Z++GoPn2/wf9+kHsNwTNo/TXS6iFdmaGm4H9fcXkgGHF21K+oSV
	qZM3J51RPmlldy26FDtfDSYQhc3M/rxTFo3X37NmtZrPvF/Y6ttYlxsH
X-Gm-Gg: AYBFou1/zkElSIVsSNMaFU2sELbWDu5IaR+E2DTspGcuoUNKPl7s/E6ZzQrsEuzu/IG
	GmkuBucThdYXn+JAf24hMCi6I8tSnu8u3f3eLoHKx0X/UtpfXkKAxGjUFBcBaVCo4OYmPii4hsW
	zkYI0aQjWqv4UTSrsAVfQUQRgGxDqFWjCs6UNPKgTQqKEL6fsWCkKoSlycwDrnw+KHAg8VYW+GM
	Z9wACObXgqf7XHqpjfjTn4SsZkIWMdrDB4bOfLc1OWvPQDE99rc1btEEGXnt4kA0i6eriN9BTFc
	mliR4v0b0BCMeJfAyij6lH0dRdiMLaYg4VrwZJlPcZSqYZTKv789uRVChHqWpVqpcONHZeXTh6t
	5rptLYai6rtiGzvALvgdNwsjqtl+7SNi2SxuhRakZyD8CiFRHpkKNfOYK6modtDYI3cqmYdByRv
	uabcxQn6eBL/ifOgbku8j4dCVyKJoxc53GiAzQ7+gKWq0Xrrk27lE/pUhomijppSWzeqHMBqdeu
	z71Mf/sDiu+8aN0ZQVIMGQTwg9qnkVe/3ZJCgkHCgN8DzBOzKYwTPGAalj/IGodq4hPavKIe8xu
	oPiDixYKsqiP0k8/Rgq4Ryj2lxkCTgld7xX6JNHhkkuLIn7HW7TTY5/+u/NAy8i+HC9ntAsDI3k
	lNg2OUt1noBV9QGtB/LelUnkXp/FjGphzwu0aBqju2DOlcmJf
X-Received: by 2002:a05:6000:470e:b0:491:5b1:fa73 with SMTP id ffacd0b85a97d-4926fd37256mr7554519f8f.0.1794004242569;
        Fri, 06 Nov 2026 14:30:42 -0800 (PST)
Received: from DESKTOP-KHFMJSR ([194.9.62.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d8472969sm6262367f8f.58.2026.11.06.14.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 14:30:42 -0800 (PST)
From: clicedvly768 <harepro29@gmail.com>
To: ojeda@kernel.org,
	dmitry.torokhov@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-input@vger.kernel.org,
	clicedvly768 <harepro29@gmail.com>
Subject: [PATCH v5 0/2] rust: input: add input/serio abstractions and port Gravis Stinger driver
Date: Sat,  7 Nov 2026 03:30:31 +0500
Message-ID: <20261106223033.452853-1-harepro29@gmail.com>
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

Changes in v5:
  - serio: resolved invalid irqreturn_t constructor compilation error
    by constructing bindings::irqreturn(ret as u32).
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
  - serio: mapped interrupt return codes via bindings::irqreturn(..).
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

clicedvly768 (2):
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
 rust/kernel/serio.rs                   | 327 +++++++++++++++++++++++++
 10 files changed, 845 insertions(+)
 create mode 100644 drivers/input/joystick/stinger_rust.rs
 create mode 100644 rust/helpers/input.c
 create mode 100644 rust/helpers/serio.c
 create mode 100644 rust/kernel/input.rs
 create mode 100644 rust/kernel/serio.rs

-- 
2.56.0
