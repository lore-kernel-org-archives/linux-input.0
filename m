From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: rmi: print an error if F11 is not found instead of
 stopping the device
Date: Thu, 14 Aug 2014 11:43:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1408141143130.15220@pobox.suse.cz>
References: <1407357460-9569-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54031 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861AbaHNJn2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Aug 2014 05:43:28 -0400
In-Reply-To: <1407357460-9569-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Wed, 6 Aug 2014, Andrew Duggan wrote:

> Currently rmi_probe will return -EIO if the device doesn't report that it has F11.
> This would indicate that something happened and the device is in the bootloader.
> We can recover the device using a userspace firmware update tool, but it needs
> access to the device through the hidraw device file. If the probe returns -EIO
> the hidraw device won't be created. So instead of failing the probe, just print
> an error message, but leave the device accessible from userspace.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---
>  drivers/hid/hid-rmi.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index 0dc2514..8389e81 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -909,10 +909,15 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		return ret;
>  	}
>  
> -	if (!test_bit(RMI_STARTED, &data->flags)) {
> -		hid_hw_stop(hdev);
> -		return -EIO;
> -	}
> +	if (!test_bit(RMI_STARTED, &data->flags))
> +		/*
> +		 * The device maybe in the bootloader if rmi_input_configured
> +		 * failed to find F11 in the PDT. Print an error, but don't
> +		 * return an error from rmi_probe so that hidraw will be
> +		 * accessible from userspace. That way a userspace tool
> +		 * can be used to reload working firmware on the touchpad.
> +		 */
> +		hid_err(hdev, "Device failed to be properly configured\n");

Queued for 3.17 still. Thanks,

-- 
Jiri Kosina
SUSE Labs
