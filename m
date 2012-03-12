From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 4/5] HID: autoload hid-multitouch as needed
Date: Mon, 12 Mar 2012 23:21:57 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1203122316420.18356@pobox.suse.cz>
References: <1331053026-21272-1-git-send-email-benjamin.tissoires@gmail.com> <1331053026-21272-5-git-send-email-benjamin.tissoires@gmail.com>   <alpine.LNX.2.00.1203072234550.29034@pobox.suse.cz>  <20120308105737.GA11201@polaris.bitmath.org>
 <6E17845C-6F9F-4CB6-AA5D-DEEDCD2089E8@enac.fr>  <alpine.LNX.2.00.1203121650500.18356@pobox.suse.cz> <1331574151.14217.86.camel@aeonflux> <4B25AD62-B1C9-4C57-AE64-34EB7F47DC9B@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B25AD62-B1C9-4C57-AE64-34EB7F47DC9B@enac.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Marcel Holtmann <marcel@holtmann.org>, Henrik Rydberg <rydberg@euromail.se>, "benjamin.tissoires" <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo F. Padovan" <padovan@profusion.mobi>, linux-bluetooth@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 12 Mar 2012, St=E9phane Chatty wrote:

> Just in case it makes a difference, I knew nothing about HIDP when I=20
> wrote the message above. My point was rather that hid looks like a bu=
s=20
> to which several transport layers can connect (USB, Bluetooth, ZigBee=
,=20
> etc), and that having USB-specific code in hid/ (as opposed to having=
 it=20
> in usb/) seems biased towards USB. I was (and am still) wondering how=
=20
> much it limits future uses of the hid core by making it USB-dependent=
=2E
>=20
> In other words: is the hid core generic enough or are there steps to=20
> take to make it more generic wrt transport layers? If we are talking=20
> about restructuring parts of it, this seems like the right time to as=
k=20
> :-)

Let me answer by a bit of history here. Originally, there have been two=
=20
copies of HID code in the kernel -- one for USB HID devices, one for=20
Bluetooth HID devices.
The parsers were not kept in sync, and there was a lot of code=20
duplication, creating quite some mess.

What I did back then in 2006 was that I have extracted the abstract HID=
=20
parts into HID core, and made it transport-independent in principle, so=
=20
that both USB HID and Bluetooth HID shared the common infrastructure,=20
while implementing different transport protocols.

Then we extended it a little bit further, making HID core a proper bus,=
 to=20
which individual drivers (independently on underlying transport protoco=
l=20
used) can register.

Currently there are just Bluetooth (hidp) and USB (usbhid) transport=20
implementations, with HID core being transport independent.

Hope this helps,

--=20
Jiri Kosina
SUSE Labs
