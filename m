From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [RFC2] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Thu, 08 Apr 2010 14:04:52 -0300
Message-ID: <4BBE0CB4.9040807@infradead.org>
References: <20100407201835.GA8438@hardeman.nu> <4BBD6550.6030000@infradead.org> <r2l9e4733911004080541s58fd4e70o215800426290a09a@mail.gmail.com> <4BBDD4ED.5040007@infradead.org> <20100408155317.GA21848@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100408155317.GA21848@hardeman.nu>
Sender: linux-media-owner@vger.kernel.org
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>
Cc: Jon Smirl <jonsmirl@gmail.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

David H=E4rdeman wrote:
> On Thu, Apr 08, 2010 at 10:06:53AM -0300, Mauro Carvalho Chehab wrote=
:
>> Jon Smirl wrote:
>>> On Thu, Apr 8, 2010 at 1:10 AM, Mauro Carvalho Chehab
>>> <mchehab@infradead.org> wrote:
>>>> On the previous code, it is drivers responsibility to call the=20
>>>> function that
>>>> de-queue. On saa7134, I've scheduled it to wake after 15 ms. So, i=
nstead of
>>>> 32 wakeups, just one is done, and the additional delay introduced =
by it is not
>>>> enough to disturb the user.
>>> The wakeup is variable when the default thread is used. My quad cor=
e
>>> desktop wakes up on every pulse. My embedded system wakes up about
>>> every 15 pulses. The embedded system called schedule_work() fifteen
>>> times from the IRQ, but the kernel collapsed them into a single
>>> wakeup. I'd stick with the default thread and let the kernel get
>>> around to processing IR whenever it has some time.
>> Makes sense.
>=20
> Given Jon's experience, it would perhaps make sense to remove=20
> ir_raw_event_handle() and call schedule_work() from every call to=20
> ir_raw_event_store()?
>=20
> One thing less for IR drivers to care about...

Maybe, on a separate patch, but let's do it by the end of the changes,
to let people to give us some feedback about the practical effects
on the users side, and the corresponding perf impacts.=20

I won't mind to move the mod_timer stuff from saa7134 to the core,=20
as a way to easy this change.

--=20

Cheers,
Mauro
