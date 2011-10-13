From: Daniel van Vugt <vanvugt@gmail.com>
Subject: [PATCH v1 1/1] hid-magicmouse: Magic Trackpad has 1 button, not 2
Date: Thu, 13 Oct 2011 18:05:12 +0800
Message-ID: <4E96B7D8.3030005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:45580 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab1JMKFS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Oct 2011 06:05:18 -0400
Received: by vcbgb30 with SMTP id gb30so1343312vcb.19
        for <linux-input@vger.kernel.org>; Thu, 13 Oct 2011 03:05:18 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

hid-magicmouse was advertising the Apple Magic Trackpad as having 2
buttons (left and right) when it actually only has 1 button.

Advertising multiple buttons in turn makes the xorg synaptics code
disable all button 2 and 3 emulation (using multi-finger clicks). So
xorg users don't get working right/middle-click emulation out of the box.

This patch makes hid-magicmouse correctly only report one real button
for Magic Trackpad, which in turn makes xorg enable multi-finger click
support to emulate right/middle buttons.

[http://launchpad.net/bugs/862094]

Signed-off-by: Daniel van Vugt <vanvugt@gmail.com>
---
drivers/hid/hid-magicmouse.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index f0fbd7b..12200e6 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -405,6 +405,8 @@ static void magicmouse_setup_input(struct input_dev
*input, struct hid_device *h
 			__set_bit(REL_HWHEEL, input->relbit);
 		}
 	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
+		__clear_bit(BTN_RIGHT, input->keybit);
+		__clear_bit(BTN_MIDDLE, input->keybit);
 		__set_bit(BTN_MOUSE, input->keybit);
 		__set_bit(BTN_TOOL_FINGER, input->keybit);
 		__set_bit(BTN_TOOL_DOUBLETAP, input->keybit);
