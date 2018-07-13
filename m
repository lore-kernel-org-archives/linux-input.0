From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 00/12] Hid multitouch rewrite, support os system multi-axis devices, take 4
Date: Fri, 13 Jul 2018 16:13:42 +0200
Message-ID: <20180713141354.7286-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi,

this is the v4 of my hid-multitouch rewrite series.

Changes are:
- added Peter's rev-by / acked-by
- changed MT_TOOL_MAX value to be 0x0f
- dropped the touch major/minor modifications

Cheers,
Benjamin

Benjamin Tissoires (12):
  input: add MT_TOOL_DIAL
  HID: multitouch: make sure the static list of class is not changed
  HID: multitouch: Store per collection multitouch data
  HID: multitouch: store a per application quirks value
  HID: multitouch: ditch mt_report_id
  HID: multitouch: remove one copy of values
  HID: input: enable Totem on the Dell Canvas 27
  HID: core: do not upper bound the collection stack
  HID: microsoft: support the Surface Dial
  HID: multitouch: report MT_TOOL_PALM for non-confident touches
  HID: multitouch: touchscreens also use confidence reports
  HID: multitouch: handle palm for touchscreens

 Documentation/input/multi-touch-protocol.rst |  12 +-
 drivers/hid/hid-core.c                       |  17 +-
 drivers/hid/hid-input.c                      |   3 +
 drivers/hid/hid-microsoft.c                  |  49 +-
 drivers/hid/hid-multitouch.c                 | 989 ++++++++++++++++-----------
 include/linux/hid.h                          |  15 +-
 include/uapi/linux/input.h                   |   9 +-
 7 files changed, 679 insertions(+), 415 deletions(-)

-- 
2.14.3
