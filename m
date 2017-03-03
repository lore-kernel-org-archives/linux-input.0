From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH v2 0/2] HID: hiddev: move hiddev's minor number and refactoring
Date: Fri,  3 Mar 2017 17:53:59 +0900
Message-ID: <1488531241-18367-1-git-send-email-climbbb.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Jaejoong Kim <climbbb.kim@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi all,

   I found hiddev's minor number is always zero in struct hid_device. So,
   store the minor number asked from usb core in struct hid_device.

   This is my first approach.

   But after reviewed from Bendjamin, he suggested that it would make sense
   to store a minor number in struct hiddev like hidraw if it neeeded.

   So, I move the minor number from hid_device to hiddev and do some refactoring
   to access struct hiddev in hid-core

Chanes in v2:
- cp2112: tie in this series

- hiddev: rollback struct hiddev_list exported
          squash this patch in a seperate patch

Jaejoong Kim (2):
  HID: cp2112: use proper hidraw name with minor number
  HID: hiddev: reallocate hiddev's minor number

 drivers/hid/hid-core.c      |  2 +-
 drivers/hid/hid-cp2112.c    |  4 +++-
 drivers/hid/usbhid/hiddev.c | 15 ++++-----------
 include/linux/hid.h         |  1 -
 include/linux/hiddev.h      | 11 +++++++++++
 5 files changed, 19 insertions(+), 14 deletions(-)

-- 
2.7.4
