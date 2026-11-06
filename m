Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794001413;
	b=2tXp52+huPmJhy8iXvdN6KrTpfI8E45zTQNWu4W70QeA37AXO2P+FpSM6iKyebpur8w4
	 Sl9Hq2MyJnsslgMLJYjUMjybhnsek5Qb0QCRbd4EOUL6juIT0gJ6MIvIltDi6upMl0V+r
	 3lpSG6iFUYh/EYFrUoLMOHyogt5NgVF2ns7Kdiyve6wL2AQDKUmpbcgKn8K2QoF0l76K4
	 Fz19PgW1PdxpFAP8iNfAbS4ULaB/VqDddEJYx+ldBWX4wDRr7xqLdWQZ6hc8RJWNMAlIa
	 BrTmg2PJV28wHNWNRsNr+VJ88z458XnaGinBTnz3Wr7F8yTAkfiA4Bx4ZgbuVc/B6Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794001413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ULFZ+Lz5JFNxqhOdlYorxY6TtGyrAFixmkP/y0AuJlI=;
	b=emJYUV231RdA9g572pL0TxrT3RmIQwZ6unwzzFSilNETdZN7+jv05WJttttmsGlih66Z
	 y2Dg+r5Y/XZ3HZWN0CIeknkzUUPRNOjuYdQDk5CXvw1Ef2clPr4NiJXxsYt71fVWHNTD+
	 TQ4lkA60+3bfNzVzZH+17ERe6c29UTWiwQ2jYli9FzmWFBZ+duQPKm/1W3gn/hgkM9DvL
	 enoW8mqUbRi77ucS0w6+vGSYqbNUGRtgoy+LO86LToJWab2/P7OM43UPmutxGbXDL2AVQ
	 q2/S6+494fHBBRZhTJ9TxnCOftUz+o1PCxxiNLqlrCIF2BA/6kI+2QmH3sNgqAcZxxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iGrY5ycN;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689EE606A326
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 21:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 689EE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iGrY5ycN
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490f38e9688so60569f8f.0
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 13:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794001412; x=1794606212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ULFZ+Lz5JFNxqhOdlYorxY6TtGyrAFixmkP/y0AuJlI=;
        b=iGrY5ycN0BualMftXCT/JlkQ3Y+E1QacH7fowGjADHRbF7guYSi+S7CvtTVrhQxCMI
         E16U1pmmaz5yzonEqVxUJ6I28G3vPuDXsGKlD1hkBirfUTWxT246HPDevqLd6HtwF+Bl
         YYmUZtb2636+/EziBwCQwqBr5Cds5v0b/msQBKoH5OEG9QCuc7Hiw6dJKD4UaryU48Ld
         595N+dJiJq8qo75u5GfEJVyDdM5cb4+HXIvru9TuT5AdblD1Nr3DtAMkgMDX0kkr802y
         8NMh57kJ8fBv/AXOWVJA3r2pPfZeLJmCZt92QT5VCjcSuvOwUvim1FijrRMJ0n+j4YuT
         udLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794001412; x=1794606212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ULFZ+Lz5JFNxqhOdlYorxY6TtGyrAFixmkP/y0AuJlI=;
        b=dHSoEc7okuoneQk14oncjmL7RjEqdLswaAnqPHIdWV/R50trIlvwuEhIUjCghNys8P
         yFXFrBdlROYUSzdebsCVEGByODtb/VOddOqlO2f/Vk7HiyX21EePb+6rGnNXJnAltz6D
         wHzYSpqjwx/a23rqGph7VB8xAUbYudXcbnDCxcHuq99kf+/CvL8STN7fiNO/Nx7/kgMs
         wOadMXlLyms120vvZnHKpDhnqQnI2/8RLySIRF1is3WKny0PDOgNLIeYKf4y7lmrDi/v
         yj5y37I1j6mnhM1R9dxxbyuPpdSrM41wE5bNHXX5nikDfGpa+6P8arLSW+KJwJ8oyjt8
         1H1g==
X-Forwarded-Encrypted: i=1; AL+hErENmrmBzNKDecO0+byJ0uEQcEBNuNlx/a9t5jZkTPfIMtRmqMqhHojoA9C8Uch1ZYAw8BBZuW2jWQFvlA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9AsXThIhkIqANixo4+49ZToF/L7kcwl5oKMnaV0umSm0au8xcp
	fgiOG6k2lQkF6goNDdmEPMjXeqdR8cmyMdOVZMasHnrkT6CAuumajRZi
X-Gm-Gg: AYBFou2t/LJyZ/Acypv3DM+jlgnz6TE67UR6u5jXLCBUkIQ8v6smN6wcrSfQTBvuObD
	15JX2sFHZZBktcTdbNyFV3/vaCxjRPSlz9Iy4eCrJFrb0UhPyg+Aoat7qznStbQhdUf7F6axAt9
	4YPYELsBiWnLzUf7LmkbNzQi4bMIfRmYBCJAxhyHPwc8+ujgyGQjjJsq1XEixhJRf+waVJzb6UE
	wuUpgXUVvantUDArcVr7LMY8Xcs/DRKczkWpYqvmtcSEggnKMXWY9BBObsyH5IFq0IO62bbCvZg
	BQ6E4ecX8u0DXLtx5oeDt6XBzaQ7QUGHp5Sm+SiJxKb3hwFVcBQOjVeTzTZtYPNrr3rYxiAxQLT
	AXNjz2wo2Tsf6b+W+joc4jS6pC38ersTzhEjGMptP7r+0AJuJqgbiB4X+oLwTj518gb2shfCXQC
	SG/B6GBh4MfLx2UeLmIrxFruWj7VRirPRUjbtgTJgRQ4Ty84pAXGCLndcd3acinqJmlBtS2j807
	ekuavLFJRxNKzWOBODwJY/mLwrBERM7VIBl/f1T6rbe3xSh0eG3O3m9thbGU8zKwPCr4z4DaGZh
	PQxokwBkCApHSsjyBDw4GrPErxwhFeElbhOtL2dp0KkQOB5ccqEeT3RE8JzI8/DCrUOQBLcpQTN
	u3+5+cfr8O29L9MwpWqAZcrPMhIaE6OLhJd0wFmB/Xb70SAPF
X-Received: by 2002:a05:6000:2c0e:b0:491:e477:6820 with SMTP id ffacd0b85a97d-49421bdacebmr415904f8f.20.1794001411624;
        Fri, 06 Nov 2026 13:43:31 -0800 (PST)
Received: from DESKTOP-KHFMJSR ([194.9.62.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc6187sm5799505f8f.46.2026.11.06.13.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:43:31 -0800 (PST)
From: clicedvly768 <harepro29@gmail.com>
To: ojeda@kernel.org,
	dmitry.torokhov@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-input@vger.kernel.org,
	clicedvly768 <harepro29@gmail.com>
Subject: [PATCH v4 0/2] rust: input: add input/serio abstractions and port Gravis Stinger driver
Date: Sat,  7 Nov 2026 02:43:20 +0500
Message-ID: <20261106214322.421869-1-harepro29@gmail.com>
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

Changes in v4:
  - Makefile: restored analog.o and db9.o in joystick Makefile
    that were inadvertently removed during previous revisions.
  - serio: eliminated concurrent borrow_mut() and aliasing data races
    between connect_callback() and interrupt_callback() by initializing
    and registering the input device prior to serio_open(), removing
    the problematic start() hook.
  - serio: mapped interrupt return codes via bindings::irqreturn_t(..)
    without referencing missing bindings constants.
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
    AsBusDevice, impl_device_context_deref!, and as_device().
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
 drivers/input/joystick/stinger_rust.rs | 184 +++++++++++++++
 rust/bindings/bindings_helper.h        |   2 +
 rust/helpers/helpers.c                 |   2 +
 rust/helpers/input.c                   |  22 ++
 rust/helpers/serio.c                   |  17 ++
 rust/kernel/input.rs                   | 253 ++++++++++++++++++++
 rust/kernel/lib.rs                     |   4 +
 rust/kernel/serio.rs                   | 306 +++++++++++++++++++++++++
 10 files changed, 807 insertions(+)
 create mode 100644 drivers/input/joystick/stinger_rust.rs
 create mode 100644 rust/helpers/input.c
 create mode 100644 rust/helpers/serio.c
 create mode 100644 rust/kernel/input.rs
 create mode 100644 rust/kernel/serio.rs

-- 
2.56.0
