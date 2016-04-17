From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [hid-sony] sony_controller_battery led triggers not working
Date: Sun, 17 Apr 2016 13:40:10 -0400
Message-ID: <909A6235-AA45-4531-9792-82385AEB6A29@gmail.com>
References: <20160417172716.b9ba5813cab5d26a6a3bb8ca@gmx.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34469 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbcDQRkM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Apr 2016 13:40:12 -0400
Received: by mail-qg0-f46.google.com with SMTP id c6so105669067qga.1
        for <linux-input@vger.kernel.org>; Sun, 17 Apr 2016 10:40:11 -0700 (PDT)
In-Reply-To: <20160417172716.b9ba5813cab5d26a6a3bb8ca@gmx.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lauri Kasanen <cand@gmx.com>
Cc: linux-input@vger.kernel.org, Antonio Ospite <ao2@ao2.it>, frank.praznik@oh.rr.com


> On Apr 17, 2016, at 10:27, Lauri Kasanen <cand@gmx.com> wrote:
>=20
> Hi,
>=20
> The battery triggers aren't working for some reason, trying to write
> them comes back with -EINVAL. I'm on somewhat old kernel, 3.17, but t=
he
> relevant parts haven't changed from the commit Frank made in 2014
> adding the MAC address to the name.
>=20
> # cat trigger
> none timer heartbeat backlight [default-on]
> sony_controller_battery_00:26:5c:31:a2:c8-charging-or-full
> sony_controller_battery_00:26:5c:31:a2:c8-charging
> sony_controller_battery_00:26:5c:31:a2:c8-full
> sony_controller_battery_00:26:5c:31:a2:c8-charging-blink-full-solid
>=20
> # echo sony_controller_battery_00:26:5c:31:a2:c8-charging-blink-full-=
solid > trigger
> bash: echo: write error: Invalid argument
>=20
> The shorter triggers do work. Is it something caused by the long name=
,
> or the colons? Do they work for others?
>=20
> My controller is the Gasia one:
> sony 0003:054C:0268.0005: input: USB HID v1.11 Joystick [Gasia Co.,Lt=
d
> PS(R) Gamepad] on usb-0000:00:12.2-2.3/input0
>=20
> - Lauri

Hi Lauri,

Those trigger names are automatically created by the battery subsystem.=
  The problem is that in leds.h TRIG_NAME_MAX is only 50 characters and=
 these trigger names are exceeding that by quite a bit, so they are bei=
ng truncated when passed to the function led_trigger_store() in led_tri=
ggers.c.

Either the battery names must be shortened significantly or the max all=
owed trigger name length has to be increased.  A 50 character limit doe=
s seem a bit low when a suffix such as "charging-blink-full-solid=E2=80=
=9D can use half of the character budget by itself.

Regards,
=46rank--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
