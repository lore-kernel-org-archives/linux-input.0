From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] HID: apple: Use country code to detect ISO keyboards
Date: Fri, 2 Jun 2017 07:50:36 +0200
Message-ID: <357294a6-1163-6608-e13e-b9e68729f714@suse.cz>
References: <20170602054544.1793-1-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33653 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbdFBFuk (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 2 Jun 2017 01:50:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id b84so16289529wmh.0
        for <linux-input@vger.kernel.org>; Thu, 01 Jun 2017 22:50:39 -0700 (PDT)
In-Reply-To: <20170602054544.1793-1-alexhenrie24@gmail.com>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alex Henrie <alexhenrie24@gmail.com>, jikos@kernel.org, benjamin.tissoires@redhat.com, stefan@glasen-hardt.de, ryan@finnie.org, morbidrsa@gmail.com, dan@pwienterprises.com, andreas.krist@gmail.com, rydberg@bitmath.org, lukas@wunner.de, linux-input@vger.kernel.org

On 06/02/2017, 07:45 AM, Alex Henrie wrote:
> At least on newer laptops, Apple uses the same USB ID for both ISO and
> ANSI keyboards. However, they have been good about filling in the
> bCountryCode field in the HID descriptor on all of their keyboards. A
> value of 13 indicates an ISO layout and other values indicate various
> country-specific ANSI layouts.
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
>  drivers/hid/hid-apple.c | 64 ++++++++++++++++++++++---------------------------
>  1 file changed, 28 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 2e046082210f..77396400bbd8 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -28,11 +28,10 @@
>  #define APPLE_IGNORE_MOUSE	0x0002
>  #define APPLE_HAS_FN		0x0004
>  #define APPLE_HIDDEV		0x0008
> -#define APPLE_ISO_KEYBOARD	0x0010
> -#define APPLE_MIGHTYMOUSE	0x0020
> -#define APPLE_INVERT_HWHEEL	0x0040
> -#define APPLE_IGNORE_HIDINPUT	0x0080
> -#define APPLE_NUMLOCK_EMULATION	0x0100
> +#define APPLE_MIGHTYMOUSE	0x0010
> +#define APPLE_INVERT_HWHEEL	0x0020
> +#define APPLE_IGNORE_HIDINPUT	0x0040
> +#define APPLE_NUMLOCK_EMULATION	0x0080

I wouldn't recommend renumbering as it is a nightmare for backporting.
Just leave there a gap.

thanks,
-- 
js
suse labs
