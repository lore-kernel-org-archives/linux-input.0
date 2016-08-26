From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH -next] HID: intel_ish-hid: Convert list_for_each to
 entry variant
Date: Fri, 26 Aug 2016 11:58:03 -0700
Message-ID: <1472237883.2694.3.camel@linux.intel.com>
References: <1471793398-24008-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:23560 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751610AbcHZS6z (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 Aug 2016 14:58:55 -0400
In-Reply-To: <1471793398-24008-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

On Sun, 2016-08-21 at 15:29 +0000, Wei Yongjun wrote:
> convert list_for_each() to list_for_each_entry() where
> applicable.
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/hid/intel-ish-hid/ishtp/bus.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c
> b/drivers/hid/intel-ish-hid/ishtp/bus.c
> index 0183eac..8a1bb8c 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/bus.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
> @@ -380,11 +380,9 @@ static struct ishtp_cl_device
> *ishtp_bus_add_device(struct ishtp_device *dev,
>  	struct ishtp_cl_device *device;
>  	int status;
>  	unsigned long flags;
> -	struct list_head *pos;
>  
>  	spin_lock_irqsave(&dev->device_list_lock, flags);
> -	list_for_each(pos, &dev->device_list) {
> -		device = list_entry(pos, struct ishtp_cl_device,
> device_link);
> +	list_for_each_entry(device, &dev->device_list, device_link)
> {
>  		if (!strcmp(name, dev_name(&device->dev))) {
>  			device->fw_client = &dev->fw_clients[
>  				dev->fw_client_presentation_num -
> 1];
> 
> 
> 
