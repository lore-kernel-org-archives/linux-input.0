From: Olivier Scherler <oscherler-uGJ1f4YLbhHtRgLqZ5aouw@public.gmane.org>
Subject: Re: [PATCH] HID: usbhid: Add a quirk for Xin-Mo Dual Arcade
Date: Mon, 26 Oct 2015 12:00:50 +0100
Message-ID: <2A323439-5639-475A-AB8A-1CF915CF4316@ithink.ch>
References: <1445701499-13748-1-git-send-email-michele@acksyn.org> <alpine.LNX.2.00.1510242210360.21100@pobox.suse.cz>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1510242210360.21100-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Michele Baldessari <michele-Vrs1pLNSz9odnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

> On 24 oct. 2015, at 22:11, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> On Sat, 24 Oct 2015, Michele Baldessari wrote:
>=20
>> The Xin-Mo Dual Arcade controller (16c0:05e1) needs this quirk in or=
der
>> to have the two distinct joysticks working.
>>=20
>> Before the change:
>> $ jstest /dev/input/js0
>> Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)
>> ...
>> $ jstest /dev/input/js1
>> jstest: No such file or directory
>>=20
>> After the change:
>> $ jstest /dev/input/js0
>> Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)
>> ...
>> $ jstest /dev/input/js1
>> Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)
>> ...
>>=20
>> Signed-off-by: Michele Baldessari <michele-Vrs1pLNSz9odnm+yROfE0A@public.gmane.org>
>=20
> Adding Oliver to CC.
>=20
> Oliver, how come that you didn't need this while working on the inigi=
al=20
> Xin-Mo Dual Arcade support?

Because I didn=E2=80=99t mind whether the controller announced itself a=
s two joysticks with two axes each, or one joystick with four axes. In =
the software I use it for (a MAME for the Raspberry Pi), I can map a si=
ngle device=E2=80=99s buttons and axes to several players.

I=E2=80=99m a bit surprised with this, though:

> $ jstest /dev/input/js0
> Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)

because in my case I had four axes, at least using evtest (I don=E2=80=99=
t remember if I tried jstest as well).

What bothered me at the time, though, is that even though the custom dr=
iver was made as a kernel module, an entry had to be added in the hid_h=
ave_special_driver table in hid-core.c for the kernel to use it, which =
means, if I understand properly, that the kernel still needs recompilin=
g. Is that normal?

Best regards,
Olivier

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
