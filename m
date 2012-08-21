From: "Henrik Rydberg" <rydberg@bitmath.se>
Subject: Re: QUANTA touchscreen controller integrated in HP2310ti no longer
 recognised (regression in 3.5 and later as compared to 3.3)
Date: Tue, 21 Aug 2012 21:06:26 +0200
Message-ID: <20120821190626.GA1260@polaris.bitmath.org>
References: <1700293.Y8yBuPUG33@f17simon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp2.one.com ([91.198.169.22]:22577 "EHLO csmtp2.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726Ab2HUTBp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Aug 2012 15:01:45 -0400
Content-Disposition: inline
In-Reply-To: <1700293.Y8yBuPUG33@f17simon>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, Jiri Kosina <jkosina@suse.cz>

Hi Simon,

> We're going through our collection of touch screens, making sure that they all 
> work with current kernels, and we've found one that doesn't work with today's 
> Linus master.
> 
> lsusb describes the screen as:
> Bus 006 Device 002: ID 0408:3001 Quanta Computer, Inc. Optical Touch Screen

What about 0408:3008, does that one work?

> Any ideas on the best way to resolve this regression?

What does 'cat /sys/bus/hid/devices/0003:0408:3001.0001/modalias' say?

The patch below ought to be enough to make it work, although it is
still unclear why it is needed.

Thanks,
Henrik

---

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index bd4bc3c..2b775c3 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -963,7 +963,7 @@ static const struct hid_device_id mt_devices[] = {
                MT_USB_DEVICE(USB_VENDOR_ID_QUANTA,
                        USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH) },
        { .driver_data = MT_CLS_CONFIDENCE_CONTACT_ID,
-               MT_USB_DEVICE(USB_VENDOR_ID_QUANTA,
+               HID_USB_DEVICE(USB_VENDOR_ID_QUANTA,
                        USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001) },
        { .driver_data = MT_CLS_CONFIDENCE_CONTACT_ID,
                MT_USB_DEVICE(USB_VENDOR_ID_QUANTA,
