From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Zeroing the report before setting fields
Date: Sun, 21 Mar 2010 23:09:41 -0600
Message-ID: <20100321230941.6a56eae2@redhat.com>
References: <20100304143349.2d861ec6@redhat.com>
	<20100305082901.GA20245@core.coreip.homeip.net>
	<alpine.LNX.2.00.1003091340250.17799@pobox.suse.cz>
	<20100309162648.289871c4@redhat.com>
	<alpine.LNX.2.00.1003132324250.18642@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43578 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493Ab0CVFJg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Mar 2010 01:09:36 -0400
In-Reply-To: <alpine.LNX.2.00.1003132324250.18642@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, zaitcev@redhat.com

On Sat, 13 Mar 2010 23:25:11 +0100 (CET)
Jiri Kosina <jkosina@suse.cz> wrote:

> I don't think it's super important (basically nothing can be considered 
> super-hot path when dealing with such slow hardware as HID devices :) ), 
> but I wouldn't object to adding extra check before calling the memset.

I thought about the issue some more and came to the conclusion that
all the bit counting in my patch was entirely unnecessary (it's still
needed in the code that sets them, of course).

What would you say to the following? I tested it to work with the
affected keyboard. Seems like a simpler way to remove the overlap
and the trailing bits.

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 368fbb0..7f2a3b9 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -940,13 +940,8 @@ static void hid_output_field(struct hid_field *field, __u8 *data)
 	unsigned count = field->report_count;
 	unsigned offset = field->report_offset;
 	unsigned size = field->report_size;
-	unsigned bitsused = offset + count * size;
 	unsigned n;
 
-	/* make sure the unused bits in the last byte are zeros */
-	if (count > 0 && size > 0 && (bitsused % 8) != 0)
-		data[(bitsused-1)/8] &= (1 << (bitsused % 8)) - 1;
-
 	for (n = 0; n < count; n++) {
 		if (field->logical_minimum < 0)	/* signed values */
 			implement(data, offset + n * size, size, s32ton(field->value[n], size));
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 56d06cd..1332ed0 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -505,7 +505,7 @@ static void __usbhid_submit_report(struct hid_device *hid, struct hid_report *re
 			return;
 		}
 
-		usbhid->out[usbhid->outhead].raw_report = kmalloc(len, GFP_ATOMIC);
+		usbhid->out[usbhid->outhead].raw_report = kzalloc(len, GFP_ATOMIC);
 		if (!usbhid->out[usbhid->outhead].raw_report) {
 			dev_warn(&hid->dev, "output queueing failed\n");
 			return;
@@ -537,7 +537,7 @@ static void __usbhid_submit_report(struct hid_device *hid, struct hid_report *re
 	}
 
 	if (dir == USB_DIR_OUT) {
-		usbhid->ctrl[usbhid->ctrlhead].raw_report = kmalloc(len, GFP_ATOMIC);
+		usbhid->ctrl[usbhid->ctrlhead].raw_report = kzalloc(len, GFP_ATOMIC);
 		if (!usbhid->ctrl[usbhid->ctrlhead].raw_report) {
 			dev_warn(&hid->dev, "control queueing failed\n");
 			return;

Greetings,
-- Pete
