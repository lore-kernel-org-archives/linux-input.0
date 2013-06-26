From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Added a check for NULL pointer in hid_add_device
Date: Wed, 26 Jun 2013 16:03:53 +0200
Message-ID: <51CAF4C9.20407@redhat.com>
References: <1372182701-12256-1-git-send-email-michael.banken@mathe.stud.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21772 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355Ab3FZOEi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Jun 2013 10:04:38 -0400
In-Reply-To: <1372182701-12256-1-git-send-email-michael.banken@mathe.stud.uni-erlangen.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Banken <michael.banken@mathe.stud.uni-erlangen.de>
Cc: linux-kernel@vger.kernel.org, rydberg@euromail.se, srinivas.pandruvada@intel.com, erazor_de@users.sourceforge.net, jkosina@suse.cz, lorenz@badgers.com, linux-kernel@i4.informatik.uni-erlangen.de, linux-input@vger.kernel.org

Hi Michael,

On 06/25/2013 07:51 PM, Michael Banken wrote:
> This check greatly simplifies creating a dummy hid device.

Could you elaborate a little here? If you want to create a hid device
from the user space, I encourage you to use uhid, which is available
since v3.6.

> With this check in place a hid dummy can be created simply by allocating and adding the device.
> This used to be possible in earlier Kernel versions.
> 
> Signed-off-by: Michael Banken <michael.banken@mathe.stud.uni-erlangen.de>
> Signed-off-by: Lorenz Haspel <lorenz@badgers.com>
> ---
>  drivers/hid/hid-core.c |   37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 0951a9a..88c573e 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2289,24 +2289,27 @@ int hid_add_device(struct hid_device *hdev)
>  	if (hid_ignore(hdev))
>  		return -ENODEV;
>  
> -	/*
> -	 * Read the device report descriptor once and use as template
> -	 * for the driver-specific modifications.
> -	 */
> -	ret = hdev->ll_driver->parse(hdev);
> -	if (ret)
> -		return ret;
> -	if (!hdev->dev_rdesc)
> -		return -ENODEV;
> -
> -	/*
> -	 * Scan generic devices for group information
> -	 */
> -	if (hid_ignore_special_drivers ||
> -	    !hid_match_id(hdev, hid_have_special_driver)) {
> -		ret = hid_scan_report(hdev);
> +	if (hdev->ll_driver != NULL) {

I am concerned by the fact that *every* hid specific driver will have to
call hid_hw_start and hid_hw_stop at some point. These 2 functions  are
not protected against a null pointer in hdev->ll_driver, so allowing
here a null pointer will introduce a kernel oops later.

I think it would be safer to have:
if (!hdev->ll_driver)
	return -ENODEV;

But if I understood correctly, this is not your point.
So definitively, I need your usage scenarios of such hid "dummy" device.

Cheers,
Benjamin

> +		/*
> +		 * Read the device report descriptor once and use as template
> +			 * for the driver-specific modifications.
> +		 */
> +		ret = hdev->ll_driver->parse(hdev);
>  		if (ret)
> -			hid_warn(hdev, "bad device descriptor (%d)\n", ret);
> +			return ret;
> +		if (!hdev->dev_rdesc)
> +			return -ENODEV;
> +
> +		/*
> +		 * Scan generic devices for group information
> +		 */
> +		if (hid_ignore_special_drivers ||
> +		    !hid_match_id(hdev, hid_have_special_driver)) {
> +			ret = hid_scan_report(hdev);
> +			if (ret)
> +				hid_warn(hdev,
> +					"bad device descriptor (%d)\n", ret);
> +		}
>  	}
>  
>  	/* XXX hack, any other cleaner solution after the driver core
> 

