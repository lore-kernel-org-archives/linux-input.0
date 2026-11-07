Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794060724;
	b=19beqvpvwUhJ8YEVLvKHAvOX6MV1LM2k0bYI6eqjDVMSCTzSghi56l5Z1icymBWbP7aX
	 zleV2E2L+J8KAf1jU2kRgffZLwWxob0iebJyuRbaL3eDUu3KNtZxlKgFLyGVJ3LKpj2j5
	 oriXlVqbXPztXdWLNO0NsGxziPRNAiHbW+169RNjakOZNg7D6kQrBp6ToJC6HSwib+2Ig
	 jXw/dYEm9OwUI8gdQLe8rDB2T369sfMxI4YA21ZiNg9OVPhyRDboIt39z4XjruY39wLtu
	 mk8HXnZ2mOhlzBxv3iONiItMajjUfJO8tsYhjq25IU/vgyJSMQR5YScgoWF/AjTArzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794060724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N7oNzfxnPM1b9iq8PjBkau8djf/0wkMbcjPct0Hzu0M=;
	b=O6SyAqUFYlQeQA6j+wsofyBDaszLKP0+igHNJcv5bsDLt/T7UPFAWDFOnVRK24NQX2rD
	 eFEQS9Xs4GJFB1Yhnw474ALGr1NGio2Wt4jVhJVFqdbj7hylOQUF1H4cu/18IMM5LNnja
	 oMEggM8Nyx5ew7jPJFb+uV561GmX4Ykm20LeJgUK/cRIgjiTYs0T+6ZZlu69tkggiMqiI
	 EtTIwBKVQRtvKl2knCuB6GKaEMYl/7SgwCXSoXFbatFYg8nvEj8wilkG7sEQhX1IaVmIX
	 bOFvnS/L5bZxjuUMhM6VxFdrFcFBkC6V4DAsmPFYuMPaZ7sZglF3fW2I9AU7WfcHHZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LW4FW7cD;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ACD606A32E
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 14:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07ACD606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LW4FW7cD
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so16918125e9.2
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2026 06:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794060722; x=1794665522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N7oNzfxnPM1b9iq8PjBkau8djf/0wkMbcjPct0Hzu0M=;
        b=LW4FW7cD+jZcHT7uQVYRyo3ICGNS03dPqayGgBVmcrYdpiTkCln0qBqhDm+abH3url
         iCg19+nIrV7WTLeDG8XCs0+Ohd/I0APYJvnKc9ztJZNgEqUBi8lThtOq7UshZeaB2v+K
         EQ6FndwVnxEtkIb4l/chDZEX4DRTOCYU3RAplyfSuEBG8ooPP//7qnv0ZgQuhbFje+f0
         NYgncEAJq7diCAWSDraKPWefMgQHTZA/B5/+gZrjQE43NlW9hLfaUuZA4Nwt13urKl8K
         0omQF4aiUC5FZQPJLrI76zh58NcJ42Wc9Q44NyuRO+wmFBxRL+KVgpTsq17HJPo22/ju
         I5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794060722; x=1794665522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N7oNzfxnPM1b9iq8PjBkau8djf/0wkMbcjPct0Hzu0M=;
        b=qmlqLDRz1WQG2XUskAOzsUbIm8XDbUPGJbOM8I4JN+NI+bcK8tf7RAYQ0ejGVf4/XC
         kUpWPz/lvjSI254cyYSXjk4AaKvdz121IIi56lZb69M/tuZa3Zde715hKrHcm01IhijB
         UfB57AN/JlaU+kMXcjsiLOiLGoVnEKMfQdw4IZLniy7jibbl2q1vWWN6DzOHI6dunGEQ
         5gaTp/D4zWTQH2rvIaU+F0vN1pstyADixmQPeP3/dp0COHJNCntE2ytXj0d5FIzwQtIg
         uxekhgWKLX3aRj1Qq+mEBAxMhzk87FLbOb8et3gO5YjMTn8Zb/dihRFeU2mSd62hcidN
         TaeA==
X-Forwarded-Encrypted: i=1; AKwUvBxAABQVD1nWLmzIbtdeUd+0cJKvJ58G3QmQaaKIEtXvPFjw55IcZzhXAENqgVy06q5j3G8WdAVHMhnWZw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8qAQgOu9ms7ienvr99i3sw40b1WZqL3MrfhH/xKwTVRqaLtrfB
	YDtWe7hT+4hSJe+uZzOP8Nz2Q6pKTPkJj1bOQfhOi6dDpjYz1hxipGGT
X-Gm-Gg: AYBFou0rts68LAfFtBE0XpN/VnMn8s1wQAaeR7k63iSHHiv1uo4Pb2g0W01uIDSOxOg
	HXXL/ASb6BmtHV+WRSrBh6A7APtEOjn80Gwo0aThDVXMBqVMSU35XMI/7Y6ua3ufk/wwGtvQUXu
	vPagn53Cv19S92A6qZlMAbBHtZ8cpqMXCigKTE5CGm797ayank+TVqpk5phzKgwMIG8C4eOJKle
	FvvWrauBbjpdQRLvXDrZYBf5vW09+/h3MrXKY/4UfrxArFAlESRD1NjS3SkEHeSgYo0uVu1Syge
	a1cNNUmF0dIeSbpEcy0wcQVOoP+zwCuyvih5c22YHLiUcJ/jfUcKgNIR5RFqmj+4Dkqq1v1wwuG
	/QtSnn8rg971VmV2t9oo9Nmjexk/er5jMUNDAtdqrgL8JzxTRW62buPNe0CYWG+FwmgMRbG50of
	9jZ1Gm6l67Dg224MqfFPp7kG1uEyv1Mu5O0eMWGYyYaKJ1CpqsbgBuD4QhhOi6qeu7/mzSHzRWC
	CGUCeR5wqVsuXJ7DB3xWkIYBw1RuOSqf9P4Sl/08lMbne2enJKHilU/DT3HSnJ/skd/aEq33v59
	ROs36LOjKv8UBcF2cDkvaUqvTHk3Pu0ZXad8PKZoDIIGGNQh40sd7nNHXE4+nWAJg2SNT+uS5VV
	6sE0VXmK1FHWGI/Rr8+LlqFhmDDzY1cuRYPjjPlA/aHZ4qxus
X-Received: by 2002:a05:600c:a015:b0:4a3:5a91:5f61 with SMTP id 5b1f17b1804b1-4b6df028f04mr101869655e9.14.1794060722177;
        Sat, 07 Nov 2026 06:12:02 -0800 (PST)
Received: from DESKTOP-KHFMJSR ([194.9.62.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d809dae9sm9313327f8f.52.2026.11.07.06.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:12:01 -0800 (PST)
From: Vecheslav Filatov <harepro29@gmail.com>
To: ojeda@kernel.org,
	dmitry.torokhov@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-input@vger.kernel.org,
	Vecheslav Filatov <harepro29@gmail.com>
Subject: [PATCH v10 0/2] rust: input: add input/serio abstractions and port Gravis Stinger driver
Date: Sat,  7 Nov 2026 19:11:54 +0500
Message-ID: <20261107141156.591711-1-harepro29@gmail.com>
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
 rust/kernel/serio.rs                   | 331 +++++++++++++++++++++++++
 10 files changed, 850 insertions(+)
 create mode 100644 drivers/input/joystick/stinger_rust.rs
 create mode 100644 rust/helpers/input.c
 create mode 100644 rust/helpers/serio.c
 create mode 100644 rust/kernel/input.rs
 create mode 100644 rust/kernel/serio.rs

-- 
2.56.0
