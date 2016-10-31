From: Marcel Hasler <mahasler@gmail.com>
Subject: [PATCH v2 0/2] Add new force feedback driver for Mayflash game
 controller adapters.
Date: Mon, 31 Oct 2016 16:25:22 +0100
Message-ID: <20161031152522.GA22049@arch-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35099 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943907AbcJaPZ3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 31 Oct 2016 11:25:29 -0400
Received: by mail-wm0-f68.google.com with SMTP id 68so12154198wmz.2
        for <linux-input@vger.kernel.org>; Mon, 31 Oct 2016 08:25:28 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

This patchset adds a new force feedback driver for game controller adapters by Mayflash,
called hid-mf.

CHANGES from v1:
* Added IS_ENABLED(CONFIG_HID_MAYFLASH) to hid_have_special_driver[] in hid-core.c
* Proper iteration over hid->inputs in mf_init() in hid-mf.c
* Use consistent naming of 'struct hid_device *hid' in hid-mf.c

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
2.10.1

