From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 0/6] HID: input cleanups and mt additions
Date: Tue, 24 Apr 2018 10:04:31 +0200
Message-ID: <20180424080437.21367-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Mario.Limonciello@dell.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi Jiri,

following the thread about the 'not incrementing ABS_MISC', here is the
actual submission of the series.

Compared to the 2 patches I sent last week, there are a few more:
- patch 1 needed to be added or some (all?) Advanced Silicon touchscreen
  would fail the tests with HID_QUIRK_INPUT_PER_APPLICATION
- patch 3 is extracted from v1-2/2, as it has grown significantly, still
  because of the same issue with Advanced Silicon panels
- patch 4 is something I had in mind while debugging some other
  not-so-talkative touchpads, because of patch 5
- patch 5 should put us at the same level than the Windows driver now.
  Note that we could unset the features (button/surface reporting, and
  latency during suspend, but not sure it helps that much. We should probably
  test the current consumption with and without)

The series has been tested against regressions thanks to my new hid test suite
https://github.com/bentiss/hid-tools (I rewrote hid-replay in python and hook
up python tests). I also used the loaner from Dell (thanks Mario!), and XPS
9360 that has both touchscreen and touchpad, and on which the touchpad has the
new features I implemented here.

Cheers,
Benjamin


Benjamin Tissoires (6):
  HID: store the full list of reports in the hidinput
  HID: generic: create one input report per application type
  HID: input: append a suffix matching the application
  HID: multitouch: make use of HID_QUIRK_INPUT_PER_APP
  HID: multitouch: simplify the settings of the various features
  HID: multitouch: implement precision touchpad latency and switches

 drivers/hid/hid-core.c       |  19 ++--
 drivers/hid/hid-generic.c    |  15 +++
 drivers/hid/hid-gfrm.c       |   2 +-
 drivers/hid/hid-input.c      |  90 +++++++++++++++--
 drivers/hid/hid-magicmouse.c |   6 +-
 drivers/hid/hid-multitouch.c | 227 ++++++++++++++++++++++---------------------
 include/linux/hid.h          |  16 ++-
 7 files changed, 244 insertions(+), 131 deletions(-)

-- 
2.14.3
