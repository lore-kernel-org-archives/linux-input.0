Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62793624D7
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 04:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980088; cv=none; b=XUGe4On6qxht4HvcsM9TcWI55wjLJdhPsmPj+LkWyFw7jHZ15CMUGtGv19+CqShFoXesvCloAf/0+7kc24tAJSgQn6pUSqD/giYtF2ccecxIvlBQhjd9qAv/fqrFoUl4ZSnwa+vbheyZP92XVC6UKxec3zqPG5J3rcyCKjoVyxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980088; c=relaxed/simple;
	bh=niVPKu3KCGXpaVcO6/gS8ySgoA3IT21ZaQzq7eQRAoI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c2jzXAqwjKW5ph4GD6ZyZPyQXSUUzxxIVHxtm8NbnUHuPx4dn498L0lUVb4ENX06eszYHZIwp1MX7CMV+1Os7biVEl0WUvDCxL7sVKyYWeI/Bf9MNxtGMpT8KovBfGGm3irI2WSxx90y+YKMZ7alvGVNUlJQ37IWBQq/48YWd3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bey43OSD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bey43OSD"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0c2d8b95bso35830935ad.1
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2026 21:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780980085; x=1781584885; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M58CbF2eNhyrWg008D0ABCR+x+AP5d/FSVenLDFjbso=;
        b=bey43OSDnW2g8//wfLnVS3L2InOBrSR+7XhB23f9w5SPJSS3FcNjfPEvIPaIDLkOkZ
         PWujDlQ1QxvqiqQsSG9naXhLuD7bXHH6XXzbq7EJQsT1ehQ68NjC7bVt1ZHuGdRXJL5h
         zacagIEJnUBeVDzYY//jx8/Sf91rQUFo8QB/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780980085; x=1781584885;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M58CbF2eNhyrWg008D0ABCR+x+AP5d/FSVenLDFjbso=;
        b=CJFRKa3iGWCjYMNZUml7W2i9L48Iu0LTEGYCPLOlWxVXoWDXAUZvqhmrCzTBSVNcF/
         RH/uWfyyaY2C/oBU4c9F5e9GPpvRmTwpbKlCQlbnG5efuze7zieWthdeb4q54J4JHzHk
         AG05nLw906BqZ1T1xkjPKHnkutHXjSMBrRIQjMH+rHU4F7GgNKhS8iENWXS0EdBhfTZI
         JIhcLsFblbxGoDueNFWC7bAn5jxhVNbsVEvN3x60L0OXKMpteEsy1f7G2P5wW4GtUuQ9
         VsipCDIlj9Iq5GwHSUH8f7JwNNDjpul3+CK6CaL34rcxMUPPxzZHuTb65JXZmbc1PIlX
         SvTA==
X-Gm-Message-State: AOJu0YywrUPLxzH8In1dQLIAIcdJOP1wukEwuZBbWzHS0gx24P10vBqC
	oHtaR2rQnz6VQR8hiEBo9sMnyU00Qt2EmHepzH7PsM6CkcDoCdpYWnjdi/NrCaDuJA==
X-Gm-Gg: Acq92OFFzvYIUQog716wv3ciZSC9kDkDcRziu2Lp8h+1YNb3VN4vk47P/47xkd1zyOp
	r6tccbdEN//HAj41U1oJlCuT5PqzX52m1P1+YcoJ5hKT3T2vD9zKEHT33s6vAVVFAwVndFFQJM9
	zNSeDp4Uk1bZb9dJ6WtzMU2I34lGN1TqgxnoY8VaTglURE8S1piSYJ1UNkbKDn1baBp7FC/5rpV
	q50d1TqXqglec0njDrBP72YxjRHttLmtQl6Az05dlvSyvynPg7GpVYn+P4rvRbZBkWWaB7WbQLA
	AHcuJU1JWangamXKFxuZmhmSWPwRtNvzmwlniqcfDM0QbggmEz6o6NSnDah7oVi+Wl3t+sehUWR
	6LFzZNBa5dHFiWzUpQ/S+qrvfhDqaEztMtE2ZdIcAfvBDrDfmfJAI9kXkEE8CavekjNNk+4wxLA
	6ai9wYOwZar81q3BO6J1ViD0DkAH3e9vwilNFGc1BJyUxG6cCWGtHCooVY1IRMEIbN4a+POa6Av
	+F7/cYhcXgNdj/g6ilBjN37XzZV4D2jAY0opV0AhBYK
X-Received: by 2002:a17:903:19e8:b0:2c0:bb2d:a30b with SMTP id d9443c01a7336-2c1e893e978mr199020155ad.32.1780980085248;
        Mon, 08 Jun 2026 21:41:25 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664a67b0sm200736065ad.80.2026.06.08.21.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 21:41:24 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Subject: [PATCH v4 00/11] Add spi-hid transport driver
Date: Tue, 09 Jun 2026 04:40:51 +0000
Message-Id: <20260609-send-upstream-v4-0-b843d5e6ced3@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFOZJ2oC/23Pyw7CIBCF4VdpWIuBAXpx5XsYF7UMLYteAi3RN
 H13aV1oiMv/JPMlsxKPzqInl2wlDoP1dhxiyFNGmq4eWqRWxybAIGfAgXocNF0mPzuse1ookxt
 doa4ASbyZHBr7PLzbPXZn/Ty618EHvq8fSTCRSIFTRrni6lEDL43Q16ZzY2+X/jy6luxYgB8AZ
 ApABBTwBsvaGFPmfwDxBSRLfwkiAjmreCNVqYUqEmDbtjdCPS72LwEAAA==
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
 hbarnor@chromium.org, tfiga@chromium.org, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>, Angela Czubak <acz@semihalf.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780980084; l=4487;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=niVPKu3KCGXpaVcO6/gS8ySgoA3IT21ZaQzq7eQRAoI=;
 b=gMiaV3ssfrSxB6Fkr0m/bcfIHp9ptbFeLfSnTk8bUHRLDQdur44JJWF8n6UENBPsDLHjwnDys
 a1vurmOpnbgC1mSlSC2pqiuwkJcE4MyhX8Df0zwQplhFF1Yawu1lVbU
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
      HID: spi_hid: add ACPI support for SPI over HID

Jarrett Schultz (3):
      Documentation: Correction in HID output_report callback description.
      HID: Add BUS_SPI support and define HID_SPI_DEVICE macro
      HID: spi_hid: add device tree support for SPI over HID

Jingyuan Liang (6):
      HID: spi-hid: add spi-hid driver HID layer
      HID: spi-hid: add HID SPI protocol implementation
      HID: spi_hid: add spi_hid traces
      dt-bindings: input: Document hid-over-spi DT schema
      HID: spi-hid: add power management implementation
      HID: spi-hid: add panel follower support

 .../devicetree/bindings/input/hid-over-spi.yaml    |  128 ++
 Documentation/hid/hid-transport.rst                |    4 +-
 drivers/hid/Kconfig                                |    2 +
 drivers/hid/Makefile                               |    2 +
 drivers/hid/hid-core.c                             |    3 +
 drivers/hid/spi-hid/Kconfig                        |   45 +
 drivers/hid/spi-hid/Makefile                       |   12 +
 drivers/hid/spi-hid/spi-hid-acpi.c                 |  254 ++++
 drivers/hid/spi-hid/spi-hid-core.c                 | 1521 ++++++++++++++++++++
 drivers/hid/spi-hid/spi-hid-core.h                 |   98 ++
 drivers/hid/spi-hid/spi-hid-of.c                   |  247 ++++
 drivers/hid/spi-hid/spi-hid-trace.h                |  169 +++
 drivers/hid/spi-hid/spi-hid.h                      |   46 +
 include/linux/hid.h                                |    2 +
 14 files changed, 2531 insertions(+), 2 deletions(-)
---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260212-send-upstream-75f6fd9ed92e

Best regards,
-- 
Jingyuan Liang <jingyliang@chromium.org>

