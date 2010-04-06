From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Fix for N-trig touch panel with recent firmware
Date: Tue, 6 Apr 2010 23:06:53 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004062302310.8345@pobox.suse.cz>
References: <20100406202258.837F19520E@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60790 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756438Ab0DFVGz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Apr 2010 17:06:55 -0400
In-Reply-To: <20100406202258.837F19520E@smtp.lii-enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@lii-enac.fr>
Cc: linux-input@vger.kernel.org, micki@n-trig.com, rafi@seas.upenn.edu, dmitry.torokhov@gmail.com, chatty@enac.fr

On Tue, 6 Apr 2010, Stephane Chatty wrote:

> Added an init message that avoids device freeze with recent firmware.
> 
> Signed-off-by: Stephane Chatty <chatty@enac.fr>
> Tested-by: Rafi Rubin <rafi@seas.upenn.edu>
> 
> diff -rupN a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
> --- a/drivers/hid/hid-ntrig.c	2010-03-20 02:17:57.000000000 +0100
> +++ b/drivers/hid/hid-ntrig.c	2010-04-02 01:06:11.000000000 +0200
> @@ -1,8 +1,8 @@
>  /*
>   *  HID driver for N-Trig touchscreens
>   *
> - *  Copyright (c) 2008 Rafi Rubin
> - *  Copyright (c) 2009 Stephane Chatty
> + *  Copyright (c) 2008-2010 Rafi Rubin
> + *  Copyright (c) 2009-2010 Stephane Chatty
>   *
>   */
>  
> @@ -16,6 +16,8 @@
>  #include <linux/device.h>
>  #include <linux/hid.h>
>  #include <linux/module.h>
> +#include <linux/usb.h>
> +#include "usbhid/usbhid.h"
>  
>  #include "hid-ids.h"
>  
> @@ -285,6 +287,7 @@ static int ntrig_probe(struct hid_device
>  	struct ntrig_data *nd;
>  	struct hid_input *hidinput;
>  	struct input_dev *input;
> +	struct hid_report *report;
>  
>  	if (id->driver_data)
>  		hdev->quirks |= HID_QUIRK_MULTI_INPUT;
> @@ -348,6 +351,11 @@ static int ntrig_probe(struct hid_device
>  		}
>  	}
>  
> +	report = hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0x0a]; 
> +	if (report)
> +		usbhid_submit_report(hdev, report, USB_DIR_OUT);
> +
> +

Thanks guys, I have queued the patch in my tree.

I will also put a one-line comment above this chunk of code to explain why 
is it actually needed, if you don't mind.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
