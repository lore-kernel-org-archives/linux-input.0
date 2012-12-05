From: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/4] i2c-hid cleanup and bug fixes
Date: Wed,  5 Dec 2012 15:02:52 +0100
Message-ID: <1354716176-12558-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Jiri, Jean,

This is the v2 of the cleanup of i2c-hid.

Changes since v1:
* patch 1: check if dsize < 4
* patch 2: no changes
* patch 3: fixed irq return path
* patch 4: correct *_count handling (much more tested this time).

Cheers,
Benjamin

Benjamin Tissoires (4):
  HID: i2c-hid: fix memory corruption due to missing hid declaration
  HID: i2c-hid: reorder allocation/free of buffers
  HID: i2c-hid: remove extra .irq field in struct i2c_hid
  HID: i2c-hid: fix i2c_hid_get_raw_report count mismatches

 drivers/hid/i2c-hid/i2c-hid.c | 108 +++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 55 deletions(-)

-- 
1.8.0.1
