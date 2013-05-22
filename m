From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: usbhid: ignore Jabra speakerphones HID interface
Date: Wed, 22 May 2013 23:27:58 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1305222327300.22195@pobox.suse.cz>
References: <1369257474-26389-1-git-send-email-vpalatin@chromium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369257474-26389-1-git-send-email-vpalatin@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Palatin <vpalatin@chromium.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Olof Johansson <olofj@chromium.org>
List-Id: linux-input@vger.kernel.org

On Wed, 22 May 2013, Vincent Palatin wrote:

> Add a quirk to ignore Jabra speakerphone 410 and 510 devices HID
> interface.
> On those devices, the USB audio interface is working nicely,
> but the HID interface is not working with the kernel usbhid driver,
> and it requires a specific userspace program.
> We could unbind it from userspace but just attaching the usbhid driver has
> sometimes nasty effects:
> either confusing the device state machine or triggering a storm of volume key
> events making eventual sound UI blinking like crazy.
> 
> Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
> ---
>  drivers/hid/hid-ids.h           | 4 ++++
>  drivers/hid/usbhid/hid-quirks.c | 3 +++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 38535c9..533815b 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -447,6 +447,10 @@
>  #define USB_VENDOR_ID_IRTOUCHSYSTEMS	0x6615
>  #define USB_DEVICE_ID_IRTOUCH_INFRARED_USB	0x0070
>  
> +#define USB_VENDOR_ID_JABRA		0x0b0e
> +#define USB_DEVICE_ID_JABRA_SPEAK_410	0x0412
> +#define USB_DEVICE_ID_JABRA_SPEAK_510	0x0420
> +
>  #define USB_VENDOR_ID_JESS		0x0c45
>  #define USB_DEVICE_ID_JESS_YUREX	0x1010
>  
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index 19b8360..d8c9aaf 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -109,6 +109,9 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X, HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X, HID_QUIRK_MULTI_INPUT },
> +
> +	{ USB_VENDOR_ID_JABRA, USB_DEVICE_ID_JABRA_SPEAK_410, HID_QUIRK_IGNORE },
> +	{ USB_VENDOR_ID_JABRA, USB_DEVICE_ID_JABRA_SPEAK_510, HID_QUIRK_IGNORE },
>  	{ 0, 0 }
>  };

Please do this in hid_ignore_list[] in drivers/hid/hid-core.c instead.

Thanks,

-- 
Jiri Kosina
SUSE Labs
