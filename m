From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 0/2] constify hid usb_device_id and fix space before '[' error
Date: Wed,  9 Aug 2017 23:51:33 +0530
Message-ID: <1502302895-30181-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

usb_device_id are not supposed to change at runtime. All functions
working with usb_device_id provided by <linux/usb.h> work with
const usb_device_id. So mark the non-const structs as const.

Fix checkpatch.pl error:
ERROR: space prohibited before open square bracket '['.

Arvind Yadav (2):
  [PATCH 1/2] HID: usbkbd: constify usb_device_id and fix space before '[' error.
  [PATCH 2/2] HID: usbmouse: constify usb_device_id and fix space before '[' error

 drivers/hid/usbhid/usbkbd.c   | 2 +-
 drivers/hid/usbhid/usbmouse.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.4
