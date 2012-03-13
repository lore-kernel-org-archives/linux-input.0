From: =?iso-8859-1?Q?St=E9phane_Chatty?= <chatty-rXV5z7KbLFk@public.gmane.org>
Subject: Re: [PATCH 4/5] HID: autoload hid-multitouch as needed
Date: Tue, 13 Mar 2012 19:14:56 +0100
Message-ID: <620FFED4-6D6D-4F70-8674-D054C5E3B38A@enac.fr>
References: <1331053026-21272-1-git-send-email-benjamin.tissoires@gmail.com> <1331053026-21272-5-git-send-email-benjamin.tissoires@gmail.com>     <alpine.LNX.2.00.1203072234550.29034@pobox.suse.cz>    <20120308105737.GA11201@polaris.bitmath.org>    <6E17845C-6F9F-4CB6-AA5D-DEEDCD2089E8@enac.fr>    <alpine.LNX.2.00.1203121650500.18356@pobox.suse.cz>   <1331574151.14217.86.camel@aeonflux>   <4B25AD62-B1C9-4C57-AE64-34EB7F47DC9B@enac.fr>  <alpine.LNX.2.00.1203122316420.18356@pobox.suse.cz>  <0EB7B0B6-EE4F-4E42-A1E6-0414D39AEAE6@enac.fr> <alpine.LNX.2.00.1203131710120.18356@pobox.suse.cz>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1203131710120.18356-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Henrik Rydberg <rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org>, "benjamin.tissoires" <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Gustavo F. Padovan" <padovan-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


Le 13 mars 2012 =E0 17:13, Jiri Kosina wrote:

> On Tue, 13 Mar 2012, St=E9phane Chatty wrote:
>>=20
>> Very useful clarification, thanks. Now, I guess I understand why Mar=
cel=20
>> wants to keep hidp in bluetooth/. And, to be honest, things would ha=
ve=20
>> been clearer to me when I explored the handling of the USB/HID class=
 if=20
>> I had found a hid (or usbhid) directory in usb/ rather than a usbhid=
=20
>> subdirectory in hid/: it did not make the above situation very obvio=
us=20
>> to me. Don't you think we could go along with Marcel and move usbhid=
 to=20
>> usb/?
>=20
> It seemed to be convenient back then, and it's still convenient for m=
e in=20
> some sense, as I am maintaining both HID core and USB HID, but blueto=
oth=20
> guys are maintaining the bluetooth transport.
>=20
> But I don't have strong opinion either way, I can as well move usbhid=
 to=20
> drivers/usb and maintain it there (will need to talk to Greg about it=
=20
> first of course). But frankly, I don't see it making things magically=
=20
> clear for everyone :)


I agree it's neither very important nor a magic bullet. But this confus=
ed at least one person (me) when exploring the code for the first time =
:-)

St.
