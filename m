From: Peter Wu <peter@lekensteyn.nl>
Subject: [PATCH 0/4] HID: logitech-hidpp: fixes for error conditions
Date: Thu, 11 Dec 2014 13:51:16 +0100
Message-ID: <1418302280-14794-1-git-send-email-peter@lekensteyn.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jiri,

Here are four patches intended for the 3.19 stream and are based on
jikos/hid (for-next, v3.18-rc4-144-gd9372ee).

* The first is actually from Benjamin Tissoires, but modified to remove
  a now unneeded goto.
* The second one depends on the first (it could work without, but there
  will be a context mismatch).
* The third one can be applied independently of the others and is needed
  to avoid a possible buffer overread.
* The fourth and final patch fixes an unbalanced hid_device_io_start().

Tested by booting with three paired USB devices (QEMU + USB
passthrough), two of them are powered off and one M525 is active. evbug
registers mouse events.

Kind regards,
Peter

Peter Wu (4):
  HID: logitech-hidpp: do not return the name length
  HID: logitech-hidpp: check name retrieval return code
  HID: logitech-hidpp: add boundary check for name retrieval
  HID: logitech-hidpp: disable io in probe error path

 drivers/hid/hid-logitech-hidpp.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

-- 
2.1.3
