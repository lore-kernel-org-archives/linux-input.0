From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Baantoo multi-touch screen trouble
Date: Tue, 17 Apr 2012 11:07:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204171106500.16373@pobox.suse.cz>
References: <201204111629.59916.tvrtko.ursulin@onelan.co.uk> <201204131033.00596.tvrtko.ursulin@onelan.co.uk> <alpine.LNX.2.00.1204131442050.16373@pobox.suse.cz> <201204131430.24672.tvrtko.ursulin@onelan.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58300 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755874Ab2DQJHV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Apr 2012 05:07:21 -0400
In-Reply-To: <201204131430.24672.tvrtko.ursulin@onelan.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tvrtko Ursulin <tvrtko.ursulin@onelan.co.uk>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org

On Fri, 13 Apr 2012, Tvrtko Ursulin wrote:

> > Guys, who of you is going to send me patch adding the device ID into
> > in-kernel list?
> 
> It is unlikely to be me unless someone explains to me in detail what needs to 
> be done, at which point it is probably quicker for that person to do it. I for 
> example don't even understand why this, allegedly HID Multitouch class 
> compliant, device needs explicit adding? Is it not compliant after all? Is it 
> that multiple HID devices it exposes a non-standard thing? Does it then need a 
> vendor specific class (looking at hid-multitouch.c). Sorry this whole area is 
> just new and unknown to me.

Could you please verify that the patch below works for you? Thanks.



From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: multitouch: Add support for Baantoo touchscreen

Reported-by: Tvrtko Ursulin <tvrtko.ursulin@onelan.co.uk>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-core.c       |    1 +
 drivers/hid/hid-ids.h        |    3 +++
 drivers/hid/hid-multitouch.c |    4 ++++
 3 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 990fe19..d6c0b1c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1388,6 +1388,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_T91MT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUSTEK_MULTITOUCH_YFO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BELKIN, USB_DEVICE_ID_FLIP_KVM) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_BAANTOO, USB_DEVICE_ID_BAANTOO_MT_190W2), },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BTC, USB_DEVICE_ID_BTC_EMPREX_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BTC, USB_DEVICE_ID_BTC_EMPREX_REMOTE_2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CANDO_PIXCIR_MULTI_TOUCH) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3eb0090..fef15c4 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -157,6 +157,9 @@
 #define USB_VENDOR_ID_AVERMEDIA		0x07ca
 #define USB_DEVICE_ID_AVER_FM_MR800	0xb800
 
+#define USB_VENDOR_ID_BAANTOO		0x2453
+#define USB_DEVICE_ID_BAANTOO_MT_190W2	0x0100
+
 #define USB_VENDOR_ID_BELKIN		0x050d
 #define USB_DEVICE_ID_FLIP_KVM		0x3201
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 1d5b941..788aca3 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -749,6 +749,10 @@ static const struct hid_device_id mt_devices[] = {
 		HID_USB_DEVICE(USB_VENDOR_ID_ATMEL,
 			USB_DEVICE_ID_ATMEL_MXT_DIGITIZER) },
 
+	/* Baantoo multitouch devices */
+	{ .driver_data = MT_CLS_DEFAULT,
+		HID_USB_DEVICE(USB_VENDOR_ID_BAANTOO,
+			USB_DEVICE_ID_BAANTOO_MT_190W2) },
 	/* Cando panels */
 	{ .driver_data = MT_CLS_DUAL_INRANGE_CONTACTNUMBER,
 		HID_USB_DEVICE(USB_VENDOR_ID_CANDO,

-- 
Jiri Kosina
SUSE Labs
