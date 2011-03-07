From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: libudev, a question about the enumerate API.
Date: Mon, 7 Mar 2011 16:27:48 +0100
Message-ID: <AANLkTik7pPUYou9OwD0E5r-Wr3a67kQZPToDepZH8pLu@mail.gmail.com>
References: <20110223235053.ae9d6b0a.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53028 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1CGP2F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Mar 2011 10:28:05 -0500
In-Reply-To: <20110223235053.ae9d6b0a.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-hotplug@vger.kernel.org, linux-input@vger.kernel.org, Alan Ott <alan@signal11.us>

On Wed, Feb 23, 2011 at 23:50, Antonio Ospite <ospite@studenti.unina.it=
> wrote:
> Hi,
>
> in my attempts to handle leds setting and usb pairing for the Sixaxis
> controller I had to fight with libudev a little bit, eventually I
> succeeded in what I wanted to achieve but I still have some questions
> about the libudev API, so here I am.
>
> This is basically the layout for the device:
>
> 4-1:1.0/
> |-- 0003:054C:0268.000C =C2=A0(hid device)
> | =C2=A0 |-- hidraw
> | =C2=A0 | =C2=A0 `-- hidraw1
> | =C2=A0 `-- uevent =C2=A0(which tells me HID_PHYS)
> |
> `-- input
> =C2=A0 =C2=A0`-- input17
> =C2=A0 =C2=A0 =C2=A0 =C2=A0|-- js0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0`-- phys
>
> I needed to get the hidraw device node, and the js device number, the
> two sibling devices (from hid and input subsystem) can be matched usi=
ng
> the 'phys' property.
>
> This is what I do now:
> =C2=A00. Monitor with a filter matching the "hidraw" subsystem.
> =C2=A01. When a matching device is connected we get the "hidraw" devi=
ce.
> =C2=A02. Go up to its "hid" parent device and check it is actually a
> =C2=A0 =C2=A0Sixaxis (using HID_NAME), if not GOTO 1.
> =C2=A03. Store the hidraw device node for later use
> =C2=A04. Store the HID_PHYS value in order to look for the matching j=
oystick.
> =C2=A05. Enumerate the joystick devices with the sysname filter "js*"
> =C2=A06. For each joystick:
> =C2=A0 =C2=A0a. Go up to its input parent device
> =C2=A0 =C2=A0b. Check that the phys attribute matches HID_PHYS,
> =C2=A0 =C2=A0 =C2=A0 if so, store the joystick device number.
> =C2=A07. Set leds
> =C2=A08. If the Sixaxis is connected via USB do the cable pairing.
>
> My doubt is about 5. and 6a.: I have go deep in the hierarchy down to
> the js0 leaf device and then I have to go up one level to get the
> input device, naively I would have done the contrary:
> =C2=A05'. Enumerate the input devices such that phys =3D=3D HID_PHYS
> =C2=A06'. Enumerate the devices _below_ the input device from 5'. loo=
king
> =C2=A0 =C2=A0 for the jsX device.
>
> But this is not possible because the enumerate API is designed to sta=
rt
> always from the root of /sys.
>
> Finally the question: why the enumerate API in libudev does not allow
> enumerating only from a _subtree_? Has that been designed this way to
> keep the API simple, or because it is not considered useful?

The usual enumeration in udev never uses the device tree in
/sys/devices/, only the subsystem lists /sys/{class,bus}/. We could
have something to enumerate all child devices of a given device. It's
not simple, but could be made working.

Kay
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
