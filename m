From: Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH v1 0/4] Add support for touchscreen on Colibri VF50
Date: Tue, 30 Jun 2015 12:24:44 +0530
Message-ID: <cover.1435646447.git.maitysanchayan@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35071 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbbF3G5k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jun 2015 02:57:40 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawn.guo@linaro.org, kernel@pengutronix.de, stefan@agner.ch, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sanchayan Maity <maitysanchayan@gmail.com>

Hello,

The patchset adds support for 4 wire touchscreen on Toradex Colibri
VF50 modules. Patches are based on top of shawn's branch.

Thanks & Regards,
Sanchayan.

Sanchayan Maity (4):
  ARM: dts: vfxxx: Add io-channel-cells property for ADC node
  ARM: dts: vf500-colibri: Add device tree node for touchscreen support
  touchscreen: colibri-vf50-ts: Add touchscreen support for Colibri VF50
  input: Add DT binding documentation for Colibri VF50 touchscreen

 .../bindings/input/touchscreen/colibri-vf50-ts.txt |  34 ++
 arch/arm/boot/dts/vf500-colibri-eval-v3.dts        |   4 +
 arch/arm/boot/dts/vf500-colibri.dtsi               |  46 ++
 arch/arm/boot/dts/vfxxx.dtsi                       |   2 +
 drivers/input/touchscreen/Kconfig                  |  12 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/colibri-vf50-ts.c        | 466 +++++++++++++++++++++
 7 files changed, 565 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt
 create mode 100644 drivers/input/touchscreen/colibri-vf50-ts.c

-- 
2.4.5

