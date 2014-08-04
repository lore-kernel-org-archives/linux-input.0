From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hyperv: register as a wakeup source
Date: Mon, 4 Aug 2014 11:23:09 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1408041122550.1368@pobox.suse.cz>
References: <1406903201-7210-1-git-send-email-decui@microsoft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55366 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108AbaHDJXL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Aug 2014 05:23:11 -0400
In-Reply-To: <1406903201-7210-1-git-send-email-decui@microsoft.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dexuan Cui <decui@microsoft.com>
Cc: gregkh@linuxfoundation.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, driverdev-devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com, kys@microsoft.com, haiyangz@microsoft.com

On Fri, 1 Aug 2014, Dexuan Cui wrote:

> With this patch, we can move the mouse to wake up the VM after the VM executes
> "echo freeze > /sys/power/state".
> 
> This addresses part of https://bugzilla.redhat.com/show_bug.cgi?id=1086100
> 
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Applied, thanks.

> ---
>  drivers/hid/hid-hyperv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index f52dbcb..31fad64 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -308,6 +308,9 @@ static void mousevsc_on_receive(struct hv_device *device,
>  		memcpy(input_dev->input_buf, input_report->buffer, len);
>  		hid_input_report(input_dev->hid_device, HID_INPUT_REPORT,
>  				 input_dev->input_buf, len, 1);
> +
> +		pm_wakeup_event(&input_dev->device->device, 0);
> +
>  		break;
>  	default:
>  		pr_err("unsupported hid msg type - type %d len %d",
> @@ -549,6 +552,8 @@ static int mousevsc_probe(struct hv_device *device,
>  		goto probe_err2;
>  	}
>  
> +	device_init_wakeup(&device->device, true);
> +
>  	input_dev->connected = true;
>  	input_dev->init_complete = true;
>  
> @@ -571,6 +576,7 @@ static int mousevsc_remove(struct hv_device *dev)
>  {
>  	struct mousevsc_dev *input_dev = hv_get_drvdata(dev);
>  
> +	device_init_wakeup(&dev->device, false);
>  	vmbus_close(dev->channel);
>  	hid_hw_stop(input_dev->hid_device);
>  	hid_destroy_device(input_dev->hid_device);
> -- 
> 1.9.1
> 

-- 
Jiri Kosina
SUSE Labs
