Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666514C10D1;
	Fri, 18 Sep 2026 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729611; cv=none; b=nqZFmHDa/tfye90cFsV/5VGaEEJRIyL409yWgJdnToYVoB5D2qTjwip8z+z9//P9kBDYD7yo4pTOCFIbob65v4VEUdHlXXRM6ulVnVRI2bZANhn8o542KIAxd5TogtuVaDVXMfccHLxYLPz48J+81kOzLpMIIcS85pZGQmNc7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729611; c=relaxed/simple;
	bh=PawLXKvlJwv7D4KsJjXTvYA+h3NHb2+AdBM76dtcECM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BLF14KEiZEpPIwL/qhQuh+yG8+KtZsFL6odmaLgSeJIo7Fq9IRzmLHkTYt82nluJkKF1TYVXXFQcYt7j56XZuDGavI8a8aoRUHGBXAJOS4OpXpl2pZ8Cv/iuipUpx0mJHa/drt7605kaH2QOJIyfsVvyCExpmxYhva/H2/Ho4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7SpKCnA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7SpKCnA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2435CC2BCF6;
	Fri, 18 Sep 2026 11:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789729610;
	bh=PawLXKvlJwv7D4KsJjXTvYA+h3NHb2+AdBM76dtcECM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=O7SpKCnAchMviM60tVz+OncP9xqcXp740adol8HcbgG87moP/sz3Ab5zCF75KfSO5
	 DZ/ENgtEwLQug35EH2NDNoZGg1yy2rEEfDJzleVt2oyn+odxI890VE0Ai8v5OZI97L
	 yLo1XJEYGkEoi5pVmtO2pTzc6R+HIIjmN4P5EqB8T5qYLmYOF2+7OWsOpDppgMTxHj
	 6n91Lfd6ZC04SjuKsmfvbGO8gZplp2rreHFLfM9ml6JJgSM//G0NYnBkM1OhUoS1xL
	 jugnhrfZzH4ehXjFNtsL3y46YEcEYj6GhKjnbio/IQoAy+019yNj28APfgzRBndY0L
	 QdLtH2UfcMFcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E9AC982D7;
	Fri, 18 Sep 2026 11:06:49 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Subject: [PATCH v2 00/10] Add support for Apple Silicon DockChannel
 internal keyboards
Date: Fri, 18 Sep 2026 21:06:43 +1000
Message-Id: <20260918-apple-mtp-keyboard-final-v2-0-a5c685e50b60@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6WPMQ6DMAxFr4Iy11WAEkSn3qNiMMGBqIQgB6Eix
 N1LmLp06vik7/fkTQRiS0Hck00wLTZYPx6QXRKhexw7AtseLDKZKamyCnCaBgI3T/CitfHILRg
 74gBVqpsClTE3o8VxPjEZ+z7Vz/rgBgNBwzjqPgodhpk4Dg17B3PPhF+lXP4uLSlIKKRqq1xhW
 sry0Tm0w1V7F329DbPn9XxpSWP+T2e97/sHkmRq3ykBAAA=
X-Change-ID: 20260629-apple-mtp-keyboard-final-91cb5a6ff4fc
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-input@vger.kernel.org, 
 Yureka Lilian <yureka@cyberchaos.dev>, Julian Braha <julianbraha@gmail.com>, 
 Sasha Finkelstein <k@chaosmail.tech>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789729608; l=5150;
 i=michael.reeves077@gmail.com; s=fedora-20260918;
 h=from:subject:message-id;
 bh=PawLXKvlJwv7D4KsJjXTvYA+h3NHb2+AdBM76dtcECM=;
 b=DyM1kiGNSg27vuEC2T7JPVm2q4rWEodR3Ak0dpi7DGHZb9sUGUPU7nvYtFL3gCq+RL/xA5/wt
 kORyTa+p2nFCwdMZwlGS4dnWRK/cgGi5vwoe7VjfsRsWtRbFvyW0p3d
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=VJ0TvyQ9TvfzYZa908YSE9kpkjFLLD5luv0bERu+boc=
X-Endpoint-Received: by B4 Relay for
 michael.reeves077@gmail.com/fedora-20260918 with auth_id=1035
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

This series introduces support for the internal keyboards on Apple
Silicon M2 and M3 MacBook models.

On these platforms, built-in input devices are managed by a dedicated
coprocessor running an RTKit-based operating system. Communication
between this coprocessor and the main processor is carried out over a
low-latency hardware byte FIFO interface called DockChannel.

To support this input path, the series introduces a few new components:
- An apple-dockchannel mailbox driver to handle the low-level
  byte-stream FIFO.
- A DockChannel HID transport driver (apple-hid) that boots the
  coprocessor using the RTKit framework and encapsulates the HID
  protocol over the mailbox.
- Minor additions to the apple-rtkit and hid-apple drivers to support
  the TraceKit endpoint and integrate the keyboards into the existing
  input-quirks framework.
- Devicetree bindings and DTS updates to describe the nodes on M2 and
  M3 laptops.

The transport driver is based on an original out-of-tree implementation
by Hector Martin, but it has been significantly rewritten for upstream
inclusion to use the standard Linux mailbox framework and align better
with upstream HID design patterns and reduce reliance on hacks.

While the coprocessor manages both the keyboard and the trackpad, this
series only enables keyboard support. The keyboard can be initialised
without loading external firmware, whereas the trackpad requires
firmware. Trackpad support will be submitted in a subsequent series
once these base transport layers are established.

Tested on: MacBook Air M3 (J613).

Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>

Changes in v2:
- Link to v1: https://lore.kernel.org/asahi/20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com/
- Rebase onto latest upstream and add M3 Pro/Max device-tree support.
- Use an optional STM node to decide whether to wait for device IDs
  (suggested by Yureka Lilian).
- Rename bindings to match the t8112 fallback (suggested by Conor Dooley).
- Fix FIFO MMIO write width (suggested by Yureka Lilian) and run mailbox
  interrupt handling in the IRQ thread.
- Remove the duplicate report fixup (suggested by Sasha Finkelstein)
  and redundant HID dependency (suggested by Julian Braha).
- Fix teardown and the missing HID stop callback; simplify interface lookup.

---
Michael Reeves (9):
      dt-bindings: mailbox: apple: Add M3 ASC mailbox compatibles
      dt-bindings: mailbox: apple: Add DockChannel mailbox
      dt-bindings: iommu: apple,dart: Add M3 compatibles
      dt-bindings: input: apple: Add DockChannel HID transport
      mailbox: apple: Add DockChannel FIFO controller
      HID: apple: Add support for DockChannel HID keyboards
      HID: apple: Add DockChannel HID transport driver
      arm64: dts: apple: Add MTP DockChannel HID nodes
      arm64: dts: apple: Enable DockChannel HID on M2 and M3 laptops

Sasha Finkelstein (1):
      soc: apple: rtkit: Add tracekit endpoint

 .../input/apple,t8112-dockchannel-hid.yaml         |  104 ++
 .../devicetree/bindings/iommu/apple,dart.yaml      |    6 +-
 .../devicetree/bindings/mailbox/apple,mailbox.yaml |    3 +
 .../bindings/mailbox/apple,t8112-dockchannel.yaml  |   77 ++
 MAINTAINERS                                        |    5 +
 arch/arm64/boot/dts/apple/t602x-die0.dtsi          |   46 +
 arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi     |   29 +
 arch/arm64/boot/dts/apple/t6030.dtsi               |   46 +
 arch/arm64/boot/dts/apple/t6031-die0.dtsi          |   46 +
 arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi     |   24 +
 arch/arm64/boot/dts/apple/t8112-j413.dts           |   24 +
 arch/arm64/boot/dts/apple/t8112-j415.dts           |   24 +
 arch/arm64/boot/dts/apple/t8112-j493.dts           |   26 +-
 arch/arm64/boot/dts/apple/t8112.dtsi               |   46 +
 arch/arm64/boot/dts/apple/t8122-j504.dts           |   26 +
 arch/arm64/boot/dts/apple/t8122-j613.dts           |   27 +
 arch/arm64/boot/dts/apple/t8122-j615.dts           |   27 +
 arch/arm64/boot/dts/apple/t8122.dtsi               |   47 +
 drivers/hid/Kconfig                                |    2 +
 drivers/hid/Makefile                               |    2 +
 drivers/hid/dockchannel/Kconfig                    |   14 +
 drivers/hid/dockchannel/Makefile                   |    3 +
 drivers/hid/dockchannel/apple-hid.c                | 1157 ++++++++++++++++++++
 drivers/hid/hid-apple.c                            |  117 +-
 drivers/mailbox/Kconfig                            |   12 +
 drivers/mailbox/Makefile                           |    2 +
 drivers/mailbox/apple-dockchannel.c                |  371 +++++++
 drivers/soc/apple/rtkit.c                          |    2 +
 include/linux/hid.h                                |    1 +
 include/linux/mailbox/apple-dockchannel.h          |   29 +
 30 files changed, 2297 insertions(+), 48 deletions(-)
---
base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
change-id: 20260629-apple-mtp-keyboard-final-91cb5a6ff4fc

Best regards,
-- 
Michael Reeves <michael.reeves077@gmail.com>


