From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH v3 0/8] HID: MS and Logitech high-resolution scroll wheel support
Date: Wed,  5 Dec 2018 10:42:20 +1000
Message-ID: <20181205004228.10714-1-peter.hutterer@who-t.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>, torvalds@linux-foundation.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

A full explanation of why and what is in the v1, v2 patch thread here:
https://lkml.org/lkml/2018/11/22/625

v3 adds a better commit messages, m560 REL_HWHEEL_HI_RES support and a patch 
moved in the ordering. This is a full patch sequence because Benjamin's
magic scripts struggle with singular updates ;)

hid-tools patches to add the tests:
https://gitlab.freedesktop.org/libevdev/hid-tools/merge_requests/12

libinput support (unmerged):
https://gitlab.freedesktop.org/whot/libinput/tree/wip/hi-res-scrolling
If you want to 'feel' how it works, run sudo ./builddir/libinput-debug-gui
and watch the green/red scroll bars. On a device with hi-res scrolling the
green bar (scroll fractions) will move smoother than the red bar (wheel
clicks).

Tested with:
- Microsoft Comfort Optical Mouse 3000
- Microsoft Sculpt Ergonomic Mouse
- Microsoft Wireless Mobile Mouse 4000
- Logitech MX Anywhere 2S

And a few other mice that don't have that feature, so the testing was of
limited excitement.

Cheers,
  Peter

Harry Cutts (3):
      HID: logitech: Add function to enable HID++ 1.0 "scrolling acceleration"
      HID: logitech: Enable high-resolution scrolling on Logitech mice
      HID: logitech: Use LDJ_DEVICE macro for existing Logitech mice

Peter Hutterer (5):
      Input: add `REL_WHEEL_HI_RES` and `REL_HWHEEL_HI_RES`
      HID: core: store the collections as a basic tree
      HID: core: process the Resolution Multiplier
      HID: input: use the Resolution Multiplier for high-resolution scrolling
      HID: logitech-hidpp: fix typo, hiddpp to hidpp

 Documentation/input/event-codes.rst    |  21 +++-
 drivers/hid/hid-core.c                 | 174 +++++++++++++++++++++++++++++++++
 drivers/hid/hid-input.c                | 108 +++++++++++++++++++-
 drivers/hid/hid-logitech-hidpp.c       | 375 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 include/linux/hid.h                    |  10 ++
 include/uapi/linux/input-event-codes.h |   2 +
 6 files changed, 651 insertions(+), 39 deletions(-)
