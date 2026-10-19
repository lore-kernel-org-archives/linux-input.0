Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436491;
	b=pLFul+ZZg+ScXjo0RueVMMVxc6x0+KG3husAXYhyvaDAAB9/356WwmDjbrYcZHoq+dYz
	 c+jbi2kRJ8k1Rk64nBFzQRGsgisDUxnGSna083eq9k8RF2UG4Qu2XUlxOe58RZ39LnjgC
	 JfHhwekovNr4q0DVwByETIAjTwuO8IFPis3odKCHK59UqsxY/7flK9t42rjEgfiW//Ij1
	 0aytHcqDxJ688N1rpbGyThiiQ8ufUBbOrMSGFK8pjnvQw7nkqXAd/WHsY6nZ/qLf17nEp
	 1/SbHwHFzvZpbXF1wc8ugFN5k8+jpt2TGO2CTf47iWDJLmLGnYncn7ay6le1SfgAvXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=NlRWSTOFbePBOR+ZW461CZ2nj2CGvQoMjpOv8gpMfng=;
	b=KfQ302zMS8GxJF0VmaR0US0lvhWl2Lux0l0c/GdmOHUHnT03j0hQ1f4Iq9nGzYkvRwLK
	 BxlkyIB1XpHY3iAno5hBJbVDNkyMDuE1ekdEM9uYWZGL12VIqIWTBObaJS+Eg9FZEak6t
	 F+QC2yUYs4VayMc7PPbaHA829sukzz8qsMN4fjUc07WRf8KaRpD7pMNOfDQXHhsmxKOym
	 nB2V6TkQT+Vfr6i833YSh6fpTek04lVpZyFAfIh8J7E2q5jC/EElPSVTzXYSNL2X/oaS0
	 7EFQZOw/y3nNMXHer4IWVOyLLwBu05/lwdH8AwVicjC6oNdRNkzA1X3Yeoobkv7kx/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZEvpwaca;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA22606A324
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 19:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CA22606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZEvpwaca
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso13313115ad.1
        for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 12:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792436490; x=1793041290; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NlRWSTOFbePBOR+ZW461CZ2nj2CGvQoMjpOv8gpMfng=;
        b=ZEvpwacarzzImH6V6uOJTzbL8stPTETvmYc17X7c96whAtVQTM+Ndsw4UT0JGwmD+I
         BKmRrsuT6++2dsgO3bXm5ZuurZ21ZFUlWCPMc3B7m+FXydpVtnxL6hsXeexpZE1Av4L+
         0CoKGxEzPf1ZzmmWfMOYbNLnW7pyHFfz0mkPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436490; x=1793041290;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NlRWSTOFbePBOR+ZW461CZ2nj2CGvQoMjpOv8gpMfng=;
        b=ivscHVbwgoSAkjiOXNwNd7OHWvF06BqkFRffRkhPtjto0x8hZOYep0RSIFRLsUs5kE
         uaydFB8AS1kkj6tL77M0QHXHuOAm52yYKgQ8ZZw68EGFUsl8meaF3V1yQHvxg8Q/DK2Q
         8TRlMA0Dq+qhy3XQEfuU7PNHmX0zGSf8rDdEMi9KgSZRmwHrKh39QPowPqUvlwjzAta+
         iSYNKzZ25/ztpNPDHcvS2tw7NeESbi/P5anwv5M8fUZdBHd4YgCY+JGXeHxroI/JZMfO
         T1pZi9J4RyyezaWHhsA3Uuhyozfiz9wcrThj9DIUaIjuc23txrPUbtXnXSVCUhIbvi7/
         A9Bw==
X-Gm-Message-State: AFq9FYJS2BXWYXhMt4BAGjgq0FBWk1+LT2z4hshsoG7Pi5RZw1kEjyu5
	tuUgeJTjsOmAWfGlIaj1W4h3hDHvJh/9SiOSnMVcwzR4DgT712r7LI1Q2z5hVlWblg==
X-Gm-Gg: AYBFou1D4S1+JMn/DitQMaregyx2qkN+LrZxsm/kRzu9jOGYrYZrXW7iFzwGk9V/VrB
	aL4bMFpEalzClMIieVZ4KDZW1SIhmW7+JdAPF5yod5auoXD9gT0peSBmhxWCIYczrIqkXDyUXtd
	Luh8pdez1z5WwCcjDzKOy/rXSuaYjh2c1RfV3C5mZQwPPDz+Tnf+faqgbL4Ze7rsV0CbhvWfUcZ
	zLotAg+ZGaMUqRKsPkQeWfKbqAHnepoQNW6m240F8r+h2k5UZNFlhIjLDL8ysarh5GkZstUvrjF
	ZWIsQfGsF8SszCnNqDlvcI3LCoj9MLTMCOqjx/uAz646Tv67RRCaDE6gvI2UXwF+hL+DK3ovwjt
	nPquSosG52Z2V+aOwC38qCrrhyU+GeWV9jB+0asZjR7Ep5K/3IDCH+mTrlRIW1buQWHwdIOlwSk
	9qfxBfxqetshdzpXXeYLaZ3kv+cMetcCbhYRaxl/vD/BfsNwSccnxxuefxfi4Mjc0RWTktLU7+m
	lwe4eC99YIMESb0Smc/cNVYVN1ykw68mvTZQcW5gbf8OgP5v9btMvFX5+5fOX4oZ32/RdIbT+k4
	Ht5Kkg==
X-Received: by 2002:a17:902:e84c:b0:2e9:6b5b:3db6 with SMTP id d9443c01a7336-2e9a69e93d4mr78949655ad.30.1792436488354;
        Mon, 19 Oct 2026 12:01:28 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151e1b7esm4473105ad.75.2026.10.19.12.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:01:27 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Subject: [PATCH v6 00/11] Add spi-hid transport driver
Date: Mon, 19 Oct 2026 19:01:12 +0000
Message-Id: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPho1moC/23PzW7DIAzA8VepOI8Jm4+SnvYe0w4UTMMhSQUt2
 lTl3Uc7aZ1Yjn/L/km+sUI5UWGH3Y1lqqmkZW5hXnbMj24+EU+hNUOBRiAgLzQHfj2XSyY38b2
 OJoaBwoDE2s05U0yfD+/9o/WYymXJXw++wn36I0khO6kCFxw06KNDsFGGNz/mZUrX6XXJJ3bHK
 v4BUPUANkAjeLIuxmjNBiCfgBL9L1U2wIgBvNI2SL3fANQTaJs9oBpwtEoGTcZTkBuA/gVA/Ad
 0A6RVLgoIThJ1wLqu3/ZCO9axAQAA
X-Change-ID: 20260212-send-upstream-75f6fd9ed92e
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>, Angela Czubak <acz@semihalf.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792436487; l=5852;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=ga6CwkzARUkSvEvRDG0PQmoQD7fSmYRrychrK6mPJmA=;
 b=vBA5OO3tSh7vW0DnhWVDJWpbII+xJtYD5/j1+yxiiJ5vl/UDtQJ3Uk4FZ+YGJnUP3gkXxZnv6
 fjs+9TLMNgCBwXACf0yfOCEkSy7lN5urMp6GOiINJI/amWw+dLgEKq1
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

This series picks up the spi-hid driver work originally started by
Microsoft. The patch breakdown has been modified and the implementation
has been refactored to address upstream feedback and testing issues. We
are submitting this as a new series while keeping the original sign-off
chain to reflect the history.

Same as the original series, there is a change to HID documentation, some
HID core changes to support a SPI device, the SPI HID transport driver,
and HID over SPI Device Tree binding. We have added the HID over SPI ACPI
support, power management, panel follower, and quirks for Ilitek touch
controllers.

Original authors: Jarrett Schultz <jaschultz@microsoft.com>,
		  Dmitry Antipov <dmanti@microsoft.com>
Link: https://lore.kernel.org/r/86b63b7b-afda-d7f4-7bfa-175085d5a8ef@gmail.com

Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
Changes in v6:
- Take output_lock while reallocating buffers in ll_start()
- Don't drop input reports while a refreshed device probes
- OF: drop mod_devicetable.h, use named initializers, fix alignment
- Move the dt-bindings patch before the OF driver patch
- Drop Tested-by from the documentation and DT binding patches
- Link to v5: https://lore.kernel.org/r/20261009-send-upstream-v5-0-384af01da3ee@chromium.org

Changes in v5:
- Fix request/response races; match GET_FEATURE responses by report ID
- Reset the device on response timeout; wait uninterruptibly
- Validate device descriptor and report lengths; fix buffer sizing
- Honor rtype in raw_request(); fix GET_REPORT off-by-one
- Use hid_safe_input_report(); forward input reports only while open
- Disable IRQ around hid_device teardown; fix a sparse warning
- Use disable_work_sync() for reset_work in remove()
- Cap trace copies at 64 bytes; cacheline-align read approval buffers
- ACPI: select RESET_CONTROLLER, use device_reset_optional()
- OF & DT: read opcodes as u8, use dev_err_probe(), require reg
- PM: cancel reset_work on suspend, wait for reset before
  reset_resume(), fix IRQ imbalance on resume failure
- Panel follower: fix regulator/IRQ imbalance; depend on DRM || !DRM
- Link to v4: https://lore.kernel.org/r/20260609-send-upstream-v4-0-b843d5e6ced3@chromium.org

Changes in v4:
- Extended io_lock scope to protect the shid->hid pointer lifecycle
  against races with the IRQ handler
- Cacheline-aligned DMA buffers, enforced 4-byte alignment
- Added error rollback for failed suspend/resume transitions
- Moved IRQ request to probe with IRQF_NO_AUTOEN (disabled by default)
- DT Bindings & OF Driver:
  - Required a device-specific compatible string in the schema.
  - Added description to explain why opcodes and addresses properties
    need to be defined in the schema
  - Added `spi-peripheral-props.yaml` reference and switched to
    `unevaluatedProperties: false`.
  - Added fallback to default timing parameters in OF driver if match
    data is missing.
- Link to v3: https://lore.kernel.org/r/20260402-send-upstream-v3-0-6091c458d357@chromium.org

Changes in v3:
- Add io_lock init
- Relocate tracepoints to drivers/hid/spi-hid/ and fix tracepoint macros
- Add tracepoints for sync, error handling, reset, and report processing
- Clean up internal includes and fix Makefile CFLAGS
- Add more details in v2 changelog
- Link to v2: https://lore.kernel.org/r/20260324-send-upstream-v2-0-521ce8afff86@chromium.org

Changes in v2:
- Clean up DT bindings: fix formatting and remove timing and flags properties
- Update DT binding example: use a device-specific compatible and drop
  reset_assert
- Simplify ACPI/OF match tables by removing ACPI_PTR/of_match_ptr
- Refactor OF driver to use match data for timing parameters instead
  of DT properties
- Switch to fsleep() for delays in ACPI and OF drivers
- Drop patch 12 as it is vendor specific
- Add a lock to fix input/output concurrency race
- Link to v1: https://lore.kernel.org/r/20260303-send-upstream-v1-0-1515ba218f3d@chromium.org

---
Angela Czubak (2):
      HID: spi-hid: add transport driver skeleton for HID over SPI bus
      HID: spi-hid: add ACPI support for HID over SPI

Jarrett Schultz (3):
      Documentation: Correction in HID output_report callback description.
      HID: Add BUS_SPI support and define HID_SPI_DEVICE macro
      HID: spi-hid: add device tree support for HID over SPI

Jingyuan Liang (6):
      HID: spi-hid: add spi-hid driver HID layer
      HID: spi-hid: add HID SPI protocol implementation
      HID: spi-hid: add spi_hid traces
      dt-bindings: input: Document hid-over-spi DT schema
      HID: spi-hid: add power management implementation
      HID: spi-hid: add panel follower support

 .../devicetree/bindings/input/hid-over-spi.yaml    |  130 ++
 Documentation/hid/hid-transport.rst                |    4 +-
 drivers/hid/Kconfig                                |    2 +
 drivers/hid/Makefile                               |    2 +
 drivers/hid/hid-core.c                             |    3 +
 drivers/hid/spi-hid/Kconfig                        |   50 +
 drivers/hid/spi-hid/Makefile                       |   12 +
 drivers/hid/spi-hid/spi-hid-acpi.c                 |  262 +++
 drivers/hid/spi-hid/spi-hid-core.c                 | 1757 ++++++++++++++++++++
 drivers/hid/spi-hid/spi-hid-core.h                 |  118 ++
 drivers/hid/spi-hid/spi-hid-of.c                   |  242 +++
 drivers/hid/spi-hid/spi-hid-trace.h                |  184 ++
 drivers/hid/spi-hid/spi-hid.h                      |   46 +
 include/linux/hid.h                                |    2 +
 14 files changed, 2812 insertions(+), 2 deletions(-)
---
base-commit: ee9c669f9bf5fd2c24206746ded9382fe810df89
change-id: 20260212-send-upstream-75f6fd9ed92e

Best regards,
-- 
Jingyuan Liang <jingyliang@chromium.org>

