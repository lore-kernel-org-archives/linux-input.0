From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Subject: Re: [PATCH 1/3] picolcd: driver for PicoLCD HID device
Date: Sat, 13 Mar 2010 20:39:53 +0100
Message-ID: <20100313203953.0f3436b3@neptune.home>
References: <20100221002001.0a7e05a7@neptune.home>
	<20100224170049.0d04af3c@neptune.home>
	<alpine.LNX.2.00.1002251201430.30967@pobox.suse.cz>
	<20100225123214.0523a310@neptune.home>
	<alpine.LNX.2.00.1002251615570.30967@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1002251615570.30967-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rick L. Vinyard Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>, Nicu Pavel <npavel-VxACSXvuqMTQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, 25 February 2010 Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org> wrote:
> On Thu, 25 Feb 2010, Bruno Pr=C3=A9mont wrote:
>=20
> > For the two sysfs attributes I currently use, the 'reset' one shall=
=20
> > probably be moved to debugfs (I would like to place it under=20
> > /sys/kernel/debug/hid/$device/ next to rdesc and events).
>=20
> Yes, that would make sense.

Hm, that works only when driver module gets loaded when USBHID device
is already plugged in.
When driver is registered and has it's probe function called on hotplug
it runs right before hid-core registers the debugfs entries.
As such hid_device's debug_dir is still NULL.

To get around this, in hid_add_device(), hid_debug_register() would
have to be called before device_add() instead of right after.

Is something like below acceptable? (from error handling point of view
it makes no difference...)

Thanks,
Bruno

file: drivers/hid/hid-core.c

 int hid_add_device(struct hid_device *hdev)
 {
         static atomic_t id =3D ATOMIC_INIT(0);
         int ret;
=20
         if (WARN_ON(hdev->status & HID_STAT_ADDED))
                 return -EBUSY;
=20
         /* we need to kill them here, otherwise they will stay allocat=
ed to
          * wait for coming driver */
         if (hid_ignore(hdev))
                 return -ENODEV;
=20
         /* XXX hack, any other cleaner solution after the driver core
          * is converted to allow more than 20 bytes as the device name=
? */
         dev_set_name(&hdev->dev, "%04X:%04X:%04X.%04X", hdev->bus,
                      hdev->vendor, hdev->product, atomic_inc_return(&i=
d));
=20
+        hid_debug_register(hdev, dev_name(&hdev->dev));
         ret =3D device_add(&hdev->dev);
         if (!ret)
                 hdev->status |=3D HID_STAT_ADDED;
=20
-        hid_debug_register(hdev, dev_name(&hdev->dev));
=20
         return ret;
 }
 EXPORT_SYMBOL_GPL(hid_add_device);

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
