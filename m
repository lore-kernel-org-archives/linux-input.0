From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Zeroing the report before setting fields
Date: Mon, 22 Mar 2010 16:22:06 -0600
Message-ID: <20100322162206.3c1e9b9e@redhat.com>
References: <20100304143349.2d861ec6@redhat.com>
 <20100305082901.GA20245@core.coreip.homeip.net>
 <alpine.LNX.2.00.1003091340250.17799@pobox.suse.cz>
 <20100309162648.289871c4@redhat.com>
 <alpine.LNX.2.00.1003132324250.18642@pobox.suse.cz>
 <20100321230941.6a56eae2@redhat.com>
 <alpine.LNX.2.00.1003221726320.18642@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3761 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756621Ab0CVWWF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Mar 2010 18:22:05 -0400
In-Reply-To: <alpine.LNX.2.00.1003221726320.18642@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, zaitcev@redhat.com

On Mon, 22 Mar 2010 17:30:31 +0100 (CET)
Jiri Kosina <jkosina@suse.cz> wrote:

> >  	if (dir == USB_DIR_OUT) {
> > -		usbhid->ctrl[usbhid->ctrlhead].raw_report = kmalloc(len, GFP_ATOMIC);
> > +		usbhid->ctrl[usbhid->ctrlhead].raw_report = kzalloc(len, GFP_ATOMIC);
> >  		if (!usbhid->ctrl[usbhid->ctrlhead].raw_report) {
> >  			dev_warn(&hid->dev, "control queueing failed\n");

> Frankly, I like the generic aproach more ... if we were to add more 
> low-level transport HID implementations later, I am sure this will be 
> forgotten multiple times :) (as it isn't directly implied by the HID 
> specification, but is rather a workaround for devices that are violating 
> the spec by looking at the bits they shouldn't care about).

You are right, I screwed the pooch on the layering. Sorry.

Still, I do not want to go back to counting of field lengths.
Too many what-ifs.

How about this (I tested it but clearly my tests are limited):

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 368fbb0..e290bb3 100644
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
@@ -966,6 +961,7 @@ void hid_output_report(struct hid_report *report, __u8 *data)
 	if (report->id > 0)
 		*data++ = report->id;
 
+	memset(data, 0, ((report->size - 1) >> 3) + 1);
 	for (n = 0; n < report->maxfield; n++)
 		hid_output_field(report->field[n], data);
 }

Yours,
-- Pete
