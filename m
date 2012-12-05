From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 09/14] HID: i2c-hid: i2c_hid_get_report may fail
Date: Wed, 5 Dec 2012 11:28:15 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1212051128100.17055@pobox.suse.cz>
References: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com> <1354634875-5182-10-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354634875-5182-10-git-send-email-benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 4 Dec 2012, Benjamin Tissoires wrote:

> If i2c_hid_get_report fails, exit i2c_hid_init_report.
> The printk log is already called by i2c_hid_get_report, so no need
> to add some more printks.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index da04948..dcacfc4 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -400,9 +400,10 @@ static void i2c_hid_init_report(struct hid_report *report, u8 *buffer,
>  	unsigned int size, ret_size;
>  
>  	size = i2c_hid_get_report_length(report);
> -	i2c_hid_get_report(client,
> +	if (i2c_hid_get_report(client,
>  			report->type == HID_FEATURE_REPORT ? 0x03 : 0x01,
> -			report->id, buffer, size);
> +			report->id, buffer, size))
> +		return;
>  
>  	i2c_hid_dbg(ihid, "report (len=%d): %*ph\n", size, size, ihid->inbuf);

Applied.

-- 
Jiri Kosina
SUSE Labs
