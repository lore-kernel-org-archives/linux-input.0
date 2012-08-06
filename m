From: =?big5?B?vEK5xcJA?= <scott.liu@emc.com.tw>
Subject: RE: [PATCH 1/1]hid:hid-multitouch:  add mt_resume for ELAN's production
Date: Mon, 6 Aug 2012 11:14:01 +0800
Message-ID: <1D0CA16CE8BA4331BC7C995D25717BFE@elan.corp>
References: <87y5lw5mbv.fsf@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87y5lw5mbv.fsf@emc.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jian-Jhong Ding' <jj_ding@emc.com.tw>, "'benjamin.tissoires'" <benjamin.tissoires@gmail.com>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Jiri Kosina' <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, eleghost@gmail.com
List-Id: linux-input@vger.kernel.org


Mode change to 0644.

=46rom: Scott Liu<scott.liu@emc.com.tw>
Signed-off-by: Scott Liu <scott.liu@emc.com.tw>

---
 0 files changed
 mode change 100755 =3D> 100644 drivers/hid/hid-ids.h
 mode change 100755 =3D> 100644 drivers/hid/hid-multitouch.c

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
old mode 100755
new mode 100644
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.=
c
old mode 100755
new mode 100644
--=20
1.7.9.5


-----Original Message-----
=46rom: linux-input-owner@vger.kernel.org
[mailto:linux-input-owner@vger.kernel.org] On Behalf Of Jian-Jhong Ding
Sent: Friday, August 03, 2012 5:58 PM
To: =BCB=B9=C5=C2@; 'benjamin.tissoires'; 'Dmitry Torokhov'; 'Jiri Kosi=
na'
Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org;
eleghost@gmail.com
Subject: Re: [PATCH 1/1]hid:hid-multitouch: add mt_resume for ELAN's
production

Hi Scott,

=BCB=B9=C5=C2@ <scott.liu@emc.com.tw> writes:
> Some of ELAN=A1=A6s production need to issue set_idle when resume.
>
> Signed-off-by: Scott Liu <scott.liu@emc.com.tw>

You might want to add a From: line at the top of mail body to make your
name go along with the SoB line.

> ---
>  drivers/hid/hid-ids.h        |    3 +++
>  drivers/hid/hid-multitouch.c |   27 +++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>  mode change 100644 =3D> 100755 drivers/hid/hid-ids.h
>  mode change 100644 =3D> 100755 drivers/hid/hid-multitouch.c

I believe these two files are merely plain text source file. No need to
make them executives.

And, please consider using git send-mail to send the patches. Your MTA
is still making the indent pretty ugly.

Thanks,
-JJ

> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> old mode 100644
> new mode 100755
> index 41c34f2..703aaed
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -829,4 +829,7 @@
>  #define USB_VENDOR_ID_PRIMAX  0x0461
>  #define USB_DEVICE_ID_PRIMAX_KEYBOARD     0x4e05
> =20
> +#define USB_VENDOR_ID_ELAN      0x04f3
> +#define USB_DEVICE_ID_ELAN_MOCCA 0x000a
> +
>  #endif
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> old mode 100644
> new mode 100755
> index 59c8b5c..2c898bb
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -767,6 +767,32 @@ static int mt_reset_resume(struct hid_device *hd=
ev)
>        mt_set_input_mode(hdev);
>        return 0;
>  }
> +
> +static int mt_resume(struct hid_device *hdev)
> +{
> +      struct usb_interface *intf =3D to_usb_interface(hdev->dev.pare=
nt);
> +      struct usb_host_interface *interface =3D intf->cur_altsetting;
> +
> +      struct usb_device *dev =3D hid_to_usb_dev(hdev);
> +
> +
> +      if (hdev->vendor =3D=3D USB_VENDOR_ID_ELAN &&=20
> +                      hdev->product =3D=3D USB_DEVICE_ID_ELAN_MOCCA)=
 {
> +
> +              usb_control_msg(dev,=20
> +                                              usb_sndctrlpipe(dev, 0=
),

> +                              HID_REQ_SET_IDLE,=20
> +                                              USB_TYPE_CLASS |
USB_RECIP_INTERFACE,=20
> +                                              0,
> +                              interface->desc.bInterfaceNumber,=20
> +                                              NULL,=20
> +                                              0,=20
> +                                              USB_CTRL_SET_TIMEOUT);
> +      }
> +
> +      return 0;
> +}
> +
>  #endif
> =20
>  static void mt_remove(struct hid_device *hdev)
> @@ -1092,6 +1118,7 @@ static struct hid_driver mt_driver =3D {
>        .event =3D mt_event,
>  #ifdef CONFIG_PM
>        .reset_resume =3D mt_reset_resume,
> +      .resume=3Dmt_resume,
>  #endif
>  };
> =20
> --=20
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
