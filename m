From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/4] HID fixes
Date: Tue,  4 Sep 2018 15:31:11 +0200
Message-ID: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jiri,

there is no real link between those 4 commit but the fact that I wrote
them today ;)

2 patches should at least be scheduled for v4.19: 1/4 and 3/4
Both are stable fixes for mistakes I made in v4.18.

Patch 2 and 4 are just nice to have, so v4.20 should be fine.

Cheers,
Benjamin

Benjamin Tissoires (4):
  HID: multitouch: fix Elan panels with 2 input modes declaration
  HID: input: do not append a suffix if the name already has it
  HID: core: fix grouping by application
  HID: multitouch: simplify the application retrieval

 drivers/hid/hid-input.c      | 18 ++++++---
 drivers/hid/hid-multitouch.c | 91 ++++++++++++++++++++++++--------------------
 include/linux/hid.h          |  1 +
 3 files changed, 62 insertions(+), 48 deletions(-)

-- 
2.14.3
