From: Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 1/2] input/joydev: Don't classify the vmmouse as a joystick
Date: Tue, 19 May 2015 04:37:04 -0700
Message-ID: <1432035425-45514-2-git-send-email-thellstrom@vmware.com>
References: <1432035425-45514-1-git-send-email-thellstrom@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:38330 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754572AbbESLhT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2015 07:37:19 -0400
In-Reply-To: <1432035425-45514-1-git-send-email-thellstrom@vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com, Thomas Hellstrom <thellstrom@vmware.com>

Joydev is currently thinking some absolute mice are joystick, and that
messes up games in VMware guests, as the cursor typically gets stuck in
the top left corner.

Try to detect the event signature of a VMmouse input device and back off
for such devices. We're still incorrectly detecting, for example, the
VMware absolute USB mouse as a joystick, but adding an event signature
matching also that device would be considerably more risky, so defer that
to a later merge window.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 drivers/input/joydev.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index f362883..1ad2fb1 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -747,6 +747,42 @@ static void joydev_cleanup(struct joydev *joydev)
 		input_close_device(handle);
 }
 
+static bool joydev_dev_is_mouse(struct input_dev *dev)
+{
+	DECLARE_BITMAP(jd_scratch, KEY_CNT);
+
+	BUILD_BUG_ON(ABS_CNT > KEY_CNT || EV_CNT > KEY_CNT);
+
+	/*
+	 * A device is, for joystick detection purposes, considered to be
+	 * a mouse if the following is true. (This is currently tailored to
+	 * the VMware PS/2 VMMouse device but might be extended).
+	 *
+	 * 1) Absolute events are exactly ABS_X and ABS_Y.
+	 * 2) Keys are exactly BTN_LEFT, BTN_RIGHT and BTN_MIDDLE.
+	 * 3) Event types include EV_ABS, EV_KEY and possibly EV_SYN.
+	 */
+
+	bitmap_zero(jd_scratch, EV_CNT);
+	jd_scratch[BIT_WORD(EV_ABS)] = BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
+	if (!bitmap_subset(jd_scratch, dev->evbit, EV_CNT))
+		return false;
+
+	__set_bit(EV_SYN, jd_scratch);
+	if (!bitmap_subset(dev->evbit, jd_scratch, EV_CNT))
+		return false;
+
+	bitmap_zero(jd_scratch, ABS_CNT);
+	jd_scratch[BIT_WORD(ABS_X)] = BIT_MASK(ABS_X) | BIT_MASK(ABS_Y);
+	if (!bitmap_equal(dev->absbit, jd_scratch, ABS_CNT))
+		return false;
+
+	bitmap_zero(jd_scratch, KEY_CNT);
+	jd_scratch[BIT_WORD(BTN_LEFT)] = BIT_MASK(BTN_LEFT) |
+		BIT_MASK(BTN_RIGHT) | BIT_MASK(BTN_MIDDLE);
+
+	return bitmap_equal(dev->keybit, jd_scratch, KEY_CNT);
+}
 
 static bool joydev_match(struct input_handler *handler, struct input_dev *dev)
 {
@@ -758,6 +794,10 @@ static bool joydev_match(struct input_handler *handler, struct input_dev *dev)
 	if (test_bit(EV_KEY, dev->evbit) && test_bit(BTN_DIGI, dev->keybit))
 		return false;
 
+	/* Avoid absolute mice */
+	if (joydev_dev_is_mouse(dev))
+		return false;
+
 	return true;
 }
 
-- 
2.1.0

