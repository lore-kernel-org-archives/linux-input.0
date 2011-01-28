From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] hid-multitouch: introduce IrTouch Infrared USB device
Date: Fri, 28 Jan 2011 18:21:39 +0100
Message-ID: <20110128172139.GB2586@polaris.bitmath.org>
References: <1296230680-2871-1-git-send-email-benjamin.tissoires@enac.fr>
 <1296230680-2871-2-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:41291 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752101Ab1A1RVG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 12:21:06 -0500
Content-Disposition: inline
In-Reply-To: <1296230680-2871-2-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 28, 2011 at 05:04:40PM +0100, Benjamin Tissoires wrote:
> The product id is the 42 inches one. I don't know if they have
> other product id for the other size, or if it is a per-size product id.
> 
> Tested-by: Victor Zhuk <v.zhuk@acs-ltd.ru>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> ---

The canonical patch description presents the reason for the change,
and what the patch does (not necessarily how).

>  drivers/hid/Kconfig          |    1 +
>  drivers/hid/hid-ids.h        |    3 +++
>  drivers/hid/hid-multitouch.c |    5 +++++
>  3 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 24cca2f..a0b117d 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -304,6 +304,7 @@ config HID_MULTITOUCH
>  	  Say Y here if you have one of the following devices:
>  	  - Cypress TrueTouch panels
>  	  - Hanvon dual touch panels
> +	  - IrTouch Infrared USB panels
>  	  - Pixcir dual touch panels
>  	  - 'Sensing Win7-TwoFinger' panel by GeneralTouch
>  
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 92a0d61..b1dd7ad 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -333,6 +333,9 @@
>  #define USB_VENDOR_ID_IMATION		0x0718
>  #define USB_DEVICE_ID_DISC_STAKKA	0xd000
>  
> +#define USB_VENDOR_ID_IRTOUCHSYSTEMS	0x6615
> +#define USB_DEVICE_ID_IRTOUCH_INFRARED_USB	0x0070
> +
>  #define USB_VENDOR_ID_JESS		0x0c45
>  #define USB_DEVICE_ID_JESS_YUREX	0x1010
>  
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index ffe2a76..1629296 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -475,6 +475,11 @@ static const struct hid_device_id mt_devices[] = {
>  		HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
>  			USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS) },
>  
> +	/* IRTOUCH panels */
> +	{ .driver_data = MT_CLS_DUAL_INRANGE_CONTACTID,
> +		HID_USB_DEVICE(USB_VENDOR_ID_IRTOUCHSYSTEMS,
> +			USB_DEVICE_ID_IRTOUCH_INFRARED_USB) },
> +
>  	/* PixCir-based panels */
>  	{ .driver_data = MT_CLS_DUAL_INRANGE_CONTACTID,
>  		HID_USB_DEVICE(USB_VENDOR_ID_HANVON,
> -- 
> 1.7.3.4
> 

Thanks,
Henrik
