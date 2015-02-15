From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCHv3] HID: sony: Enable Gasia third-party PS3 controllers
Date: Sun, 15 Feb 2015 11:27:48 +0100
Message-ID: <20150215112748.1f544d7be55a1518814f76a5@ao2.it>
References: <20150210145252.d5b86e42.cand@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:23842 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbbBOK2A (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Feb 2015 05:28:00 -0500
In-Reply-To: <20150210145252.d5b86e42.cand@gmx.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@gmail.com, AndrewD207@aol.com

On Tue, 10 Feb 2015 14:52:52 +0200
Lauri Kasanen <cand@gmx.com> wrote:

> Without this, my "Gasia Co.,Ltd PS(R) Gamepad" would not send
> any events. Now everything works including the leds.
> 
> Based on work by Andrew Haines and Antonio Ospite.
> 
> cc: Antonio Ospite <ao2@ao2.it>
> cc: Andrew Haines <AndrewD207@aol.com>
> Signed-off-by: Lauri Kasanen <cand@gmx.com>

Hi Lauri, we are almost there, last doubt, see below.

> ---
>  drivers/hid/hid-sony.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
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
> index 31e9d25..b0010d9 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -1131,7 +1131,7 @@ static void sony_input_configured(struct hid_device *hdev,
>  static int sixaxis_set_operational_usb(struct hid_device *hdev)
>  {
>  	int ret;
> -	char *buf = kmalloc(18, GFP_KERNEL);
> +	char *buf = kmalloc(65, GFP_KERNEL);
>

Does report 0xf5 really have to be of size 65?
I checked that in the BlueZ plugin we just request 8 bytes from feature
report 0xf5, and I tested here that the request succeeds with size 8.

Did you verify that 65 (actually 64 as that's what we pass to
hid_hw_raw_request) is the minimum valid size to make the controller
operational?

I ask because I'd like to stick to common values between kernel and
BlueZ if possible.

JFTR, the value 17 is the minimum accepted size by the original
controller for report 0xf2; however size 18 gets used sometimes maybe
because of some historical leftovers regarding code messing explicitly
with the report id.

>  	if (!buf)
>  		return -ENOMEM;
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
> +	ret = hid_hw_raw_request(hdev, 0xf5, buf, 64, HID_FEATURE_REPORT,
> +				 HID_REQ_GET_REPORT);

What's the minimum size accepted by the controller here?

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
