From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 0/2] Input: ABS2 and motion tracking
Date: Tue, 27 Sep 2016 16:38:50 -0700
Message-ID: <1475019532-16876-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:33784 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756061AbcI0X47 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Sep 2016 19:56:59 -0400
Received: by mail-it0-f45.google.com with SMTP id x192so21735002itb.0
        for <linux-input@vger.kernel.org>; Tue, 27 Sep 2016 16:56:58 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org, Input Tools <input-tools@lists.freedesktop.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

For some input driver work we have been doing, we were limited by not
having a wide enough ABS range in evdev. The current ABS range is mostly
full and due to limitations on the ioctl design, it can't be extended.

About 3 years ago, David Herrmann did work in this area to address this
problem for similar reasons as us. However his patches at the time didn't
make it in.

Since we have a need for this kind of functionality, we took over his
patches and are submitting them again with various improvements based
on feedback to the original patches and some new functionality for motion
tracking we are interested in ourselves. The patchset is simpler than before,
because at the time a uinput overhaul was needed, before uinput could even
support ABS_MAX2, which has happened since then.

The patches have been tested with some David's libevdev branch which
supports the new APIs. In addition we verified the new APIs in some
of internal software.

Thanks,
Roderick Colenbrander
Gaikai Inc, a Sony Interactive Entertainment Company

Roderick Colenbrander (2):
  Input: introduce ABS_MAX2/CNT2 and friends
  Input: add motion-tracking ABS_* bits and docs

 Documentation/input/gamepad.txt          |   9 +-
 Documentation/input/motion-tracking.txt  | 176 +++++++++++++++++++++++++++++++
 drivers/hid/hid-debug.c                  |   2 +-
 drivers/hid/hid-input.c                  |   2 +-
 drivers/input/evdev.c                    |  95 ++++++++++++++++-
 drivers/input/input.c                    |  14 +--
 drivers/input/keyboard/goldfish_events.c |   6 +-
 drivers/input/keyboard/hil_kbd.c         |   2 +-
 drivers/input/misc/uinput.c              |   8 +-
 include/linux/hid.h                      |   2 +-
 include/linux/input.h                    |   6 +-
 include/linux/mod_devicetable.h          |   2 +-
 include/uapi/linux/input-event-codes.h   |  21 +++-
 include/uapi/linux/input.h               |  37 ++++++-
 14 files changed, 355 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/input/motion-tracking.txt

-- 
2.7.4

