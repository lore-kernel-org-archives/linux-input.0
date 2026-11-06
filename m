Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999444;
	b=Mf2Vx8WKJdsh7tDYrZHmGpXhHEM9ugDMh8ETfbTGJ2/0ewXUPv76WoB/OF4MyAoxJ0CZ
	 ZWFLgWku6/8xkIPnSbGJNaqmmwaJoSteMWeaHJRvxR9ZXYkNomW+5xRyvU6THzi15ilww
	 nCnlcqPiXi3kiNlYKaDggH1EsULY8yi9ozxlFSAfpPbU+zwxEd7mVbxCO6gxavKMm+fr5
	 S8eJEGkqN4HJnY7VaJREM0Tv9h3lF+VQVQQHzbTjxOe1CMwmhBI2Yqy3fz45vXXKR4vQM
	 r1IPK92kybG5iWfrmskjOQu95rBBIl0B+SxgziFnAY+WcI0UY67LZKJ2ZL1K3AdoN2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0TfHtZkqJznG2H+ws+ctScG95Xi0uNmW+KweBrxJavE=;
	b=y/e4XIomVVcTDGhFgHYYBLU/n/4hbJVJNXjWGKh2cDg3loNK7xpcdjRL1ltqVDUjUsQf
	 OL0NWJIL+DVRmEFXdQQA1ZkKyhWpZUaRjKj8qIIW5g89objLwjfji6oLVbmaijSCpeeCH
	 M/RDeTV4vWoiVYLT2198scEkq7vbIy0lL8Arapnpc7nmRg7R0kUH/VtrgzGgnsqe9Bez4
	 UD2azdDvxdriX/YeKAsB9ZlcYTiAC+y8IPr+BZQVkwk0VeXAaCyuMaETk3dYg7pol4M2X
	 CoFllHKlwnXgFy4Kw8604m6eUzOLeNhckWC46rPUnsB/mHRgVD0Cep87Sxo2jYWgk7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BwqKv2nH;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B265606A326
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 21:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B265606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BwqKv2nH
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49d05d51553so7268385e9.2
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 13:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793999442; x=1794604242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0TfHtZkqJznG2H+ws+ctScG95Xi0uNmW+KweBrxJavE=;
        b=BwqKv2nHqlm/VApnRX/biC9ZPMZFsgVjs84rOx+CUeBa3nmfcpe6vaAi7mffbfOFJ7
         PTe7AEW2u70fWna1sS80Pw3IQHcKXYNKMaMHyFO5sGGubkNZr/DzkBZ7VExhe+T+W275
         2W2FtGgYDCRcQs5WyK0o9aGnEvYFTG/aVAJngCgGbliwTVlv5G0TpM2bcMXT6AVsSVDv
         7H9BOTNB2hfiilneePopWNT4Gt/XWv0dWtDW7G4RoInbYX49aCk0M5gzs9ec9HSYVeZy
         BmZyTFTVNdeSCOAGpi4C+gqvTFFAVbjpEM9HxNFfo9eXDoU+E5TLTFBYzvJNJCkay6mT
         FGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793999442; x=1794604242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0TfHtZkqJznG2H+ws+ctScG95Xi0uNmW+KweBrxJavE=;
        b=mheDkLWVjGuno2yj6KbpkYX2AHiQal1zUCfLve/9NwVTiG+HBAjKxXFcLHmUiuxSdW
         wVrVaLT/GESMq095JXW8TeK/aIcH23FtWAo4fi9ctVk31KhuMw+GYEjcTXgUveYrafTv
         mGb7FYlGCyGntjudirETKYr/ACt9M6ovOm/fhLB42a5mXYdYEBOxsvSwjo3KTX7ov0W+
         ojZiIMpv5f5avPRRKUi+4GfXRzpjGEwrb3iBPnf67PNf3J1idcNDtg4oBF5AvhCOWNI9
         JNJWiHRIvOlH5+kjCO9nyRcrAFgYCfj8iBApwI66FO/ovmxwRephIBsd/6raNBqffNe9
         fmmQ==
X-Forwarded-Encrypted: i=1; AKwUvBwI+SQ/w73adT8Pwa+PR80hkvgg2PQzUkPnS+7ZxlmefZaHRpCZ0nPWAt1PUZU5a1Q3XUGUQJ18/Ado1g==@vger.kernel.org
X-Gm-Message-State: APuU4Z9bgyVib6ygFUA2gd37jONhxZzP/kinq9kpZsNHsysthPewhnuX
	Qiuy3Ynz8mya9m/fWbiBpPRsslA6+2a+8Ruuvup8zhWZyF6j9X10BfPxk7F45XjzL7wjDK/r
X-Gm-Gg: AYBFou0tBircn6u6CU+YHorppjO73AvCRqMKZY3YXaFrYzorfxHd8oj7lNkjoZah0wr
	jmfBvAkDLIUm3JAIHMtgJZblQLaEfL04daheDwRABEgUSWPS+Kiz3KImIc/p9AisvvC15KJXT2z
	oxi+KX/DIMUf52doSSvmEpy6Je5py7CvuudfjXK0T3n7LNZhEDiSqC1ZRB6AmXiYJ+k37sdzsEw
	5uA7jswbclqrbx4I/WidTnODniyIWqhcwWsTGPks52INg8uu0wCL3qNTODP4MX7zSx+szJYCwpT
	eswNEkpdUIvFXxw1OovfeHzM5Bj9vS68HYFnzK/VckVAZVlWEN2zqrMS9Ls9qKd34QuQkEb0aDp
	fTVrsb62X93YmXfsrTcI2dY0BUC2pcYne/bALqghLNduKE0EFxWonEdEFDerHfSpLe8RTA+p8QE
	9WvyAapKxR9lesYxyVrL5uFEQP8y5uFtCmC5yktSzdEKf315mkYgio0/KX1gIReks6NYgpoyF5A
	HgDBPtcF2qOEDe3XoKThZU4bEpJdMNjTLv059ET6zD3Qp5Uu5P4oHWPjbvkw+b7gP+REDNXWcPH
	Rww0HnArZp7KZkpyFE709hRmZXzZBDr/e84DXkCH8DeQgijtAvL7EwB7e45MGiQ+RNOiZ9Li92K
	WasIwCIdF5FSNfLan0KuulYO0P5efw5XisaeNJjZ9P+X3p5PT
X-Received: by 2002:a05:600c:8b23:b0:4a1:6517:ccf1 with SMTP id 5b1f17b1804b1-4b6dea6984emr67911215e9.9.1793999441880;
        Fri, 06 Nov 2026 13:10:41 -0800 (PST)
Received: from DESKTOP-KHFMJSR ([194.9.62.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3283b50sm8049295e9.10.2026.11.06.13.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:10:41 -0800 (PST)
From: clicedvly768 <harepro29@gmail.com>
To: ojeda@kernel.org,
	dmitry.torokhov@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-input@vger.kernel.org,
	clicedvly768 <harepro29@gmail.com>
Subject: [PATCH v3 0/2] rust: input: add input/serio abstractions and port Gravis Stinger driver
Date: Sat,  7 Nov 2026 02:10:32 +0500
Message-ID: <20261106211034.401918-1-harepro29@gmail.com>
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
  - serio: eliminated race condition in connect_callback(): initialized
    driver state in T::init(), set drvdata prior to serio_open(), and
    published input devices in T::start().
  - serio: integrated serio::Device with kernel device abstractions via
    AsBusDevice, impl_device_context_deref!, and as_device().
  - serio: mapped IrqReturn variants to C irqreturn_t constants.
  - stinger: restored userspace-visible device name ("Gravis Stinger")
    and dynamic phys path, preserving udev and EVIOCGNAME compatibility.
  - stinger: maintained module name "stinger.ko" using Kbuild object
    aliasing under CONFIG_JOYSTICK_STINGER_RUST.
  - stinger: formatted imports vertically and fixed line-length warnings.

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
 drivers/input/joystick/Makefile        |   5 +-
 drivers/input/joystick/stinger_rust.rs | 179 +++++++++++++++
 rust/bindings/bindings_helper.h        |   2 +
 rust/helpers/helpers.c                 |   2 +
 rust/helpers/input.c                   |  22 ++
 rust/helpers/serio.c                   |  17 ++
 rust/kernel/input.rs                   | 248 ++++++++++++++++++++
 rust/kernel/lib.rs                     |   4 +
 rust/kernel/serio.rs                   | 301 +++++++++++++++++++++++++
 10 files changed, 792 insertions(+), 2 deletions(-)
 create mode 100644 drivers/input/joystick/stinger_rust.rs
 create mode 100644 rust/helpers/input.c
 create mode 100644 rust/helpers/serio.c
 create mode 100644 rust/kernel/input.rs
 create mode 100644 rust/kernel/serio.rs

-- 
2.56.0
