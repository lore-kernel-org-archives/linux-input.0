Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992645;
	b=kjEqhaUkyJ8NisaeUfIuh6lilLbwvj0MtXZpLnBi7GPTCGtIvqHpKnav73S7WK8TuBbc
	 BCwCRdmB82IZ7nT64ukZjnLPrqinGkZnXD2w8F3k4PPXT4EpprUi3fFvRRTihtKTH/C7B
	 zGUxo7EVLv99OTuNzgkOxP3OGfHnGZUK+V5jsSjOKnputtD9a3CQZA1NWfF52eWhPOBTR
	 tyzY0RNiZb+SrnzLgQeOKt5lNUq2TShDssxnzcBcbxnFKAWbyUrMZPKlAb5e9HFnJ1d+7
	 Z/0bOrlW/rARrbgsLdn1sga+e6uDb6qZS2ve/0qJkz5JCiYi8gjSm1OlmugIR4F00yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992645;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=opDReGPxNbgoF/lkah1ZnN+d9K7uBHUX04tEROSAFWU=;
	b=GdZdTBuJUbuKLLD6eDKlcb8KStsnFNibHaWdvTCiyHtbi+2WKRaFvLgDm6opxx5x3/DH
	 eNF34F5ubveviCquLUzzo67WwW+VMhHJ7EH5/7m3b7Sasn/33t59Okq14QcIMD7U6jqwt
	 oSMJCQMO4cUfLO09yP/XlPLTLU5DsENkDZV16Ci5laM61RLkiXlj01JwMXlB/xU/kAwlb
	 qXiA+MRJHD5L6fBLH9SoFnTsK4rUvamIjFbWWe3wPwsMitl4XfjI3ENKNYfT9KlSSjVA6
	 hmBxQaIWU/3sB8l68oClMgtei3F/yVq3HcP91vc6Hj2MEj68wwZ66k4SmCnrcsuIFnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tdVeEylp;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73256606A329
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 19:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73256606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tdVeEylp
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-492690dd5daso783147f8f.1
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 11:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793992643; x=1794597443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=opDReGPxNbgoF/lkah1ZnN+d9K7uBHUX04tEROSAFWU=;
        b=tdVeEylp8uQr+1+RxLJqR/HNFIhsvs2m/OS0BpuoKxs88Ok/8jNteIWXjNJZ+DtJVk
         wgczD9qos2kCArVBOQ6Xi7cFLgkluITLkhLAKhXH6Vmlm7Xviwb5RxAQZfFUrbkwIp4M
         bH5G1LQS3NG9IW6vH7oz82IZmiECoykEIDyNBymJR3akGqPYQB9RW78Ry/MQ16+aNJ3O
         BEDKUOHAeKo3UoHn0bFindc7ThTTDWe/R3U3SNf/QiXj3HdTnfcH/LrKZZfrZ0OwcCxR
         4oQkvpq/lSzwKFjaio1CzXon8KFsCCw5pirhkC+R0fDujSqr4obOUpa4yiur5aqMjxv2
         J1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793992643; x=1794597443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=opDReGPxNbgoF/lkah1ZnN+d9K7uBHUX04tEROSAFWU=;
        b=MR5Yb3Y0B1nG1ErFboj0ZHrXPfdBKPbkRQvn0WiWfqAk4fvHqcNdrPAJgsUDYAJ+2V
         5yql49X+ePzprPTZ0Er3UOqA7vEyf0nlJ7SPeRYDy7lMZYiiCDW4IyaFdt41HEGDWjpE
         nxWKtSfetQCiwowP7tWV0EgvV5pzK7OCgQa696sEa+8I0mLsyfImJ+4DJ7+Xy2ILHv3Z
         uPGc+S6WMM+xpKSE4ESP1yKHC1xT+glWR1IzVY8cCsClSAVT0Fwd1lHBOgG3/5v43hBM
         gC6XvqcMDFJoNg28WYz0JNGIn7DgNSvP3Oaqk6AswATOEClRWAOy1wJlw1fBnkyDqRBq
         yyTg==
X-Forwarded-Encrypted: i=1; AL+hErEAa7gq5koRly2FULl4Jrd1Q8UrhsPzI2UDpBhofU7xCbedPGH3Ugg3zfCtGg/HapbNCOdExf6s5cYenA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8dXs1j2q80/e2NDe7IR+0DYxznsdn2cFCGnNlONeMcVQeZT98o
	e4BpVQDcT1hyHsC3nFCJo0gubPtDAVQWN+betFqWpIRh27qcmGsupt0F
X-Gm-Gg: AYBFou2e88oo0hdXkA1sXfPvDlE+XrYeShMmhTk83vZiQJtYzYvZtFK4TZfbSUu1wYE
	xaCz4CTdHJipE2Y+DDNch2cDmz0yMChb8twWdd4649q4eQK27rn4kwve2WKzsUzxgaMJdUeEF21
	GFYZp1mCYFaoEuS/J2OTDTFmdDLZCIgtt4EBxNGSiOObUXO8pt34K8Qmo2PW5EfxaYYzUCZMmrg
	W7e0MgtnlibDTmy61mWCjjG1a9ifTy+yEMLjzwyHI1LPh03MavDD+JJhWx2ZloIof1CH9luMZ4M
	BKWjGBCrgr94Vt+guy97NTSHHKqjyhxbyKA6iMgzj918xFoNNyHEMvJioxpy5HV6yqKQ0PbRvhP
	QTCHCTtHaOuSSIQv6LI5oS2fnOwhpruianjeptJ20NeimflH7zLuE/1YECI/Y2yUPyPD/S9wfRt
	MJrUbxmCyGO2jhiC+8+YDEVQiWi0y/flOPyIl8O9ntGa3Mj23X+verjgRJoJOmuuyvP54b+zeL5
	0IYCh0zyXVpdjPC3kPVdnEjivNc5GNdKRK6U8GJb/y6/lf7a8wpw/2erpAVJDS6vOCJFecvR4vJ
	N77A50asE0FU0zbEjfTIdG8tqPN6i6xc9b9DG01A7VKmHrQVaFcxE+I63fxDUa7Yila/BvhnU1P
	j1IsJYjINuJXQaeqjIxrZ+JOWPrmw+TFrlKheifWrwCwAzKEj
X-Received: by 2002:a05:6000:4818:b0:48e:3bc4:a367 with SMTP id ffacd0b85a97d-4940d559deamr170530f8f.33.1793992642527;
        Fri, 06 Nov 2026 11:17:22 -0800 (PST)
Received: from DESKTOP-KHFMJSR ([194.9.62.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc6187sm5224380f8f.46.2026.11.06.11.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:17:21 -0800 (PST)
From: clicedvly768 <harepro29@gmail.com>
To: ojeda@kernel.org,
	dmitry.torokhov@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-input@vger.kernel.org,
	clicedvly768 <harepro29@gmail.com>
Subject: [PATCH 0/3] rust: input: add input/serio abstractions and port Gravis Stinger driver
Date: Sat,  7 Nov 2026 00:17:11 +0500
Message-ID: <20261106191714.334055-1-harepro29@gmail.com>
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
by porting the legacy Gravis Stinger serial gamepad driver from C to
safe Rust.

Motivation and Design:
- In the Rust for Linux (RfL) philosophy, device drivers should not rely
  on raw FFI and unsafe blocks. Instead, the kernel crate provides safe,
  idiomatic Rust abstractions.
- The Gravis Stinger gamepad is an ideal candidate for demonstrating safe
  Rust driver development in the input subsystem: it uses a well-defined
  4-byte serial protocol at 9600 baud, 10 buttons, and 2 analog axes.
- The ported driver (`drivers/input/joystick/stinger.rs`) contains ZERO
  unsafe blocks, using RAII types (`AllocatedDevice`, `RegisteredDevice`,
  `serio::Registration`) for memory safety and device lifetime management.

Testing:
- Built with Clang/LLVM and rustc 1.99.1.
- Passes all strict kernel Rust checks: `make rustfmtcheck`,
  `make rustdoc`,
  and `make CLIPPY=1` with zero warnings.
- Tested end-to-end in a custom QEMU virtual test environment with serial
  port loopback (`serport` line discipline `N_MOUSE` and `SERIO_STINGER`).
- Verified event reporting (`EV_KEY`, `EV_ABS`, `EV_SYN`) via `evtest`
  and an automated Python protocol test suite across all 10 buttons and
  both axes (-64..64).

Structure of the series:
1. Patch 1: Add input device abstractions (`kernel::input`).
2. Patch 2: Add serio bus abstractions (`kernel::serio`).
3. Patch 3: Port `drivers/input/joystick/stinger.c` to `stinger.rs`.

clicedvly768 (3):
  rust: input: add input device abstractions
  rust: serio: add serio bus abstractions
  input: joystick: stinger: port Gravis Stinger driver to safe Rust

 drivers/input/joystick/Kconfig    |   1 +
 drivers/input/joystick/stinger.c  | 191 -------------------------
 drivers/input/joystick/stinger.rs | 174 +++++++++++++++++++++++
 rust/bindings/bindings_helper.h   |   2 +
 rust/helpers/helpers.c            |   2 +
 rust/helpers/input.c              |  18 +++
 rust/helpers/serio.c              |  23 +++
 rust/kernel/input.rs              | 174 +++++++++++++++++++++++
 rust/kernel/lib.rs                |   2 +
 rust/kernel/serio.rs              | 223 ++++++++++++++++++++++++++++++
 10 files changed, 619 insertions(+), 191 deletions(-)
 delete mode 100644 drivers/input/joystick/stinger.c
 create mode 100644 drivers/input/joystick/stinger.rs
 create mode 100644 rust/helpers/input.c
 create mode 100644 rust/helpers/serio.c
 create mode 100644 rust/kernel/input.rs
 create mode 100644 rust/kernel/serio.rs

-- 
2.56.0
