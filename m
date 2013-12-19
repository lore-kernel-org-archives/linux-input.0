From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/3] Change in handling different input device in hid-multitouch
Date: Thu, 19 Dec 2013 11:23:08 -0500
Message-ID: <1387470191-9725-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Edel Maks <edelmaks@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi guys,

well, I have been reported a brand new device, which, as always presents a new
way of dealing with multitouch and mouse and soever.
The new fancy stuff is capable to report mouse and touch, whereas by default,
we consider mouse as garbage.

if you want to get an idea of the device:
http://www.pearl.de/a-PX2569-1002.shtml

So, we need to add a quirk for it, as usual, but I also cleaned up the way we
treat the different input devices within the driver. I expect some bikesheding
here, so I fire this right now until it's too late for 3.14 or 3.15 :)

Cheers,
Benjamin

Benjamin Tissoires (3):
  HID: multitouch: switch to a callback system for handling events
  HID: multitouch: introduce mt_protocol_generic
  HID: multitouch: add support of other generic collections in hid-mt

 drivers/hid/hid-ids.h        |   3 +
 drivers/hid/hid-multitouch.c | 205 +++++++++++++++++++++++++++++++++----------
 include/linux/hid.h          |   3 +
 3 files changed, 166 insertions(+), 45 deletions(-)

-- 
1.8.3.1
