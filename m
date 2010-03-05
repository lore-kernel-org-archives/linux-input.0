From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Zeroing the report before setting fields
Date: Fri, 5 Mar 2010 00:29:01 -0800
Message-ID: <20100305082901.GA20245@core.coreip.homeip.net>
References: <20100304143349.2d861ec6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34493 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456Ab0CEI3I (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Mar 2010 03:29:08 -0500
Received: by gyg10 with SMTP id 10so481361gyg.19
        for <linux-input@vger.kernel.org>; Fri, 05 Mar 2010 00:29:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100304143349.2d861ec6@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi Pete,

On Thu, Mar 04, 2010 at 02:33:49PM -0700, Pete Zaitcev wrote:
> Hi, Dmitry et. al.:
> 
> I was looking at the way unused bits of report are being zeroed, and
> it seems like there must be a bug. Currently, the zeroing is done in
> hid_output_field and it covers any bits between the last used bit and
> the end of the byte. But in case of, say, my keyboard, NumLock is mask
> 0x01 and CapsLock is 0x02. Invoking hid_output_field for NumLock
> definitely zeroes across CapsLock. The only reason this works is that
> the fields are sorted by the offset.
> 
> I am not sure it's safe at all times, so why don't we pull the
> zeroing outside and do it once per report? Please see the attached.
> I tested it with various keyboards (including those that blow up
> on RHEL 5), and it works, but the question is, do we want it?
> 

I think Jiri is the most qualified to answer questions like that about
HID (CCed) buit I think what you are proposing is reasonable and would
make the code safer indeed.

> Cheers,
> -- Pete
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index eabe5f8..14b45b1 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -929,6 +929,15 @@ exit:
>  	kfree(value);
>  }
>  
> +static unsigned int hid_field_length(struct hid_field *field)
> +{
> +	unsigned count = field->report_count;
> +	unsigned offset = field->report_offset;
> +	unsigned size = field->report_size;
> +
> +	return offset + count * size;
> +}
> +
>  /*
>   * Output the field into the report.
>   */
> @@ -938,13 +947,8 @@ static void hid_output_field(struct hid_field *field, __u8 *data)
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
> @@ -960,10 +964,19 @@ static void hid_output_field(struct hid_field *field, __u8 *data)
>  void hid_output_report(struct hid_report *report, __u8 *data)
>  {
>  	unsigned n;
> +	unsigned length, bitsused;
>  
>  	if (report->id > 0)
>  		*data++ = report->id;
>  
> +	length = 0;
> +	for (n = 0; n < report->maxfield; n++) {
> +		bitsused = hid_field_length(report->field[n]);
> +		if (bitsused > length)
> +			length = bitsused;
> +	}
> +	memset(data, 0, (length + 7) / 8);
> +
>  	for (n = 0; n < report->maxfield; n++)
>  		hid_output_field(report->field[n], data);
>  }

-- 
Dmitry
