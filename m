From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: usb/misc/ims-pcu: slab-out-of-bounds in ims_pcu_parse_cdc_data
Date: Sat, 7 Oct 2017 11:14:33 -0700
Message-ID: <20171007181433.GA14355@dtor-ws>
References: <CAAeHK+w_9oFs4=2PLY++EKgVme7KJ07F8AkOgwePdX+p2tK1qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37238 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbdJGSOh (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 7 Oct 2017 14:14:37 -0400
Content-Disposition: inline
In-Reply-To: <CAAeHK+w_9oFs4=2PLY++EKgVme7KJ07F8AkOgwePdX+p2tK1qQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Johan Hovold <johan@kernel.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>

On Thu, Sep 28, 2017 at 01:35:51PM +0200, Andrey Konovalov wrote:
> Hi!
> 
> I've got the following report while fuzzing the kernel with syzkaller.
> 
> On commit dc972a67cc54585bd83ad811c4e9b6ab3dcd427e (4.14-rc2+).
> 
> There's no check that the length of intf->altsetting->extra is big
> enough to hold usb_cdc_union_desc struct.

Can you please tell me if the following works for you?

Thanks!

-- 
Dmitry

Input: ims-psu - check if CDC union descriptor is sane

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Before trying to use CDC union descriptor, try to validate whether that it
is sane by checking that intf->altsetting->extra is big enough and that
descriptor bLength is not too big and not too small.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 6bf82ea8c918..ae473123583b 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1635,13 +1635,25 @@ ims_pcu_get_cdc_union_desc(struct usb_interface *intf)
 		return NULL;
 	}
 
-	while (buflen > 0) {
+	while (buflen >= sizeof(*union_desc)) {
 		union_desc = (struct usb_cdc_union_desc *)buf;
 
+		if (union_desc->bLength > buflen) {
+			dev_err(&intf->dev, "Too large descriptor\n");
+			return NULL;
+		}
+
 		if (union_desc->bDescriptorType == USB_DT_CS_INTERFACE &&
 		    union_desc->bDescriptorSubType == USB_CDC_UNION_TYPE) {
 			dev_dbg(&intf->dev, "Found union header\n");
-			return union_desc;
+
+			if (union_desc->bLength >= sizeof(*union_desc))
+				return union_desc;
+
+			dev_err(&intf->dev,
+				"Union descriptor to short (%d vs %zd\n)",
+				union_desc->bLength, sizeof(*union_desc));
+			return NULL;
 		}
 
 		buflen -= union_desc->bLength;
