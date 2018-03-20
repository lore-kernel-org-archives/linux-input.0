From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/7] HID core and multitouch fixups
Date: Tue, 20 Mar 2018 12:04:44 +0100
Message-ID: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi,

Patches 1 and 2 are related to the Razer Blade Stealth that has some dead zone
near the edges of the touchpad.
Patches 3 was previously sent and reviewed by Dmitry and he suggested patch 4
at the time.
Patches 5..7 are cleanups I realized while trying to merge hid-multitouch
into hid-core, so that other drivers could reuse the hid-mt logic (but it's
not that easy I must confess).

Cheers,
Benjamin

Benjamin Tissoires (7):
  HID: multitouch: export a quirk for the button handling of touchpads
  HID: multitouch: remove dead zones of Razer Blade Stealth
  HID: use BIT macro instead of plain integers for flags
  HID: use BIT() macro for quirks too
  HID: core: remove the need for HID_QUIRK_NO_EMPTY_INPUT
  HID: multitouch: do not set HID_QUIRK_NO_INIT_REPORTS
  HID: core: reset the quirks before calling probe again

 drivers/hid/hid-asus.c       |  3 +-
 drivers/hid/hid-core.c       |  2 ++
 drivers/hid/hid-input.c      | 10 +++----
 drivers/hid/hid-multitouch.c | 61 ++++++++++++++++-------------------------
 drivers/hid/hid-uclogic.c    |  1 -
 include/linux/hid.h          | 65 ++++++++++++++++++++++----------------------
 6 files changed, 65 insertions(+), 77 deletions(-)

-- 
2.14.3
