From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Mighty mouse (bluetooth) with ID 0x1000 (vendor ID 0x05ac apple)
 any chance for mousewheel?
Date: Mon, 10 Nov 2008 11:53:19 +0100
Message-ID: <4918129F.5000106@gmail.com>
References: <3d0c012d0811100104o6de42b6er279498eec6781698@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:24840 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872AbYKJKxZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Nov 2008 05:53:25 -0500
In-Reply-To: <3d0c012d0811100104o6de42b6er279498eec6781698@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?Q2hyaXN0b2YgS8OkbGlu?= <christof.kaelin@gmail.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 11/10/2008 10:04 AM, Christof K=C3=A4lin wrote:
> Hi
>=20
> As a newbie, I just saw your email in the source-file when I was look=
ing
> into the sources of hid-apple.c to find my mighty mouse somewhere:
>=20
> /* Apple wireless Mighty Mouse */
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, 0x030c),
>                 .driver_data =3D APPLE_MIGHTYMOUSE | APPLE_INVERT_HWH=
EEL },
>=20
> According to hid-ids.h, the ID 0x030c is a TDK mighty mouse. On my
> Alu-iMac (last year edition), it's a Apple's owned mighty mouse (vend=
or
> 0x05ac, ID 0x1000), which is not currently listed in hid-ids.h. My
> mighty mouse anyway runs o.k. with the "wrong" ID, but since the star=
t
> withouth the mouse-wheel.
> It did not help when I changed the ID's accordingly. So my question i=
s:
> Is there anything to be done in bluetooth driver area too to get this
> mighty mouse fully supported (some quirks needed)?
>=20
> Sorry for my annoying questions.
>=20
> Thanks in advance for any suggestions and best regards

I guess, they map Z axis to be a wheel instead a wheel be a wheel like =
in the
0x030c case.

Could you add
{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, 0x030c),
  .driver_data =3D APPLE_MIGHTYMOUSE }
there and
HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, 0x030c)
to hid_blacklist in drivers/hid/hid-core.c and try? If the wheel is inv=
erted
with your device, then you need also APPLE_INVERT_HWHEEL aswell.

<me goes to implement new_id like in the PCI case to not bother users w=
ith
recompiling the kernel for testing such things>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
