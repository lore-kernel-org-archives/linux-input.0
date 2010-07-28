From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Can I expect in-kernel decoding to work out of box?
Date: Wed, 28 Jul 2010 13:35:07 -0400
Message-ID: <AANLkTikotLLPcCvwwNFEe+80sV6w9F0pa_fx3f_jdK77@mail.gmail.com>
References: <1280269990.21278.15.camel@maxim-laptop>
	<1280273550.32216.4.camel@maxim-laptop>
	<AANLkTi=493LW6ZBURCtyeSYPoX=xfz6n6z77Lw=a2C9D@mail.gmail.com>
	<AANLkTimN1t-1a0v3S1zAXqk4MXJepKdsKP=cx9bmo=6g@mail.gmail.com>
	<1280298606.6736.15.camel@maxim-laptop>
	<AANLkTingNgxFLZcUszp-WDZocH+VK_+QTW8fB2PAR7XS@mail.gmail.com>
	<4C502CE6.80106@redhat.com>
	<AANLkTinCs7f6zF-tYZqJ49CAjNWF=2MPGh0VRuU=VLzq@mail.gmail.com>
	<1280327929.11072.24.camel@morgan.silverblock.net>
	<AANLkTikFfXx4NBB2z2UXNt5Kt-2QrvTfvK0nQhSSqw8v@mail.gmail.com>
	<4C504FDB.4070400@redhat.com>
	<1280336530.19593.52.camel@morgan.silverblock.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1280336530.19593.52.camel@morgan.silverblock.net>
Sender: linux-media-owner@vger.kernel.org
To: Andy Walls <awalls@md.metrocast.net>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Jarod Wilson <jarod@wilsonet.com>, linux-input <linux-input@vger.kernel.org>, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jul 28, 2010 at 1:02 PM, Andy Walls <awalls@md.metrocast.net> w=
rote:
> On Wed, 2010-07-28 at 12:42 -0300, Mauro Carvalho Chehab wrote:
>> Em 28-07-2010 11:53, Jon Smirl escreveu:
>> > On Wed, Jul 28, 2010 at 10:38 AM, Andy Walls <awalls@md.metrocast.=
net> wrote:
>> >> On Wed, 2010-07-28 at 09:46 -0400, Jon Smirl wrote:
>
>> > I recommend that all decoders initially follow the strict protocol
>> > rules. That will let us find bugs like this one in the ENE driver.
>>
>> Agreed.
>
> Well...
>
> I'd possibly make an exception for the protocols that have long-mark
> leaders. =A0The actual long mark measurement can be far off from the
> protocol's specification and needs a larger tolerance (IMO).
>
> Only allowing 0.5 to 1.0 of a protocol time unit tolerance, for a
> protocol element that is 8 to 16 protocol time units long, doesn't ma=
ke
> too much sense to me. =A0If the remote has the basic protocol time un=
it
> off from our expectation, the error will likely be amplified in a lon=
g
> protocol elements and very much off our expectation.

Do you have a better way to differentiate JVC and NEC protocols? They
are pretty similar except for the timings. What happened in this case
was that the first signals matched the NEC protocol. Then we shifted
to bits that matched JVC protocol.

The NEC bits are 9000/8400 =3D 7% longer. If we allow more than a 3.5%
error in the initial bit you can't separate the protocols.

In general the decoders are pretty lax and the closest to the correct
one with decode the stream. The 50% rule only comes into play between
two very similar protocols.

One solution would be to implement NEC/JVC in the same engine. Then
apply the NEC consistency checks. If the consistency check pass
present the event on the NEC interface. And then always present the
event on the JVC interface.

>> I think that the better is to add some parameters, via sysfs, to rel=
ax the
>> rules at the current decoders, if needed.
>
> Is that worth the effort? =A0It seems like only going half-way to an
> ultimate end state.
>
> <crazy idea>
> If you go through the effort of implementing fine grained controls
> (tweaking tolerances for this pulse type here or there), why not just
> implement a configurable decoding engine that takes as input:
>
> =A0 =A0 =A0 =A0symbol definitions
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(pulse and space length specifications=
 and tolerances)
> =A0 =A0 =A0 =A0pulse train states
> =A0 =A0 =A0 =A0allowed state transitions
> =A0 =A0 =A0 =A0gap length
> =A0 =A0 =A0 =A0decoded output data length
>
> and instantiates a decoder that follows a user-space provided
> specification?
>
> The user can write his own decoding engine specification in a text fi=
le,
> feed it into the kernel, and the kernel can implement it for him.
> </crazy idea>
>
> OK, maybe that is a little too much time and effort. ;)
>
> Regards,
> Andy
>
>
>> Cheers,
>> Mauro
>
>
>



--=20
Jon Smirl
jonsmirl@gmail.com
