From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [hid] Add the GYR4101US USB ID to hid-gyration
Date: Sat, 22 May 2010 13:07:40 -0700
Message-ID: <20100522200740.GA30464@core.coreip.homeip.net>
References: <1274558428-1799-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:38692 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758026Ab0EVUHr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 May 2010 16:07:47 -0400
Received: by pxi18 with SMTP id 18so912804pxi.19
        for <linux-input@vger.kernel.org>; Sat, 22 May 2010 13:07:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1274558428-1799-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi Cory,

On Sat, May 22, 2010 at 01:00:28PM -0700, Cory Maccarrone wrote:
> This change adds in the USB product ID for the Gyration
> GYR4101US USB media center remote control.  This remote
> is similar enough to the other two devices that this driver
> can be used without any other changes to get full support
> for the remote.
> 
> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>

Please send HID-related stuff to Jiri (CCed).

Thanks!

> ---
>  drivers/hid/hid-core.c     |    1 +
>  drivers/hid/hid-gyration.c |    1 +
>  drivers/hid/hid-ids.h      |    1 +
>  3 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 368fbb0..6efc814 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1309,6 +1309,7 @@ static const struct hid_device_id hid_blacklist[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, 0x0012) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE_2) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE_3) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_ID_KS_SLIMBLADE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_ERGO_525V) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LABTEC, USB_DEVICE_ID_LABTEC_WIRELESS_KEYBOARD) },
> diff --git a/drivers/hid/hid-gyration.c b/drivers/hid/hid-gyration.c
> index cab13e8..9de37d0 100644
> --- a/drivers/hid/hid-gyration.c
> +++ b/drivers/hid/hid-gyration.c
> @@ -70,6 +70,7 @@ static int gyration_event(struct hid_device *hdev, struct hid_field *field,
>  static const struct hid_device_id gyration_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE_2) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE_3) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, gyration_devices);
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 72c05f9..33ae92d 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -266,6 +266,7 @@
>  #define USB_VENDOR_ID_GYRATION		0x0c16
>  #define USB_DEVICE_ID_GYRATION_REMOTE	0x0002
>  #define USB_DEVICE_ID_GYRATION_REMOTE_2 0x0003
> +#define USB_DEVICE_ID_GYRATION_REMOTE_3 0x0008
>  
>  #define USB_VENDOR_ID_HAPP		0x078b
>  #define USB_DEVICE_ID_UGCI_DRIVING	0x0010
> -- 
> 1.7.0.4
> 

-- 
Dmitry
