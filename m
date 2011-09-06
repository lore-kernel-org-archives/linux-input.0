From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 0/2] Add device tree support for Samsung's keypad controller
 driver
Date: Tue, 06 Sep 2011 19:25:15 +0530
Message-ID: <1315317317-21873-1-git-send-email-thomas.abraham@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:26975 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209Ab1IFN4I (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Sep 2011 09:56:08 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: grant.likely@secretlab.ca, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jy0922.shim@samsung.com, dh09.lee@samsung.com

This patchset adds device tree support for samsung's keypad controller driver.
First patch adds a new config option to be used by device tree enabled platforms
for selecting the samsung's keypad controller driver. The second patch adds device
tree support for the keypad driver.

Thomas Abraham (2):
  input: samsung-keypad: Add HAVE_SAMSUNG_KEYPAD config option
  input: samsung-keypad: Add device tree support

 .../devicetree/bindings/input/samsung-keypad.txt   |   88 +++++++++++
 drivers/input/keyboard/Kconfig                     |    9 +-
 drivers/input/keyboard/samsung-keypad.c            |  161 +++++++++++++++++++-
 3 files changed, 254 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/samsung-keypad.txt

