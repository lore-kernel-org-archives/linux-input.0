From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: remove 2 unused usbh.h includes
Date: Fri, 27 Feb 2015 00:37:52 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502270037050.19920@pobox.suse.cz>
References: <1424975988-18094-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424975988-18094-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 26 Feb 2015, Benjamin Tissoires wrote:

> These 2 are left over from the USB dependency cleaning, so there is
> no need to keep them.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I have fixed the filename in the subject :) and applied. Thanks.

> ---
>  drivers/hid/hid-multitouch.c  | 1 -
>  drivers/hid/hid-steelseries.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index f65e78b..b61715f 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -42,7 +42,6 @@
>  #include <linux/hid.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> -#include <linux/usb.h>
>  #include <linux/input/mt.h>
>  #include <linux/string.h>
>  
> diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
> index 29f328f..3edd4ac 100644
> --- a/drivers/hid/hid-steelseries.c
> +++ b/drivers/hid/hid-steelseries.c
> @@ -12,7 +12,6 @@
>   */
>  
>  #include <linux/device.h>
> -#include <linux/usb.h>
>  #include <linux/hid.h>
>  #include <linux/module.h>
>  
> -- 
> 2.1.0
> 

-- 
Jiri Kosina
SUSE Labs
