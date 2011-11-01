From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 0/3] usb/hid-core: drain URB queue when going to suspend
Date: Tue,  1 Nov 2011 17:25:44 +0800
Message-ID: <1320139547-7921-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz, oneukum@suse.de, bleung@chromium.org
Cc: stern@rowland.harvard.edu, olofj@chromium.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-input@vger.kernel.org

In some situations, trying to suspend a laptop with an attached USB keyboard
would fail if both NumLock and CapsLock LEDs were lit.
This was due to a race condition between asynchronously submitted
LED-manipulating CTRL URBs and the suspend process.

This is a different solution to the same problem highlighted here:
https://lkml.org/lkml/2011/9/2/391

These patches are against Jiri's hid/master branch.

Daniel Kurtz (3):
  HID: usbhid: remove LED_ON
  HID: usbhid: hid-core: submit queued urbs before suspend
  HID: usbhid: defer LED setting to a workqueue

 drivers/hid/hid-input.c       |   42 +++++++
 drivers/hid/usbhid/hid-core.c |  237 ++++++++++++++++++++++++-----------------
 drivers/hid/usbhid/usbhid.h   |    3 +-
 include/linux/hid.h           |    2 +
 4 files changed, 184 insertions(+), 100 deletions(-)

-- 
1.7.3.1
