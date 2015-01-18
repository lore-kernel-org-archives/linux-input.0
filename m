From: Aleksei Mamlin <mamlinav@gmail.com>
Subject: [PATCH v2 0/3] Add device tree support for Goodix GT9xx series touchscreen controller
Date: Sun, 18 Jan 2015 17:02:20 +0300
Message-ID: <1421589740-12132-1-git-send-email-mamlinav@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:43031 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbbAROD4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Jan 2015 09:03:56 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org, Aleksei Mamlin <mamlinav@gmail.com>

This patch set adds device tree support and binding information for Goodix GT9xx series touchscreen controller.
Support was tested on Wexler Tab 7200 tablet pc and also should work on other devices.

Changes since v1:
  Added Kconfig entry, which enable CONFIG_OF

Aleksei Mamlin (3):
  input: goodix: Add device tree support
  dt-bindings: Add vendor-prefix for Goodix
  input: goodix: Add bindings documentation

 .../bindings/input/touchscreen/gt9xx.txt           | 23 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/input/touchscreen/Kconfig                  |  2 +-
 drivers/input/touchscreen/goodix.c                 | 10 ++++++++++
 4 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/gt9xx.txt

-- 
2.0.5

