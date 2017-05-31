From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/7] HID: Consolidate serializing ope/close in transport drivers
Date: Wed, 31 May 2017 13:59:44 -0700
Message-ID: <20170531205951.30852-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This originally came about as report of uhid sending duplicate open and
premature close when hidraw was used alongside of input. After looking at
the drivers I think we shoud consolidate user tracking inside of the HID
core. While implementing this, there were a few cleanups as well.

Dmitry Torokhov (7):
  HID: hiddev: use hid_hw_open/close instead of usbhid_open/close
  HID: hiddev: use hid_hw_power instead of usbhid_get/put_power
  HID: usbhid: do not rely on hid->open when deciding to do IO
  HID: serialize hid_hw_open and hid_hw_close
  HID: i2c-hid: remove custom locking from i2c_hid_open/close
  HID: usbhid: remove custom locking from i2c_hid_open/close
  HID: remove no longer used hid->open field

 drivers/hid/hid-core.c        |  89 +++++++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid.c |  32 +++------
 drivers/hid/usbhid/hid-core.c | 150 ++++++++++++++++++++----------------------
 drivers/hid/usbhid/hiddev.c   |  12 ++--
 drivers/hid/usbhid/usbhid.h   |  15 +++--
 include/linux/hid.h           |  73 +++-----------------
 6 files changed, 194 insertions(+), 177 deletions(-)

Thanks.

-- 
Dmitry
