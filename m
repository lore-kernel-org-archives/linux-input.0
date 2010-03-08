From: Benjamin Tissoires <tissoire@cena.fr>
Subject: Re: [PATCH 3/3] HID: deletion of unused code in hid-magicmouse.
Date: Mon, 08 Mar 2010 17:57:27 +0100
Message-ID: <4B952C77.3080505@cena.fr>
References: <1268065277-30129-1-git-send-email-tissoire@cena.fr> <1268065277-30129-2-git-send-email-tissoire@cena.fr> <1268065277-30129-3-git-send-email-tissoire@cena.fr> <1268065277-30129-4-git-send-email-tissoire@cena.fr> <1268065277-30129-5-git-send-email-tissoire@cena.fr> <4B95255B.5010900@cena.fr> <alpine.LNX.2.00.1003081730170.17799@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080906080602050007090105"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fw.tls.cena.fr ([195.83.98.200]:47536 "EHLO
	mailhost.tls.cena.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab0CHQ5a (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Mar 2010 11:57:30 -0500
In-Reply-To: <alpine.LNX.2.00.1003081730170.17799@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Poole <mdpoole@troilus.org>, linux-input@vger.kernel.org, Stephane Chatty <chatty@enac.fr>

This is a multi-part message in MIME format.
--------------080906080602050007090105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

>
> Well ... I don't see any patch titled "HID: deletion of unused code in
> hid-magicmouse" neither in my inbox nor in my linux-input@ folder. Could
> you perhaps please resend?
>
> Thanks,
>

Of course, I attached it. Do I need to send it in mbox format or is it ok ?

Cheers,
Benjamin

--------------080906080602050007090105
Content-Type: text/x-patch;
 name="0003-HID-deletion-of-unused-code-in-hid-magicmouse.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0003-HID-deletion-of-unused-code-in-hid-magicmouse.patch"

>From cfc6bae70e1531ef059d254ac4b91188bbc6c5c9 Mon Sep 17 00:00:00 2001
From: Benjamin Tissoires <tissoire@cena.fr>
Date: Mon, 8 Mar 2010 12:12:58 +0100
Subject: [PATCH 3/3] HID: deletion of unused code in hid-magicmouse.

This code, related to the second input device, is unnecessary as it concerns
the old implementation and is not used anymore.

Signed-off-by: Benjamin Tissoires <tissoire@cena.fr>
---
 drivers/hid/hid-magicmouse.c |   68 ------------------------------------------
 1 files changed, 0 insertions(+), 68 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 32d90c8..b9d605e 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -262,74 +262,6 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 	return 1;
 }
 
-static int magicmouse_input_open(struct input_dev *dev)
-{
-	struct hid_device *hid = input_get_drvdata(dev);
-
-	return hid->ll_driver->open(hid);
-}
-
-static void magicmouse_input_close(struct input_dev *dev)
-{
-	struct hid_device *hid = input_get_drvdata(dev);
-
-	hid->ll_driver->close(hid);
-}
-
-static void magicmouse_setup_input(struct input_dev *input, struct hid_device *hdev)
-{
-	input_set_drvdata(input, hdev);
-	input->event = hdev->ll_driver->hidinput_input_event;
-	input->open = magicmouse_input_open;
-	input->close = magicmouse_input_close;
-
-	input->name = hdev->name;
-	input->phys = hdev->phys;
-	input->uniq = hdev->uniq;
-	input->id.bustype = hdev->bus;
-	input->id.vendor = hdev->vendor;
-	input->id.product = hdev->product;
-	input->id.version = hdev->version;
-	input->dev.parent = hdev->dev.parent;
-
-	__set_bit(EV_KEY, input->evbit);
-	__set_bit(BTN_LEFT, input->keybit);
-	__set_bit(BTN_RIGHT, input->keybit);
-	if (emulate_3button)
-		__set_bit(BTN_MIDDLE, input->keybit);
-	__set_bit(BTN_TOOL_FINGER, input->keybit);
-
-	__set_bit(EV_REL, input->evbit);
-	__set_bit(REL_X, input->relbit);
-	__set_bit(REL_Y, input->relbit);
-	if (emulate_scroll_wheel)
-		__set_bit(REL_WHEEL, input->relbit);
-
-	if (report_touches) {
-		__set_bit(EV_ABS, input->evbit);
-
-		input_set_abs_params(input, ABS_MT_TRACKING_ID, 0, 15, 0, 0);
-		input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 255, 4, 0);
-		input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 255, 4, 0);
-		input_set_abs_params(input, ABS_MT_ORIENTATION, -32, 31, 1, 0);
-		input_set_abs_params(input, ABS_MT_POSITION_X, -1100, 1358,
-				4, 0);
-		/* Note: Touch Y position from the device is inverted relative
-		 * to how pointer motion is reported (and relative to how USB
-		 * HID recommends the coordinates work).  This driver keeps
-		 * the origin at the same position, and just uses the additive
-		 * inverse of the reported Y.
-		 */
-		input_set_abs_params(input, ABS_MT_POSITION_Y, -1589, 2047,
-				4, 0);
-	}
-
-	if (report_undeciphered) {
-		__set_bit(EV_MSC, input->evbit);
-		__set_bit(MSC_RAW, input->mscbit);
-	}
-}
-
 static int magicmouse_input_mapping(struct hid_device *hdev, struct hid_input *hinput,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
-- 
1.6.6.1


--------------080906080602050007090105--
