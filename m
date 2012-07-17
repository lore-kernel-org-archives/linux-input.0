From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] HID: Allow drivers without listeners to remain on the bus
Date: Tue, 17 Jul 2012 23:50:45 +0200
Message-ID: <20120717215045.GA562@polaris.bitmath.org>
References: <1342559541-22421-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:35991 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756830Ab2GQVtz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Jul 2012 17:49:55 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id 35ADCD82D
	for <linux-input@vger.kernel.org>; Tue, 17 Jul 2012 23:49:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1342559541-22421-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

Hi David,

> hid-picolcd and hid-wiimote do not allow any of hidinput, hiddev or hidraw
> to claim the device but still want to remain on the bus. Hence, if a
> driver uses the raw_event callback but no listener claimed the device, we
> still leave it on the bus as the driver probably handles everything by
> itself.
> 
> Under some circumstances (eg., hidinput_connect() fails and raw_event set)
> a device may not be left on the bus even though it has no listeners. But
> then if hidinput_connect() fails there are bigger issues than a device
> that is left unhandled. So we can safely use this heuristic to avoid
> adding another flag for special devices like hid-picolcd and hid-wiimote.
> 
> This also removes the ugly hack from hid-picolcd as this is no longer
> required.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
> Hi Jiri
> 
> I posted another patchset that introduced HID_CLAIMED_OTHER to avoid this
> heuristic but Henrik convinced me that this trivial check is the cleaner and
> less intrusive implementation. If you're interested, the old patchset was here:
>   http://thread.gmane.org/gmane.linux.kernel.input/25945
> 
> Henrik, can you add your signed-off-by as this was your idea?

Gladly, but I would like to change the wording slightly, since a driver
with raw_event set is a listener, and we are still bailing out if
there are no listeners at all. The title is thus misleading.

> 
> Thanks
> David
> 
>  drivers/hid/hid-core.c    | 8 ++++++--
>  drivers/hid/hid-picolcd.c | 4 ----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 9cdc74e..83ca3ba 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1373,8 +1373,12 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
>  	if ((connect_mask & HID_CONNECT_HIDRAW) && !hidraw_connect(hdev))
>  		hdev->claimed |= HID_CLAIMED_HIDRAW;
>  
> -	if (!hdev->claimed) {
> -		hid_err(hdev, "claimed by neither input, hiddev nor hidraw\n");
> +	/* There are device drivers that do not allow hidinput, hiddev or
> +	 * hidraw to be connected but still want to remain on the bus. We
> +	 * require that these devices use the raw_event callback. Otherwise, we
> +	 * simply remove them from the bus if no listener claimed them. */

How about "Drivers using raw_event() are not required to connect to anything else"?

> +	if (!hdev->claimed && !hdev->driver->raw_event) {
> +		hid_err(hdev, "device has no listeners, quitting\n");
>  		return -ENODEV;
>  	}
>  
> diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
> index 45c3433..74c388d 100644
> --- a/drivers/hid/hid-picolcd.c
> +++ b/drivers/hid/hid-picolcd.c
> @@ -2613,11 +2613,7 @@ static int picolcd_probe(struct hid_device *hdev,
>  		goto err_cleanup_data;
>  	}
>  
> -	/* We don't use hidinput but hid_hw_start() fails if nothing is
> -	 * claimed. So spoof claimed input. */
> -	hdev->claimed = HID_CLAIMED_INPUT;
>  	error = hid_hw_start(hdev, 0);
> -	hdev->claimed = 0;
>  	if (error) {
>  		hid_err(hdev, "hardware start failed\n");
>  		goto err_cleanup_data;
> -- 
> 1.7.11.2
> 

Thanks,
Henrik
