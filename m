From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 0/4] Quirks cleanup and hid-generic niceness
Date: Mon, 20 Nov 2017 11:48:40 +0100
Message-ID: <20171120104844.31977-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbdKTKs6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Nov 2017 05:48:58 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Niels Skou Olsen <nolsen@jabra.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-bluetooth@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi,

this is v3 rebased on top of for-next.
There are no other changes.

Cheers,
Benjamin

Benjamin Tissoires (4):
  HID: core: move the dynamic quirks handling in core
  HID: quirks: move the list of special devices into a quirk
  HID: core: move the list of ignored devices in hid-quirks.c
  HID: core: remove the absolute need of hid_have_special_driver[]

 drivers/hid/Makefile            |    2 +-
 drivers/hid/hid-core.c          |  932 ++---------------------------
 drivers/hid/hid-generic.c       |   68 ++-
 drivers/hid/hid-quirks.c        | 1248 +++++++++++++++++++++++++++++++++++++++
 drivers/hid/usbhid/Makefile     |    2 +-
 drivers/hid/usbhid/hid-core.c   |   10 +-
 drivers/hid/usbhid/hid-quirks.c |  402 -------------
 include/linux/hid.h             |   21 +-
 net/bluetooth/hidp/core.c       |    2 +-
 9 files changed, 1395 insertions(+), 1292 deletions(-)
 create mode 100644 drivers/hid/hid-quirks.c
 delete mode 100644 drivers/hid/usbhid/hid-quirks.c

-- 
2.14.3

