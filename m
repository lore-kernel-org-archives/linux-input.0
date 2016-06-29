From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: xpad - validate USB endpoint count during probe
Date: Wed, 29 Jun 2016 10:08:06 -0700
Message-ID: <20160629170806.GA35304@dtor-ws>
References: <577362E7.2000508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33310 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbcF2RIK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2016 13:08:10 -0400
Received: by mail-pf0-f196.google.com with SMTP id c74so4997260pfb.0
        for <linux-input@vger.kernel.org>; Wed, 29 Jun 2016 10:08:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <577362E7.2000508@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Wed, Jun 29, 2016 at 12:55:51AM -0500, Cameron Gutman wrote:
> This prevents a malicious USB device from causing an oops.
> 
> Signed-off-by: Cameron Gutman <aicommander@gmail.com>
> Cc: stable@vger.kernel.org
> ---

Applied, thank you.

>  drivers/input/joystick/xpad.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 3438e98..a529a45 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1431,6 +1431,9 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>  	int ep_irq_in_idx;
>  	int i, error;
>  
> +	if (intf->cur_altsetting->desc.bNumEndpoints != 2)
> +		return -ENODEV;
> +
>  	for (i = 0; xpad_device[i].idVendor; i++) {
>  		if ((le16_to_cpu(udev->descriptor.idVendor) == xpad_device[i].idVendor) &&
>  		    (le16_to_cpu(udev->descriptor.idProduct) == xpad_device[i].idProduct))
> -- 
> 2.7.4

-- 
Dmitry
