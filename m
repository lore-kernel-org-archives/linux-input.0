From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] hid: remove duplicate for D-WAV eGalax 0x7224
Date: Tue, 07 May 2013 17:34:47 +0300
Message-ID: <1367937287.29283.21.camel@smile>
References: <1367936944-16249-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1367936944-16249-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14189 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341Ab3EGOe5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 May 2013 10:34:57 -0400
In-Reply-To: <1367936944-16249-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Tue, 2013-05-07 at 17:29 +0300, Andy Shevchenko wrote: 
> There is actually not clear which driver_data ahall be used.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hid/hid-ids.h        | 1 -
>  drivers/hid/hid-multitouch.c | 3 ---
>  2 files changed, 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 2378a0b..a5520ba 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -268,7 +268,6 @@
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7207	0x7207
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_720C	0x720c
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224	0x7224
> -#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224	0x7224
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_722A	0x722A
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_725E	0x725e
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7262	0x7262
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 895d140..383adc9 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1126,9 +1126,6 @@ static const struct hid_device_id mt_devices[] = {
>  	{ .driver_data = MT_CLS_EGALAX_SERIAL,
>  		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
>  			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224) },
> -	{ .driver_data = MT_CLS_EGALAX,
> -		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> -			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224) },

Ah, it seems different device definition.
So, only ID is duplicated.

>  	{ .driver_data = MT_CLS_EGALAX_SERIAL,
>  		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
>  			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_722A) },

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
