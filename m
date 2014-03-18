From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Subject: [PATCH v2 0/5] Add ST Keyscan driver
Date: Tue, 18 Mar 2014 16:00:01 +0100
Message-ID: <1395154806-2810-1-git-send-email-gabriel.fernandez@st.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([62.209.51.94]:51036 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932070AbaCRPDX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Mar 2014 11:03:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, kernel@stlinux.com, Lee Jones <lee.jones@linaro.org>, Gabriel Fernandez <gabriel.fernandez@st.com>

Changes in v2:
- use standard format for matrix keymap
- suppress __exit mark for keyscan_remove()
- Call to keyscan_stop() shoudl go into keyscan_close() implementation
- use of SIMPLE_DEV_PM_OPS()
- rename compatibility name into "st,sti-keyscan"
- suppress platform data management
- omit vendor information
- cosmetic change and renaming

The goal of this series is to add ST Keyscan support to ST SoCs.
The DT definition is added for STiH415 and STiH416 SoCs on
B2000 board.

Gabriel Fernandez (4):
  drivers: input: keyboard: st-keyscan: add keyscan driver
  ARM: STi: DT: add keyscan for stih416
  ARM: STi: DT: add keyscan for stih41x-b2000
  ARM: multi_v7_defconfig: add ST Keyscan driver

Giuseppe CONDORELLI (1):
  ARM: STi: DT: add keyscan for stih415

 .../devicetree/bindings/input/st-keyscan.txt       |  60 +++++
 arch/arm/boot/dts/stih415-pinctrl.dtsi             |  16 ++
 arch/arm/boot/dts/stih415.dtsi                     |  10 +
 arch/arm/boot/dts/stih416-pinctrl.dtsi             |  16 ++
 arch/arm/boot/dts/stih416.dtsi                     |  10 +
 arch/arm/boot/dts/stih41x-b2000.dtsi               |  23 ++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 drivers/input/keyboard/Kconfig                     |  12 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/st-keyscan.c                | 260 +++++++++++++++++++++
 10 files changed, 409 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/st-keyscan.txt
 create mode 100644 drivers/input/keyboard/st-keyscan.c

-- 
1.9.0

