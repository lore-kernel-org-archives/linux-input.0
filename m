From: Marcel Hasler <mahasler@gmail.com>
Subject: [PATCH v3 0/2] Add new force feedback driver for Mayflash game
 controller adapters.
Date: Thu, 3 Nov 2016 19:47:00 +0100
Message-ID: <20161103184700.GA19179@arch-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32995 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760082AbcKCSrI (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 3 Nov 2016 14:47:08 -0400
Received: by mail-wm0-f68.google.com with SMTP id u144so385237wmu.0
        for <linux-input@vger.kernel.org>; Thu, 03 Nov 2016 11:47:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

This patchset adds a new force feedback driver for game controller adapters by Mayflash,
called hid-mf.

These devices identify themselves using the vendor ID of DragonRise but don't actually seem
to be in any way related to those gamepads. They are therefore not in any way compatible with
the hid-dr driver that implements force feedback for regular DragonRise gamepads. In fact, the
protocol used by these adapters is a lot simpler than the one implemented in hid-dr. On the
other hand, because of the multi-input nature of these adapters the new driver needs to setup
memory-less force feedback for four individual input devices.

At the moment only the PS3 adapter is supported. I assume that the other adapters (for Wii U
and GameCube) use the same protocol, but since I don't own any of these (nor any of the gamepads)
I haven't been able to test them.

CHANGES from v1:
* Added IS_ENABLED(CONFIG_HID_MAYFLASH) to hid_have_special_driver[] in hid-core.c
* Proper iteration over hid->inputs in mf_init() in hid-mf.c
* Use consistent naming of 'struct hid_device *hid' in hid-mf.c

CHANGES from v2:
* NONE, only resubmission

Marcel Hasler (2):
  usbhid: Add quirks for Mayflash/Dragonrise GameCube and PS3 adapters.
  Add new force feedback driver for Mayflash game controller adapters.

 drivers/hid/Kconfig             |   8 ++
 drivers/hid/Makefile            |   1 +
 drivers/hid/hid-core.c          |   3 +
 drivers/hid/hid-ids.h           |   6 +-
 drivers/hid/hid-mf.c            | 166 ++++++++++++++++++++++++++++++++++++++++
 drivers/hid/usbhid/hid-quirks.c |   2 +
 6 files changed, 184 insertions(+), 2 deletions(-)
 create mode 100644 drivers/hid/hid-mf.c

-- 
2.10.2

