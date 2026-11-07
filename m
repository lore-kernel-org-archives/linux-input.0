Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794033330;
	b=VeHAPexo8+ebtyhXkkxGB3D46PJuxEj0oBcOknSqVtX7b6TH1vdvmFFHMm8V3OBoPYQy
	 dfj+Z9VA30ORMRmxmPaS7AUPbFSGlLvrI0+XtQqg3ODupC1hAGg+80d44Da5FSBnmJeO5
	 qdmML8ZO3yMgZGvT1HHZGiOvuGG94PTcj7Bawok4bq2p7Rdu5Yq46rbqF+SYdN2oQmrCp
	 MHLQNv3bWve7R4xUnez8ol4e6rzyyIgc4l+4wnGWhNrLuszZhpNRUtgbd98yZ4nGt2lCS
	 A02LH3/GgdfizD1XCzWtUHzdgqLExszDKukY7L6cz/PsCR6AaO8yPPLdiHr88wwZn6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794033330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PeiovD1XuxWqfD0XNRLRX5QSPyRdhh58GujWtqQnqv8=;
	b=kdtUX6jQe5PrBZC3aj1c2wvrR3jAexf/RaPoiw0niXcKFHD8XkxOjOCBKQxZUPTekjs2
	 BsUNTc14Ga1V5zA13l6ZEpqK3Iq66vl4hZmw0gT2GchxB5UnjGH8W9sQDtOxqrgIWkrSC
	 eRsJaxCS4vZCsFitEZWX2eRO843mu8Xeay+wgTr7s3hpHuYEPQBol6kSe3FlbEvNQhkD0
	 CJrHSjuY0Gm9yroTr1xzs3ph5uJ6ZKhMMNg8zaOoCrWdhKEmBqD3G+zaLJif74QpXRHm1
	 iu42NiN3I7CsvE/iTBy4zd1nKPRRK3UCZWmiSeamOOkW/y1W8Tzu2QVVCWW6Lee9T6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VvQikJke;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8444606A32C
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 06:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8444606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VvQikJke
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so1447968f8f.1
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 22:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794033328; x=1794638128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PeiovD1XuxWqfD0XNRLRX5QSPyRdhh58GujWtqQnqv8=;
        b=VvQikJken5svri7SHXvAT/PYxOkNvZtbBdgZs5xawzzM7a1AMG447LWNThqA5rPef2
         vTpNnj6/l16jS2SXlbeOFX3ZWFBqdrGjtqvAkZ8dQq2Y5vgnlVQrcAyVon37h+vrfkI6
         V7BrMMjrn22kqY+/WNBCJN6Xn3F0Z+cYKmz5dZtRkI743tBb01ZRzcBvbgJUaHkjeo/r
         cvtz5oqHpFYY/Y7a29TyWSOeoFYzYxJmKXnsbkGWEh920HQ180vA28T3201MM98WHnLO
         6V34HoUUsarGYbxIdG1L8HipD5mnTLS9tmXnMblezhQ+jbhOcr8N8yEFsggK2hT5wHLT
         E42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794033328; x=1794638128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PeiovD1XuxWqfD0XNRLRX5QSPyRdhh58GujWtqQnqv8=;
        b=cIwHmEB4k6UPyaxF9bcNyRs72cNVcaZfLfKVCE58DFtBrOzbgM79oVxnZtsFOKygjN
         4feLUZRpHCC5iYLKmU5rPU6ozzqVm2XgEjX20xf6xc1LeN6uRys8fCgQtE3mN8r39rXf
         iInbR3JBr7fHLRVGJyQHyCZnRP+6vBAuWuUqhL9H7J8XkYFP14J7lVmqCSU/eDfjLWZW
         adTsU+BVOQatR2/QVaSnq1N0FsIj/Lukrb2ObISO0+1U3w4Ia6vz23nq/ug2t06Y41Zl
         aCW9sfTCBTyifA7/vS0HYukm0PoizXFwwhE2zf5ND7ZY59oU/Bh2RG10bAXDk0bWNcIw
         QxsA==
X-Forwarded-Encrypted: i=1; AL+hErHOfa95eNB8BzFrmycse1E5JCaUStq0awWaDHigO9eKi/VLOmamUBqWix17J0OyVA8HIoQKzLYCW0Z0Lw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+2R86LUQFUTzRqmbqQZRQ52tlnOit6PG5JDAZdXJukucxacISB
	Pl2gut6XkE6qndDP049PIjGkuTkt7IuXS9v9ts8tTC3vPdooPlDit3l5
X-Gm-Gg: AYBFou04etfH6hdcSOR6ot51erSWMuOMvSa5cNXiK3cMt2vCfrvhvRMUPbuBKA3dZaI
	Pddt/+0skTBsQFNWYpAqs9osiGJmAuMuNtcFKv2fKw1cYUDWp/5hnB2LQdeeM1R6T5b8oiqUb7N
	4R4OmdUOEr3ufDDkaYdd8EjmJY90bK4uOosVOh8m4bjrL1bjOWdNOXDFEVV3TjR/M2FFXvmRqG7
	t8iPerdDAW7jHCVljT1oV/Udt0DB5T+ujtpc8eAp3j/GT61uGC2ZM1aNMCNWJDxjyXFL3QgMGde
	/wHqkIyNnSC5INCZdcIPhlwsyGWWZaO9kYNjTKrY0QDHyoAsQZag1RmNYyypoH3gy7B3rC4xSHM
	7JwJrQp0vuBvR0QcosE7+aB044zhRUuhGufyuy9p7sV4WQhhoD2S7msJyDve6d8+bTRyFncvP8l
	gOGCZmTgaIuSzMgsrcI+jXmhLTDSQWpXdcIJ9XiuS9+C5Bz0At48rkVaZ2wuNn46sIl0K+Ys1VY
	gnLhNNPfOLHuhhhIfzMYOclgsRBuGt5nPnMqSIlTjoMRcoo1g4Mk6+FhqMxmcfPW8vAFt1/PCjw
	DcQ25dzg4/di+xcJ74yGMgq46GpwWh3RNjNSAm0JOTJwYG3ljx5K75qogp2r2gEagNHVMu1Ljyb
	gXYavJCF9bV46BEoADUTxAd/CJw5r7muqKKg7mQ00fmRRA8XC
X-Received: by 2002:a5d:5f04:0:b0:491:68e2:bf2f with SMTP id ffacd0b85a97d-49278174603mr8568203f8f.52.1794033327979;
        Fri, 06 Nov 2026 22:35:27 -0800 (PST)
Received: from DESKTOP-KHFMJSR ([194.9.62.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d837e3f5sm7916903f8f.56.2026.11.06.22.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:35:27 -0800 (PST)
From: Vecheslav Filatov <harepro29@gmail.com>
To: ojeda@kernel.org,
	dmitry.torokhov@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-input@vger.kernel.org,
	Vecheslav Filatov <harepro29@gmail.com>
Subject: [PATCH v7 0/2] rust: input: add input/serio abstractions and port Gravis Stinger driver
Date: Sat,  7 Nov 2026 11:35:17 +0500
Message-ID: <20261107063520.489958-1-harepro29@gmail.com>
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

Changes in v7:
  - serio: updated interrupt_callback() to return flat constants
    bindings::irqreturn_IRQ_NONE and bindings::irqreturn_IRQ_HANDLED.
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
 rust/kernel/serio.rs                   | 340 +++++++++++++++++++++++++
 10 files changed, 859 insertions(+)
 create mode 100644 drivers/input/joystick/stinger_rust.rs
 create mode 100644 rust/helpers/input.c
 create mode 100644 rust/helpers/serio.c
 create mode 100644 rust/kernel/input.rs
 create mode 100644 rust/kernel/serio.rs

-- 
2.56.0
