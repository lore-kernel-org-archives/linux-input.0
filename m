From: "DusonLin" <dusonlin@emc.com.tw>
Subject: RE: [PATCH] Input: elan_i2c - enable ELAN0100 acpi panels
Date: Sat, 22 Aug 2015 15:28:19 +0800
Message-ID: <005d01d0dcac$222f3870$668da950$@emc.com.tw>
References: <1440226737-832-1-git-send-email-michele.curti@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:23399 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbbHVH2n (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Aug 2015 03:28:43 -0400
In-Reply-To: <1440226737-832-1-git-send-email-michele.curti@gmail.com>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Michele Curti' <michele.curti@gmail.com>, jikos@kernel.org, dmitry.torokhov@gmail.com
Cc: bleung@chromium.org, k.kozlowski@samsung.com, charliemooney@chromium.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Michele,

The vaildpage_count for type 0x08 should be 512, not 768.

Thanks
Duson

-----Original Message-----
From: Michele Curti [mailto:michele.curti@gmail.com] 
Sent: Saturday, August 22, 2015 2:59 PM
To: jikos@kernel.org; dmitry.torokhov@gmail.com; dusonlin@emc.com.tw
Cc: bleung@chromium.org; k.kozlowski@samsung.com;
charliemooney@chromium.org; benjamin.tissoires@redhat.com;
linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Michele Curti
Subject: [PATCH] Input: elan_i2c - enable ELAN0100 acpi panels

Enable ELAN0100 touchpad driver, found on a Asus X205TA laptop, to gain 2,3
fingers tap and 2 fingers scroll.

Signed-off-by: Michele Curti <michele.curti@gmail.com>
---
 drivers/hid/hid-core.c              | 1 +
 drivers/input/mouse/elan_i2c_core.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c index
22afab9..70a11ac 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2294,6 +2294,7 @@ static const struct hid_device_id hid_ignore_list[] =
{
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x0004) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x000a) },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0400) },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0401) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY,
USB_DEVICE_ID_ESSENTIAL_REALITY_P5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) }, diff
--git a/drivers/input/mouse/elan_i2c_core.c
b/drivers/input/mouse/elan_i2c_core.c
index 67388f4..3f1eef0 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -98,6 +98,7 @@ static int elan_get_fwinfo(u8 ic_type, u16
*vaildpage_count,
 			   u16 *signature_address)
 {
 	switch(ic_type) {
+	case 0x08:


 	case 0x09:
 		*vaildpage_count = 768;
 		break;
@@ -1165,6 +1166,7 @@ MODULE_DEVICE_TABLE(i2c, elan_id);  #ifdef CONFIG_ACPI
static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0000", 0 },
+	{ "ELAN0100", 0 },
 	{ "ELAN0600", 0 },
 	{ }
 };
--
2.5.0


