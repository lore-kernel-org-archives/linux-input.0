Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BB45326BC
	for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985991; cv=none; b=PZVuiGLC8TAeTa4P/O2BgFX1AocczrH4GkNUAS6siMVIIlISvFquBRY1Rko/PwAFr/FT5/g6TlH8cliJWEqoMXVycxQi3Ein9i7D0ILKiCZv8EBtTATXVw/HbeU/WrKBE9R/aJOQBsqElRNu5ZZpRP9JntN/FqjL9zMQuopNc9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985991; c=relaxed/simple;
	bh=4K/OfbKxhhyoFgt/4DQIc1mzkF2vBz5Hc42fatDf+Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tj+gRrqODjS1FRuPbpey084+7bP6ttZ2hFmwzFbEdTR+ufJYgniZIYymBcFhuwZLZA2A3NDER5JOC5n3P98tf6kYPmYDbxjWBXE9E85/ZXNcM7PGJfzvH6EOJWklXw1f348O94n7aHfcZFgRHZqktSAgP5O03ReiWhryzG0euF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOyHVQ27; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOyHVQ27"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd632f7a4a1so28790a12.3
        for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791985981; x=1792590781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UT8AC87k3JtmR9Mgdy2bUpHUaBQHrXk1Cf/Lmj4HaME=;
        b=OOyHVQ27C7hGcKD7rFVCvRftfUyJ4JS9lZVXxey0n0VR5lDB5L0RmoEo5R7CNzlSs3
         SA7zONTxDWWKOLwc3aZO6j182FGjgzuI97JZkyTzfW26pO78slmxGYjcmxGGB4SEJPJ+
         Bh+Z73KTZe0f07iC82+6AhmKnNujgu4Xjl8YAyvxORaymc/LEOq5oHcteG7mKpWU8DMq
         FjvIMxHcpo+k44RMg/6PIzGdqe+FUGLy7DB25DH2Gy7iAbDdVx0PzZlOjNU09aqGxxoR
         0V3O7Q7aNHjaNFtR1QC3z2FViVOIr9G4gyNSz8nikiVli0gMi4nAEfmDIPpU2fkTcbkD
         FiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791985981; x=1792590781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UT8AC87k3JtmR9Mgdy2bUpHUaBQHrXk1Cf/Lmj4HaME=;
        b=KTetIzQam8O7JmpTM7vlYfQI0A2/EtLeqLuckbbDzEaYkVT2XxhDL4mGim84toBdnH
         FwSg36O8P4N37a/2PX3EHBpbHO+fCwPKMuhxEvcTwtSbX+jg+uXKDXIzC1Gv8JBFf1mD
         O2QVkwzZpWQIUU7+r1UAjIxl/fLac3aM/hum/0iKypOVgj+RUH3kPesehwrif0LTOBT9
         IuZU/vkstTW2KIGk2i845CygW/9SXdO6tK0om9PO/7AR4C8nxGfmAo7OEHUHX2IjjsVY
         EFmCp23mPiaDwJybNfiW2DztiWUwY+gZK3iTUKfgGc1VQGCa9sRksPIs+CCRnKX1VNWb
         MGHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNZDaEs7iVH/mlqM9UjorKw8FbP50gVC45dpI0hFL+//eh4lFLQnieInB3SmpmkPgCa9WXARi7GAEzGQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJcikx6LyCbXxbNpmrfeBdaMuYB5KOJbfoLjLR39Ji5346ijPX6
	hfTJyUhOFRW3OXbg8k1//5ohvOavePzQd1g6c/BEEIwINvbuN5/1I3R/
X-Gm-Gg: AYBFou2ouFhz6qinR/RpjnTF9lqoeDIIT1zfZf9MuMWdcqMhznAnEeG66Lebqyh9+9S
	U6ITu7rnnTgJSkm+tifswK9YaMoiQ0K7NS+dHLzCxMw5Su5Boj+MpIpq4/Yl2vPmVQ1jrxm5QOZ
	b7G2FJlFAWfxeug+n2o1848ELjtGuhL4yOfbU5cFio/TzhiDaRNYIDBloSLfKvKW5UqjAcOxz3a
	nR7zyuPj4YljOjHeSFiuGy9O6hnRNXgrFQ+ls10M7edRjxcST415LAgwxjHFZz3zxvFfEtSYs/Y
	GVtN4+V2T3oQ7w47yfW/sHzOjKLv2tVW1KnxAjJW/OWtQS7bafxCG6fAqYPtfWWx+D0KNfHz64A
	Nv3rVT3RmyIkY5OnI4Xokvr+a0l+zicCb8qC7PflcBMziCFcSULGoincJ4l65yoTAW682na+huf
	0elbrAfRyeBn7n0gbQ1whdAqezaHrD1MqwJPRwYMHtyfETjyAODcRUvNHP2xX2dov0/69vneUoC
	3JlGQ==
X-Received: by 2002:a05:6a21:8203:b0:3de:2fbc:82c3 with SMTP id adf61e73a8af0-3e16ba9fd1bmr16360118637.10.1791985980935;
        Wed, 14 Oct 2026 06:53:00 -0700 (PDT)
Received: from wyb-ms7e59 ([38.55.195.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d804e6e77sm1121244b3a.40.2026.10.14.06.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:53:00 -0700 (PDT)
From: wyibo6109@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yibo Wang <wyibo6109@gmail.com>
Subject: [PATCH v3 0/2] Input: add support for OnePlus/OPPO Pad pogo-pin keyboards
Date: Wed, 14 Oct 2026 08:52:49 -0500
Message-ID: <20261014135251.11234-1-wyibo6109@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010143836.173883-1-wyibo6109@gmail.com>
References: <20261010143836.173883-1-wyibo6109@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yibo Wang <wyibo6109@gmail.com>

This series adds support for the magnetic pogo-pin smart keyboards of
the OnePlus Pad 3 Pro / Pad 4 and the OPPO Pad 5 Pro.  The keyboard is
built around a Tinno MCU attached to a tablet UART.  Both sides share a
single data wire, so the host gates its transmission onto the bus with a
PMIC GPIO for the duration of a frame, and every host frame is echoed
back on RX.

The MCU speaks a framed "one wire bus" protocol over the half-duplex
921600 8N1 UART: 8x 0x55 preamble, 0xF1, src/dst addresses, command,
length, payload, CRC16-IBM (poly 0x8005, init 0xC596), 0xFE and 4x 0xAA.
The protocol was reverse engineered from the vendor kernel driver; this
is a clean-room serdev reimplementation that replaces the downstream
platform driver, which depends on a private msm_geni_serial callback and
a user-space held tty fd.

The core protocol (framing, keys, touchpad, sync/heartbeat) has been
carried unchanged across four SoC generations of this MCU, from the
sm8550 era keyboards to the sm8850 ones covered here; only the 0x3A
general sub-commands grew over time.  Patch 1 adds the DT binding,
patch 2 the driver.

Changes in v3:

- the compatible names the tablet project the pogo port belongs to
  (oneplus,caihong- / erhai- / iceland-pogo-keyboard, the codenames
  used by the vendor trees) instead of a DT property, and the
  driver carries a per-project description in the OF match data:
  feature flags gate each 0x3A general sub-command (caihong, sm8650
  era, has no wake notification and no backlight; erhai, sm8750 era,
  adds the wake notification; iceland, sm8850 era, adds the keyboard
  backlight), while the touchpad geometry and the per-brand product
  names are per-project constants - the wake notification is skipped
  and the backlight LED only registered where supported;

- the touchpad geometry and product names are no longer DT properties:
  they are fixed per project and live in the driver; the common
  touchscreen properties (touchscreen-size-x/y, touchscreen-x-mm/y-mm)
  remain as an optional override, parsed with
  touchscreen_parse_properties().

Changes in v2, addressing Krzysztof Kozlowski's review of the binding:

- dropped the redundant "binding" from the dt-bindings subject;

- replaced the custom oneplus,touchpad-xy-max/-resolution properties
  with the common touchscreen properties: the MCU protocol has no way
  to query the touchpad geometry and the same MCU is shipped in
  keyboards with different touchpad matrices;

- dropped the serial wrapper node from the binding example;

- the MAINTAINERS entry added with the binding references only the
  binding file; the driver F: line is added together with the driver
  patch.

Tested on the OnePlus Pad 4 (iceland) running Linux 7.2.0-sm8850
(v7.2-based iceland tree).

Yibo Wang (2):
  dt-bindings: input: add OnePlus pogo-pin keyboard
  Input: add OnePlus/OPPO Pad pogo-pin keyboard serdev driver

 .../bindings/input/oneplus,pogo-keyboard.yaml |   73 +
 MAINTAINERS                                   |    7 +
 drivers/input/keyboard/Kconfig                |   13 +
 drivers/input/keyboard/Makefile               |    1 +
 drivers/input/keyboard/oneplus-pogo-kbd.c     | 1263 +++++++++++++++++
 5 files changed, 1357 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
 create mode 100644 drivers/input/keyboard/oneplus-pogo-kbd.c

-- 
2.53.0

