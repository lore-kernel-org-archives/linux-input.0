From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 0/8] HID: sony: DS4 updates
Date: Wed, 23 Nov 2016 14:07:05 -0800
Message-ID: <1479938833-26424-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:35779 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932758AbcKWWII (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Nov 2016 17:08:08 -0500
Received: by mail-yw0-f170.google.com with SMTP id i145so23765203ywg.2
        for <linux-input@vger.kernel.org>; Wed, 23 Nov 2016 14:08:08 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

I would like to share various updates to the DS4 driver. The first
4 patches are bug fixes and improvements discussed in various
discussions on linux-input:
- Fix issue when mixing USB and Bluetooth due to failure behind
  the scens in sony_input_configured. Benjamin suggested the
  fix we added.
- The touchpad is a separate device to avoid touch influencing
  the analog sticks, which happened due to use of input_mt_sync.
- The DS4 code now complies to the Linux game controller spec.
  We work with SDL2, the biggest DS4 user, to make sure it can
  handle the different mappings. If desired we could make the DS3
  comply as well and make similar changes.
- Make DS4 motion sensors a separate device, so applications
  don't have to use 'non-existing' axes. Updated the event code
  specs to allow gyroscope data when INPUT_PROP_ACCELEROMETER is
  set as suggested by Peter Hutterer.

The next 2 patches add the unique ID to the USB device and add
support for a new DS4 device.

The last 2 patches add calibration and timestamp to the motion
sensors, which finally makes the motion sensors usable.

As part of the changes we started to wonder if we should drop
HID report fixups altogether for the DS4. It is used right now
to have the hid-core layer be able to handle events for the
'misbehaving' report ID 17. I'm aware though of various cross
platform libraries parsing DS4 HID reports, which are seeing
inconsistent views per OS. Not sure what we should do, we could
change this in a future patch. We would need to manually report
buttons / axes when on Bluetooth for report ID 17.

Thanks,
Roderick

Roderick Colenbrander (8):
  HID: sony: Fix memory issue when connecting device using both
    Bluetooth and USB
  HID: sony: Make the DS4 touchpad a separate device
  HID: sony: Comply to Linux gamepad spec for DS4
  HID: sony: Report DS4 motion sensors through a separate device
  HID: sony: Use DS4 MAC address as unique identifier on USB
  HID: sony: Support DS4 dongle
  HID: sony: Calibrate DS4 motion sensors
  HID: sony: Report hardware timestamp for DS4 sensor values

 Documentation/input/event-codes.txt |   5 +-
 drivers/hid/hid-core.c              |   1 +
 drivers/hid/hid-ids.h               |   1 +
 drivers/hid/hid-sony.c              | 790 +++++++++++++++++++++---------------
 include/uapi/linux/input.h          |  11 +-
 5 files changed, 477 insertions(+), 331 deletions(-)

-- 
2.7.4

