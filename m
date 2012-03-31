From: Arkadiusz =?utf-8?q?Mi=C5=9Bkiewicz?= <a.miskiewicz@gmail.com>
Subject: Re: logitech-djdevice and /sys
Date: Sat, 31 Mar 2012 07:50:43 +0200
Message-ID: <201203310750.43619.a.miskiewicz@gmail.com>
References: <201203221844.54688.a.miskiewicz@gmail.com> <alpine.LNX.2.00.1203301520030.25526@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36212 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065Ab2CaFus convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Mar 2012 01:50:48 -0400
Received: by wibhq7 with SMTP id hq7so1157519wib.1
        for <linux-input@vger.kernel.org>; Fri, 30 Mar 2012 22:50:47 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1203301520030.25526@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>

On Friday 30 of March 2012, Jiri Kosina wrote:
> On Thu, 22 Mar 2012, Arkadiusz Mi=C5=9Bkiewicz wrote:
> > Hi,
> >=20
> > I'm detecting usb keyboards from shell using this simple script:
> >=20
> > for i in /sys/class/input/input*; do
> >=20
> >                 [ ! -f $i/device/bInterfaceClass -o ! -f
> >                 $i/device/bInterfaceProtocol ] && continue
> >                 bInterfaceClass=3D$(cat $i/device/bInterfaceClass)
> >                 bInterfaceProtocol=3D$(cat $i/device/bInterfaceProt=
ocol)
> >                 if [ "$bInterfaceClass" =3D "03" -a "$bInterfacePro=
tocol"
> >                 =3D "01" ]; then
> > 		=09
> > 			module=3D$(readlink $i/device/driver/module)
> > 		=09
> >                         module=3D$(basename $module)
> > 		=09
> > 			echo "found keyboard driven by $module"
> > 	=09
> > 		fi
> >=20
> > done
> >=20
> > but for keyboards hidden behind logitech unifying receiver there se=
em to
> > be no such information in /sys.
> >=20
> > Any ideas on how I can detect such keyboards via /sys or other
> > scriptable method?
> >=20
> > (note that I'm interested only in "regular" keyboards, so single bu=
ttons
> > and some other devices are not interesting)
> >=20
> > dmesg:
> >=20
> > [130816.672862] usb 6-2: new full-speed USB device number 4 using
> > uhci_hcd [130816.856173] usb 6-2: New USB device found, idVendor=3D=
046d,
> > idProduct=3Dc52b [130816.856183] usb 6-2: New USB device strings: M=
fr=3D1,
> > Product=3D2, SerialNumber=3D0 [130816.856190] usb 6-2: Product: USB=
 Receiver
> > [130816.856195] usb 6-2: Manufacturer: Logitech
> > [130816.868751] logitech-djreceiver 0003:046D:C52B.000F: hiddev0,hi=
draw2:
> > USB HID v1.11 Device [Logitech USB Receiver] on
> > usb-0000:00:1d.0-2/input2 [130816.878201] input: Logitech Unifying
> > Device. Wireless PID:4004 as
> > /devices/pci0000:00/0000:00:1d.0/usb6/6-2/6-2:1.2/0003:046D:C52B.00=
0F/in
> > put/input14 [130816.878717] logitech-djdevice 0003:046D:C52B.0010:
> > input,hidraw3: USB HID v1.11 Keyboard [Logitech Unifying Device.
> > Wireless PID:4004] on usb-0000:00:1d.0-2:1
>=20
> I suggest you inspect all available input devices using EVIOCGBIT ioc=
tl()
> instead, querying the device capabilities (and looking namely on the
> EV_KEY capabilities).
>=20
> Alternatively, you can find this information prepared for you in
> /proc/bus/input/devices.
>=20
> If you really want to restrict yourself to USB keyboards, you'll have=
 to
> inspect 'Phys' as well. This you can do via EVIOCGPHYS ioctl() or loo=
k
> into procfs as well.

Ok, thanks. Seems there is no good way to find out regular keyboards on=
ly=20
since many non keyboard devices have some keys.

--=20
Arkadiusz Mi=C5=9Bkiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
