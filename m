From: Javier Herrero <jherrero@hvsistemas.es>
Subject: Re: [PATCH v3] input/keyboard: new OpenCores Keyboard Controller
 	driver
Date: Mon, 14 Sep 2009 20:18:48 +0200
Message-ID: <4AAE8908.1000104@hvsistemas.es>
References: <1252911864-19233-1-git-send-email-vapier@gentoo.org> 	<1252950003-9451-1-git-send-email-vapier@gentoo.org> <200909141049.50705.dmitry.torokhov@gmail.com> <8bd0f97a0909141102l5fa309f4ua1bedd0f1ac99295@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933075AbZINSZf@vger.kernel.org>
In-Reply-To: <8bd0f97a0909141102l5fa309f4ua1bedd0f1ac99295@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Bryan Wu <cooloney@kernel.org>
List-Id: linux-input@vger.kernel.org

Hello,

It has a bit long since last time I touched the driver, so I should als=
o=20
try to refresh my memory about it :). I suppose that you're right in th=
e=20
double allocation issue (I took another keyboard driver as a starting=20
point and probably the double allocation was already there...), so feel=
=20
free to introduce the change and I will test it as soon as I can.

About the exact scancode - key mapping, the reason is that since the=20
=46PGA opencores device already implements a translation table, I found=
=20
that another translation table sounded a bit redundant.

Best regards,

Javier

Mike Frysinger escribi=C3=B3:
> On Mon, Sep 14, 2009 at 13:49, Dmitry Torokhov wrote:
>> On Monday 14 September 2009 10:40:03 am Mike Frysinger wrote:
>>> +struct opencores_kbd {
>>> +     struct input_dev *input;
>>> +     struct resource *addr_res;
>>> +     struct resource *irq_res;
>>> +     unsigned short *keycode;
>>> +};
>> Why do we allocate keycode table separately form the main structure?
>
> the double alloc looked a little funny, but i didnt dive deep into th=
e
> details.  but as you point this out, it seems to make sense to me.
> any problems with that change Javier ?
>
> i.e. we do:
> struct ... { ... unsigned short keycode[NUM_KEYS]; }
> rather than doing two calls to kmalloc
>
>> I think I still have some reservations with the notion that we can j=
ust
>> have exact "scancode" - KEY_* mapping and hardware producers will ad=
just
>> the hardware to follow the deriver but I guess it's OK...
>
> considering this is a piece of "hardware" implemented in FPGAs, i
> think it's ok too.  if someone really needs more flexibility, then
> they're free to extend the driver and submit a patch :).
> -mike
>
>

--=20
-----------------------------------------------------------------------=
-
Javier Herrero                            EMAIL: jherrero@hvsistemas.co=
m
HV Sistemas S.L.                          PHONE:         +34 949 336 80=
6
Los Charcones, 17A                        FAX:           +34 949 336 79=
2
19170 El Casar - Guadalajara - Spain      WEB: http://www.hvsistemas.co=
m
