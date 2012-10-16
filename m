From: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c-hid: introduce HID over i2c specification implementation
Date: Tue, 16 Oct 2012 10:17:50 +0200
Message-ID: <507D182E.9010902@suse.cz>
References: <1350333533-13366-1-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1350333533-13366-1-git-send-email-benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Stephane Chatty <chatty-rXV5z7KbLFk@public.gmane.org>, fabien.andre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, JJ Ding <jj_ding-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 10/15/2012 10:38 PM, Benjamin Tissoires wrote:
> Notes:
> {1}: I don't have all the informations in the beginning of the probe function to
> get the real size I need to allocate. So the behavior is to allocate first a
> buffer by using HID_MIN_BUFFER_SIZE and once I got the information, I can
> reallocate the buffer to the right size (in i2c_hid_start).

And there is a bug in this. See below.

> --- /dev/null
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
...
> +static int i2c_hid_alloc_buffers(struct i2c_hid *ihid)
> +{
> +	/* the worst case is computed from the set_report command with a
> +	 * reportID > 15 and the maximum report length */
> +	int args_len = sizeof(__u8) + /* optional ReportID byte */
> +		       sizeof(__u16) + /* data register */
> +		       sizeof(__u16) + /* size of the report */
> +		       ihid->bufsize; /* report */
> +
> +	ihid->inbuf = kzalloc(ihid->bufsize, GFP_KERNEL);
> +
> +	if (!ihid->inbuf)
> +		return -ENOMEM;
> +
> +	ihid->argsbuf = kzalloc(args_len, GFP_KERNEL);
> +
> +	if (!ihid->argsbuf) {
> +		kfree(ihid->inbuf);
> +		return -ENOMEM;
> +	}
> +
> +	ihid->cmdbuf = kzalloc(sizeof(union command) + args_len, GFP_KERNEL);
> +
> +	if (!ihid->cmdbuf) {
> +		kfree(ihid->inbuf);
> +		kfree(ihid->argsbuf);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;

If this is called from hid_start and some of the latter allocation fails
here, you free the buffers appropriately. However if another start
occurs (e.g. by loading another module for that particular device), it
will crash, as the buffers will remain unallocated because at this point
ihid->bufsize == old_bufsize. You should set ihid->bufsize back to
old_bufsize if i2c_hid_alloc_buffers fails and also set the pointers to
NULL here.

regards,
-- 
js
suse labs
