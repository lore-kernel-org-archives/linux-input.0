Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794122714;
	b=rwoV1GEBw6tvEbCGcIrGZ9OKeVE6Dyd93rmTPMphh3PH2UFeDw2Iwk06ijvqo54OFGYR
	 wvdmOKkk0oeBz+oMpvNxW8NSoJ0WYvgCLGZplNka8UrD7CIsIXvvFpvtADxUr1cpgFyzY
	 muwWFGXi1et98hKShYrn/1xW86qLyI2Mt5J5jr5s3YuPoltIek3fZEf36X9E8vFVpGq2z
	 sVeGMm3feyY2VPFzOkn05oFLgiwQTpyHr/G8I7TU9sX67eTtXb+UEpKPv27z29HJc4kd3
	 AGaNxd3MOWD/3t6/DA2v3LOHSCYphn15AY59JucTp9/dAKtwM4yvt7wPdxQjlcLco2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794122714;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=LrxaMvNwH09tjq33c660ZGy57bdUstQX8cQSopm00l4=;
	b=FGAuznNyi0T0DuXEqR/bxGyr/AQPsjJDoGq019NzxmBhB6fXVAwRA5E9J4zwnJM1diOr
	 +UFf5eLER2FKuVgCsX0LR51BHg17BNtBLQC1Hu8l33WUg8JcqAcUxEnF7NEXS7B9pIajF
	 +yyk5o4Cnh8XuFTHKn8lhDbbKklaLWIZCK7gbtzgM8uMKYHd9cWk7LeT+h6hpAvPslpLt
	 2NBO7oT8vqkPNB78RIga4hOHiltxvcbMmZRSVfCjmCFeIdbd2dLnX0lC5L+9UTIlaj1kY
	 e+moxjXgJ88bq8XF+v3ya2StjgHIzrlkAPTQPiYxZvX+Zq9QmI5f48FOE/TPhDK8kUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+igfSRE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D780E606A321;
	Sun,  8 Nov 2026 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+igfSRE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794122713;
	b=agUCUocW/IgvIyosS4Z3dTT/QY5vwKKg+tIGlZFp9a9AEokBziSkz9irnfzzr6B7Amrr
	 YqDh8PdCf+A2L1dUf9dh+oV4LHGPtI+UDQfaIZsP2XxJoKmspD2EdEa0x4elC0IZCo8IZ
	 gqT+Fv0tuV3PALE3HoRDydqu7VaXwUZDb88z21Q7kX6oyUyzU8ozSs22V2aBeOCVzrVBF
	 6c0UxEgnkLFViDdRr2JaMgCtvg5kwEzdyJk5mSTnYyYodZG7f9ZFzOSJNMoDpvrgSba8u
	 6U6D5J2VEkXXq4OadQK/DvmxjS3uJSxmwvGEWj665LPKdmSEjLYNnV3irxFapjC12Ww==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794122713;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=LrxaMvNwH09tjq33c660ZGy57bdUstQX8cQSopm00l4=;
	b=wztEEYEyiQ1FWosURQ0WCqQpV4DiJ+FwBZAaVJgKAZaZz6ncxmRw1+XonlM19kM5vsmo
	 23FMkbs+M117rtgyIz7zWsaN8ZMHsNVfAvcAr4IEerSBGZxcH6w0P//GXMe6sA0XDSKRi
	 kzl8zyoGJe0C9OQjs+xk8gf0fpxRnxTb15yOtE0jxrZ4/1Qkf/AbJJIH+19mMSLLTmi3T
	 OhyK1hCrOGq1x9Fmz2YwIc4IQqc5J0icg2pasy0wvW6l602zmF8YR5KELJA1KMk+grDS2
	 3IVzNYp+prjbT3mASC2cVjl4pOrXDJJKuKqcxKEuzNY6Z/fZS7L57OykxQdcrZtkL6Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A75651F008A1;
	Sun,  8 Nov 2026 07:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794122713;
	bh=LrxaMvNwH09tjq33c660ZGy57bdUstQX8cQSopm00l4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=K+igfSREr7otlufYNxmEaAFTJD/ofxA9bcCue4Bf9LxPRPpHihAvz8HQeae80P8mG
	 Gv4BYQpooYBT7Smh/y1fxesXIibgBtBV13JrAfk+Rw2hzkEZxm5PmAxGArb8ghqfiP
	 My51r3/lflYz+NUsvY22RQ4c4LcVG04RKsoP1rl5uDN1HL6fPoU1j9jc4hAvdw61xs
	 9580UGWkCpoq3pBCEOAUcbKOXXOuL8FS+aBTEdiu1+tknSB8fpfwTA0eu8Sx9cZzKN
	 GYWf+/E9BjUJSzRiBEEyCHkhRPiHJy57ZqLJYxISPg7IWgHrghL1uDHiB6izOrRgAc
	 WK3bajFXM/uTA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 092C547E57;
	Sun,  8 Nov 2026 07:25:12 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Subject: [PATCH v5 0/8] Add support for Apple Silicon DockChannel internal
 keyboards
Date: Sun, 08 Nov 2026 07:25:05 +0000
Message-Id: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw6CMBBG4Vchs3aSDkGDvopx0Za/Ol6gacFoC
 O9O0eW3OGemjKTIdKpmSnhr1qEv2O8q8jfbX8HaFVNt6oOIadk1bGN8gl9j5Ae+brCp42MTxAf
 TIohQaWNC0M/ve778nSd3hx+3GS3LCrRNPvR5AAAA
X-Change-ID: 20261108-b4-apple-mtp-keyboard-94f1cf08ef11
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Michael Reeves <michael.reeves077@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>, 
 Hector Martin <marcan@marcan.st>, Sasha Finkelstein <k@chaosmail.tech>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794122710; l=6706;
 i=michael.reeves077@gmail.com; s=20261107; h=from:subject:message-id;
 bh=oZ1mf4X7qkbYYE4msjSc6m28dHS86c7Eq0mA+YXb+hg=;
 b=v7ki5JFSQhh+Q4zMjzyf2zjxjqVKQX0Y8h+QJlST2dPie/6iR4/iewchJkfTySTilGaDN4KQ4
 S16otZvP0PnDkux1SbtRtTWJ/ZxNnuiFknjcJhC7w815itopmzU3QAf
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=ykwkLcuByJYb/cdLc2UuoYP03pIzwrscEZg30+4tJL8=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20261107
 with auth_id=1442
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

Changes in v5:
- Link to v4: https://lore.kernel.org/all/20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com/
- Drop ASC mailbox and DART binding patches which were picked up and are in apple-soc/dt-7.5
- Simplify HID transport reg-names from coproc-asc/sram to asc/sram (suggested by Rob Herring).
- Replace the empty STM child node with the 'apple,has-stm' boolean property (suggested by Rob Herring).
- Drop the keyboard child node and move 'hid-country-code' to the parent node (suggested by Rob Herring).
- Simplify the transport driver to filter supported interfaces in C and drop fwnode handling.
- Collect Reviewed-by from Rob Herring on the DockChannel mailbox binding.
- Rebase on v7.4-rc1

Changes in v4:
- Link to v3: https://lore.kernel.org/all/20260918-apple-mtp-keyboard-final-v3-0-e356464e454b@gmail.com/
- Describe the DockChannel interrupt pair in DT (suggested by Yureka Lilian).
- Serialize command transactions and finish STM setup before signalling ready.
- Keep IRQ flag reads and acknowledgements under the controller lock.
- Clarify teardown synchronization and use the explicit-bounds HID API.
- Preserve interface-start errors and allow waiting again for delayed readiness.
- Simplify FIFO writes, IRQ startup and compatible matching.
- The command and IRQ changes address Sashiko feedback.

Changes in v3:
- Link to v2: https://lore.kernel.org/all/20260918-apple-mtp-keyboard-final-v2-0-a5c685e50b60@gmail.com/
- Fix failed-probe cleanup and interface publication ordering.
- Fix report lengths/types and reject replacement descriptors.
- Terminate serial replies and encode checksums as little endian.
- Honor HID_QUIRK_IGNORE_SPECIAL_DRIVER.
- Clarify the DockChannel TX byte register layout.
- All changes above address Sashiko feedback.

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
Michael Reeves (7):
      dt-bindings: mailbox: apple: Add DockChannel mailbox
      dt-bindings: input: apple: Add DockChannel HID transport
      mailbox: apple: Add DockChannel FIFO controller
      HID: apple: Add support for DockChannel HID keyboards
      HID: apple: Add DockChannel HID transport driver
      arm64: dts: apple: Add MTP DockChannel HID nodes
      arm64: dts: apple: Enable DockChannel HID on M2 and M3 laptops

Sasha Finkelstein (1):
      soc: apple: rtkit: Add tracekit endpoint

 .../input/apple,t8112-dockchannel-hid.yaml         |   92 ++
 .../bindings/mailbox/apple,t8112-dockchannel.yaml  |   88 ++
 MAINTAINERS                                        |    5 +
 arch/arm64/boot/dts/apple/t602x-die0.dtsi          |   47 +
 arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi     |   24 +
 arch/arm64/boot/dts/apple/t6030.dtsi               |   47 +
 arch/arm64/boot/dts/apple/t6031-die0.dtsi          |   47 +
 arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi     |   19 +
 arch/arm64/boot/dts/apple/t8112-j413.dts           |   19 +
 arch/arm64/boot/dts/apple/t8112-j415.dts           |   19 +
 arch/arm64/boot/dts/apple/t8112-j493.dts           |   21 +-
 arch/arm64/boot/dts/apple/t8112.dtsi               |   47 +
 arch/arm64/boot/dts/apple/t8122-j504.dts           |   22 +
 arch/arm64/boot/dts/apple/t8122-j613.dts           |   22 +
 arch/arm64/boot/dts/apple/t8122-j615.dts           |   22 +
 arch/arm64/boot/dts/apple/t8122.dtsi               |   48 +
 drivers/hid/Kconfig                                |    2 +
 drivers/hid/Makefile                               |    2 +
 drivers/hid/dockchannel/Kconfig                    |   14 +
 drivers/hid/dockchannel/Makefile                   |    3 +
 drivers/hid/dockchannel/apple-hid.c                | 1167 ++++++++++++++++++++
 drivers/hid/hid-apple.c                            |  118 +-
 drivers/mailbox/Kconfig                            |   12 +
 drivers/mailbox/Makefile                           |    2 +
 drivers/mailbox/apple-dockchannel.c                |  357 ++++++
 drivers/soc/apple/rtkit.c                          |    2 +
 include/linux/hid.h                                |    1 +
 include/linux/mailbox/apple-dockchannel.h          |   29 +
 28 files changed, 2251 insertions(+), 47 deletions(-)
---
base-commit: 1d368e025d7c4fe63c8bf68ccb4bc3c9772ab75c
change-id: 20261108-b4-apple-mtp-keyboard-94f1cf08ef11

Best regards,
--  
Michael Reeves <michael.reeves077@gmail.com>


