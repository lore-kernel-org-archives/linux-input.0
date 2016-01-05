From: Oreste Salerno <oreste.salerno@tomtom.com>
Subject: [PATCH v2 0/3] Add device tree support to the cyttsp driver
Date: Tue, 5 Jan 2016 13:59:12 +0100
Message-ID: <cover.1451997697.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3.tomtom.com ([85.90.76.132]:55939 "EHLO mail3.tomtom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbcAEM7V (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Jan 2016 07:59:21 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, fery@cypress.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, oreste.salerno@tomtom.com

This set of patches adds support to the cyttsp touchscreen driver
to retrieve platform data details from the device tree.
Additionally, they define a default init function that performs a hard
reset of the chip on boot.

---
Changes in v2:
  - Fix err_cast.cocci warning in patch 2/3

Oreste Salerno (3):
  Input: cyttsp - remove unused irq_gpio from platform_data
  Input: cyttsp - add device tree support
  Input: cyttsp - add default init function

 .../bindings/input/touchscreen/cyttsp.txt          |  73 +++++++++++++
 drivers/input/touchscreen/cyttsp_core.c            | 120 +++++++++++++++++++--
 include/linux/input/cyttsp.h                       |   4 +-
 3 files changed, 189 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt

-- 
1.9.1

