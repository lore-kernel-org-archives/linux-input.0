From: Arkadiusz =?utf-8?q?Mi=C5=9Bkiewicz?= <a.miskiewicz@gmail.com>
Subject: logitech-djdevice and /sys
Date: Thu, 22 Mar 2012 18:44:54 +0100
Message-ID: <201203221844.54688.a.miskiewicz@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:64878 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111Ab2CVRpA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Mar 2012 13:45:00 -0400
Received: by wejx9 with SMTP id x9so2044174wej.19
        for <linux-input@vger.kernel.org>; Thu, 22 Mar 2012 10:44:59 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, Jiri Kosina <jkosina@suse.cz>


Hi,

I'm detecting usb keyboards from shell using this simple script:

for i in /sys/class/input/input*; do
                [ ! -f $i/device/bInterfaceClass -o ! -f $i/device/bInt=
erfaceProtocol ] && continue
                bInterfaceClass=3D$(cat $i/device/bInterfaceClass)
                bInterfaceProtocol=3D$(cat $i/device/bInterfaceProtocol=
)
                if [ "$bInterfaceClass" =3D "03" -a "$bInterfaceProtoco=
l" =3D "01" ]; then
			module=3D$(readlink $i/device/driver/module)
                        module=3D$(basename $module)

			echo "found keyboard driven by $module"
		fi
done


but for keyboards hidden behind logitech unifying receiver
there seem to be no such information in /sys.

Any ideas on how I can detect such keyboards via /sys or other
scriptable method?

(note that I'm interested only in "regular" keyboards, so single button=
s
and some other devices are not interesting)

dmesg:

[130816.672862] usb 6-2: new full-speed USB device number 4 using uhci_=
hcd
[130816.856173] usb 6-2: New USB device found, idVendor=3D046d, idProdu=
ct=3Dc52b
[130816.856183] usb 6-2: New USB device strings: Mfr=3D1, Product=3D2, =
SerialNumber=3D0
[130816.856190] usb 6-2: Product: USB Receiver
[130816.856195] usb 6-2: Manufacturer: Logitech
[130816.868751] logitech-djreceiver 0003:046D:C52B.000F: hiddev0,hidraw=
2: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:1d.0-2/i=
nput2
[130816.878201] input: Logitech Unifying Device. Wireless PID:4004 as /=
devices/pci0000:00/0000:00:1d.0/usb6/6-2/6-2:1.2/0003:046D:C52B.000F/in=
put/input14
[130816.878717] logitech-djdevice 0003:046D:C52B.0010: input,hidraw3: U=
SB HID v1.11 Keyboard [Logitech Unifying Device. Wireless PID:4004] on =
usb-0000:00:1d.0-2:1

--=20
Arkadiusz Mi=C5=9Bkiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
