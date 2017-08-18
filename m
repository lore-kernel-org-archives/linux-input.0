From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH v2 0/3] Input/HID: joydev fixes for motion sensors
Date: Thu, 17 Aug 2017 19:01:53 -0700
Message-ID: <20170818020156.23390-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:38194 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753857AbdHRCCI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Aug 2017 22:02:08 -0400
Received: by mail-qt0-f170.google.com with SMTP id t37so47162480qtg.5
        for <linux-input@vger.kernel.org>; Thu, 17 Aug 2017 19:02:07 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Hi,

Some weeks ago we submitted an earlier version of this patch set,
which attempted to blacklist dualshock 3 / 4 motion sensor devices
from joydev. The motion sensor devices got picked up since the hid-sony
driver in recent months split the motion sensors of in separate devices.

The earlier version of this patch set, added a filter to joydev to
ignore devices which have INPUT_PROP_ACCELEROMETER set. Dmitry pointed
out that often you could use a motion sensor device as a joystick. He
felt the issue is with composite devices.

The discussion didn't result in a conclusion. This patch set only
filters out motion sensors if they are part of a composite device.
Since there is no way during driver initialization to determine
whether we are dealing with a composite device, we introduce a new
property INPUT_PROP_COMPOSITE to determine this. I think having such
flag is beneficial for userspace as well, since applications now get a hint
that a device is part of a composite device without having to infer
this from a EVIOCGPHYS / EVIOCGUINIQ match across devices.

Hopefully this patches will be accepted for 4.14, but maybe earlier if
still possible as the next wave of distributions will likely be on 4.13
with more users dealing with this issue.

Thanks,
Roderick


Roderick Colenbrander (3):
  Input: Add new property INPUT_PROP_COMPOSITE
  HID: sony: Set INPUT_PROP_COMPOSITE flag on sub devices.
  Input: joydev - ignore accelerometer devices

 Documentation/input/event-codes.rst    | 12 ++++++++++++
 drivers/hid/hid-sony.c                 |  8 ++++++++
 drivers/input/joydev.c                 |  5 +++++
 include/uapi/linux/input-event-codes.h |  1 +
 4 files changed, 26 insertions(+)

-- 
2.9.4

