From: Marcel Hasler <mahasler@gmail.com>
Subject: [PATCH 0/2] Add new force feedback driver for Mayflash game
 controller adapters.
Date: Sun, 30 Oct 2016 23:12:30 +0100
Message-ID: <20161030221230.GA13800@arch-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32791 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754461AbcJ3WMj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 30 Oct 2016 18:12:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id m83so15952643wmc.0
        for <linux-input@vger.kernel.org>; Sun, 30 Oct 2016 15:12:38 -0700 (PDT)
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

The first patch is identical to the one I already submitted earlier today. It's include here
only because the second patch requires one of the new defines for the device ID.

The second patch adds the new driver.

Marcel Hasler (2):
  usbhid: Add quirks for Mayflash/Dragonrise GameCube and PS3 adapters.
  Add new force feedback driver for Mayflash game controller adapters.

 drivers/hid/Kconfig             |   8 ++
 drivers/hid/Makefile            |   1 +
 drivers/hid/hid-core.c          |   1 +
 drivers/hid/hid-ids.h           |   6 +-
 drivers/hid/hid-mf.c            | 165 ++++++++++++++++++++++++++++++++++++++++
 drivers/hid/usbhid/hid-quirks.c |   2 +
 6 files changed, 181 insertions(+), 2 deletions(-)
 create mode 100644 drivers/hid/hid-mf.c

-- 
2.10.1

