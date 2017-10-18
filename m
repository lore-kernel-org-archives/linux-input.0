From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: rmi: Check that a device is a RMI device before
 calling RMI functions
Date: Wed, 18 Oct 2017 10:48:03 +0200
Message-ID: <20171018084803.GE24559@mail.corp.redhat.com>
References: <1508290656-18871-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967032AbdJRIsI (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Oct 2017 04:48:08 -0400
Content-Disposition: inline
In-Reply-To: <1508290656-18871-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Hendrik Langer <hendrik.langer@gmx.de>

On Oct 17 2017 or thereabouts, Andrew Duggan wrote:
> The hid-rmi driver may handle non rmi devices on composite USB devices.
> Callbacks need to make sure that the current device is a RMI device before
> calling RMI specific functions. Most callbacks already have this check, but
> this patch adds checks to the remaining callbacks.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---
> This is the patch which hopefully will address the X1 tablet dock freeze:
> http://www.spinics.net/lists/linux-input/msg53582.html
> 
> I was not able to test on a composite USB device so I have not tested confirmed
> this will fix the reported issues. But, based on the description I think it will.
> I also added a check for rmi_raw_event() since it could be possible that another
> hid device using one of the same report IDs as an RMI device could result in calling
> into unitialized RMI functions. It was also the only callbacl left not checking the
> RMI_DEVICE flag. I wonder if this explains the attach crash.
> 
> Anyway, I would appriciate it if Hendrik or someone else with the device could test this
> patch to confirm it fixes the reported behavior.

Shouldn't rmi_hid_reset() also get the same check?

>From what I can see, even if the patch doesn't fix the immediate issue,
such a patch should definitively go in as those checks are clearly
missing.

Cheers,
Benjamin

> 
> Thanks,
> Andrew
> 
>  drivers/hid/hid-rmi.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index 5b40c26..d987e02 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -368,6 +368,11 @@ static int rmi_check_sanity(struct hid_device *hdev, u8 *data, int size)
>  static int rmi_raw_event(struct hid_device *hdev,
>  		struct hid_report *report, u8 *data, int size)
>  {
> +	struct rmi_data *hdata = hid_get_drvdata(hdev);
> +
> +	if (!(hdata->device_flags & RMI_DEVICE))
> +		return 0;
> +
>  	size = rmi_check_sanity(hdev, data, size);
>  	if (size < 2)
>  		return 0;
> @@ -706,9 +711,11 @@ static void rmi_remove(struct hid_device *hdev)
>  {
>  	struct rmi_data *hdata = hid_get_drvdata(hdev);
>  
> -	clear_bit(RMI_STARTED, &hdata->flags);
> -	cancel_work_sync(&hdata->reset_work);
> -	rmi_unregister_transport_device(&hdata->xport);
> +	if (hdata->device_flags & RMI_DEVICE) {
> +		clear_bit(RMI_STARTED, &hdata->flags);
> +		cancel_work_sync(&hdata->reset_work);
> +		rmi_unregister_transport_device(&hdata->xport);
> +	}
>  
>  	hid_hw_stop(hdev);
>  }
> -- 
> 2.7.4
> 
