From: Patrick Vogelaar <Patrick.Vogelaar@gigatronik.com>
Subject: [PATCH 0/2] add driver for cypress cy8cmbr3102
Date: Mon, 20 Feb 2017 11:33:31 +0100
Message-ID: <1487586813-4122-1-git-send-email-Patrick.Vogelaar@gigatronik.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:54536 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbdBTKeB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Feb 2017 05:34:01 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, Patrick Vogelaar <Patrick.Vogelaar@gigatronik.com>

* compiles without errors
* no errors when using checkpatch
* tested with a connected touch button on HW

NOTE: This implementation does not implement the full range of functions the
      Cypress CY8CMBR3102 CapSense Express controller provides. It only 
      implements its use for connected touch buttons (yet).

Patrick Vogelaar (2):
  add driver for cypress cy8cmbr3102
  add device tree documentation for cy8cmbr3102

 .../bindings/input/cypress,cy8cmbr3102.txt         |  32 +++
 drivers/input/misc/Kconfig                         |  12 ++
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/cy8cmbr3102.c                   | 222 +++++++++++++++++++++
 4 files changed, 267 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cypress,cy8cmbr3102.txt
 create mode 100644 drivers/input/misc/cy8cmbr3102.c

-- 
2.7.4

