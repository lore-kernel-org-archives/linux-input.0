From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Need advice on USB device interaction
Date: Wed, 21 Jan 2009 19:07:31 +0300
Message-ID: <78f5d6bf0901210807x10666e93na53bf5c6453494c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:37805 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbZAUQHd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Jan 2009 11:07:33 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1825971fgg.17
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2009 08:07:31 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello everybody!

I'm working on force feedback support for Saitek gamepad devices. I
base my work on J=C3=A9r=C3=B4me Poisson (goffi@goffi.org) Saitek P2500=
 driver,
which was written pretty dirty and should be loaded before usbhid to
work.
Logitech/Thrustmaster/ZeroPlus/etc force feedback drivers are
informative enough to build my own driver, but there are still 2
things that I need to clear up:

1. there is always some init code in _probe() function, e.g. for hid-zp=
ff:

>  zpff->report =3D report;
>  zpff->report->field[0]->value[0] =3D 0x00;
>  zpff->report->field[1]->value[0] =3D 0x02;
>  zpff->report->field[2]->value[0] =3D 0x00;
>  zpff->report->field[3]->value[0] =3D 0x00;
>  usbhid_submit_report(hid, zpff->report, USB_DIR_OUT);

J=C3=A9r=C3=B4me used this code in open() function (input_dev::open fie=
ld):

>  struct usb_device *udev;
>  char buf[2];
>
> ...
>
>  buf[0]=3D0x15;
>  buf[1]=3D0x01;
>  usb_control_msg(udev, usb_sndctrlpipe(udev, 0), 0x09, 0x21, 0x315, 0=
, &buf, 2, 50);

May this be replaced by usbhid_submit_report() call and how report
should look like then?

2. in kernell FF drivers all interaction with the device made using
usbhid_submit_report() call, but J=C3=A9r=C3=B4me used usb_submit_urb()=
:

> static int SP2500_playback(struct input_dev *dev, int code, int value=
)
> {
>     struct usb_SP2500* sp2500 =3D (struct usb_SP2500*)(dev->private);
>     struct urb *urb =3D NULL;
>     char *buf =3D NULL;
>     int count=3D4;
>     int retval;
>
>     urb =3D usb_alloc_urb(0, GFP_KERNEL);
>     if (!urb) {
>         retval =3D -ENOMEM;
>         goto error;
>     }
>
>     buf =3D usb_buffer_alloc(sp2500->udev, count, GFP_KERNEL, &urb->t=
ransfer_dma);
>     if (!buf) {
>         retval =3D -ENOMEM;
>         goto error;
>     }
>
>     if (code < 0 || code >=3D MAX_FF)
>         return -EINVAL;
>
>     buf[0]=3D0x51;
>     buf[1]=3D(__u8)code;
>
>     if (value > 0)
>         buf[2]=3D02;  //play
>     else
>         buf[2]=3D01;  //stop
>
>     buf[3]=3D01;
>     count=3D4;
>
>     usb_fill_int_urb(urb, sp2500->udev,
>                     usb_sndintpipe(sp2500->udev, sp2500->int_out_endp=
ointAddr),
>                     buf, count, SP2500_write_int_callback, sp2500, 20=
);
>     urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
>
>
>     retval =3D usb_submit_urb(urb, GFP_KERNEL);
>     if (retval) {
>         err("%s - failed submitting write urb, error %d", __FUNCTION_=
_, retval);
>         goto error;
>     }
>
>     usb_free_urb(urb);
>
>     return 0;
>
> error:
>     err ("playback error");
>     usb_buffer_free(sp2500->udev, count, buf, urb->transfer_dma);
>     usb_free_urb(urb);
>     return retval;
> }

Is following my replacement for this function correct? Mainly, I want
to know, if data packet is formed correctly.

> static int stff_play(struct input_dev *idev, int code, int value)
> {
>     struct hid_device *hid =3D input_get_drvdata(idev);
>     struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_RE=
PORT].report_list;
>     struct hid_report *report =3D list_entry(report_list->next, struc=
t hid_report, list);
>
>     report->field[0]->value[0] =3D 0x51;
>     report->field[0]->value[1] =3D (__u8)code;
>
>     if (value > 0)
>         report->field[0]->value[2] =3D 02;  //play
>     else
>         report->field[0]->value[2] =3D 01;  //stop
>
>     report->field[0]->value[3]=3D01;
>
>     usbhid_submit_report(hid, report, USB_DIR_OUT);
>
>     return 0;
> }


P.S. you can find SP2500 driver source here:
http://www.goffi.org/index.php?post/2006/09/14/Pilote-Linux-pour-le-joy=
pad-Saitek-P2501
P.P.S. original driver contains quirk from original saitek driver --
d-pad and first analog stick swap on button press; I don't wan't to
implement this quirk at the moment
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
