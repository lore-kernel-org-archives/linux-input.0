From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/6] HID: wacom: cleanup
Date: Fri, 12 Feb 2016 17:27:39 +0100
Message-ID: <1455294465-13694-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

While working on the wacom.ko driver, I ended up having those 6 patches that
the current wacom.ko could benefit right now.

Besides cleaning, the only gain users will see is in patch 6 which allows to
actually use the wireless receiver (for development) without having to
unplug/replug it.

Cheers,
Benjamin

Benjamin Tissoires (6):
  HID: wacom: break out wacom_intuos_get_tool_type
  HID: wacom: break out parsing of device and registering of input
  HID: wacom: move down wireless_work()
  HID: wacom: reuse wacom_parse_and_register() in wireless_work
  HID: wacom: cleanup input devices
  HID: wacom: close the wireless receiver on remove()

 drivers/hid/wacom_sys.c | 363 ++++++++++++++++++++++++------------------------
 drivers/hid/wacom_wac.c | 166 +++++++++++-----------
 2 files changed, 265 insertions(+), 264 deletions(-)

-- 
2.5.0
