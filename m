From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] HID: logitech: read all 32 bits of report type bitfield
Date: Fri, 11 May 2012 02:22:31 -0500
Message-ID: <20120511072231.GA5733@burratino>
References: <20120503052420.GD15205@burratino>
 <4FA217B7.7070908@osvaldobarrera.com.ar>
 <20120503055051.GA15960@burratino>
 <CAE7qMrqtmu+bYYYp43s7Ek=UxfUG8HzwQSQBsdCGcVCBzCMQQw@mail.gmail.com>
 <20120506031428.GA20044@hugoo.com.ar>
 <20120506055508.GA21209@burratino>
 <4FA6162F.1020408@osvaldobarrera.com.ar>
 <20120506062309.GB26002@burratino>
 <20120511050639.GA13777@hugoo.com.ar>
 <CAE7qMroedSu_-GJ3mye0vnKtQKiS1jEuDAkk75=qdTVQMTgaxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:43530 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab2EKHWn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 03:22:43 -0400
Received: by gglu4 with SMTP id u4so1523528ggl.19
        for <linux-input@vger.kernel.org>; Fri, 11 May 2012 00:22:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAE7qMroedSu_-GJ3mye0vnKtQKiS1jEuDAkk75=qdTVQMTgaxQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@enac.fr>, 671292@bugs.debian.org, Jiri Kosina <jkosina@suse.cz>

On big-endian systems (e.g., Apple PowerBook), trying to use a
logitech wireless mouse with the Logitech Unifying Receiver does not
work with v3.2 and later kernels.  The device doesn't show up in
/dev/input.  Older kernels work fine.

That is because the new hid-logitech-dj driver claims the device.  The
device arrival notification appears:

	20 00 41 02 00 00 00 00 00 00 00 00 00 00 00

and we read the report_types bitfield (02 00 00 00) to find out what
kind of device it is.  Unfortunately the driver only reads the first 8
bits and treats that value as a 32-bit little-endian number, so on a
powerpc the report type seems to be 0x02000000 and is not recognized.

Even on little-endian machines, connecting a media center remote
control (report type 00 01 00 00) with this driver loaded would
presumably fail for the same reason.

Fix both problems by using get_unaligned_le32() to read all four
bytes, which is a little clearer anyway.  After this change, the
wireless mouse works on Hugo's PowerBook again.

Based on a patch by Nestor Lopez Casado.
Addresses http://bugs.debian.org/671292

Reported-by: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>
Inspired-by: Nestor Lopez Casado <nlopezcasad@logitech.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Cc: <stable@vger.kernel.org>
---
Nestor Lopez Casado wrote:

> Great news. Thanks Hugo for your help testing the patches.
>
> Jonathan, how do we proceed now, I mean to submit the fix ?

If the patch looks good to you, we ask Jiri to pick it up.  What do
you think?

Thanks,
Jonathan

 drivers/hid/hid-logitech-dj.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 38b12e45780c..2eac8c566b17 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -26,6 +26,7 @@
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/usb.h>
+#include <asm/unaligned.h>
 #include "usbhid/usbhid.h"
 #include "hid-ids.h"
 #include "hid-logitech-dj.h"
@@ -265,8 +266,8 @@ static void logi_dj_recv_add_djhid_device(struct dj_receiver_dev *djrcv_dev,
 		goto dj_device_allocate_fail;
 	}
 
-	dj_dev->reports_supported = le32_to_cpu(
-		dj_report->report_params[DEVICE_PAIRED_RF_REPORT_TYPE]);
+	dj_dev->reports_supported = get_unaligned_le32(
+		dj_report->report_params + DEVICE_PAIRED_RF_REPORT_TYPE);
 	dj_dev->hdev = dj_hiddev;
 	dj_dev->dj_receiver_dev = djrcv_dev;
 	dj_dev->device_index = dj_report->device_index;
-- 
1.7.10.1

