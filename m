From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/2] HID: Add Saitek X52 to the HID IDs
Date: Mon, 5 Aug 2019 14:12:40 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1908051411410.5899@cbobk.fhfr.pm>
References: <20190724180806.5745-1-ivaradi@varadiistvan.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724180806.5745-1-ivaradi@varadiistvan.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Istv=E1n_V=E1radi?= <ivaradi@varadiistvan.hu>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 24 Jul 2019, István Váradi wrote:

> The USB device ID of the Saitek X52 joystick is added as a
> define to hid-ids.h.
> 
> Signed-off-by: István Váradi <ivaradi@varadiistvan.hu>
> ---
>  drivers/hid/hid-ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 0d695f8e1b2c..3a90962614ef 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -989,6 +989,7 @@
>  #define USB_DEVICE_ID_SAITEK_RAT7	0x0cd7
>  #define USB_DEVICE_ID_SAITEK_RAT9	0x0cfa
>  #define USB_DEVICE_ID_SAITEK_MMO7	0x0cd0
> +#define USB_DEVICE_ID_SAITEK_X52	0x075c
>  
>  #define USB_VENDOR_ID_SAMSUNG		0x0419
>  #define USB_DEVICE_ID_SAMSUNG_IR_REMOTE	0x0001

István,

thanks for the fix. I don't think it's necessary to have this as a 
split-out change from the quirk addition. I've squashed the two patches 
into one, and applied to for-5.3/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs
