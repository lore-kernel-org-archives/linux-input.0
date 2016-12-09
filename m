From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 0/7] HID: sony: DS4 fixes and improvements
Date: Thu,  8 Dec 2016 19:09:49 -0800
Message-ID: <1481252996-25288-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36372 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932532AbcLIDKj (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Dec 2016 22:10:39 -0500
Received: by mail-pg0-f44.google.com with SMTP id f188so2542368pgc.3
        for <linux-input@vger.kernel.org>; Thu, 08 Dec 2016 19:10:39 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Hi all,

This patch series contains a few small fixes/improvements in addition
to the motion sensor patches, shared before.

The first 3 patches we would recommend to get included in 4.10. They
fixes minor bugs and prevent DS4 dongle from sending empty HID reports.

The second set of the patches are the motion sensor patches, they were
rebased as the other changes caused them not to apply cleanly. I know
these patches are still being discussed.

The last patch removes HID report fixup for DS4 BT descriptors. As
described in more detail in the patch, it felt it was best to remove
it as it is causing issues for various cross platform libraries and
applications.

Thanks,
Roderick

Roderick Colenbrander (7):
  HID: sony: Fix error handling bug when touchpad registration fails
  HID: sony: Use DS4 MAC address as unique identifier on USB
  HID: sony: Ignore DS4 dongle reports when no device is connected
  HID: sony: Report DS4 motion sensors through a separate device
  HID: sony: Calibrate DS4 motion sensors
  HID: sony: Report hardware timestamp for DS4 sensor values
  HID: sony: Remove report descriptor fixup for DS4

 Documentation/input/event-codes.txt |   5 +-
 drivers/hid/hid-sony.c              | 886 ++++++++++++++++--------------------
 include/uapi/linux/input.h          |  11 +-
 3 files changed, 397 insertions(+), 505 deletions(-)

-- 
2.7.4

