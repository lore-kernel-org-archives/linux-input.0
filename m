From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 14421] New: CH Products joystick detected but not functional
Date: Fri, 16 Oct 2009 23:31:37 +0200
Message-ID: <200910162331.37533.oliver@neukum.org>
References: <bug-14421-10286@http.bugzilla.kernel.org/> <20091016142009.ab63e171.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091016142009.ab63e171.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, rutkowski-T1p9dGDnAHDoS6w7zS32OEtZW7PLQM7H@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Freitag, 16. Oktober 2009 23:20:09 schrieb Andrew Morton:
> > Plugged joystick in and kernel detects device (from /var/log/messag=
es):
> > =A0 kernel: usb 3-6: new low speed USB device using ohci_hcd and ad=
dress 3
> > =A0 kernel: usb 3-6: New USB device found, idVendor=3D068e, idProdu=
ct=3D00d3
> > =A0 kernel: usb 3-6: New USB device strings: Mfr=3D1, Product=3D2,
> > SerialNumber=3D0 kernel: usb 3-6: Product: CH OEM 3 AXIS 5 BUTTON J=
OYSTICK
> > =A0 kernel: usb 3-6: Manufacturer: CH PRODUCTS
> > =A0 kernel: usb 3-6: configuration #1 chosen from 1 choice
> > =A0 kernel: input: CH PRODUCTS CH OEM 3 AXIS 5 BUTTON JOYSTICK as
> > /devices/pci0000:00/0000:00:02.0/usb3/3-6/3-6:1.0/input/input8
> > =A0 kernel: generic-usb 0003:068E:00D3.0004: input,hidraw3: USB HID=
 v1.00
> > Joystick [CH PRODUCTS CH OEM 3 AXIS 5 BUTTON JOYSTICK] on
> > usb-0000:00:02.0-6/input0
> >
> > HAL also detects the device (from lshal): attached as hal.txt
> >
> > Functionality was checked for under jstest, jscal, KDE 4 joystick s=
ection
> > in System Settings, and by cat-ing the device. =A0In all tests the =
axis
> > values did not change, and the button states did not change when jo=
ystick
> > manipulated


Do you see traffic with usbmon as you move the stick or press buttons?

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
