From: Jaejoong Kim <climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] HID: hiddev: move hiddev's minor number and refactoring
Date: Thu,  2 Mar 2017 22:45:28 +0900
Message-ID: <1488462330-12349-1-git-send-email-climbbb.kim@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jaejoong Kim <climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi all,

I found hiddev's minor number is always zero in struct hid_device. So,
store the minor number asked from usb core in struct hid_device.

This is my first approach.

But after reviewed from Bendjamin, he suggested that it would make sense
to store a minor number in struct hiddev like hidraw if it neeeded.

So, I move the minor number from hid_device to hiddev and do some refactoring
to access struct hiddev in hid-core

Jaejoong Kim (2):
  HID: hiddev: move hiddev's minor number from struct hid_device to
    hiddev
  HID: hiddev: store hiddev's minor number when hiddev is connected

 drivers/hid/hid-core.c      |  2 +-
 drivers/hid/usbhid/hiddev.c | 25 +++----------------------
 include/linux/hid.h         |  1 -
 include/linux/hiddev.h      | 24 ++++++++++++++++++++++++
 4 files changed, 28 insertions(+), 24 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
