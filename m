From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] Fix for N-trig touch panel with recent firmware
Date: Tue, 06 Apr 2010 16:28:00 -0400
Message-ID: <4BBB9950.7090004@seas.upenn.edu>
References: <20100406202258.837F19520E@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:58664 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab0DFU21 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Apr 2010 16:28:27 -0400
In-Reply-To: <20100406202258.837F19520E@smtp.lii-enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@lii-enac.fr>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, micki@n-trig.com, dmitry.torokhov@gmail.com, chatty@enac.fr

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I can confirm I tested this patch.  On a side note, Micki, you are quite right,
sending the reports does need to come after starting the device.

Rafi

Stephane Chatty wrote:
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
>  	return 0;
>  err_free:
>  	kfree(nd);
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAku7mVAACgkQwuRiAT9o609EcACdHm83W1+a78Cudgg0Hn2bXNV/
FzgAnipS24BjtTvTi691db4NzPcViZqx
=AIfV
-----END PGP SIGNATURE-----
