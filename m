From: Patrick Vogelaar <Patrick.Vogelaar@gigatronik.com>
Subject: [PATCH v2 0/2] add driver for cypress cy8cmbr3102
Date: Tue, 21 Feb 2017 07:40:19 +0100
Message-ID: <1487659221-14665-1-git-send-email-Patrick.Vogelaar@gigatronik.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, fengguang.wu@intel.com, Patrick Vogelaar <Patrick.Vogelaar@gigatronik.com>
List-Id: linux-input@vger.kernel.org

* compiles without errors
* no errors when using checkpatch
* tested with a connected touch button on HW

NOTE: This implementation does not implement the full range of functions the
      Cypress CY8CMBR3102 CapSense Express controller provides. It only
      implements its use for connected touch buttons (yet).

Version 2:
* removed .owner
* based on branch next

Patrick Vogelaar (2):
  add driver for cypress cy8cmbr3102
  add device tree documentation for cy8cmbr3102

 .../bindings/input/cypress,cy8cmbr3102.txt         |  32 +++
 drivers/input/misc/Kconfig                         |  12 ++
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/cy8cmbr3102.c                   | 221 +++++++++++++++++++++
 4 files changed, 266 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cypress,cy8cmbr3102.txt
 create mode 100644 drivers/input/misc/cy8cmbr3102.c

-- 
2.7.4
