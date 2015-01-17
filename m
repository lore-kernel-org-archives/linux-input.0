From: Aleksei Mamlin <mamlinav@gmail.com>
Subject: [PATCH 0/3] Add device tree support for Goodix GT9xx series touchscreen controller
Date: Sat, 17 Jan 2015 17:34:13 +0300
Message-ID: <1421505253-7474-1-git-send-email-mamlinav@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:44986 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbbAQOfs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Jan 2015 09:35:48 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org, Aleksei Mamlin <mamlinav@gmail.com>

Provide device tree support and binding information.

Aleksei Mamlin (3):
  input: goodix: Add device tree support
  dt-bindings: Add vendor-prefix for Goodix
  input: goodix: Add bindings documentation

 .../bindings/input/touchscreen/gt9xx.txt           | 23 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/input/touchscreen/goodix.c                 | 10 ++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/gt9xx.txt

-- 
2.0.5

