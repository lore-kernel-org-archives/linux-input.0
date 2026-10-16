Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7144DE703
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168753; cv=none; b=g6k6bG5gybenhJTHGJRn3rqbh7GsqN/KonkEAr4PibJ2JzoNRFQLjK4LnVg82rQY8xhTqXQzoRaj1zAsgeu4m/tRo2o0i/tZx+WJcRtdY8Zqwp5q8XmFgvdVEKJeOcjHwsrlqlt6UG02QdVXH2zT+AIXnO5efSYaDwWZ/YNDcLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168753; c=relaxed/simple;
	bh=epQt/E98GTYEskX4PyjS7jICG/eZycLiTH28xa0X2N4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=btsqjZTg7OvGGxTWo/pjo3iRk6nSO6tpPRjeO68blHgXfj4IWqhL8XpguvgaBR3n0h45eToj68kYwpGY3VMRWElsLgePgVvsCDd6jvywaBdWdZWxpQdIHa6VnZPaIck3VY5b9wvCnp/UHPwxbSVysoOKG1Xap+nX8hWdFd+DH3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyr+cnhg; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyr+cnhg"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ccce6d9abfeso144546a12.1
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792168751; x=1792773551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iJWlli0kiLSD2GIUGWe0mxltnuBg0ha7PrEGOS3Fz9U=;
        b=iyr+cnhgLwHyHUrRFkiyQj+tr+cEUaBVwtZEX285zRTLOsOECmy1BydPRwr/UbPOer
         vQLW50jObhv4qCyq7EvXc+Dvz4650tLcwP6Po8wAXPrLS5Su6o5wj7eylFxH6GMSWhLP
         o3ypHl/8PCFxwhk6S1K0N4m3LxpoowgqLJJvej6dPu7cjd7ac57zZ7eZeImTd2g5NYyR
         AXwO45+kQOnFXMBcZED6GIaLQlZP1iMXe05hTASmZ2jC2yG7xWgwtf38aiM7DGmZvKZi
         OgumhdAFiNi3selojvWyskpv+rGUo/k15Kw3MkLAKhrhEMDRT6mxOCxxt1hcctIvgLi+
         /4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792168751; x=1792773551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iJWlli0kiLSD2GIUGWe0mxltnuBg0ha7PrEGOS3Fz9U=;
        b=f6/9Ugb0D85dbmAycaBva6M5BReFAmjJBLALP5LiC75LcvdJJ0Akwq7vuPEReEghPh
         JdJktVeTTJRTMJphFtKNMdUHsu0Teq1EoKVTy+RW9/VeWmnnIa9AJw9XXtArRDtvCVIG
         O53hV/Xo/BQRwwXjXNtHFVl6j7W3eu8rXio7F/Wdvhihb5tBJVoTOGunJrL6T781iIv/
         IBEQBtfWf/sjsIn7lvNbOEXI2vcM4lE+rroxaiFbZlqGl/Z60p8JP1RnDPPBrmZpfsWx
         p3ZkmHNPyn/ywxTLw0q6kWjQWHYtzetPO8+XPyEm3m6Aqcds77XadCuOoCjlijl7hiTc
         V8fA==
X-Forwarded-Encrypted: i=1; AKwUvBxInoEeukeEWzyDmUIn75xl/FE+CnUoRVtk4vZWUn5EfaFiNVEeyReW1CS51IQ7YyEoOmWDgYCBuh6aeg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIEmGoPmpcjPW4BrByHh4Ua3Ppj+1LWh67/YMthWtzFOb7X3PbP
	azUeX8bETjX6mNfFGsxj8RhSBql1PPdXQtYhI2nfzjngSAJHfktQNWiD6CjjgYOh
X-Gm-Gg: AYBFou0001ewHpyonisQhAyiCPKP9HEY7BGQtCVLipsABA+wDR29VLs3YyADCwiimsu
	7bV0tWUF5OtDBLSv36bZ1XK5LClSaIEjpUVTn3gEJf+Fu10ZUsHht32R7J5zPUgETZcGDjNlQo9
	2HWe9Loc8IP85vxCA065r1qeU+4giz0BLtxnc7Lc3NkjgtMmY9X6ISHaQQcjrh8WIeaJOtMZ7Hd
	pio7amSwgQqNimngqfmmASiFC+L8TDrpHtYsZ5kBqFBJH/FUOni4ZMGlXZUJ/pNNkhg6bJI9gYd
	zyZw83b6hSMZ0Wplk5y313jeVw6JolkGqihcjcqteTq8cijUhlGtkNKjDhC4vsgJow4cZMnHU8P
	GhxrUU8cmuQqHTYq1ooSp8v9F+LCdwxwi7+PXIQeFB/GIm1kw6V7Il+BC4qgKA8p7m6hwTkArMW
	HLoMqmjj6LPlBbqSsKuvywa1lzFhDRqP7zJPWI3P0kDIhfpvL1IjiGJUdUiDJ2/MRVJC0=
X-Received: by 2002:a17:90a:fc48:b0:3aa:fdad:7d6e with SMTP id 98e67ed59e1d1-3acef1042aemr403629a91.10.1792168751457;
        Fri, 16 Oct 2026 09:39:11 -0700 (PDT)
Received: from wyb-ms7e59 ([38.55.195.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc46ecd32sm4899797a91.3.2026.10.16.09.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:39:11 -0700 (PDT)
From: wyibo6109@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yibo Wang <wyibo6109@gmail.com>
Subject: [PATCH v6 0/2] Input: add support for OnePlus/OPPO Pad pogo-pin keyboards
Date: Fri, 16 Oct 2026 11:38:57 -0500
Message-ID: <20261016163859.1070138-1-wyibo6109@gmail.com>
X-Mailer: git-send-email 2.53.0
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
carried unchanged across four SoC generations of these keyboards, from
the sm8550 era to the sm8850 ones covered here; only the 0x3A general
sub-commands grew over time.  Patch 1 adds the DT binding, patch 2 the
driver.

Changes in v6:

- disclose the AI assistance in preparing the binding documentation
  with an Assisted-by trailer; no functional change.

Changes in v5, addressing Rob Herring's comments on the binding:

- dropped the block scalar from the top-level description;

- rewrapped the descriptions to stay within 75 columns;

- restored the serial parent node in the example.

Changes in v4, after Krzysztof Kozlowski's comment that the binding
describes the keyboard rather than the MCU (wording only, no functional
change):

- the binding description and the commit messages now describe the
  keyboard (built around the Tinno MCU) instead of the MCU itself, and
  spell out that a keyboard is a fixed physical device, so the touchpad
  geometry and the product names are per-compatible constants in the
  driver.

Changes in v3:

- the compatible names the tablet project the pogo port belongs to
  (oneplus,caihong- / erhai- / iceland-pogo-keyboard, the codenames
  used by the vendor trees), and the driver carries a per-project
  description in the OF match data: feature flags gate each 0x3A
  general sub-command (caihong, sm8650 era, has no wake notification
  and no backlight; erhai, sm8750 era, adds the wake notification;
  iceland, sm8850 era, adds the keyboard backlight), while the touchpad
  geometry and the per-brand product names are per-project constants -
  the wake notification is skipped and the backlight LED only
  registered where supported;

- the touchpad geometry and product names are no longer DT properties:
  they are fixed per project and live in the driver; the common
  touchscreen properties (touchscreen-size-x/y, touchscreen-x-mm/y-mm)
  remain as an optional override, parsed with
  touchscreen_parse_properties(), for the unlikely case of a variant.

Changes in v2:

- dropped the redundant "binding" from the dt-bindings subject;

- replaced the custom oneplus,touchpad-xy-max/-resolution properties
  with the common touchscreen properties;

- dropped the serial wrapper node from the binding example;

- the MAINTAINERS entry added with the binding references only the
  binding file; the driver F: line is added together with the driver
  patch.

Tested on the OnePlus Pad 4 (iceland) running Linux 7.2.0-sm8850
(v7.2-based iceland tree).

The binding documentation was prepared with the assistance of an AI
agent; the technical content was reviewed, adjusted and validated by
the author.

Assisted-by: Z.ai:GLM-5.3

Yibo Wang (2):
  dt-bindings: input: add OnePlus pogo-pin keyboard
  Input: add OnePlus/OPPO Pad pogo-pin keyboard serdev driver

 .../bindings/input/oneplus,pogo-keyboard.yaml |   76 +
 MAINTAINERS                                   |    7 +
 drivers/input/keyboard/Kconfig                |   13 +
 drivers/input/keyboard/Makefile               |    1 +
 drivers/input/keyboard/oneplus-pogo-kbd.c     | 1263 +++++++++++++++++
 5 files changed, 1360 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
 create mode 100644 drivers/input/keyboard/oneplus-pogo-kbd.c

-- 
2.53.0

