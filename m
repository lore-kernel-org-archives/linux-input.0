From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Zeroing the report before setting fields
Date: Mon, 22 Mar 2010 17:30:31 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003221726320.18642@pobox.suse.cz>
References: <20100304143349.2d861ec6@redhat.com> <20100305082901.GA20245@core.coreip.homeip.net> <alpine.LNX.2.00.1003091340250.17799@pobox.suse.cz> <20100309162648.289871c4@redhat.com> <alpine.LNX.2.00.1003132324250.18642@pobox.suse.cz>
 <20100321230941.6a56eae2@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55091 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755044Ab0CVQad (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Mar 2010 12:30:33 -0400
In-Reply-To: <20100321230941.6a56eae2@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-input@vger.kernel.org

On Sun, 21 Mar 2010, Pete Zaitcev wrote:

> > I don't think it's super important (basically nothing can be considered 
> > super-hot path when dealing with such slow hardware as HID devices :) ), 
> > but I wouldn't object to adding extra check before calling the memset.
> 
> I thought about the issue some more and came to the conclusion that
> all the bit counting in my patch was entirely unnecessary (it's still
> needed in the code that sets them, of course).
> 
> What would you say to the following? I tested it to work with the
> affected keyboard. Seems like a simpler way to remove the overlap
> and the trailing bits.
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 368fbb0..7f2a3b9 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -940,13 +940,8 @@ static void hid_output_field(struct hid_field *field, __u8 *data)
>  	unsigned count = field->report_count;
>  	unsigned offset = field->report_offset;
>  	unsigned size = field->report_size;
> -	unsigned bitsused = offset + count * size;
>  	unsigned n;
>  
> -	/* make sure the unused bits in the last byte are zeros */
> -	if (count > 0 && size > 0 && (bitsused % 8) != 0)
> -		data[(bitsused-1)/8] &= (1 << (bitsused % 8)) - 1;
> -
>  	for (n = 0; n < count; n++) {
>  		if (field->logical_minimum < 0)	/* signed values */
>  			implement(data, offset + n * size, size, s32ton(field->value[n], size));
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 56d06cd..1332ed0 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -505,7 +505,7 @@ static void __usbhid_submit_report(struct hid_device *hid, struct hid_report *re
>  			return;
>  		}
>  
> -		usbhid->out[usbhid->outhead].raw_report = kmalloc(len, GFP_ATOMIC);
> +		usbhid->out[usbhid->outhead].raw_report = kzalloc(len, GFP_ATOMIC);
>  		if (!usbhid->out[usbhid->outhead].raw_report) {
>  			dev_warn(&hid->dev, "output queueing failed\n");
>  			return;
> @@ -537,7 +537,7 @@ static void __usbhid_submit_report(struct hid_device *hid, struct hid_report *re
>  	}
>  
>  	if (dir == USB_DIR_OUT) {
> -		usbhid->ctrl[usbhid->ctrlhead].raw_report = kmalloc(len, GFP_ATOMIC);
> +		usbhid->ctrl[usbhid->ctrlhead].raw_report = kzalloc(len, GFP_ATOMIC);
>  		if (!usbhid->ctrl[usbhid->ctrlhead].raw_report) {
>  			dev_warn(&hid->dev, "control queueing failed\n");
>  			return;

In principle this looks correct. 

The problem is that with previous aproach, we are handling the zeroing in 
the generic HID layer, but after your patch the zeroing is handled less 
generally for USB transport only.

I.e. I see two problems, which are closely related

- you forgot to do the same change to Bluetooth as well
- this introduces a new semantical constraint on HID transport drivers, so 
  that they have to make sure that the reports are always zeroed properly

Frankly, I like the generic aproach more ... if we were to add more 
low-level transport HID implementations later, I am sure this will be 
forgotten multiple times :) (as it isn't directly implied by the HID 
specification, but is rather a workaround for devices that are violating 
the spec by looking at the bits they shouldn't care about).

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
