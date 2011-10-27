From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: BUG: hid-multitouch causes 10 second delay and error
Date: Thu, 27 Oct 2011 13:54:23 +0200
Message-ID: <4EA9466F.4000508@gmail.com>
References: <20111026213705.GA32664@pequod.mess.org> <CAN+gG=E0sUd3WOzAuT1LOTz_U9jLrGg2Bq_jRjha8Dcptk6Zcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57994 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294Ab1J0Ly2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Oct 2011 07:54:28 -0400
Received: by gyb13 with SMTP id 13so2526931gyb.19
        for <linux-input@vger.kernel.org>; Thu, 27 Oct 2011 04:54:28 -0700 (PDT)
In-Reply-To: <CAN+gG=E0sUd3WOzAuT1LOTz_U9jLrGg2Bq_jRjha8Dcptk6Zcw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-1?Q?St=E9phane_?= =?ISO-8859-1?Q?Chatty?= <chatty@enac.fr>, Henrik Rydberg <rydberg@bitmath.org>

On 10/27/2011 11:25 AM, Benjamin Tissoires wrote:
> Hi Sean,
>
>
> On Wed, Oct 26, 2011 at 23:37, Sean Young<sean@mess.org>  wrote:
>> Since this commit:
>>
>>         commit 0db3bfc72adf0cb70f08dfe92e4040f64e25e205
>>
>>         HID: multitouch: decide if hid-multitouch needs to handle mt devices
>>
>> I get the following when I insert a smartjoy device (hid-sjoy driver):
>>
>> [ 3727.405037] usb 7-1: new low speed USB device number 2 using uhci_hcd
>> [ 3727.709082] usb 7-1: New USB device found, idVendor=6666, idProduct=8802
>> [ 3727.709087] usb 7-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>> [ 3727.709092] usb 7-1: Product: TigerGame PS/PS2 Game Controller Adapter
>> [ 3727.709095] usb 7-1: Manufacturer: WiseGroup.,Ltd
>> [ 3738.002095] hid-multitouch 0003:6666:8802.0005: timeout initializing reports
>> [ 3738.007861] input: WiseGroup.,Ltd TigerGame PS/PS2 Game Controller Adapter as /devices/pci0000:00/0000:00:1d.1/usb7/7-1/7-1:1.0/input/input17
>> [ 3738.008137] smartjoyplus 0003:6666:8802.0005: input,hidraw4: USB HID v1.00 Joystick [WiseGroup.,Ltd TigerGame PS/PS2 Game Controller Adapter] on usb-0000:00:1d.1-1/input0
>> [ 3738.008163] smartjoyplus 0003:6666:8802.0005: Force feedback for SmartJoy PLUS PS2/USB adapter
>>
>> Note the 10 second delay caused by the hid-multitouch error.
>
> Thanks for this bug report. It's great that this bug that concerns
> only 9 devices has been reported.
> To sum up, I'll have to redo my patch.
>
>>
>> If I understand it correctly, the problem is that hid-multitouch now has
>> a catch-all usb-id field, and does a usbhid_init_reports() on the device
>> without the quirk HID_QUIRK_NOGET.
>
> yep
>
>>
>> The HID_QUIRK_NOGET for this device is listed in the hid-sjoy.c driver itself
>> rather than in hid-quirks.c; presumably the latter is handled correctly.
>
> It should work, but this patch was a little bit too invasive.
>
>>
>> Is there a different way of handling this rather than hid-multitouch
>> messing with every usb device which identifies itself as hid? Alternatively,
>> should all quirks for all devices be specified in hid-quirks.c and not in
>> individual drivers?
>>
>>
>
> I'm working on a better solution than this patch (I've just found it
> but I need some time to format and send it...)
>
> Cheers,
> Benjamin
>
>> Sean
>>

Hi Sean, can you test the following patch please:


 From 488272baf9bc95718dba2b9a0f62fe3309ca578f Mon Sep 17 00:00:00 2001
From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Date: Thu, 27 Oct 2011 13:36:05 +0200
Subject: [PATCH 1/2] hid-multitouch: fix interaction with other hid drivers

The commit 0db3bfc72adf0cb70f08dfe92e4040f64e25e205
(HID: multitouch: decide if hid-multitouch needs to handle mt devices)
was too invasive in its relationship with other drivers.
For instance, hid-sjoy specify the quirk HID_QUIRK_NOGET
and hid-multitouch ignores it, thus adding a 10 seconds wait.

This patch allows hid-multitouch to infer how the device landed here:
* if it was manually added to the supported devices of hid-multitouch
and in hid_have_special_driver in hid-core, then it has to be taken.
* if it was rejected by hid-core due to the VID/PID in
hid_have_special_driver and is not present in the manual list,
then another driver will take care of it.
* if it was rejected by hid-core due to the presence of the CONTACT_ID
hid field, then no other driver will handle it, and hid-multitouch
can safely handle it.

The mt_have_special_driver list is also obsolete now.

Reported-by: Sean Young <sean@mess.org>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
  drivers/hid/hid-core.c       |    1 -
  drivers/hid/hid-multitouch.c |   35 +++++------------------------------
  2 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 2572db9..09e3d9b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1230,7 +1230,6 @@ int hid_connect(struct hid_device *hdev, unsigned 
int connect_mask)
  		hdev->claimed |= HID_CLAIMED_INPUT;
  	if (hdev->quirks & HID_QUIRK_MULTITOUCH) {
  		/* this device should be handled by hid-multitouch, skip it */
-		hdev->quirks &= ~HID_QUIRK_MULTITOUCH;
  		return -ENODEV;
  	}

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index fa5d7a1..0cc3cea 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -530,33 +530,6 @@ static void mt_set_input_mode(struct hid_device *hdev)
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
  }

  static int mt_probe(struct hid_device *hdev, const struct 
hid_device_id *id)
@@ -565,7 +538,10 @@ static int mt_probe(struct hid_device *hdev, const 
struct hid_device_id *id)
  	struct mt_device *td;
  	struct mt_class *mtclass = mt_classes; /* MT_CLS_DEFAULT */

-	if (mt_match_id(hdev, mt_have_special_driver))
+	if (!id->driver_data && !(hdev->quirks & HID_QUIRK_MULTITOUCH))
+		/* cought by HID_USB_DEVICE(HID_ANY_ID, HID_ANY_ID),
+		 * and either in hid_have_special_driver
+		 * or not detected as multitouch by hid-core */
  		return -ENODEV;

  	for (i = 0; mt_classes[i].name ; i++) {
@@ -794,8 +770,7 @@ static const struct hid_device_id mt_devices[] = {
  			USB_DEVICE_ID_XAT_CSR) },

  	/* Rest of the world */
-	{ .driver_data = MT_CLS_DEFAULT,
-		HID_USB_DEVICE(HID_ANY_ID, HID_ANY_ID) },
+	{ HID_USB_DEVICE(HID_ANY_ID, HID_ANY_ID) },

  	{ }
  };
-- 
1.7.4.4

Cheers,
Benjamin
