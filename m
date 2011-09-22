From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v5 1/1] HID: Add full support for Logitech Unifying receivers
Date: Thu, 22 Sep 2011 22:48:36 +0200
Message-ID: <CAN+gG=EcaMrz2w-cVL-cCwi2NNVJ-NXOpOQpbjyFdCwn5+Bn+w@mail.gmail.com>
References: <1316018905-4175-1-git-send-email-nlopezcasad@logitech.com>
	<4E77A221.1060909@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33887 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823Ab1IVUsi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Sep 2011 16:48:38 -0400
In-Reply-To: <4E77A221.1060909@t-online.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Richard_Sch=FCtz?= <r.schtz@t-online.de>
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rtitmuss@logitech.com, ogay@logitech.com, jzanone@logitech.com

Hi Richard,

here, you'll find a small C program that allows you to do a pairing of
a new device to a receiver.

compile it with with gcc -o pairing_tool pairing_tool.c

--------------------------------- file pairing_tool.c
---------------------------------
/*
 * Copyright 2011 Benjamin Tissoires <benjamin.tissoires@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>=
=2E
 */

#include <linux/input.h>
#include <linux/hidraw.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>

#define USB_VENDOR_ID_LOGITECH			(__u32)0x046d
#define USB_DEVICE_ID_UNIFYING_RECEIVER		(__s16)0xc52b
#define USB_DEVICE_ID_UNIFYING_RECEIVER_2	(__s16)0xc532

int main(int argc, char **argv)
{
	int fd;
	int res;
	struct hidraw_devinfo info;
	char magic_sequence[] =3D {0x10, 0xFF, 0x80, 0xB2, 0x01, 0x00, 0x00};

	if (argc =3D=3D 1) {
		errno =3D EINVAL;
		perror("No hidraw device given");
		return 1;
	}

	/* Open the Device with non-blocking reads. */
	fd =3D open(argv[1], O_RDWR|O_NONBLOCK);

	if (fd < 0) {
		perror("Unable to open device");
		return 1;
	}

	/* Get Raw Info */
	res =3D ioctl(fd, HIDIOCGRAWINFO, &info);
	if (res < 0) {
		perror("error while getting info from device");
	} else {
		if (info.bustype !=3D BUS_USB ||
		    info.vendor !=3D USB_VENDOR_ID_LOGITECH ||
		    (info.product !=3D USB_DEVICE_ID_UNIFYING_RECEIVER &&
		     info.product !=3D USB_DEVICE_ID_UNIFYING_RECEIVER_2)) {
			errno =3D EPERM;
			perror("The given device is not a Logitech "
				"Unifying Receiver");
			return 1;
		}
	}

	/* Send the magic sequence to the Device */
	res =3D write(fd, magic_sequence, sizeof(magic_sequence));
	if (res < 0) {
		printf("Error: %d\n", errno);
		perror("write");
	} else if (res =3D=3D sizeof(magic_sequence)) {
		printf("The receiver is ready to pair a new device.\n"
		"Switch your device on to pair it.\n");
	} else {
		errno =3D ENOMEM;
		printf("write: %d were written instead of %ld.\n", res,
			sizeof(magic_sequence));
		perror("write");
	}
	close(fd);
	return 0;
}
----------------------------- end of file pairing_tool.c
----------------------------

I hope it will be useful to you.

Cheers,
Benjamin

On Mon, Sep 19, 2011 at 22:12, Richard Sch=FCtz <r.schtz@t-online.de> w=
rote:
> Am 14.09.2011 18:48, schrieb Nestor Lopez Casado:
>>
>> From: Nestor Lopez Casado<nlopezcasad@logitech.com>
>>
>> With this driver, all the devices paired to a single Unifying
>> receiver are exposed to user processes in separated /input/dev
>> nodes.
>
> But there's still no way to pair devices with an Unifying receiver un=
der
> Linux, right? It would be nice to have a simple userspace tool for th=
at,
> too.
>
> --
> Regards,
> Richard Sch=FCtz
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
