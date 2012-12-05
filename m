From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 09/14] HID: i2c-hid: i2c_hid_get_report may fail
Date: Wed, 5 Dec 2012 10:59:17 +0100
Message-ID: <20121205105917.291f483f@endymion.delvare>
References: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com>
	<1354634875-5182-10-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:1928 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab2LEJ7Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Dec 2012 04:59:25 -0500
In-Reply-To: <1354634875-5182-10-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue,  4 Dec 2012 16:27:50 +0100, Benjamin Tissoires wrote:
> If i2c_hid_get_report fails, exit i2c_hid_init_report.
> The printk log is already called by i2c_hid_get_report, so no need
> to add some more printks.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
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
>  

OK, although I don't quite get the rationale for not reporting the
errors from i2c_hid_init_report() and i2c_hid_init_reports() to their
respective callers. Does the device have any chance to work properly if
i2c_hid_init_reports() fails?

Reviewed-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare
