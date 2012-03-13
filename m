From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 4/5] HID: autoload hid-multitouch as needed
Date: Tue, 13 Mar 2012 17:13:29 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1203131710120.18356@pobox.suse.cz>
References: <1331053026-21272-1-git-send-email-benjamin.tissoires@gmail.com> <1331053026-21272-5-git-send-email-benjamin.tissoires@gmail.com>    <alpine.LNX.2.00.1203072234550.29034@pobox.suse.cz>   <20120308105737.GA11201@polaris.bitmath.org>  
 <6E17845C-6F9F-4CB6-AA5D-DEEDCD2089E8@enac.fr>   <alpine.LNX.2.00.1203121650500.18356@pobox.suse.cz>  <1331574151.14217.86.camel@aeonflux>  <4B25AD62-B1C9-4C57-AE64-34EB7F47DC9B@enac.fr> <alpine.LNX.2.00.1203122316420.18356@pobox.suse.cz>
 <0EB7B0B6-EE4F-4E42-A1E6-0414D39AEAE6@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50982 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754779Ab2CMQNc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Mar 2012 12:13:32 -0400
In-Reply-To: <0EB7B0B6-EE4F-4E42-A1E6-0414D39AEAE6@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Marcel Holtmann <marcel@holtmann.org>, Henrik Rydberg <rydberg@euromail.se>, "benjamin.tissoires" <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo F. Padovan" <padovan@profusion.mobi>, linux-bluetooth@vger.kernel.org

On Tue, 13 Mar 2012, St=E9phane Chatty wrote:

> > Let me answer by a bit of history here. Originally, there have been=
=20
> > two copies of HID code in the kernel -- one for USB HID devices, on=
e=20
> > for Bluetooth HID devices. The parsers were not kept in sync, and=20
> > there was a lot of code duplication, creating quite some mess.
> >=20
> > What I did back then in 2006 was that I have extracted the abstract=
 HID=20
> > parts into HID core, and made it transport-independent in principle=
, so=20
> > that both USB HID and Bluetooth HID shared the common infrastructur=
e,=20
> > while implementing different transport protocols.
> >=20
> > Then we extended it a little bit further, making HID core a proper =
bus, to=20
> > which individual drivers (independently on underlying transport pro=
tocol=20
> > used) can register.
> >=20
> > Currently there are just Bluetooth (hidp) and USB (usbhid) transpor=
t=20
> > implementations, with HID core being transport independent.
> >=20
> > Hope this helps,
>=20
> Very useful clarification, thanks. Now, I guess I understand why Marc=
el=20
> wants to keep hidp in bluetooth/. And, to be honest, things would hav=
e=20
> been clearer to me when I explored the handling of the USB/HID class =
if=20
> I had found a hid (or usbhid) directory in usb/ rather than a usbhid=20
> subdirectory in hid/: it did not make the above situation very obviou=
s=20
> to me. Don't you think we could go along with Marcel and move usbhid =
to=20
> usb/?

It seemed to be convenient back then, and it's still convenient for me =
in=20
some sense, as I am maintaining both HID core and USB HID, but bluetoot=
h=20
guys are maintaining the bluetooth transport.

But I don't have strong opinion either way, I can as well move usbhid t=
o=20
drivers/usb and maintain it there (will need to talk to Greg about it=20
first of course). But frankly, I don't see it making things magically=20
clear for everyone :)

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
