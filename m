From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] hid:hid-multitouch: add mt_resume for ELAN's production
Date: Wed, 8 Aug 2012 11:08:12 +0200
Message-ID: <CAN+gG=FTZwX-fLdodD-P=F8NdC-9V0cQR2ZecR3SjhSQPjoTAA@mail.gmail.com>
References: <1344390033-14139-1-git-send-email-scott.liu@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60086 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932502Ab2HHJIN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Aug 2012 05:08:13 -0400
In-Reply-To: <1344390033-14139-1-git-send-email-scott.liu@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Scott Liu <scott.liu@emc.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, eleghost@gmail.com

Hi Scott,

There is a few white space problems and a maybe an oops.
Sorry for not having seen this before.

On Wed, Aug 8, 2012 at 3:40 AM, Scott Liu <scott.liu@emc.com.tw> wrote:
> Some of ELAN=92s production need to issue set_idle when resume.
>
> Signed-off-by: Scott Liu <scott.liu@emc.com.tw>
> ---
>  drivers/hid/hid-ids.h        |    3 +++
>  drivers/hid/hid-multitouch.c |   26 ++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 41c34f2..703aaed 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -829,4 +829,7 @@
>  #define USB_VENDOR_ID_PRIMAX   0x0461
>  #define USB_DEVICE_ID_PRIMAX_KEYBOARD  0x4e05
>
> +#define USB_VENDOR_ID_ELAN     0x04f3
> +#define USB_DEVICE_ID_ELAN_MOCCA       0x000a
> +
>  #endif
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index 59c8b5c..a086a16 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -767,6 +767,31 @@ static int mt_reset_resume(struct hid_device *hd=
ev)
>         mt_set_input_mode(hdev);
>         return 0;
>  }
> +
> +static int mt_resume(struct hid_device *hdev)
> +{
> +       struct usb_interface *intf =3D to_usb_interface(hdev->dev.par=
ent);
> +       struct usb_host_interface *interface =3D intf->cur_altsetting=
;

There is at least one bluetooth multitouch device, so maybe intf will
be null....

> +
> +       struct usb_device *dev =3D hid_to_usb_dev(hdev);
> +
> +       if (hdev->vendor =3D=3D USB_VENDOR_ID_ELAN &&
> +                       hdev->product =3D=3D USB_DEVICE_ID_ELAN_MOCCA=
) {

moving this test at the beginning will prevent us from null or random p=
ointers.

> +
> +               usb_control_msg(dev,
> +                                               usb_sndctrlpipe(dev, =
0),
> +                               HID_REQ_SET_IDLE,

mix tab/spaces....

> +                                               USB_TYPE_CLASS | USB_=
RECIP_INTERFACE,
> +                                               0,
> +                               interface->desc.bInterfaceNumber,

again....

> +                                               NULL,
> +                                               0,
> +                                               USB_CTRL_SET_TIMEOUT)=
;
> +       }
> +
> +       return 0;
> +}
> +
>  #endif
>
>  static void mt_remove(struct hid_device *hdev)
> @@ -1092,6 +1117,7 @@ static struct hid_driver mt_driver =3D {
>         .event =3D mt_event,
>  #ifdef CONFIG_PM
>         .reset_resume =3D mt_reset_resume,
> +       .resume=3Dmt_resume,

spaces are need before and after the equal sign....

Cheers,
Benjamin

>  #endif
>  };
>
> --
> 1.7.9.5
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
