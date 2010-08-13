From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH RESEND] USB HID: Add ID for eGalax Multitouch used in  JooJoo tablet
Date: Fri, 13 Aug 2010 12:47:50 +0200
Message-ID: <C6B3DDC8-79F3-47FC-BC26-244C49998852@enac.fr>
References: <m339wl2ug6.fsf@pullcord.laptop.org>  <m3hbiz8m11.fsf@pullcord.laptop.org> <alpine.LNX.2.00.1008130113530.2702@pobox.suse.cz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:58253 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934171Ab0HMK5g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Aug 2010 06:57:36 -0400
In-Reply-To: <alpine.LNX.2.00.1008130113530.2702@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Chris Ball <cjb@laptop.org>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, tito@bankiz.org


Le 13 ao=FBt 10 =E0 01:15, Jiri Kosina a =E9crit :
> i Chris,
>
> has this patch been really tested?
>
> I am almost certain that we need to have the device ID to be added to
> hid_blacklist[] in drivers/hid/hid-core.c as well. Otherwise the
> hid-egalax driver wouldn't bind to the device automatically in a =20
> proper
> way.
>

Guys,

I happen to have gathered information about this during the last five =20
days:

  - Mathieu Virbel, author of PyMT, has reported that with the above =20
patch (and probably the corresponding change to hid-core.c) the =20
multitouch panel of the Joojoo kind of works, but with a strange =20
behaviour: SYNC messages are inserted between fingers.

  - after checking HID report descriptors, it appears that the =20
protocol used by this device is fairly different from that of the =20
eGalax found in the T101MT. Basically, it uses what Microsoft =20
describes as 'serial' multitouch events instead of the 'parallel' =20
multitouch events we ususally see. This means that each finger is =20
reported in a message of its own.

  - after checking with the maker of these panels, it appears that =20
they have two independent product lines. One, with product IDs 48xx, =20
is resistive and has a classical 'parallel' protocol. The other, with =20
product IDs 72xx, is capacitive and has an unusual 'serial' protocol. =20
The Joojoo has the latter.

In summary this is a new kind of panel with an unusual HID prototol =20
and the hid-egalax driver fails at producing a proper event sequence. =20
The major issue here is that the key to resolving the problem does =20
*not* lie in the driver: SYNC messages are produced in hid-input.c =20
and drivers cannot block them. To address this, one would need to =20
make the <HID event> -> <input event> + <sync> mapping less =20
systematic. This could converge with the efforts required if we were =20
to have a more generic management of multitouch devices (we need one =20
driver for each device because hid-core.c was not designed with this =20
kind of device in mind).

My suggestions:
  - accept the patch, after adding a few comments in the code about =20
this device requiring future care for its 'serial' protocol.
  - start thinking about what changes are required in hid-input and/=20
or hid-core for a more generic management of multitouch devices.

Cheers,

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
