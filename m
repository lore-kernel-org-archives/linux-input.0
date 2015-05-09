From: Guillaume Apostoly <guillaume.apostoly-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: issue with Mad Catz joystick ?
Date: Sat, 9 May 2015 10:54:06 +0200
Message-ID: <FB27B34B-9562-4A20-BC73-634B4B1824BD@gmail.com>
References: <CAHkp7MAbgJZ0bkDCG=WYWgJa2=y0rqFVRSjDL6jbtVQpp--==A@mail.gmail.com> <CAHkp7MAsieivQuZQ5aTKDTXWM=9bP1BK8Yqy5SLWeK1dr+2pzQ@mail.gmail.com> <1431121180.9786.23.camel@mars>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431121180.9786.23.camel@mars>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "chf.fritz-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org" <chf.fritz-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,
Yes it's on working conditions (and i have two of them), I looked into =
the xpad driver because 1) it was handling the ps3 pad at the beginning=
 2) because I found reference to the xbox version of my pad in it, so I=
 stupidly tried just to had the UUID of mine in the code.
The issues I have to investigate further is that I don't understand how=
 the kernel decide which module is loaded for the joypad, if I modprobe=
 other joystick related modules I don't see how to know if module A or =
B is handling it.=20
All I know is jstest "kind of" work with it but does not.
If you could point me to some leads that could be cool, I can give you =
external root access to it if you want.

Best regards


> Le 8 mai 2015 =C3=A0 23:39, Christoph Fritz <chf.fritz-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org=
> a =C3=A9crit :
>=20
> Hi Guillaume
>=20
>> On Tue, 2015-05-05 at 08:09 +0200, Guillaume APOSTOLY wrote:
>> I have the first PS3 version of the MadCatz Arcade Stick and I am tr=
ying to
>> use it on my raspberry pi (with a raspbian distribution).
>> The joystick is "detected", it shows up if I do "lsusb" and even if =
I do a
>> "jstest /dev/input/js0" but the display of jstest is like frozen and
>> pressing the buttons has no effect.
>> Oddly enough, it worked once (not the first time) after a reboot.
>=20
> Can you make sure this PS3 device is in an overall working condition?=
 If
> so, you need to come up with a quirk to make it work for Linux.
>=20
>> I have tested modification of the voltage of the USB, tried to power=
 it
>> with a Y cable in case this was the issue, I have investigated the u=
sb
>> layer (the stick being known on the web to use OHCI but I think this=
 is a
>> wrong lead).
>> Yesterday, I also added a part to xpad.c with the appropriate device=
 ID,
>> hoping that it will make it work somehow better, as currently only t=
he xbox
>> version is declared, and recompiled the kernel but this changes noth=
ing :
>=20
> As you noted, your device is for PlayStation 3 -- why do you think th=
e
> xbox driver is appropriate? It's not!
>=20
> have fun
>  -- chf
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
