From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH v2 4/4] HID: i2c-hid: fix i2c_hid_get_raw_report count
 mismatches
Date: Wed, 5 Dec 2012 20:59:26 +0100
Message-ID: <20121205205926.143070ef@endymion.delvare>
References: <1354716176-12558-1-git-send-email-benjamin.tissoires@gmail.com>
	<1354716176-12558-5-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:15689 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab2LET7k (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Dec 2012 14:59:40 -0500
In-Reply-To: <1354716176-12558-5-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed,  5 Dec 2012 15:02:56 +0100, Benjamin Tissoires wrote:
> The previous memcpy implementation relied on the size advertized by the
> device. There were no guarantees that buf was big enough.
> 
> Some gymnastic is also required with the +2/-2 to take into account
> the first 2 bytes of the returned buffer where the total returned
> length is supplied by the device.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index c6630d4..ce01d59 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -502,23 +502,31 @@ static int i2c_hid_get_raw_report(struct hid_device *hid,
>  {
>  	struct i2c_client *client = hid->driver_data;
>  	struct i2c_hid *ihid = i2c_get_clientdata(client);
> +	size_t ret_count, ask_count;
>  	int ret;
>  
>  	if (report_type == HID_OUTPUT_REPORT)
>  		return -EINVAL;
>  
> -	if (count > ihid->bufsize)
> -		count = ihid->bufsize;
> +	/* +2 bytes to include the size of the reply in the query buffer */
> +	ask_count = min(count + 2, (size_t)ihid->bufsize);
>  
>  	ret = i2c_hid_get_report(client,
>  			report_type == HID_FEATURE_REPORT ? 0x03 : 0x01,
> -			report_number, ihid->inbuf, count);
> +			report_number, ihid->inbuf, ask_count);
>  
>  	if (ret < 0)
>  		return ret;
>  
> -	count = ihid->inbuf[0] | (ihid->inbuf[1] << 8);
> +	ret_count = ihid->inbuf[0] | (ihid->inbuf[1] << 8);
>  
> +	if (!ret_count)

I'd make this (ret_count <= 2), as this would let you call memcpy with a
null or even negative length.

Other than that, the new code looks OK and safe.

> +		return 0;
> +
> +	ret_count = min(ret_count, ask_count);
> +
> +	/* The query buffer contains the size, dropping it in the reply */
> +	count = min(count, ret_count - 2);
>  	memcpy(buf, ihid->inbuf + 2, count);
>  
>  	return count;


-- 
Jean Delvare
