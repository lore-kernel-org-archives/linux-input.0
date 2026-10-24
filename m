Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803113;
	b=Kvnw0WPbNZzy6Gdd5OOVRSM0gxj2PeyL3Q83kNuYpNVTO/+yEy5CANHJ4LgBMJwkQqEi
	 8L6iCSh55301HDi+xqVotlurMx/wUlP162k1EiiHpElG5bmFx932RUQjfSqhv4gJyYjVx
	 axJku09DSN2IpJDCFuUO7ODrmyUituUYKcfCyrmzE+0hQ2sfgj8WxJwt1kO6BpwAxuJWO
	 F43qqtCE/4KnE+WlFMNCU6DEWlaXyVNAQuPBVcg07X1AxFA6XptQXFt35bG5YKCIVO9H3
	 6PeRX9Vg12pjOxehWtW1zLkmZos9EnIY0WVk4SZP2MKzRoeso4ON/x1GP7v8tSoqvtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=5PqPEXwYn+4RHFltKHPK65Z0DEkdjhotFWC8JsbNnjM=;
	b=ezf3J+bBPDmvP27cB/drD2hnk9RInPnm/+O56Cn/5P2KPV9sJLBUzulWWj4pmo/6Bevk
	 HfF7RIGLrK3SCdcD/h1G/PJibTW3r3CoBt37XyRtdBOXSY2kd8qyfQF5S6b5SbUZ4PNv0
	 YduMafv2ByzOcGduQ7AIwE97sHQ9m5qQCdQ9Z9miGnOpNPOx2PM1oecohhLHKCJOmWs45
	 0KEwf1EfSpFsetvdVpAgFQuoes4NxgYnycBXQpCv7E03QqK1CG09Yk55I9u4Njw4BVful
	 Pb5f4DHOT4EUpnd10UGgKrQoX7DQTGwiz8SOnHasQ2/nFcgPdMqLdst0AoqgELRa0EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WCEhii4W;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8067B606A31B
	for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 00:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8067B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WCEhii4W
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so804848a91.1
        for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 17:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792803112; x=1793407912; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5PqPEXwYn+4RHFltKHPK65Z0DEkdjhotFWC8JsbNnjM=;
        b=WCEhii4W5Td/KXJQwYmHo7GyYGOFEKae+BofkfkaGczeRzWgCLgXnThRM6R+YSf5VU
         ZHDsa2q3zYSS9FTAyxq4O9Io5IichFvsQ6BKQd/jnrMQnFq9JWG4sfsyc5aqL7QN3guZ
         pU3YWdXKnZygCAuMdAwlwbUqUOu8hMSg/d9CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792803112; x=1793407912;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5PqPEXwYn+4RHFltKHPK65Z0DEkdjhotFWC8JsbNnjM=;
        b=24GBsMIjlFCCdD/Dxy2G+8hVpXFQpgXhiRtYX1ZuiICgeh5Hd0+k2EHgxg9YBYMIiu
         OlcmduHIIrOFMQlT29M1EmDOL1AIcYVo0/FyZkYUBmOehXM9nlxXgtbs0ztx0Vfqsdri
         tsSK0o+FE1WG5VTUxy+72sP0IpluNAbeMf5SAsHoRTs21fw6V1/62YRGrQYsJUeeYfNY
         g+8asuchNYzNH/kKiZHApy3krznNrydbmqgAlxCQRNdyH/apoAMzjv/P8LRVCHy5NYls
         f9xiwUY9H+Gx3GyDYnKDo3kesd4tIVfMRIocfQzKrwNYZdI8u3Xsn5nf0M1ieoYlNY2x
         wQCw==
X-Gm-Message-State: AFq9FYL9WZjnZ9Li75R81xRdBgtWai4iV+6GQ7Y1RsVscHsihnUoMCm/
	KM3JaJjAcjWOudS3H0RTieKzbEa2YT/ZJ+BM3QXeFGrYsxGLWDuAZRCmk8ShoHsLLg5JrfbX7bR
	0HVA=
X-Gm-Gg: AYBFou1JCCXng+UJ0rt7md4TyOQ9xGDLjc4OV+MwvAaCXvZitupr4Ex3v1TReQ2f8l6
	qI7HqAJGJjXZaYA3bUh97OGUKYAVF50XRF9APaaUmcMboivcZ7lF2h+O2GHeVYnhdeKXinb+6JU
	czgDn5joXvhIxyl8I2T7tBJq/5VjS6X6TS+fqB238nFNWuVewkpDio8ASu5OlmJDu2C5XOyrfAW
	74J1wuy9ZLu6Z/0M9YkCIw/W/vLvLeiyMOxCaU6iUR6pMlGK7KeU6r1AmPYOvOL9UvP8dyrGcdu
	vUG8b1SijBUyhg3cy3PHmsq+tgOXpom8fhCL83XgzOXiQknkdWzis5ooGaREV1jpmXBB1ZdV8nk
	Xe10sMMr8YacVActSJp/OMpxPETWkQEsH0sZ9a/p1EAF1XLHeEJHKrtutu8KOzaNXm7F6+RVKqV
	W2Q/oCTv/lsrgP9cLZtHE6jpvXxRgXX2yuFraQVnkkcXgEArz0aXFjZNA1y2ytqJEenv81oS7Ei
	+23OujzVrOrASiTbHkrkeOEzxWoxz5oDe8rVnLR7VMZta+PhgK62gLWsGMVC3kZgl4ePV/u/3Ci
	2yWHl7m/eJYEmI2hL1v/IzHcY0tLf7w94E9njWaIPoysL/gaQQzTL76CD4xhDuo=
X-Received: by 2002:a17:90b:1a85:b0:3ac:7c4d:8be6 with SMTP id 98e67ed59e1d1-3adead4f66amr712837a91.40.1792803111828;
        Fri, 23 Oct 2026 17:51:51 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm843763a91.9.2026.10.23.17.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:51:51 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Subject: [PATCH v7 00/11] Add spi-hid transport driver
Date: Sat, 24 Oct 2026 00:51:34 +0000
Message-Id: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
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
X-B4-Tracking: v=1; b=H4sIABcB3GoC/23PwW7DIAyA4VepOI8JYyCkp73HtAMB03BIUkEbt
 ary7qOdtFZpjr9lf5JvrFBOVNh+d2OZ5lTSNNZoPnbM9248EE+hNpNCGiFB8kJj4OdjOWVyA29
 0NDG0FFpJrN4cM8V0eXjfP7X7VE5Tvj74Ge7TPwkFrqQZuOCgQXdOgo0YvnyfpyGdh88pH9gdm
 +ULINUakBXQEjxZF2O0ZgPAJ6DE+pcZK2BEC15pG1A3G4B6AnVzDagKdFZh0GQ8BdwA9D8A4h3
 QFUCrXBQQHBJtAOYFgDfAVMB3bedUh8FEtwKWZfkFlglPH/IBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792803111; l=7277;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=nNYO6idEpLauPqDXQvv90+SC/2ZK0xY5I65cLCsgDHY=;
 b=p5RQ4OcghzWSWrRKttkp/rtck0c6aXEYG3MzjxpNtHszzhiB27lNZRqYb7PduCFSWkS6eaJPk
 WBkVelYEZ2RC7aa/7ItikRTwMfMDpu8adtKg0sVxaLB4oFFVcDaGT7c
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
Changes in v7:
- Drop the error counter sysfs attributes.
- Print error codes in power up/down failure messages.
- Reject an empty report descriptor.
- Check the minimum input report body size instead of max_input_length.
- Clear reset_attempts only after the report descriptor check succeeds.
- Drop pending work flags when the error handler resets the device.
- Don't schedule a reset when GET_FEATURE fails with -ENODEV.
- dt-bindings: drop the address/opcode properties and the "hid-over-spi"
  fallback; the compatible determines them.
- dt-bindings: fix authorship to match the Signed-off-by chain.
- dt-bindings: update maintainer email addresses.
- dt-bindings: drop Rob's Reviewed-by because the binding changed.
- of: use per-compatible match data; match only
  "microsoft,g6-touch-digitizer".
- pm: disable reset_work across suspend.
- pm: check deassert_reset(); schedule recovery on reset timeout.
- pm: skip hid_driver_reset_resume() when the device is not ready.
- pm: log power_down() failure instead of rolling back suspend.
- pm: use dev_err() instead of dev_WARN_ONCE() for a failed device
  descriptor request.
- panel follower: start with reset_work disabled.
- Drop Dale's Tested-by from the OF, PM and panel follower patches
  because they changed since v4.
- Link to v6: https://lore.kernel.org/r/20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org

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

Dmitry Antipov (1):
      dt-bindings: input: Document hid-over-spi DT schema

Jarrett Schultz (3):
      Documentation: Correction in HID output_report callback description.
      HID: Add BUS_SPI support and define HID_SPI_DEVICE macro
      HID: spi-hid: add device tree support for HID over SPI

Jingyuan Liang (5):
      HID: spi-hid: add spi-hid driver HID layer
      HID: spi-hid: add HID SPI protocol implementation
      HID: spi-hid: add spi_hid traces
      HID: spi-hid: add power management implementation
      HID: spi-hid: add panel follower support

 .../devicetree/bindings/input/hid-over-spi.yaml    |   75 +
 Documentation/hid/hid-transport.rst                |    4 +-
 drivers/hid/Kconfig                                |    2 +
 drivers/hid/Makefile                               |    2 +
 drivers/hid/hid-core.c                             |    3 +
 drivers/hid/spi-hid/Kconfig                        |   50 +
 drivers/hid/spi-hid/Makefile                       |   12 +
 drivers/hid/spi-hid/spi-hid-acpi.c                 |  261 +++
 drivers/hid/spi-hid/spi-hid-core.c                 | 1698 ++++++++++++++++++++
 drivers/hid/spi-hid/spi-hid-core.h                 |  112 ++
 drivers/hid/spi-hid/spi-hid-of.c                   |  211 +++
 drivers/hid/spi-hid/spi-hid-trace.h                |  184 +++
 drivers/hid/spi-hid/spi-hid.h                      |   45 +
 include/linux/hid.h                                |    2 +
 14 files changed, 2659 insertions(+), 2 deletions(-)
---
base-commit: ee9c669f9bf5fd2c24206746ded9382fe810df89
change-id: 20260212-send-upstream-75f6fd9ed92e

Best regards,
-- 
Jingyuan Liang <jingyliang@chromium.org>

