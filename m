From: Sushaanth Srirangapathi <sushaanth.s@ti.com>
Subject: [PATCH 0/3] Add Device Tree support for tps6507x-ts
Date: Mon, 1 Feb 2016 11:58:46 +0530
Message-ID: <1454308130-12452-1-git-send-email-sushaanth.s@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40370 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbcBAG3v (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Feb 2016 01:29:51 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joe Perches <joe@perches.com>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Sushaanth Srirangapathi <sushaanth.s@ti.com>

Add DT support for touchscreen input device tps6507x-ts which is part
of MFD device "TPS6507x"

Sushaanth Srirangapathi (3):
  Input: tps6507x-ts - add binding for tps6507x-ts
  Input: tps6507x-ts - Add device tree support
  ARM: DTS: da850: add DT node for tps6507x-ts

 Documentation/devicetree/bindings/mfd/tps6507x.txt |   10 +++-
 arch/arm/boot/dts/da850-evm.dts                    |    3 ++
 drivers/input/touchscreen/tps6507x-ts.c            |   51 ++++++++++++++++++--
 3 files changed, 59 insertions(+), 5 deletions(-)

-- 
1.7.9.5

