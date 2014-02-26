From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 0/8] Input: pixcir_i2c_ts: Add Type-B Multi-touch and DT support
Date: Wed, 26 Feb 2014 17:27:58 +0200
Message-ID: <1393428486-15001-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: rydberg@euromail.se, jcbian@pixcir.com.cn, balbi@ti.com, dmurphy@ti.com, mugunthanvnm@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-input@vger.kernel.org

Hi,

This series does the following

- use devres managed resource allocations
- convert to Type-B multi touch protocol
- support upto 5 fingers with hardware supplied tracking IDs
- device tree support

Changelog:

v2:
- Addressed review comments and re-arranged patch order

v1:
- http://article.gmane.org/gmane.linux.kernel/1616417

cheers,
-roger

---
Roger Quadros (8):
  Input: pixcir_i2c_ts: Use devres managed resource allocations
  Input: pixcir_i2c_ts: Initialize interrupt mode and power mode
  Input: pixcir_i2c_ts: Get rid of pdata->attb_read_val()
  Input: pixcir_i2c_ts: Use Type-B Multi-Touch protocol
  Input: pixcir_i2c_ts: support upto 5 fingers and hardware provided
    tracking IDs
  Input: pixcir_i2c_ts: Implement wakeup from suspend
  Input: pixcir_i2c_ts: Add device tree support
  ARM: dts: am43x-epos-evm: Correct Touch controller info

 .../bindings/input/touchscreen/pixcir_i2c_ts.txt   |  26 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/am43x-epos-evm.dts               |  13 +-
 drivers/input/touchscreen/pixcir_i2c_ts.c          | 510 ++++++++++++++++++---
 include/linux/input/pixcir_ts.h                    |  56 ++-
 5 files changed, 545 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt

-- 
1.8.3.2
