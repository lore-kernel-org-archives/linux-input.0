From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: keyboard not working with Thinkpad Helix (2nd gen)
Date: Tue, 28 Apr 2015 16:40:02 -0400
Message-ID: <553FF022.6050708@gmail.com>
References: <CAJXMp+qGdtEh59U33FKx+7CSyKbARRbAs30u8=fFR1c492eK4A@mail.gmail.com>	<CAN+gG=G8NboNgBQDTRZoUWaq0=+PqQaFiYFg6Jm_DYgpHStYQA@mail.gmail.com>	<CAJXMp+rzgaYA=nJ_Vrhg8FbUJ2-nEdmyoKg=X6fF+uXYBLCr0g@mail.gmail.com> <CAN+gG=GKJr4t_iFkuR68mA4_wz2xRZ=gsmJt=RkT-+9LGD+czw@mail.gmail.com> <553FCA5C.8060808@gmail.com> <553FD5A1.6040206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vn0-f48.google.com ([209.85.216.48]:39499 "EHLO
	mail-vn0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965358AbbD1UkF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Apr 2015 16:40:05 -0400
Received: by vnbg62 with SMTP id g62so977731vnb.6
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2015 13:40:04 -0700 (PDT)
In-Reply-To: <553FD5A1.6040206@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Reid <owlman.lists@gmail.com>, jono <lejono@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Hi,

On 04/28/2015 02:46 PM, John Reid wrote:
> Hi all,
> 
> To me the following page in the keyboard interface 0 descriptor (from
> "sudo usbhid-dump -a1:8 -i0| grep -v : | xxd -r -p | hidrd-convert -o")
> seems suspicious. I'm guessing Logical Maximum should not be -1 if
> Logical Minimum is 0, and a Usage Maximum of FFFFh might break
> include/linux/hid.h #define HID_MAX_USAGES    12288

Yep, that's what prevents the hid subsystem to handle the keyboard
(though the logical min has nothing to do here).
Below is a patch that fixes the report descriptor and will hopefully
make the keyboard working.
Can you apply it on top of Jiri's tree? (or you might want to cherry
pick https://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/commit/?h=for-4.2/lenovo&id=d92189ebbdcd0eb180317d8cd6d46c57ac9a3dc0
on top of a clean v4.0)

And then, tell us if hid-lenovo handles the keyboard?

> 
> Usage Page (88h),                   ; 88h, reserved
> Usage (01h),
> Collection (Application),
>      Report ID (4),
>      Usage Minimum (00h),
>      Usage Maximum (FFFFh),
>      Logical Minimum (0),
>      Logical Maximum (-1),
>      Report Size (8),
>      Report Count (2),
>      Input (Variable),
> End Collection,
> 
> Cheers,
> John
> 

FWIW, I'll track down the other problems in the other threads.

Cheers,
Benjamin


>From abc7922e4972910a31eb54c673bc3b261fd919f7 Mon Sep 17 00:00:00 2001
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 28 Apr 2015 16:31:56 -0400
Subject: [PATCH] HID: lenovo: add support for Lenovo ThinkPad Keyboard Pro
 unit

This dock is used with the Thinkpad Helix 2 but suffers from an error
in the report descriptor where an usage max is 65535.

Add a report fixup for it and make the keyboard working.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c   |  1 +
 drivers/hid/hid-ids.h    |  1 +
 drivers/hid/hid-lenovo.c | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 722a925..c2baf8c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1851,6 +1851,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPKBD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CUSBKBD) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CBTKBD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPPRODOCK) },
 #endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_S510_RECEIVER) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b24caf8..e5b86e0 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -585,6 +585,7 @@
 #define USB_DEVICE_ID_LENOVO_TPKBD	0x6009
 #define USB_DEVICE_ID_LENOVO_CUSBKBD	0x6047
 #define USB_DEVICE_ID_LENOVO_CBTKBD	0x6048
+#define USB_DEVICE_ID_LENOVO_TPPRODOCK	0x6067
 
 #define USB_VENDOR_ID_LG		0x1fd2
 #define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 78608d6..c6c81ff 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -43,6 +43,36 @@ struct lenovo_drvdata_cptkbd {
 
 #define map_key_clear(c) hid_map_usage_clear(hi, usage, bit, max, EV_KEY, (c))
 
+static const __u8 lenovo_pro_dock_need_fixup_collection[] = {
+	0x05, 0x88,		/* Usage Page (Vendor Usage Page 0x88)	*/
+	0x09, 0x01,		/* Usage (Vendor Usage 0x01)		*/
+	0xa1, 0x01,		/* Collection (Application)		*/
+	0x85, 0x04,		/*  Report ID (4)			*/
+	0x19, 0x00,		/*  Usage Minimum (0)			*/
+	0x2a, 0xff, 0xff,	/*  Usage Maximum (65535)		*/
+};
+
+static __u8 *lenovo_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+		unsigned int *rsize)
+{
+	switch (hdev->product) {
+	case USB_DEVICE_ID_LENOVO_TPPRODOCK:
+		/* the fixups that need to be done:
+		 *   - get a reasonable usage max for the vendor collection
+		 *     0x8801 from the report ID 4
+		 */
+		pr_err("%s %14ph %s:%d\n", __func__, &rdesc[140], __FILE__, __LINE__);
+		if (*rsize >= 153 &&
+		    memcmp(&rdesc[140], lenovo_pro_dock_need_fixup_collection,
+			  sizeof(lenovo_pro_dock_need_fixup_collection)) == 0) {
+			rdesc[151] = 0x01;
+			rdesc[152] = 0x00;
+		}
+		break;
+	}
+	return rdesc;
+}
+
 static int lenovo_input_mapping_tpkbd(struct hid_device *hdev,
 		struct hid_input *hi, struct hid_field *field,
 		struct hid_usage *usage, unsigned long **bit, int *max)
@@ -784,6 +814,7 @@ static const struct hid_device_id lenovo_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPKBD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CUSBKBD) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CBTKBD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPPRODOCK) },
 	{ }
 };
 
@@ -797,6 +828,7 @@ static struct hid_driver lenovo_driver = {
 	.probe = lenovo_probe,
 	.remove = lenovo_remove,
 	.raw_event = lenovo_raw_event,
+	.report_fixup = lenovo_report_fixup,
 };
 module_hid_driver(lenovo_driver);
 
-- 
2.3.5
