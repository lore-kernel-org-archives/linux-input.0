From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 0/6] HID: huion/uclogic merge and few additions
Date: Tue,  3 Mar 2015 12:43:59 -0500
Message-ID: <1425404645-20134-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>
List-Id: linux-input@vger.kernel.org

Resent the full series with Nick's Rev-by and fixes in 6/6.

Again, this is the upstream patches, DIGImend-devel is just added
to inform of the progress.

Cheers,
Benjamin

Benjamin Tissoires (6):
  HID: uclogic: Set quirks from inside the driver
  HID: uclogic: merge hid-huion driver in hid-uclogic
  HID: uclogic: name the input nodes based on their tool
  HID: uclogic: apply quirk NO_EMPTY_INPUT
  HID: uclogic: discard the extra Pen input node on Huion tablets
  HID: uclogic: actually invert the in-range bit for huion tablets only

 drivers/hid/Kconfig             |   8 +-
 drivers/hid/Makefile            |   1 -
 drivers/hid/hid-huion.c         | 290 -----------------------------------
 drivers/hid/hid-uclogic.c       | 326 +++++++++++++++++++++++++++++++++++++++-
 drivers/hid/usbhid/hid-quirks.c |   4 -
 5 files changed, 326 insertions(+), 303 deletions(-)
 delete mode 100644 drivers/hid/hid-huion.c

-- 
2.1.0
