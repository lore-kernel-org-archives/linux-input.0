From: Oreste Salerno <oreste.salerno@tomtom.com>
Subject: [PATCH 0/3] Add device tree support to the cyttsp driver
Date: Sun, 27 Dec 2015 17:21:07 +0100
Message-ID: <cover.1451231697.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, fery@cypress.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, oreste.salerno@tomtom.com
List-Id: linux-input@vger.kernel.org

This set of patches adds support to the cyttsp touchscreen driver
to retrieve platform data details from the device tree.
Additionally, they define a default init function that performs a hard
reset of the chip on boot.

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
