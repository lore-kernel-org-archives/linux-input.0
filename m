From: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH 0/4] reduce Surface Pro 3 multitouch jitter
Date: Sat, 30 Jun 2018 14:19:49 -1000
Message-ID: <cover.1530402641.git.joeypabalinas@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Daniel Martin <consume.noise@gmail.com>
List-Id: linux-input@vger.kernel.org

The Surface Pro 3 firmware doesn't reliably send contact lift off
reports nor handle invalid report values gracefully.

To reduce touchscreen input jitter:
  - add MT_QUIRK_NOT_SEEN_MEANS_UP to the MT_CLS_WIN_8
  - drop invalid report values

Joey Pabalinas (4):
  HID: multitouch: add MT_QUIRK_NOT_SEEN_MEANS_UP to MT_CLS_WIN_8 quirks
  HID: multitouch: don't check HID_GROUP_MULTITOUCH_WIN_8 for serial protocol
  HID: multitouch: drop reports containing invalid values
  HID: multitouch: remove unneeded else conditional cases

 drivers/hid/hid-multitouch.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

-- 
2.18.0
