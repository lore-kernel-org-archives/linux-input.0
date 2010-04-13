From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [Patch] HID: non-overlapping zeroing of extra bits
Date: Tue, 13 Apr 2010 15:56:43 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004131556330.8345@pobox.suse.cz>
References: <20100412121611.4d8ff409@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:38521 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065Ab0DMN4o (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Apr 2010 09:56:44 -0400
In-Reply-To: <20100412121611.4d8ff409@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-input@vger.kernel.org

On Mon, 12 Apr 2010, Pete Zaitcev wrote:

> From my review of the way the unused bits of report are being zeroed,
> it seems like there must be a bug. Currently, the zeroing is done
> in hid_output_field and it covers any bits between the last used bit
> and the end of the byte. But in case of, say, my keyboard, NumLock is
> mask 0x01 and CapsLock is 0x02. Invoking hid_output_field for NumLock
> definitely zeroes across CapsLock. The only reason this works is that
> the fields are sorted by the offset.
> 
> It would be more correct and simpler to zero-fill the buffer into
> which the fields are set.
> 
> The patch is tested with an IBM keyboard that is improperly sensitive
> to out-of-report pad bits, the extra bits are still zeroed and the
> fields continue to work as expected. It is also tested with good
> keyboards.
> 
> In case, a related bug in RHEL 5 is tracked with Red Hat bug 513934.
> 
> Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
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
> @@ -966,6 +961,7 @@ void hid_output_report(struct hid_report *report, __u8 *data)
>  	if (report->id > 0)
>  		*data++ = report->id;
>  
> +	memset(data, 0, ((report->size - 1) >> 3) + 1);
>  	for (n = 0; n < report->maxfield; n++)
>  		hid_output_field(report->field[n], data);
>  }

I have applied the patch, thanks Pete.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
