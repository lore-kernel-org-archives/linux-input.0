From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: [PATCH v2 2/2] Input: uinput: Sanity check on ff_effects_max and EV_FF
Date: Sun,  8 Nov 2015 18:37:34 +0100
Message-ID: <1447004254-12431-1-git-send-email-elias.vds@gmail.com>
References: <1442510988-3164-3-git-send-email-elias.vds@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36439 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbbKHRi1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Nov 2015 12:38:27 -0500
In-Reply-To: <1442510988-3164-3-git-send-email-elias.vds@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Elias Vanderstuyft <elias.vds@gmail.com>

Currently the user can set ff_effects_max to zero with the EV_FF bit
(and the FF_GAIN and/or FF_AUTOCENTER bits) set,
in this case the uninitialized methods
ff->set_gain and/or ff->set_autocenter can be dereferenced,
resulting in a kernel oops.

Check in uinput_create_device() and
print a helpful message and return -EINVAL in case the check fails.

Signed-off-by: Elias Vanderstuyft <elias.vds@gmail.com>
---
Changes in v2:
  - Rebase on pending patches from David Herrmann and Benjamin Tissoires:
    - v3 Input: uinput - add new UINPUT_DEV_SETUP and UI_ABS_SETUP ioctl
    - Input: uinput - rework ABS validation
  - Don't require EV_FF bit to be set when ff_effects_max is non-zero
  - Move check from uinput_setup_device() to uinput_create_device()
  - Update commit description

At the same time, the new UINPUT_DEV_SETUP and UI_ABS_SETUP ioctls were
tested as well (in both orders).
The legacy write() (instead of UINPUT_DEV_SETUP) was also tested.

 drivers/input/misc/uinput.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 1d93037..b9d0713 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -272,6 +272,13 @@ static int uinput_create_device(struct uinput_device *udev)
 		input_set_events_per_packet(dev, 60);
 	}
 
+	if (test_bit(EV_FF, dev->evbit) && !udev->ff_effects_max) {
+		printk(KERN_DEBUG "%s: ff_effects_max should be non-zero when FF_BIT is set\n",
+			UINPUT_NAME);
+		error = -EINVAL;
+		goto fail1;
+	}
+
 	if (udev->ff_effects_max) {
 		error = input_ff_create(dev, udev->ff_effects_max);
 		if (error)
-- 
1.9.3

