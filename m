From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH 0/8] HID: MS and Logitech high-resolution scroll wheel support
Date: Thu, 22 Nov 2018 16:34:01 +1000
Message-ID: <20181122063409.15816-1-peter.hutterer@who-t.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>, torvalds@linux-foundation.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org


This series enables high-resolution scrolling on some or many Microsoft mice
of the last decade and Logitech mice with the required feature support.

High resolution scrolling is exposed to userspace as REL_WHEEL_HI_RES and
REL_HWHEEL_HI_RES. An accumulated value of 120 signals one wheel click, mice
with higher granularity can send multiple values that are fractions of 120.
REL_WHEEL and REL_HWHEEL are emulated for backwards compatibility.
The 120 magic number comes from Windows and affects how hardware vendors
build their shiny (and the use of a multiplier in the hw that is a whole
fraction of 120).

This series adds implementations for generic HID and for Logitech's HID++.

Windows Vista added the Resolution Multiplier HID feature which gives
us a multiplier that is applied (in hardware) to the wheel data. For the
same physical motion and an example multiplier of 8, the hardware may: 
- send 8 events of value 1, or
- send 1 event of value 8, or
- send 8/n events of value 1 * n
The multiplier is a HID Feature and should default to an effective 1 in the
hardware. Windows Vista and newer set this to the logical maximum, we do the
same now. It's an approved HID Feature but so far, this feature has only
been found on some Microsoft mice.

Logitech mice do not seem to use it and have their own HID++ protocol to
apply that multiplier. Harry's patchset had previously been merged, the
exact implementation was incompatible with the Microsoft bits though so it
was reverted. Harry's patches in this series are adjusted accordingly but
are by and large the same.

Notable: The Logitech REL_WHEEL emulation cannot just hook into the HID
bits. The firmware drops some events so the point when we get the REL_WHEEL
event moves around. This is worked around by directional resets and a
timeout-based reset.

Devices tested:
- Microsoft Comfort Optical Mouse 3000
- Microsoft Sculpt Ergonomic Mouse
- Microsoft Surface mouse
- Logitech MX Anywhere 2S

The following devices were tested for the HID feature and didn't have it:
- Logitech G500s, G303
- Roccat Kone XTD
- all the cheap Lenovo, HP, Dell, Logitech USB mice that come with a
  workstation that I could find in the local office
- Etekcity something something
- Razer Imperator
- Microsoft Classic IntelliMouse
- Microsoft Surface Mobile Mouse

Cheers,
  Peter

Harry Cutts (3):
      HID: logitech: Use LDJ_DEVICE macro for existing Logitech mice
      HID: logitech: Add function to enable HID++ 1.0 "scrolling acceleration"
      HID: logitech: Enable high-resolution scrolling on Logitech mice

Peter Hutterer (5):
      Input: add `REL_WHEEL_HI_RES` and `REL_HWHEEL_HI_RES`
      HID: core: store the collections as a basic tree
      HID: core: process the Resolution Multiplier
      HID: input: use the Resolution Multiplier for high-resolution scrolling
      HID: logitech-hidpp: fix typo, hiddpp to hidpp

 Documentation/input/event-codes.rst    |  21 +++-
 drivers/hid/hid-core.c                 | 174 ++++++++++++++++++++++++++++++++
 drivers/hid/hid-input.c                | 137 ++++++++++++++++++++++++-
 drivers/hid/hid-logitech-hidpp.c       | 384 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 include/linux/hid.h                    |  10 ++
 include/uapi/linux/input-event-codes.h |   2 +
 6 files changed, 690 insertions(+), 38 deletions(-)
