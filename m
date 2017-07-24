From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: rmi: Make sure the HID device is opened on resume
Date: Mon, 24 Jul 2017 10:15:29 +0200
Message-ID: <20170724081529.GA18097@mail.corp.redhat.com>
References: <20170723011509.23651-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752699AbdGXIPj (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Jul 2017 04:15:39 -0400
Content-Disposition: inline
In-Reply-To: <20170723011509.23651-1-lyude@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lyude <lyude@redhat.com>
Cc: linux-input@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>, stable@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org

On Jul 22 2017 or thereabouts, Lyude wrote:
> So it looks like that suspend/resume has actually always been broken on
> hid-rmi. The fact it worked was a rather silly coincidence that was
> relying on the HID device to already be opened upon resume. This means
> that so long as anything was reading the /dev/input/eventX node for for
> an RMI device, it would suspend and resume correctly. As well, if
> nothing happened to be keeping the HID device away it would shut off,
> then the RMI driver would get confused on resume when it stopped
> responding and explode.

Oh, good finding. However, given that there are few other drivers not
calling hid_hw_open during their .reset_resume() callback and those
drivers also are communicating with the device, I wonder if we should
not have something more generic, that will call hid_hw_open/close in the
transport layer directly.

I do not recall having seen bugs for Wacom devices, so maybe this is
something i2c-hid related, but it wouldn't hurt I guess to open/close
the device before calling reset_resume.

Cheers,
Benjamin

> 
> So, call hid_hw_open() in rmi_post_resume() so we make sure that the
> device is alive before we try talking to it.
> 
> This fixes RMI device suspend/resume over HID.
> 
> Signed-off-by: Lyude <lyude@redhat.com>
> Cc: Andrew Duggan <aduggan@synaptics.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/hid/hid-rmi.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index 5b40c2614599..e7d124f9a27f 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -431,22 +431,29 @@ static int rmi_post_resume(struct hid_device *hdev)
>  {
>  	struct rmi_data *data = hid_get_drvdata(hdev);
>  	struct rmi_device *rmi_dev = data->xport.rmi_dev;
> -	int ret;
> +	int ret = 0;
>  
>  	if (!(data->device_flags & RMI_DEVICE))
>  		return 0;
>  
> -	ret = rmi_reset_attn_mode(hdev);
> +	/* Make sure the HID device is ready to receive events */
> +	ret = hid_hw_open(hdev);
>  	if (ret)
>  		return ret;
>  
> +	ret = rmi_reset_attn_mode(hdev);
> +	if (ret)
> +		goto out;
> +
>  	ret = rmi_driver_resume(rmi_dev, false);
>  	if (ret) {
>  		hid_warn(hdev, "Failed to resume device: %d\n", ret);
> -		return ret;
> +		goto out;
>  	}
>  
> -	return 0;
> +out:
> +	hid_hw_close(hdev);
> +	return ret;
>  }
>  #endif /* CONFIG_PM */
>  
> -- 
> 2.13.3
> 
