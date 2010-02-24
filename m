From: "Rick L. Vinyard, Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>
Subject: Re: [PATCH 1/3] picolcd: driver for PicoLCD HID device
Date: Wed, 24 Feb 2010 14:44:53 -0700
Message-ID: <ffb352764fc5a0da5cca6f3da7fc2603.squirrel@intranet.cs.nmsu.edu>
References: <20100221002001.0a7e05a7@neptune.home>
    <20100224170049.0d04af3c@neptune.home>
    <201002241927.53532.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201002241927.53532.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Bruno =?iso-8859-1?Q?Pr=C3=A9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicu Pavel <npavel-VxACSXvuqMTQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org


Oliver Neukum wrote:
> Am Mittwoch, 24. Februar 2010 17:00:49 schrieb Bruno Pr=C3=A9mont:
>> +static int picolcd_raw_event(struct hid_device *hdev,
>> +               struct hid_report *report, u8 *raw_data, int size)
>> +{
>> +       struct picolcd_data *data =3D hid_get_drvdata(hdev);
>> +       char hexdata[25];
>> +       int i;
>> +
>> +       if (data =3D=3D NULL)
>> +               return 1;
>> +
>> +       for (i =3D 0; i < sizeof(hexdata) / 2; i++)
>> +               sprintf(hexdata+2*i, "%02hhx", raw_data[i]);
>> +       if (size >=3D sizeof(hexdata)/2) {
>> +               hexdata[sizeof(hexdata)-4] =3D '.';
>> +               hexdata[sizeof(hexdata)-3] =3D '.';
>> +               hexdata[sizeof(hexdata)-2] =3D '.';
>> +               hexdata[sizeof(hexdata)-1] =3D '\0';
>> +       } else
>> +               hexdata[size*2] =3D '\0';
>> +
>> +       switch (report->id) {
>> +       case REPORT_KEYPAD:
>> +               if (size =3D=3D 3 && raw_data[0] =3D=3D 0x11 &&
>> data->input_keys) {
>> +                       return picolcd_raw_keypad(hdev, report,
>> raw_data+1, size-1);
>> +               } else {
>> +                       dbg_hid(PICOLCD_NAME " unsupported key event=
 (%d
>> bytes): 0x%s\n", size, hexdata);
>> +                       break;
>> +               }
>> +               break;
>> +       case REPORT_VERSION:
>> +               if (size =3D=3D 3)
>> +                       dev_info(&hdev->dev, "Firmware version is
>> %hd.%hd\n", raw_data[1], raw_data[2]);
>> +
>> +               spin_lock(&data->lock);
>
> If I recall correctly raw_event is called in interrupt. As you take a
> spinlock here,
> the lock in code not called in interrupt must disable interrupts, or =
you
> may
> deadlock.
>

The issue, as I understand it is that non-interrupt code may obtain the
lock and then the interrupt code is executed... hence the deadlock and =
the
need to use spin_lock_irqsave() and spin_unlock_irqrestore().

If that is correct, is there any problem with the following approach?

The key difference is the replacement of spin_lock() with spin_trylock(=
)
such that if the non-interrupt code has already obtained the lock, the
interrupt will not deadlock but instead take the else path and schedule=
 a
framebuffer update at the next interval.

static void g13_fb_urb_completion(struct urb *urb)
{
	struct g13_data *data =3D urb->context;
	spin_unlock(&data->fb_urb_lock);
}

static int g13_fb_send(struct hid_device *hdev)
{
	struct usb_interface *intf;
	struct usb_device *usb_dev;
	struct g13_data *data =3D hid_get_g13data(hdev);

	struct usb_host_endpoint *ep;
	unsigned int pipe;
	int retval =3D 0;

	/*
	 * Try and lock the framebuffer urb to prevent access if we have
	 * submitted it. If we can't lock it we'll have to delay this update
	 * until the next framebuffer interval.
	 *
	 * Fortunately, we already have the infrastructure in place with the
	 * framebuffer deferred I/O driver to schedule the delayed update.
	 */
	if (likely(spin_trylock(&data->fb_urb_lock))) {
		/* Get the usb device to send the image on */
		intf =3D to_usb_interface(hdev->dev.parent);
		usb_dev =3D interface_to_usbdev(intf);

		pipe =3D usb_sndintpipe(usb_dev, 0x02);

		ep =3D usb_dev->ep_out[usb_pipeendpoint(pipe)];

		if (unlikely(!ep)) {
			spin_unlock(&data->fb_urb_lock);
			return -EINVAL;
		}

		pipe =3D (pipe & ~(3 << 30)) | (PIPE_INTERRUPT << 30);
		usb_fill_int_urb(data->fb_urb, usb_dev, pipe, data->fb_vbitmap,
				 G13_VBITMAP_SIZE, g13_fb_urb_completion, NULL,
				 ep->desc.bInterval);
		data->fb_urb->context =3D data;
		data->fb_urb->actual_length =3D 0;

		retval =3D usb_submit_urb(data->fb_urb, GFP_NOIO);
		if (unlikely(retval < 0)) {
			/*
			 * We need to unlock the framebuffer urb lock since
			 * the urb submission failed and therefore
			 * g13_fb_urb_completion() won't be called.
			 */
			spin_unlock(&data->fb_urb_lock);
			return retval;
		}
	} else {
		schedule_delayed_work(&data->fb_info->deferred_work,
				      data->fb_defio.delay);
	}

	return retval;
}

Thanks,

--=20

Rick

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
