From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: BUG: hid-multitouch causes 10 second delay and error
Date: Tue, 1 Nov 2011 15:17:04 +0100
Message-ID: <20111101141704.GA2135@polaris.bitmath.org>
References: <20111026213705.GA32664@pequod.mess.org>
 <CAN+gG=E0sUd3WOzAuT1LOTz_U9jLrGg2Bq_jRjha8Dcptk6Zcw@mail.gmail.com>
 <4EA9466F.4000508@gmail.com>
 <20111028111605.GA23693@polaris.bitmath.org>
 <CAN+gG=EiJJR464q_eoJuJYpWOPMsk61W6sAKD18SdT+2tQfmQA@mail.gmail.com>
 <20111028140033.GA2155@polaris.bitmath.org>
 <alpine.LNX.2.00.1110281913010.3541@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:42673 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab1KAOHv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Nov 2011 10:07:51 -0400
Received: from iph1.telenor.se (iph1.telenor.se [195.54.127.132])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 4881CDA7B
	for <linux-input@vger.kernel.org>; Tue,  1 Nov 2011 15:07:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1110281913010.3541@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Sean Young <sean@mess.org>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>

>From bc81ba588149a0058ca083f673cb22ff543e5af8 Mon Sep 17 00:00:00 2001
From: Henrik Rydberg <rydberg@euromail.se>
Date: Tue, 1 Nov 2011 13:20:59 +0100
Subject: [PATCH 1/2] Revert "HID: multitouch: decide if hid-multitouch needs
 to handle mt devices"

This reverts commit 0db3bfc72adf0cb70f08dfe92e4040f64e25e205.

The generic detection of hid-mt devices has two major flaws, and was
merged prematurely. Firstly, the hid-multitouch gets loaded even when
the device is handled by a special device. Secondly, the patch only
partially duplicates the device whitelist already present in hid-core,
effectively rendering a number of devices non-functional.

Reported-by: Sean Young <sean@mess.org>
Tested-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
Hi Jiri,

Unfortunately, the recently discussed solution does not seem to work,
so there is only a revert for now.

I was planning to send a second patch, very small and concise, based
on Benjamins patch, but

1. It still does not resolve the
hid-multitouch-gets-loaded-for-every-hid-device problem, and

2. It did not work after removing the tested device from the hid core
whitelist; the device quirk seemed to get lost in the process.

In other words, there is currently no viable solution.

Thanks,
Henrik

 drivers/hid/hid-multitouch.c |   47 +++--------------------------------------
 1 files changed, 4 insertions(+), 43 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index fa5d7a1..f1c909f 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -291,7 +291,6 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			td->last_slot_field = usage->hid;
 			td->last_field_index = field->index;
 			td->last_mt_collection = usage->collection_index;
-			hdev->quirks &= ~HID_QUIRK_MULTITOUCH;
 			return 1;
 		case HID_DG_WIDTH:
 			hid_map_usage(hi, usage, bit, max,
@@ -530,44 +529,12 @@ static void mt_set_input_mode(struct hid_device *hdev)
 	}
 }
 
-/* a list of devices for which there is a specialized multitouch driver */
-static const struct hid_device_id mt_have_special_driver[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, 0x0001) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, 0x0006) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA,
-			USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA,
-			USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH) },
-	{ }
-};
-
-static bool mt_match_one_id(struct hid_device *hdev,
-		const struct hid_device_id *id)
-{
-	return id->bus == hdev->bus &&
-		(id->vendor == HID_ANY_ID || id->vendor == hdev->vendor) &&
-		(id->product == HID_ANY_ID || id->product == hdev->product);
-}
-
-static const struct hid_device_id *mt_match_id(struct hid_device *hdev,
-		const struct hid_device_id *id)
-{
-	for (; id->bus; id++)
-		if (mt_match_one_id(hdev, id))
-			return id;
-
-	return NULL;
-}
-
 static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret, i;
 	struct mt_device *td;
 	struct mt_class *mtclass = mt_classes; /* MT_CLS_DEFAULT */
 
-	if (mt_match_id(hdev, mt_have_special_driver))
-		return -ENODEV;
-
 	for (i = 0; mt_classes[i].name ; i++) {
 		if (id->driver_data == mt_classes[i].name) {
 			mtclass = &(mt_classes[i]);
@@ -575,6 +542,10 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 	}
 
+	/* This allows the driver to correctly support devices
+	 * that emit events over several HID messages.
+	 */
+	hdev->quirks |= HID_QUIRK_NO_INPUT_SYNC;
 
 	td = kzalloc(sizeof(struct mt_device), GFP_KERNEL);
 	if (!td) {
@@ -590,16 +561,10 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (ret != 0)
 		goto fail;
 
-	hdev->quirks |= HID_QUIRK_MULTITOUCH;
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret)
 		goto fail;
 
-	/* This allows the driver to correctly support devices
-	 * that emit events over several HID messages.
-	 */
-	hdev->quirks |= HID_QUIRK_NO_INPUT_SYNC;
-
 	td->slots = kzalloc(td->maxcontacts * sizeof(struct mt_slot),
 				GFP_KERNEL);
 	if (!td->slots) {
@@ -793,10 +758,6 @@ static const struct hid_device_id mt_devices[] = {
 		HID_USB_DEVICE(USB_VENDOR_ID_XAT,
 			USB_DEVICE_ID_XAT_CSR) },
 
-	/* Rest of the world */
-	{ .driver_data = MT_CLS_DEFAULT,
-		HID_USB_DEVICE(HID_ANY_ID, HID_ANY_ID) },
-
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, mt_devices);
-- 
1.7.7.1

