From: Andrew Shadura <andrew.shadura@collabora.co.uk>
Subject: [PATCH v2] HID: report only one button for PenMount 6000 USB touchscreen controller
Date: Thu, 29 Oct 2015 16:09:49 +0100
Message-ID: <1446131389-21759-1-git-send-email-andrew.shadura@collabora.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:53068 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489AbbJ2PKI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Oct 2015 11:10:08 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input Mailing List <linux-input@vger.kernel.org>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>

PenMount 6000 USB resistive touchscreen controller reports it has three
buttons, while in reality it doesn't have any and doesn't support active
styli, and only generates touch events.

In penmount_input_mapping(), map only the first button (with code 0),
ignore the rest.

Signed-off-by: Andrew Shadura <andrew.shadura@collabora.co.uk>
---
  I tested the patch on with my touchscreen. When I run evtest on this device,
  without the patch I get three buttons (I shortened the output):
  
    Event type 1 (EV_KEY)
      Event code 330 (BTN_TOUCH)
      Event code 331 (BTN_STYLUS)
      Event code 332 (BTN_STYLUS2)
  
  And the device isn't recognised by libinput.
  
  When the patch is applied, however, the output of evtest is the following:
  
  Input driver version is 1.0.1
  Input device ID: bus 0x3 vendor 0x14e1 product 0x6000 version 0x101
  Input device name: "DIALOGUE INC PenMount USB"
  Supported events:
    Event type 0 (EV_SYN)
    Event type 1 (EV_KEY)
      Event code 330 (BTN_TOUCH)
    Event type 3 (EV_ABS)
      Event code 0 (ABS_X)
        Value      0
        Min        0
        Max     1023
      Event code 1 (ABS_Y)
        Value      0
        Min        0
        Max     1023
    Event type 4 (EV_MSC)
      Event code 4 (MSC_SCAN)
  Properties:
  
  And libevent-list-devices now mentions the touchscreen device, too:
  
  Device:           DIALOGUE INC PenMount USB
  Kernel:           /dev/input/event16
  Group:            4
  Seat:             seat0, default
  Capabilities:     touch
  Tap-to-click:     n/a
  Tap drag lock:    n/a
  Left-handed:      n/a
  Nat.scrolling:    n/a
  Middle emulation: n/a
  Calibration:      identity matrix
  Scroll methods:   none
  Click methods:    none

 drivers/hid/hid-penmount.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-penmount.c b/drivers/hid/hid-penmount.c
index c11dce8..d90383f 100644
--- a/drivers/hid/hid-penmount.c
+++ b/drivers/hid/hid-penmount.c
@@ -23,8 +23,12 @@ static int penmount_input_mapping(struct hid_device *hdev,
 		struct hid_usage *usage, unsigned long **bit, int *max)
 {
 	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
-		hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
-		return 1;
+		if (((usage->hid - 1) & HID_USAGE) == 0) {
+			hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
+			return 1;
+		} else {
+			return -1;
+		}
 	}
 
 	return 0;
-- 
2.5.0

