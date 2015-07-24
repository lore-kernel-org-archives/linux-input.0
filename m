From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] HID: apple: Add support for the 2015 Macbook Pro
Date: Fri, 24 Jul 2015 10:54:44 -0700
Message-ID: <20150724175444.GC2872@dtor-ws>
References: <1437759260-7748-1-git-send-email-rydberg@bitmath.org>
 <1437759260-7748-2-git-send-email-rydberg@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36175 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895AbbGXRyt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jul 2015 13:54:49 -0400
Content-Disposition: inline
In-Reply-To: <1437759260-7748-2-git-send-email-rydberg@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>

On Fri, Jul 24, 2015 at 07:34:19PM +0200, Henrik Rydberg wrote:
> This patch adds keyboard support for MacbookPro12,1 as WELLSPRING9
> (0x0272, 0x0273, 0x0274). The touchpad is handled in a separate
> bcm5974 patch, as usual.
> 
> Tested-by: John Horan <knasher@gmail.com>
> Tested-by: Jochen Radmacher <jradmacher@gmx.de>
> Tested-by: Yang Hongyang <burnef@gmail.com>
> Tested-by: Yen-Chin, Lee <coldnew.tw@gmail.com>
> Tested-by: George Hilios <ghilios@gmail.com>
> Tested-by: Janez Urevc <janez@janezurevc.name>
> Signed-off-by: Henrik Rydberg <rydberg@bitmath.org>

Jiri, do you think I can take all three in through my tree? I think it
might be worthwhile to get the changes in 4.2 still.

> ---
>  drivers/hid/hid-apple.c | 6 ++++++
>  drivers/hid/hid-core.c  | 6 ++++++
>  drivers/hid/hid-ids.h   | 3 +++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index f822fd2..884d82f 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -546,6 +546,12 @@ static const struct hid_device_id apple_devices[] = {
>  		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING8_JIS),
>  		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_ANSI),
> +		.driver_data = APPLE_HAS_FN },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_ISO),
> +		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_JIS),
> +		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI),
>  		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO),
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 157c627..e6fce23 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1782,6 +1782,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING8_ISO) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING8_JIS) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_ANSI) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_ISO) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_JIS) },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI) },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO) },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_JIS) },
> @@ -2463,6 +2466,9 @@ static const struct hid_device_id hid_mouse_ignore_list[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING8_ISO) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING8_JIS) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_ANSI) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_ISO) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_JIS) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
>  	{ }
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index b04b082..b3b225b 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -142,6 +142,9 @@
>  #define USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI	0x0290
>  #define USB_DEVICE_ID_APPLE_WELLSPRING8_ISO	0x0291
>  #define USB_DEVICE_ID_APPLE_WELLSPRING8_JIS	0x0292
> +#define USB_DEVICE_ID_APPLE_WELLSPRING9_ANSI	0x0272
> +#define USB_DEVICE_ID_APPLE_WELLSPRING9_ISO		0x0273
> +#define USB_DEVICE_ID_APPLE_WELLSPRING9_JIS		0x0274
>  #define USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY	0x030a
>  #define USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY	0x030b
>  #define USB_DEVICE_ID_APPLE_IRCONTROL	0x8240
> -- 
> 2.4.5
> 

-- 
Dmitry
