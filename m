From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH v2 3/5] Input: add KEY_ROTATE_LOCK_TOGGLE
Date: Thu, 25 Jan 2018 08:23:56 -0800
Message-ID: <CANRwn3R_SKzJyH3pNCpuzp+4--ebzG5VRCh9YEtj+F3VUJ1xew@mail.gmail.com>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de>
 <8ebdb255-b0b5-4de2-a680-e7f6713256d0@rwthex-w2-a.rwth-ad.de>
 <1510270493.2624.49.camel@hadess.net> <2845999.tyV6EiPLrg@sbruens-linux> <CANRwn3SzMUvNoBjp2X1jtN9XaQ98RxCCZ86Hu4sPQygTORqjKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CANRwn3SzMUvNoBjp2X1jtN9XaQ98RxCCZ86Hu4sPQygTORqjKg@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: =?UTF-8?B?QnLDvG5zLCBTdGVmYW4=?= <Stefan.Bruens@rwth-aachen.de>, Alex Hung <alex.hung@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Any movement on this? Are we just waiting on an ACK/NAK from Dmitry?

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....


On Tue, Dec 5, 2017 at 10:50 AM, Jason Gerecke <killertofu@gmail.com> wrote=
:
> Looks like this might also be needed for the MobileStudio Pro...
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D197991
>
> Jason
> ---
> Now instead of four in the eights place /
> you=E2=80=99ve got three, =E2=80=98Cause you added one  /
> (That is to say, eight) to the two,     /
> But you can=E2=80=99t take seven from three,    /
> So you look at the sixty-fours....
>
>
>
> On Thu, Nov 30, 2017 at 9:51 AM, Br=C3=BCns, Stefan
> <Stefan.Bruens@rwth-aachen.de> wrote:
>> On Freitag, 10. November 2017 00:34:53 CET Bastien Nocera wrote:
>>> On Thu, 2017-11-09 at 23:44 +0100, Stefan Br=C3=BCns wrote:
>>> > The key has the same use as the SW_ROTATE_LOCK, but is used on
>>> > devices
>>> > where the state is not tracked by the hardware but has to be handled
>>> > in software.
>>>
>>> I'll let the input and hid subsystem maintainers have the final say
>>> here, though I think that sending out Win+O would be easier, as this is
>>> already something that desktops need to support for those devices that
>>> send the actual Win+O key combination when those buttons are pressed
>>> there.
>>>
>>> If we're going with the separate keycode, could you also file bugs
>>> against xkbd-common and xkeyboard-config to get the key added to the
>>> list of XF86 keysyms and to the default evdev keymap? Otherwise Wayland
>>> and X11 based desktops won't be able to use it.
>>
>> Filed for xkeyboard-config:
>> https://bugs.freedesktop.org/show_bug.cgi?id=3D103998
>>
>> and xkb-common:
>> https://github.com/xkbcommon/libxkbcommon/issues/55
>>
>> Regards,
>>
>> Stefan
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" i=
n
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
