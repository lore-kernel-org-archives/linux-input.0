From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 00/12] HID: sony: updates for 4.12
Date: Tue,  7 Mar 2017 15:44:59 -0800
Message-ID: <20170307234511.30380-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36044 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933243AbdCGXqo (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Mar 2017 18:46:44 -0500
Received: by mail-pf0-f182.google.com with SMTP id o126so6629450pfb.3
        for <linux-input@vger.kernel.org>; Tue, 07 Mar 2017 15:45:15 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

These patches are a resubmit of previous patches rebased against 4.11
with minor improvemnts and additional patches improving other areas for
dualshock 3 / 4 support.
The original series wasn't merged for 4.11, which was likely because
discussions on motion sensor handling took a while to complete.

The first set of patches (1-8) are for DS4 / dongle:
- Add proper support for the motion sensors including calibration.
- Remove fixup for DS4 BT HID descriptors was removed. As described in more
  detail in the patch, it felt it was best to remove it as it is causing
  issues for various cross platform libraries and applications.
- Dongle is handled as a separate device as in terms of behavior it is
  in between a USB and BT DS4.
- Hotplug improvements were added for the dongle device including delayed
  calibration.
- The touchpad is now marked as a pointer device, before it wasn't anything.

The next patches (9-11) improve dualshock 3 support:
- The axes/button mapping has been suboptimal for a long time with axes
  even leaking into the ABS_MT range due to large amount of analog buttons.
  The ds3 now complies to the Linux gamepad spec and support for the analog
  buttons was dropped as there is no good way of expressing them, digital
  button state is preserved. We provided patches to SDL2, which is the main
  library through which users typically use game controllers.
- Motion sensors are now reported through a separate device similar to what
  was done for the dualshock 4 earlier.

The last patch moves the duplicate game controller check to an earlier
point, preventing unneeded 'transient' devices.

Thanks,
Roderick

Roderick Colenbrander (12):
  HID: sony: Report DS4 motion sensors through a separate device
  HID: sony: Calibrate DS4 motion sensors
  HID: sony: Report hardware timestamp for DS4 sensor values
  HID: sony: Remove report descriptor fixup for DS4
  HID: sony: Treat the ds4 dongle as a separate device
  HID: sony: Make work handling more generic
  HID: sony: Support motion sensor calibration on dongle
  HID: sony: Mark DS4 touchpad device as a pointer
  HID: sony: DS3 comply to Linux gamepad spec
  HID: sony: Print error on failure to active DS3 / Navigation
    controllers
  HID: sony: Expose DS3 motion sensors through separate device
  HID: sony: Perform duplicate device check earlier on

 Documentation/input/event-codes.txt |    5 +-
 drivers/hid/hid-sony.c              | 1352 ++++++++++++++++++-----------------
 include/uapi/linux/input.h          |   11 +-
 3 files changed, 700 insertions(+), 668 deletions(-)

-- 
2.9.3

