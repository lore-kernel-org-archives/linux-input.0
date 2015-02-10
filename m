From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH] HID: sony: Enable Gasia third-party PS3 controllers, v2
Date: Tue, 10 Feb 2015 12:19:48 +0100
Message-ID: <20150210121948.a74fb71f5f3a8fc0a9504f68@ao2.it>
References: <20150208111138.6f562d6c.cand@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:59787 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751746AbbBJLT5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Feb 2015 06:19:57 -0500
In-Reply-To: <20150208111138.6f562d6c.cand@gmx.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Lauri Kasanen <cand@gmx.com>, jkosina@suse.cz, linux-kernel@vger.kernel.org, benjamin.tissoires@gmail.com, AndrewD207@aol.com

Hi Lauri,

On Sun, 8 Feb 2015 11:11:38 +0200
Lauri Kasanen <cand@gmx.com> wrote:

> Without this, my "Gasia Co.,Ltd PS(R) Gamepad" would not send
> any events. Now everything works including the leds.
> 
> Based on work by Andrew Haines and Antonio Ospite.
> 
> v2:
> - edited error messages
> - use output_report

These annotations about the history of a patch are usually added
after the '---' marker right before sending the patch, not in the commit
message.

They are useful for reviewers, but not really interesting anymore after
the code is validated and merged.

In the subject you can mark a v2 like [PATCHv2], the prefix will be
stripped by git am, do not put the version of the patch in the short
commit message itself.

Some nitpicking below.

> cc: Antonio Ospite <ao2@ao2.it>
> cc: Andrew Haines <AndrewD207@aol.com>
> Signed-off-by: Lauri Kasanen <cand@gmx.com>
> ---
>  drivers/hid/hid-sony.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> Despite Andrew's report, using output_report worked fine.

Good! :)

I also tested the patch on an original controller and it still works
fine.

> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 31e9d25..2661227 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -1131,7 +1131,8 @@ static void sony_input_configured(struct hid_device *hdev,
>  static int sixaxis_set_operational_usb(struct hid_device *hdev)
>  {
>  	int ret;
> -	char *buf = kmalloc(18, GFP_KERNEL);
> +	char *buf = kmalloc(65, GFP_KERNEL);
> +	unsigned char buf2[] = { 0x00 };
>

The argument of hid_hw_output_report() is of the same type of
hid_hw_raw_request() so make it all the same here.

But even better, can't you just reuse buf? It's a dummy buffer anyways.

Moreover, a following cleanup patch could make this __u8 *buf which
would be the correct type.

Another follow-up patch could indeed use SIXAXIS_REPORT_0xF2_SIZE and
also define SIXAXIS_REPORT_0xF5_SIZE.

I can do these latter if you want.

>  	if (!buf)
>  		return -ENOMEM;
> @@ -1140,7 +1141,22 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
>  				 HID_REQ_GET_REPORT);
>  
>  	if (ret < 0)
> -		hid_err(hdev, "can't set operational mode\n");
> +		hid_err(hdev, "can't set operational mode: step 1\n");
> +

Maybe you can add a "goto out" here and skip the other steps if a
previous one fails. Or is some slack actually required to support
compatible controllers?

> +	/*
> +	 * Some compatible controllers like the Speedlink Strike FX and
> +	 * Gasia need another query plus an USB interrupt to get operational.
> +	 */
> +	ret = hid_hw_raw_request(hdev, 0xf5, buf, 64, HID_FEATURE_REPORT,
> +				 HID_REQ_GET_REPORT);
> +
> +	if (ret < 0)
> +		hid_err(hdev, "can't set operational mode: step 2\n");
> +

	goto out;
}

> +	ret = hid_hw_output_report(hdev, buf2, sizeof(buf2));

This could be:
	ret = hid_hw_output_report(hdev, buf, 1);

> +
> +	if (ret < 0)
> +		hid_err(hdev, "can't set operational mode: step 3\n");
>

out:

>  	kfree(buf);
>  

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
