From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel IR
	system?
Date: Sun, 29 Nov 2009 16:47:18 -0500
Message-ID: <9e4733910911291347x4c4cac73h8c64223d0de563e4@mail.gmail.com>
References: <m3r5riy7py.fsf@intrepid.localdomain> <BDkdITRHqgB@lirc>
	 <9e4733910911280906if1191a1jd3d055e8b781e45c@mail.gmail.com>
	 <m3aay6y2m1.fsf@intrepid.localdomain>
	 <9e4733910911280937k37551b38g90f4a60b73665853@mail.gmail.com>
	 <1259450815.3137.19.camel@palomino.walls.org>
	 <m3ocml6ppt.fsf@intrepid.localdomain>
	 <9e4733910911291244p364b328fm3a76ded4e4cd8603@mail.gmail.com>
	 <83224BA3-A5FF-4525-BF20-16A60F865C0A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <83224BA3-A5FF-4525-BF20-16A60F865C0A@gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Andy Walls <awalls@radix.net>, Christoph Bartelmus <lirc@bartelmus.de>, "j@jannau.net" <j@jannau.net>, "jarod@redhat.com" <jarod@redhat.com>, "jarod@wilsonet.com" <jarod@wilsonet.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "maximlevitsky@gmail.com" <maximlevitsky@gmail.com>, "mchehab@redhat.com" <mchehab@redhat.com>, "stefanr@s5r6.in-berlin.de" <stefanr@s5r6.in-berlin.de>, "superm1@ubuntu.com" <superm1@ubuntu.com>
List-Id: linux-input@vger.kernel.org

On Sun, Nov 29, 2009 at 4:29 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Nov 29, 2009, at 12:44 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>
>> On Sun, Nov 29, 2009 at 3:27 PM, Krzysztof Halasa <khc@pm.waw.pl> wr=
ote:
>>>
>>> 1. Do we agree that a lirc (-style) kernel-user interface is needed=
 at
>>> =A0least?
>>>
>>> 2. Is there any problem with lirc kernel-user interface?
>>
>> Can you consider sending the raw IR data as a new evdev message type
>> instead of creating a new device protocol?
>
> No, I think it would be wrong. Such events are ill-suited for consump=
tion by
> regular applications and would introduce the "looping" interface I de=
scribed
> in my other email.

Regular applications are going to ignore these messages. The only
consumer for them is the LIRC daemon. Which is just going to process
them and re-inject the events back into evdev again in a different
form.

IR is an input device, what make it so special that it needs to by
pass this subsystem and implement its own private communications
scheme?

>> evdev protects the messages in a transaction to stop incomplete
>> messages from being read.
>
> If such property is desired we can add it to the new lirc-like interf=
ace,
> can't we?

Why do you want to redesign evdev instead of using it?


>
> --
>>
> Dmitry
>



--=20
Jon Smirl
jonsmirl@gmail.com
