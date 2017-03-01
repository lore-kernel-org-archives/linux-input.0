From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] hid: usbhid: usbkbd: fix checkpatch.pl issues
Date: Wed, 1 Mar 2017 10:16:28 -0800
Message-ID: <20170301181628.GD30349@dtor-ws>
References: <48d55583-6f2d-cfda-c6dd-0e789f4bf6f1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36642 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbdCASQd (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 1 Mar 2017 13:16:33 -0500
Content-Disposition: inline
In-Reply-To: <48d55583-6f2d-cfda-c6dd-0e789f4bf6f1@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Avraham Shukron <avraham.shukron@gmail.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Avraham,

On Tue, Feb 21, 2017 at 07:26:50PM +0200, Avraham Shukron wrote:
> - Broke long lines
> - Added spaces where needed
> - Removed unnecessary / trailing whitespaces
> - Extracted assignments outside of 'if' statements
> 
> Signed-off-by: Avraham Shukron <avraham.shukron@gmail.com>
> ---
>  drivers/hid/usbhid/usbkbd.c | 121 ++++++++++++++++++++++++++------------------
>  1 file changed, 72 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkbd.c
> index 7fb2d1e..ae40b0d 100644
> --- a/drivers/hid/usbhid/usbkbd.c
> +++ b/drivers/hid/usbhid/usbkbd.c
> @@ -45,22 +45,24 @@ MODULE_DESCRIPTION(DRIVER_DESC);
>  MODULE_LICENSE("GPL");
> 
>  static const unsigned char usb_kbd_keycode[256] = {
> -	  0,  0,  0,  0, 30, 48, 46, 32, 18, 33, 34, 35, 23, 36, 37, 38,
> -	 50, 49, 24, 25, 16, 19, 31, 20, 22, 47, 17, 45, 21, 44,  2,  3,
> -	  4,  5,  6,  7,  8,  9, 10, 11, 28,  1, 14, 15, 57, 12, 13, 26,
> -	 27, 43, 43, 39, 40, 41, 51, 52, 53, 58, 59, 60, 61, 62, 63, 64,
> -	 65, 66, 67, 68, 87, 88, 99, 70,119,110,102,104,111,107,109,106,
> -	105,108,103, 69, 98, 55, 74, 78, 96, 79, 80, 81, 75, 76, 77, 71,
> -	 72, 73, 82, 83, 86,127,116,117,183,184,185,186,187,188,189,190,
> -	191,192,193,194,134,138,130,132,128,129,131,137,133,135,136,113,
> -	115,114,  0,  0,  0,121,  0, 89, 93,124, 92, 94, 95,  0,  0,  0,
> -	122,123, 90, 91, 85,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
> -	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
> -	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
> -	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
> -	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
> -	 29, 42, 56,125, 97, 54,100,126,164,166,165,163,161,115,114,113,
> -	150,158,159,128,136,177,178,176,142,152,173,140
> +	  0,   0,   0,   0,  30,  48,  46,  32,  18,  33,  34,  35,  23,  36,
> +	 37,  38,  50,  49,  24,  25,  16,  19,  31,  20,  22,  47,  17,  45,
> +	 21,  44,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  28,   1,
> +	 14,  15,  57,  12,  13,  26,  27,  43,  43,  39,  40,  41,  51,  52,
> +	 53,  58,  59,  60,  61,  62,  63,  64,  65,  66,  67,  68,  87,  88,
> +	 99,  70, 119, 110, 102, 104, 111, 107, 109, 106, 105, 108, 103,  69,
> +	 98,  55,  74,  78,  96,  79,  80,  81,  75,  76,  77,  71,  72,  73,
> +	 82,  83,  86, 127, 116, 117, 183, 184, 185, 186, 187, 188, 189, 190,
> +	191, 192, 193, 194, 134, 138, 130, 132, 128, 129, 131, 137, 133, 135,
> +	136, 113, 115, 114,   0,   0,   0, 121,   0,  89,  93, 124,  92,  94,
> +	 95,   0,   0,   0, 122, 123,  90,  91,  85,   0,   0,   0,   0,   0,
> +	  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
> +	  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
> +	  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
> +	  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
> +	  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
> +	 29,  42,  56, 125,  97,  54, 100, 126, 164, 166, 165, 163, 161, 115,
> +	114, 113, 150, 158, 159, 128, 136, 177, 178, 176, 142, 152, 173, 140
>  };

This kind of change is definitely not helpful. The original table was
Nx16, you converted it to Nx14. Why do you think original table used 16
columns?

Regardless, it's a very old driver, just let it be.

Thanks.

-- 
Dmitry
