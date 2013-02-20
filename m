From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 6/7] HID: multitouch: remove usbhid dependency
Date: Wed, 20 Feb 2013 21:25:31 +0100
Message-ID: <20130220202531.GA1413@polaris.bitmath.org>
References: <1360334256-22127-1-git-send-email-benjamin.tissoires@gmail.com>
 <1360334256-22127-7-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:55141 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935700Ab3BTUYL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Feb 2013 15:24:11 -0500
Content-Disposition: inline
In-Reply-To: <1360334256-22127-7-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---
>  drivers/hid/hid-multitouch.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Since removing the transport layer dependency has a rationale, it
might be good to mention that here.

Also, what about the explicit usb dependency, was that going to be
moved to a usbhid quirk?

> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 32258ba..184ac0a 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -32,7 +32,6 @@
>  #include <linux/slab.h>
>  #include <linux/usb.h>
>  #include <linux/input/mt.h>
> -#include "usbhid/usbhid.h"
>  
>  
>  MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
> @@ -907,7 +906,7 @@ static int mt_resume(struct hid_device *hdev)
>  
>  	intf = to_usb_interface(hdev->dev.parent);
>  	interface = intf->cur_altsetting;
> -	dev = hid_to_usb_dev(hdev);
> +	dev = interface_to_usbdev(intf);
>  
>  	/* Some Elan legacy devices require SET_IDLE to be set on resume.
>  	 * It should be safe to send it to other devices too.
> -- 
> 1.8.1
> 

Thanks,
Henrik
