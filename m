From: Oreste Salerno <oreste.salerno@tomtom.com>
Subject: [PATCH v4 0/4] Add device tree support to the cyttsp driver
Date: Thu, 21 Jan 2016 20:21:12 +0100
Message-ID: <cover.1453403916.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, fery@cypress.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, oreste.salerno@tomtom.com
List-Id: linux-input@vger.kernel.org

Implement a number of updates for the cyttsp driver to be able to parse generic
ACPI/of/static properties and drop support for platform data (no platform data
user is present in the kernel tree).

---
Changes in v4:
  Major rework based on Dmitry's review:
  - Use device_property_read() functions instead of of_property()
  - Use touchscreen_parse_properties to parse common properties
  - Drop support for platform data
  - Used devres managed allocations
Changes in v3:
  - Rework binding names and descriptions
Changes in v2:
  - Fix err_cast.cocci warning in patch 2/3


Oreste Salerno (4):
  Input: cyttsp - use devres managed resource allocations
  Input: cyttsp - check return value of input_mt_init_slots
  Input: cyttsp - switch to using device properties
  Input: cyttsp - perform hard reset of the chip during probe

 .../bindings/input/touchscreen/cyttsp.txt          |  95 ++++++++++
 drivers/input/touchscreen/cyttsp_core.c            | 197 +++++++++++++--------
 drivers/input/touchscreen/cyttsp_core.h            |  10 +-
 drivers/input/touchscreen/cyttsp_i2c.c             |  10 --
 drivers/input/touchscreen/cyttsp_spi.c             |  10 --
 include/linux/input/cyttsp.h                       |  15 --
 6 files changed, 231 insertions(+), 106 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt

-- 
1.9.1
