From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: logitech-djdevice and /sys
Date: Fri, 30 Mar 2012 15:25:13 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1203301520030.25526@pobox.suse.cz>
References: <201203221844.54688.a.miskiewicz@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33024 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758908Ab2C3NZP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Mar 2012 09:25:15 -0400
In-Reply-To: <201203221844.54688.a.miskiewicz@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-2?Q?Arkadiusz_Mi=B6kiewicz?= <a.miskiewicz@gmail.com>
Cc: linux-input@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>

On Thu, 22 Mar 2012, Arkadiusz Mi=C5=9Bkiewicz wrote:

> Hi,
>=20
> I'm detecting usb keyboards from shell using this simple script:
>=20
> for i in /sys/class/input/input*; do
>                 [ ! -f $i/device/bInterfaceClass -o ! -f $i/device/bI=
nterfaceProtocol ] && continue
>                 bInterfaceClass=3D$(cat $i/device/bInterfaceClass)
>                 bInterfaceProtocol=3D$(cat $i/device/bInterfaceProtoc=
ol)
>                 if [ "$bInterfaceClass" =3D "03" -a "$bInterfaceProto=
col" =3D "01" ]; then
> 			module=3D$(readlink $i/device/driver/module)
>                         module=3D$(basename $module)
>=20
> 			echo "found keyboard driven by $module"
> 		fi
> done
>=20
> but for keyboards hidden behind logitech unifying receiver there seem=
 to=20
> be no such information in /sys.
>=20
> Any ideas on how I can detect such keyboards via /sys or other
> scriptable method?
>=20
> (note that I'm interested only in "regular" keyboards, so single butt=
ons
> and some other devices are not interesting)
>=20
> dmesg:
>=20
> [130816.672862] usb 6-2: new full-speed USB device number 4 using uhc=
i_hcd
> [130816.856173] usb 6-2: New USB device found, idVendor=3D046d, idPro=
duct=3Dc52b
> [130816.856183] usb 6-2: New USB device strings: Mfr=3D1, Product=3D2=
, SerialNumber=3D0
> [130816.856190] usb 6-2: Product: USB Receiver
> [130816.856195] usb 6-2: Manufacturer: Logitech
> [130816.868751] logitech-djreceiver 0003:046D:C52B.000F: hiddev0,hidr=
aw2: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:1d.0-2=
/input2
> [130816.878201] input: Logitech Unifying Device. Wireless PID:4004 as=
 /devices/pci0000:00/0000:00:1d.0/usb6/6-2/6-2:1.2/0003:046D:C52B.000F/=
input/input14
> [130816.878717] logitech-djdevice 0003:046D:C52B.0010: input,hidraw3:=
 USB HID v1.11 Keyboard [Logitech Unifying Device. Wireless PID:4004] o=
n usb-0000:00:1d.0-2:1

I suggest you inspect all available input devices using EVIOCGBIT ioctl=
()=20
instead, querying the device capabilities (and looking namely on the=20
EV_KEY capabilities).

Alternatively, you can find this information prepared for you in=20
/proc/bus/input/devices.

If you really want to restrict yourself to USB keyboards, you'll have t=
o=20
inspect 'Phys' as well. This you can do via EVIOCGPHYS ioctl() or look=20
into procfs as well.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
