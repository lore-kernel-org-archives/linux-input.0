From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] synaptics_usb: Remove TrackPoint name trailing whitespace
Date: Sat, 7 Jul 2012 17:52:20 -0700
Message-ID: <20120708005220.GB19007@core.coreip.homeip.net>
References: <20120706122817.4ff2cdbf@atom.pigiron.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35100 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab2GHAwZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Jul 2012 20:52:25 -0400
Content-Disposition: inline
In-Reply-To: <20120706122817.4ff2cdbf@atom.pigiron.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bob Ross <pigiron@gmx.com>
Cc: Jan Steinhoff <mail@jan-steinhoff.de>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jul 06, 2012 at 12:28:17PM -0500, Bob Ross wrote:
> 
> The USB TrackPoint name string contains a space at the trailing end that
> can cause confusion/difficulty when creating udev rules. Example:
> 
>  "Synaptics Inc. Composite TouchPad / TrackPoint (Stick) "
> 
> This patch removes the trailing space.
> 
> Signed-off-by: Bob Ross <pigiron@gmx.com>

Applied, thank you Bob.

> ---
> This patch was based from the "torvalds" git tree.
> 
>  drivers/input/mouse/synaptics_usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/synaptics_usb.c b/drivers/input/mouse/synaptics_usb.c
> index 3c5eaaa..64cf34e 100644
> --- a/drivers/input/mouse/synaptics_usb.c
> +++ b/drivers/input/mouse/synaptics_usb.c
> @@ -364,7 +364,7 @@ static int synusb_probe(struct usb_interface *intf,
>  			 le16_to_cpu(udev->descriptor.idProduct));
>  
>  	if (synusb->flags & SYNUSB_STICK)
> -		strlcat(synusb->name, " (Stick) ", sizeof(synusb->name));
> +		strlcat(synusb->name, " (Stick)", sizeof(synusb->name));
>  
>  	usb_make_path(udev, synusb->phys, sizeof(synusb->phys));
>  	strlcat(synusb->phys, "/input0", sizeof(synusb->phys));
> -- 
> 1.7.11
> 

-- 
Dmitry
