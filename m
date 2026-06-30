Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B734740FDAD;
	Tue, 30 Jun 2026 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824086; cv=none; b=FhcFQETm/uTRXb38l0A49U8nTN2c2QdY/YX7nYfQUn+zk9QS6bMYMo7B2Zesp45PP/u7dA/K2/nmfA3b80CGlM6FzssqHijoIGXG5FuWdgLIpfAb99vSGczPu6obah2ER3xWNZXnErq0vv5EFjKF3sNTVrDSjZbCxygUET/7rqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824086; c=relaxed/simple;
	bh=eaYasJGTo79RPD26c3SmYtaVMbARHDwN7ZlMRtFRy80=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c2XqQq+HT9l3Jkf19xunB/f5XcH0uiIFbCiYqN62nJu0Ir0s4yMIJg0m1plbewFCzdXY10UUTAvMTnLAXHaYLDo9Q0cFT6WNKnrxucDmqm6IAo9QS+9SPx3PCEM6iOo2OudM4tGkrNT1iC8OUmtC/nhD0wBYfh5Kgn6Fn9BNCss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIshjdur; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIshjdur"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 518C6C2BCB9;
	Tue, 30 Jun 2026 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782824086;
	bh=eaYasJGTo79RPD26c3SmYtaVMbARHDwN7ZlMRtFRy80=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=KIshjdurzygOiSAA/GvHTJXfy3H/APETCZFWf18Pu9Ch5pg7KMpOesCBdK/klTt5K
	 kq2iW3DtPFP0fx2nTBdHEExEoq63oAwrywRuipa3SD1v8TsvJ7N6jL2MLbabHWyVBF
	 BwB6IXm9bdDBnOFPJC7gKz9BQsvPfKweUikzXZJpSMeeZLXm0bKQf1ImXq+ZZhvnOs
	 HUXrIOiRy7yHtA06qvpxKB1DAPS/aCivxnC+tfw7sr6ci0IY/2wA0zKlhoaoB6LN4/
	 RDXBigpTDqaCWSWts9dXxArbUSq2yUEPivJDps7KgQE8glsGvYVemmorQdLnTcVdUk
	 NknIxDbO25tTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BD8C43458;
	Tue, 30 Jun 2026 12:54:46 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Subject: [PATCH 00/10] Add support for Apple Silicon DockChannel internal
 keyboards
Date: Tue, 30 Jun 2026 22:54:28 +1000
Message-Id: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIS8Q2oC/x3MQQqEMAxA0atI1ga0OAW9iriINZkJai2tiCLe3
 TLLt/j/hsRROUFX3BD50KSbz6jLAtyP/JdRp2wwlbGVNS1SCAvjugec+Ro3ihOKelqwrd34ISv
 SiIOch8ii53/dD8/zAmGZkaZqAAAA
X-Change-ID: 20260629-apple-mtp-keyboard-final-91cb5a6ff4fc
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-input@vger.kernel.org, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 Sasha Finkelstein <k@chaosmail.tech>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782824083; l=4257;
 i=michael.reeves077@gmail.com; s=20260105; h=from:subject:message-id;
 bh=eaYasJGTo79RPD26c3SmYtaVMbARHDwN7ZlMRtFRy80=;
 b=ebb+Ox7p7yerFmB6WM6BevtFuS599DpSgn+0BYEpLRvDsyJzPxX79VG1SimhfsFSzFufv39RH
 1MfaeC0Z5VqBHIkyXTsZMKjyTFM2B/TdyGIBue7F8/vJ4hhkvFAE/xe
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=QIrgWBGCm3LG0YYc6MLCDkwuVXLTGGooVBdWX/KhSiU=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20260105
 with auth_id=591
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
---
Michael Reeves (9):
      dt-bindings: mailbox: Add Apple t8122 ASC mailbox
      dt-bindings: mailbox: apple: Add DockChannel mailbox
      dt-bindings: iommu: apple,dart: Add t8122 compatible
      dt-bindings: input: apple: Add DockChannel HID transport
      mailbox: apple: Add DockChannel FIFO controller
      HID: apple: Add support for DockChannel HID keyboards
      HID: apple: Add DockChannel HID transport driver
      arm64: dts: apple: Add MTP DockChannel HID nodes
      arm64: dts: apple: Enable DockChannel HID on M2 and M3 laptops

Sasha Finkelstein (1):
      soc: apple: rtkit: Add tracekit endpoint

 .../bindings/input/apple,dockchannel-hid.yaml      |   91 ++
 .../devicetree/bindings/iommu/apple,dart.yaml      |    4 +-
 .../bindings/mailbox/apple,dockchannel.yaml        |   75 ++
 .../devicetree/bindings/mailbox/apple,mailbox.yaml |    1 +
 MAINTAINERS                                        |    5 +
 arch/arm64/boot/dts/apple/t602x-die0.dtsi          |   46 +
 arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi     |   25 +
 arch/arm64/boot/dts/apple/t8112-j413.dts           |   20 +
 arch/arm64/boot/dts/apple/t8112-j415.dts           |   20 +
 arch/arm64/boot/dts/apple/t8112-j493.dts           |   22 +-
 arch/arm64/boot/dts/apple/t8112.dtsi               |   46 +
 arch/arm64/boot/dts/apple/t8122-j504.dts           |   22 +
 arch/arm64/boot/dts/apple/t8122-j613.dts           |   23 +
 arch/arm64/boot/dts/apple/t8122-j615.dts           |   23 +
 arch/arm64/boot/dts/apple/t8122.dtsi               |   47 +
 drivers/hid/Kconfig                                |    2 +
 drivers/hid/Makefile                               |    2 +
 drivers/hid/dockchannel/Kconfig                    |   15 +
 drivers/hid/dockchannel/Makefile                   |    3 +
 drivers/hid/dockchannel/apple-hid.c                | 1130 ++++++++++++++++++++
 drivers/hid/hid-apple.c                            |  139 ++-
 drivers/mailbox/Kconfig                            |   12 +
 drivers/mailbox/Makefile                           |    2 +
 drivers/mailbox/apple-dockchannel.c                |  380 +++++++
 drivers/soc/apple/rtkit.c                          |    2 +
 include/linux/hid.h                                |    1 +
 include/linux/mailbox/apple-dockchannel.h          |   29 +
 27 files changed, 2139 insertions(+), 48 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260629-apple-mtp-keyboard-final-91cb5a6ff4fc

Best regards,
--  
Michael Reeves <michael.reeves077@gmail.com>


