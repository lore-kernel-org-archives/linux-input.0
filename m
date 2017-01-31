From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: uinput - fix crash when mixing old and new init style
Date: Tue, 31 Jan 2017 15:17:28 -0800
Message-ID: <20170131231728.GA37933@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35265 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdAaXRb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Jan 2017 18:17:31 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>, linux-kernel@vger.kernel.org

If user tries to initialize uinput device mixing old and new style
initialization (i.e. using old UI_SET_ABSBIT instead of UI_ABS_SETUP,
we forget to allocate input->absinfo and will crash when trying to send
absolute events:

        ioctl(ui, UI_DEV_SETUP, &us);
        ioctl(ui, UI_SET_EVBIT, EV_ABS);
        ioctl(ui, UI_SET_ABSBIT, ABS_X);
        ioctl(ui, UI_SET_ABSBIT, ABS_Y);
        ioctl(ui, UI_DEV_CREATE, 0);

Reported-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=191811
Fixes: fbae10db0940 ("Input: uinput - rework ABS validation")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/uinput.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 92595b98e7ed..022be0e22eba 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -263,13 +263,21 @@ static int uinput_create_device(struct uinput_device *udev)
 		return -EINVAL;
 	}
 
-	if (test_bit(ABS_MT_SLOT, dev->absbit)) {
-		nslot = input_abs_get_max(dev, ABS_MT_SLOT) + 1;
-		error = input_mt_init_slots(dev, nslot, 0);
-		if (error)
+	if (test_bit(EV_ABS, dev->evbit)) {
+		input_alloc_absinfo(dev);
+		if (!dev->absinfo) {
+			error = -EINVAL;
 			goto fail1;
-	} else if (test_bit(ABS_MT_POSITION_X, dev->absbit)) {
-		input_set_events_per_packet(dev, 60);
+		}
+
+		if (test_bit(ABS_MT_SLOT, dev->absbit)) {
+			nslot = input_abs_get_max(dev, ABS_MT_SLOT) + 1;
+			error = input_mt_init_slots(dev, nslot, 0);
+			if (error)
+				goto fail1;
+		} else if (test_bit(ABS_MT_POSITION_X, dev->absbit)) {
+			input_set_events_per_packet(dev, 60);
+		}
 	}
 
 	if (test_bit(EV_FF, dev->evbit) && !udev->ff_effects_max) {
-- 
2.11.0.483.g087da7b7c-goog

-- 
Dmitry
