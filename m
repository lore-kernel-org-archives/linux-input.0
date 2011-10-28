From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: BUG: hid-multitouch causes 10 second delay and error
Date: Fri, 28 Oct 2011 13:16:05 +0200
Message-ID: <20111028111605.GA23693@polaris.bitmath.org>
References: <20111026213705.GA32664@pequod.mess.org>
 <CAN+gG=E0sUd3WOzAuT1LOTz_U9jLrGg2Bq_jRjha8Dcptk6Zcw@mail.gmail.com>
 <4EA9466F.4000508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:55519 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805Ab1J1LQG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Oct 2011 07:16:06 -0400
Received: from iph5.telenor.se (iph5.telenor.se [195.54.127.136])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 3FB79CF8A
	for <linux-input@vger.kernel.org>; Fri, 28 Oct 2011 13:16:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4EA9466F.4000508@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Sean Young <sean@mess.org>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>

Hi Benjamin,

> Hi Sean, can you test the following patch please:
> 
> 
> From 488272baf9bc95718dba2b9a0f62fe3309ca578f Mon Sep 17 00:00:00 2001
> From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> Date: Thu, 27 Oct 2011 13:36:05 +0200
> Subject: [PATCH 1/2] hid-multitouch: fix interaction with other hid drivers

I took this patch, fixed it up, applied it to jikos/multitouch, and
did a "git diff HEAD~3" to see the actual changes applied so far for
generic hid-mt support. That diff is quite small, so I would recommend
rewinding the tree once things settle down. I have commented on the
diff below, and at the end there are three alternative (untested)
patches, as a suggestion.

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 956f849..78253ae 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1212,6 +1212,11 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 	if ((connect_mask & HID_CONNECT_HIDINPUT) && !hidinput_connect(hdev,
 				connect_mask & HID_CONNECT_HIDINPUT_FORCE))
 		hdev->claimed |= HID_CLAIMED_INPUT;
+	if (hdev->quirks & HID_QUIRK_MULTITOUCH) {
+		/* this device should be handled by hid-multitouch, skip it */
+		return -ENODEV;
+	}
+
 	if ((connect_mask & HID_CONNECT_HIDDEV) && hdev->hiddev_connect &&
 			!hdev->hiddev_connect(hdev,
 				connect_mask & HID_CONNECT_HIDDEV_FORCE))

The regret here is that hid-core needs to know about hit-mt at
all. What it needs to know is whether the device should be dropped.

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 6559e2e..f333139 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -474,6 +474,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			map_key_clear(BTN_STYLUS2);
 			break;
 
+		case 0x51: /* ContactID */
+			device->quirks |= HID_QUIRK_MULTITOUCH;
+			goto unknown;
+
 		default:  goto unknown;
 		}
 		break;

So in addition to the detection here,
 
@@ -978,6 +982,13 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 		}
 	}
 
+	if (hid->quirks & HID_QUIRK_MULTITOUCH) {
+		/* generic hid does not know how to handle multitouch devices */
+		if (hidinput)
+			goto out_cleanup;
+		goto out_unwind;
+	}
+
 	if (hidinput && input_register_device(hidinput->input))
 		goto out_cleanup;

One could instead drop handling based on a quirk designed for that
purpose (HID_QUIRK_HIDINPUT_DROP).

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index f1c909f..28f8ff2 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -291,6 +291,7 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			td->last_slot_field = usage->hid;
 			td->last_field_index = field->index;
 			td->last_mt_collection = usage->collection_index;
+			hdev->quirks &= ~HID_QUIRK_MULTITOUCH;
 			return 1;
 		case HID_DG_WIDTH:
 			hid_map_usage(hi, usage, bit, max,

Although correct per se, it is clearer to reset this flag in mt_probe().

@@ -535,6 +536,12 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct mt_device *td;
 	struct mt_class *mtclass = mt_classes; /* MT_CLS_DEFAULT */
 
+	if (!id->driver_data && !(hdev->quirks & HID_QUIRK_MULTITOUCH))
+		/* cought by HID_USB_DEVICE(HID_ANY_ID, HID_ANY_ID),
+		 * and either in hid_have_special_driver
+		 * or not detected as multitouch by hid-core */
+		return -ENODEV;
+
 	for (i = 0; mt_classes[i].name ; i++) {
 		if (id->driver_data == mt_classes[i].name) {
 			mtclass = &(mt_classes[i]);

Very neat solution indeed!

@@ -542,10 +549,6 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 	}
 
-	/* This allows the driver to correctly support devices
-	 * that emit events over several HID messages.
-	 */
-	hdev->quirks |= HID_QUIRK_NO_INPUT_SYNC;
 
 	td = kzalloc(sizeof(struct mt_device), GFP_KERNEL);
 	if (!td) {

It seems there is no longer any reason to move this line around, since
we now only come here when the device is really meant for this driver.

@@ -561,10 +564,16 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (ret != 0)
 		goto fail;
 
+	hdev->quirks |= HID_QUIRK_MULTITOUCH;

This is unnecessary and makes the logic blurred.

 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret)
 		goto fail;
 
+	/* This allows the driver to correctly support devices
+	 * that emit events over several HID messages.
+	 */
+	hdev->quirks |= HID_QUIRK_NO_INPUT_SYNC;
+
 	td->slots = kzalloc(td->maxcontacts * sizeof(struct mt_slot),
 				GFP_KERNEL);
 	if (!td->slots) {

In addition to not needing to be moved, this line introduces a race
with hid-input, since the device has already started when this line is
executed.

@@ -758,6 +767,9 @@ static const struct hid_device_id mt_devices[] = {
 		HID_USB_DEVICE(USB_VENDOR_ID_XAT,
 			USB_DEVICE_ID_XAT_CSR) },
 
+	/* Rest of the world */
+	{ HID_USB_DEVICE(HID_ANY_ID, HID_ANY_ID) },
+
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, mt_devices);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 9cf8e7a..6fb743d 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -312,6 +312,7 @@ struct hid_item {
 #define HID_QUIRK_BADPAD			0x00000020
 #define HID_QUIRK_MULTI_INPUT			0x00000040
 #define HID_QUIRK_HIDINPUT_FORCE		0x00000080
+#define HID_QUIRK_MULTITOUCH			0x00000100
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		0x00010000
 #define HID_QUIRK_FULLSPEED_INTERVAL		0x10000000
 #define HID_QUIRK_NO_INIT_REPORTS		0x20000000

As an alternative, here are three untested and uncommited patches
which implements the comments above.

Cheers,
Henrik

--

>From defdac444919b99a932368ee1a8ad290dc724933 Mon Sep 17 00:00:00 2001
From: Henrik Rydberg <rydberg@euromail.se>
Date: Fri, 28 Oct 2011 11:36:36 +0200
Subject: [PATCH 1/3] hid: Allow an input device to be dropped after parsing

Some devices need a special driver based on the input mapping of the
device. This patch enables a mechanism where hidinput can set
HID_QUIRK_HIDINPUT_DROP to leave a device to be picked up by a special
driver which intercepts the input mapping.
---
 drivers/hid/hid-core.c  |    3 +++
 drivers/hid/hid-input.c |    6 ++++++
 include/linux/hid.h     |    1 +
 3 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 956f849..2628f9c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1212,6 +1212,9 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 	if ((connect_mask & HID_CONNECT_HIDINPUT) && !hidinput_connect(hdev,
 				connect_mask & HID_CONNECT_HIDINPUT_FORCE))
 		hdev->claimed |= HID_CLAIMED_INPUT;
+	if (hdev->quirks & HID_QUIRK_HIDINPUT_DROP)
+		return -ENODEV;
+
 	if ((connect_mask & HID_CONNECT_HIDDEV) && hdev->hiddev_connect &&
 			!hdev->hiddev_connect(hdev,
 				connect_mask & HID_CONNECT_HIDDEV_FORCE))
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 6559e2e..aa3ce2e 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -978,6 +978,12 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 		}
 	}
 
+	if (hid->quirks & HID_QUIRK_HIDINPUT_DROP) {
+		if (hidinput)
+			goto out_cleanup;
+		goto out_unwind;
+	}
+
 	if (hidinput && input_register_device(hidinput->input))
 		goto out_cleanup;
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 9cf8e7a..4028a27 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -312,6 +312,7 @@ struct hid_item {
 #define HID_QUIRK_BADPAD			0x00000020
 #define HID_QUIRK_MULTI_INPUT			0x00000040
 #define HID_QUIRK_HIDINPUT_FORCE		0x00000080
+#define HID_QUIRK_HIDINPUT_DROP			0x00000100
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		0x00010000
 #define HID_QUIRK_FULLSPEED_INTERVAL		0x10000000
 #define HID_QUIRK_NO_INIT_REPORTS		0x20000000
-- 
1.7.7

>From 5f4fe6ef4cab9721c6b277f57d5374d6b549359d Mon Sep 17 00:00:00 2001
From: Henrik Rydberg <rydberg@euromail.se>
Date: Fri, 28 Oct 2011 11:42:39 +0200
Subject: [PATCH 2/3] hid-input: Drop generic handling of hid-mt multitouch
 devices

The hid-mt devices are recognized by the ContactID field. This patch
sets HID_QUIRK_MULTITOUCH accordingly, and leaves the device to be
picked up by any driver which intercepts the ContactID field.

All in-tree hid-mt drivers intercept the ContactID, so this patch has
no other effect than to skip generic handling of hid-mt devices.
---
 drivers/hid/hid-input.c |    6 ++++++
 include/linux/hid.h     |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index aa3ce2e..108830fc 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -474,6 +474,12 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			map_key_clear(BTN_STYLUS2);
 			break;
 
+		case 0x51: /* ContactID */
+			device->quirks |= HID_QUIRK_MULTITOUCH;
+			/* hid-mt is not handled by generic hid */
+			device->quirks |= HID_QUIRK_HIDINPUT_DROP;
+			goto unknown;
+
 		default:  goto unknown;
 		}
 		break;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 4028a27..b9c4296 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -313,6 +313,7 @@ struct hid_item {
 #define HID_QUIRK_MULTI_INPUT			0x00000040
 #define HID_QUIRK_HIDINPUT_FORCE		0x00000080
 #define HID_QUIRK_HIDINPUT_DROP			0x00000100
+#define HID_QUIRK_MULTITOUCH			0x00000200
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		0x00010000
 #define HID_QUIRK_FULLSPEED_INTERVAL		0x10000000
 #define HID_QUIRK_NO_INIT_REPORTS		0x20000000
-- 
1.7.7

>From 6b1ecc88b3f5cca7c9178e3900c6766544db0798 Mon Sep 17 00:00:00 2001
From: Henrik Rydberg <rydberg@euromail.se>
Date: Fri, 28 Oct 2011 12:01:08 +0200
Subject: [PATCH 3/3] hid-multitouch: Pick up all hid-mt devices

This patch adds a catch-all device entry, which "undrops" all devices
that have been identified as hid-mt by the hid core.
---
 drivers/hid/hid-multitouch.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index f1c909f..1f051eb 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -535,6 +535,15 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct mt_device *td;
 	struct mt_class *mtclass = mt_classes; /* MT_CLS_DEFAULT */
 
+	if (!id->driver_data && !(hdev->quirks & HID_QUIRK_MULTITOUCH))
+		/* cought by HID_USB_DEVICE(HID_ANY_ID, HID_ANY_ID),
+		 * and either in hid_have_special_driver
+		 * or not detected as multitouch by hid-core */
+		return -ENODEV;
+
+	/* pick up the device that was dropped by hid-core */
+	hdev->quirks &= ~HID_QUIRK_HIDINPUT_DROP;
+
 	for (i = 0; mt_classes[i].name ; i++) {
 		if (id->driver_data == mt_classes[i].name) {
 			mtclass = &(mt_classes[i]);
@@ -758,6 +767,9 @@ static const struct hid_device_id mt_devices[] = {
 		HID_USB_DEVICE(USB_VENDOR_ID_XAT,
 			USB_DEVICE_ID_XAT_CSR) },
 
+	/* Rest of the world */
+	{ HID_USB_DEVICE(HID_ANY_ID, HID_ANY_ID) },
+
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, mt_devices);
-- 
1.7.7

