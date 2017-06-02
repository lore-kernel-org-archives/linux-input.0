From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] HID: apple: Use country code to detect ISO keyboards
Date: Fri, 2 Jun 2017 09:18:27 +0200
Message-ID: <20170602071827.GI1293@mail.corp.redhat.com>
References: <20170602055411.1965-1-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750772AbdFBHSg (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 2 Jun 2017 03:18:36 -0400
Content-Disposition: inline
In-Reply-To: <20170602055411.1965-1-alexhenrie24@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: jikos@kernel.org, jirislaby@gmail.com, stefan@glasen-hardt.de, ryan@finnie.org, morbidrsa@gmail.com, dan@pwienterprises.com, andreas.krist@gmail.com, rydberg@bitmath.org, lukas@wunner.de, linux-input@vger.kernel.org

Hi,

On Jun 01 2017 or thereabouts, Alex Henrie wrote:
> At least on newer laptops, Apple uses the same USB ID for both ISO and
> ANSI keyboards. However, they have been good about filling in the
> bCountryCode field in the HID descriptor on all of their keyboards. A
> value of 13 indicates an ISO layout and other values indicate various
> ANSI layouts.
> 
> With this patch, users of Apple US keyboards will no longer have to run
> `echo 0 > /sys/module/hid_apple/parameters/iso_layout` to get a working
> tilde key.
> 
> Please test this patch and send feedback if you have a Macbook or an
> Apple keyboard.
> 
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  drivers/hid/hid-apple.c | 56 +++++++++++++++++++++----------------------------
>  1 file changed, 24 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 2e046082210f..f180932fdeaa 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -28,7 +28,6 @@
>  #define APPLE_IGNORE_MOUSE	0x0002
>  #define APPLE_HAS_FN		0x0004
>  #define APPLE_HIDDEV		0x0008
> -#define APPLE_ISO_KEYBOARD	0x0010

Also note that in addition to what Jiri said, this is kABI now. People
can change this settings from user-space by adding it into a new_id.
So you should probably add a comment here:
/* 0x0010 reserved, was: APPLE_ISO_KEYBOARD */

This will prevent future submissions to fill the gap and have users
having custom configurations that suddenly break.

>  #define APPLE_MIGHTYMOUSE	0x0020
>  #define APPLE_INVERT_HWHEEL	0x0040
>  #define APPLE_IGNORE_HIDINPUT	0x0080
> @@ -247,7 +246,7 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
>  	}
>  
>  	if (iso_layout) {
> -		if (asc->quirks & APPLE_ISO_KEYBOARD) {
> +		if (hid->country == 13) {

Just nitpicking here. I'd prefer see the value 13 in a #define. Just
because it'll be easier to re-read this later.

Cheers,
Benjamin

>  			trans = apple_find_translation(apple_iso_keyboard, usage->code);
>  			if (trans) {
>  				input_event(input, usage->type, trans->to, value);
> @@ -412,60 +411,54 @@ static const struct hid_device_id apple_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ANSI),
>  		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ISO),
> -		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
> -			APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_JIS),
>  		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ANSI),
>  		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ISO),
> -		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
> -			APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_JIS),
>  		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
>  			APPLE_RDESC_JIS },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ANSI),
>  		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ISO),
> -		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
> -			APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_JIS),
>  		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
>  			APPLE_RDESC_JIS },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_MINI_ANSI),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_MINI_ISO),
> -		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_MINI_JIS),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_ANSI),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_ISO),
> -		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_JIS),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ANSI),
>  		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ISO),
> -		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
> -			APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_JIS),
>  		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
>  			APPLE_RDESC_JIS },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_REVB_ANSI),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_REVB_ISO),
> -		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_REVB_JIS),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI),
>  		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_ISO),
> -		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
> -			APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO),
> -		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
> -			APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
>  				USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI),
>  		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
> @@ -479,86 +472,85 @@ static const struct hid_device_id apple_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ANSI),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ISO),
> -		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_JIS),
>  		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_ANSI),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_ISO),
> -		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_JIS),
>  		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING3_ANSI),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING3_ISO),
> -		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING3_JIS),
>  		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING4_ISO),
> -		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING4_JIS),
>  		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING4A_ANSI),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING4A_ISO),
> -		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS),
>  		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5_ANSI),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5_ISO),
> -		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5_JIS),
>  		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6_ANSI),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6_ISO),
> -		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6_JIS),
>  		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_ANSI),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_ISO),
> -		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS),
>  		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5A_ANSI),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5A_ISO),
> -		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5A_JIS),
>  		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7_ANSI),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7_ISO),
> -		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7_JIS),
>  		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7A_ANSI),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7A_ISO),
> -		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7A_JIS),
>  		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING8_ISO),
> -		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING8_JIS),
>  		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_ANSI),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_ISO),
> -		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_JIS),
>  		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI),
>  		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO),
> -		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
> -			APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_JIS),
>  		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY),
> -- 
> 2.13.0
> 
