From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: [PATCH RESEND 1/2] HID: hid-sensor-hub: Remove setting
 hdev->claimed before calling hid_hw_start()
Date: Wed, 19 Sep 2012 15:32:24 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A919D532A1@ORSMSX108.amr.corp.intel.com>
References: <1347929533.6562.0.camel@phoenix>
 <alpine.LNX.2.00.1209191345360.31149@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56966 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754287Ab2ISPc0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Sep 2012 11:32:26 -0400
In-Reply-To: <alpine.LNX.2.00.1209191345360.31149@pobox.suse.cz>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Axel Lin <axel.lin@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

I felt subject line was too long. Minor change in subject line. Tested and added my ack for both of these patches.

Thanks,
Srinivas

-----Original Message-----
From: Jiri Kosina [mailto:jkosina@suse.cz] 
Sent: Wednesday, September 19, 2012 4:46 AM
To: Axel Lin
Cc: Jonathan Cameron; Pandruvada, Srinivas; linux-input@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] HID: hid-sensor-hub: Remove setting hdev->claimed before calling hid_hw_start()

On Tue, 18 Sep 2012, Axel Lin wrote:

> Current implementation of hid_hw_start() allows connect_mask to be 0.
> Setting hdev->claimed = HID_CLAIMED_INPUT before calling 
> hid_hw_start() is not necessary. Remove it.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Jonathan, please take it on top of the other changes.

Thanks.

> ---
>  drivers/hid/hid-sensor-hub.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-hub.c 
> b/drivers/hid/hid-sensor-hub.c index 4ac759c..1faacf2 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -539,7 +539,6 @@ static int sensor_hub_probe(struct hid_device *hdev,
>  	}
>  	INIT_LIST_HEAD(&hdev->inputs);
>  
> -	hdev->claimed = HID_CLAIMED_INPUT;
>  	ret = hid_hw_start(hdev, 0);
>  	if (ret) {
>  		hid_err(hdev, "hw start failed\n"); @@ -627,7 +626,6 @@ static void 
> sensor_hub_remove(struct hid_device *hdev)
>  	int i;
>  
>  	hid_dbg(hdev, " hardware removed\n");
> -	hdev->claimed &= ~HID_CLAIMED_INPUT;
>  	hid_hw_stop(hdev);
>  	hid_hw_close(hdev);
>  	spin_lock_irqsave(&data->lock, flags);
> --
> 1.7.9.5
> 
> 
> 

--
Jiri Kosina
SUSE Labs
