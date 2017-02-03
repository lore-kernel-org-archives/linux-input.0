From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH v3 0/7] HID: sony: DS4 motion sensor improvements
Date: Thu,  2 Feb 2017 16:20:59 -0800
Message-ID: <20170203002106.23225-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:32829 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751565AbdBCAVa (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 2 Feb 2017 19:21:30 -0500
Received: by mail-pf0-f181.google.com with SMTP id y143so1111933pfb.0
        for <linux-input@vger.kernel.org>; Thu, 02 Feb 2017 16:21:29 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Hi all,

This patch is a resubmit of previous patches, which moved the DS4
motion sensors to a separate device and which added calibration.
The patches weren't merged, because there was discussion about
the overall direction of streaming motion sensors for linux input.
Last week consensus was reached with Jiri on the direction, so I'm
resubmitting these patches.

In addtion this series adds a few more patches to improve ds4 dongle
support. One patch separates the ds4 dongle handling from the ds4 usb
as the dongle needs slightly different handling (behaves like bluetooth
in some cases). The other patches focus on scheduling dongle calibration
based on connection of a DS4 to the dongle. To allow for this in a clean
way this required some rework to the work handling code.

Thanks,
Roderick

Roderick Colenbrander (7):
  HID: sony: Report DS4 motion sensors through a separate device
  HID: sony: Calibrate DS4 motion sensors
  HID: sony: Report hardware timestamp for DS4 sensor values
  HID: sony: Remove report descriptor fixup for DS4
  HID: sony: Treat the ds4 dongle as a separate device
  HID: sony: Make work handling more generic
  HID: sony: Support motion sensor calibration on dongle

 Documentation/input/event-codes.txt |    5 +-
 drivers/hid/hid-sony.c              | 1063 +++++++++++++++++------------------
 include/uapi/linux/input.h          |   11 +-
 3 files changed, 515 insertions(+), 564 deletions(-)

-- 
2.9.3

