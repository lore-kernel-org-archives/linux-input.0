From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH RESEND] HID: uclogic: add support for Ugee Tablet EX07S
Date: Fri, 31 Mar 2017 10:52:14 +0200
Message-ID: <20170331085214.GE22683@mail.corp.redhat.com>
References: <78f2649b-3df2-14eb-7df5-0bb33922d5ab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754597AbdCaIw1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 31 Mar 2017 04:52:27 -0400
Content-Disposition: inline
In-Reply-To: <78f2649b-3df2-14eb-7df5-0bb33922d5ab@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiaolei Yu <dreifachstein@gmail.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org

On Mar 30 2017 or thereabouts, Xiaolei Yu wrote:
> This device has a different vendor id but responds to
> initialization.
> 
> Signed-off-by: Xiaolei Yu <dreifachstein@gmail.com>
> ---

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/hid-core.c    | 1 +
>  drivers/hid/hid-ids.h     | 3 +++
>  drivers/hid/hid-uclogic.c | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 3ceb4a2af381..004871cf0d58 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2096,6 +2096,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UGEE_TABLET_45) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_DRAWIMAGE_G3) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_UGTIZER, USB_DEVICE_ID_UGTIZER_TABLET_GP0610) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_TABLET_EX07S) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SUPER_JOY_BOX_3) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_DUAL_USB_JOYPAD) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 0e2e7c571d22..b85a77bb9d29 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -1028,6 +1028,9 @@
>  #define USB_DEVICE_ID_UGEE_TABLET_45		0x0045
>  #define USB_DEVICE_ID_YIYNOVA_TABLET		0x004d
>  
> +#define USB_VENDOR_ID_UGEE		0x28bd
> +#define USB_DEVICE_ID_UGEE_TABLET_EX07S		0x0071
> +
>  #define USB_VENDOR_ID_UNITEC	0x227d
>  #define USB_DEVICE_ID_UNITEC_USB_TOUCH_0709	0x0709
>  #define USB_DEVICE_ID_UNITEC_USB_TOUCH_0A19	0x0a19
> diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
> index 1509d7287ff3..e3e6e5c893cc 100644
> --- a/drivers/hid/hid-uclogic.c
> +++ b/drivers/hid/hid-uclogic.c
> @@ -977,6 +977,7 @@ static int uclogic_probe(struct hid_device *hdev,
>  		}
>  		break;
>  	case USB_DEVICE_ID_UGTIZER_TABLET_GP0610:
> +	case USB_DEVICE_ID_UGEE_TABLET_EX07S:
>  		/* If this is the pen interface */
>  		if (intf->cur_altsetting->desc.bInterfaceNumber == 1) {
>  			rc = uclogic_tablet_enable(hdev);
> @@ -1069,6 +1070,7 @@ static const struct hid_device_id uclogic_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UGEE_TABLET_45) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_DRAWIMAGE_G3) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_UGTIZER, USB_DEVICE_ID_UGTIZER_TABLET_GP0610) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_TABLET_EX07S) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, uclogic_devices);
> -- 
> 2.11.0
> 
