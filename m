From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 0/2] Add device tree support for omap4 keypad
Date: Wed, 4 Apr 2012 19:00:19 +0530
Message-ID: <1333546221-19700-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57707 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756415Ab2DDN1y (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Apr 2012 09:27:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>

This series adds device tree support for omap4
onchip keypad.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Felipe Balbi <balbi@ti.com>

Sourav Poddar (2):
  arm/dts: omap4-sdp: Add keypad data
  drivers: input: keypad: Add device tree support

Test Info:
-Tested on Omap4430 sdp with 3.4-rc1

 .../devicetree/bindings/input/omap-keypad.txt      |   52 ++++
 arch/arm/boot/dts/omap4-sdp.dts                    |  291 ++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |    5 +
 drivers/input/keyboard/omap4-keypad.c              |  114 ++++++--
 4 files changed, 439 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/omap-keypad.txt

