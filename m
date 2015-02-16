From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCHv4] HID: sony: Enable Gasia third-party PS3 controllers
Date: Mon, 16 Feb 2015 17:59:21 +0100
Message-ID: <20150216175921.05ce3e9326e9aacbb9f77795@ao2.it>
References: <20150216150659.db522f3d.cand@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:38201 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102AbbBPQ70 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Feb 2015 11:59:26 -0500
In-Reply-To: <20150216150659.db522f3d.cand@gmx.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Lauri Kasanen <cand@gmx.com>, jkosina@suse.cz, linux-kernel@vger.kernel.org, benjamin.tissoires@gmail.com, AndrewD207@aol.com

On Mon, 16 Feb 2015 15:06:59 +0200
Lauri Kasanen <cand@gmx.com> wrote:

> Without this, my "Gasia Co.,Ltd PS(R) Gamepad" would not send
> any events. Now everything works including the leds.
> 
> Based on work by Andrew Haines and Antonio Ospite.
> 
> cc: Antonio Ospite <ao2@ao2.it>
> cc: Andrew Haines <AndrewD207@aol.com>
> Signed-off-by: Lauri Kasanen <cand@gmx.com>

Reviewed-by: Antonio Ospite <ao2@ao2.it>

Original controllers still work fine after this change.
Some follow-up patches are on their way.

Thanks,
   Antonio

> ---
>  drivers/hid/hid-sony.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> Antonio: size 8 works.
> 
> v4:
> - use size 8
> 
> v3:
> - reuse the dummy heap buffer
> - skip later checks if the earlier ones fail
> 
> v2:
> - edited error messages
> - use output_report
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 31e9d25..f3d44e5 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -1139,9 +1139,29 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
>  	ret = hid_hw_raw_request(hdev, 0xf2, buf, 17, HID_FEATURE_REPORT,
>  				 HID_REQ_GET_REPORT);
>  
> +	if (ret < 0) {
> +		hid_err(hdev, "can't set operational mode: step 1\n");
> +		goto out;
> +	}
> +
> +	/*
> +	 * Some compatible controllers like the Speedlink Strike FX and
> +	 * Gasia need another query plus an USB interrupt to get operational.
> +	 */
> +	ret = hid_hw_raw_request(hdev, 0xf5, buf, 8, HID_FEATURE_REPORT,
> +				 HID_REQ_GET_REPORT);
> +
> +	if (ret < 0) {
> +		hid_err(hdev, "can't set operational mode: step 2\n");
> +		goto out;
> +	}
> +
> +	ret = hid_hw_output_report(hdev, buf, 1);
> +
>  	if (ret < 0)
> -		hid_err(hdev, "can't set operational mode\n");
> +		hid_err(hdev, "can't set operational mode: step 3\n");
>  
> +out:
>  	kfree(buf);
>  
>  	return ret;
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
