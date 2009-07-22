From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 14:57:09 -0700
Message-ID: <d6200be20907221457r4e2f6d29g57146586fd13776a@mail.gmail.com>
References: <5d5443650907151033w36008b71pe4b32bcea9489b75@mail.gmail.com>
	 <alpine.LFD.2.00.0907221427380.2813@localhost.localdomain>
	 <1248269443.27058.1449.camel@twins>
	 <200907220957.16499.david-b@pacbell.net>
	 <alpine.LFD.2.00.0907222226270.2813@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.00.0907222226270.2813-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.fujak-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jul 22, 2009 at 2:04 PM, Thomas Gleixner<tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wr=
ote:
> On Wed, 22 Jul 2009, David Brownell wrote:
>> On Wednesday 22 July 2009, Peter Zijlstra wrote:
>> > Wouldn't it be better if we could express the nesting property fro=
m
>> > within genirq, so that we can do things like:
>> >
>> > =A0 register_chip_nested(parent_chip, parent_irq, slave_chip);
>> >
>> > And let genirq set-up the needed magic to make the nesting work.
>>
>> I've been requesting such IRQ chaining support for some time
>> now ... if the ears are now listening, that kind of direction
>> should be pursued.
>
> Well, I was all ear back then, but the disconnect between "embedded
> only needs X be happy" and my repsonsibility to keep that all working
> for everyone was way larger. :)
>
>> > Also, how important is it that subhandler1..n run in their own thr=
ead?
>>
>> Completely unimportant in a practical sense. =A0Undesirable, even;
>> wasteful to allocate all those stack pages and keep them idle
>> most of the time.
>>
>> There might be an argument that the design isn't technicaly done
>> until that model *can* be supported. =A0On the flip side, last time
>> this came up there was no "customer demand" for that ... it was
>> all "supplier push".
>>
>>
>> > That is, can't we let them run from the thread that is otherwise w=
aiting
>> > for the completino anyway?
>>
>> That would be far preferable, yes.
>
> Ok, so let me summarize what we came up with so far.
>
> 1) handle_level_oneshot_irq is the correct answer to the problem of
> those "I'm behind a slow bus" interrupt controllers.
>
> 2) Some mechanism to request ONESHOT from the driver level is
> required. Preferrably via a flag on request_threaded_irq
>
> 3) a function which allows to express the nested thread irq nature of
> the interrupt controller and its subdevices.
>
> 4) a generic serializing mechanism which is implemented via irq_chip
> functions to solve the chip->mask/unmask issue for the demultiplexed
> interrupts. Something like the bus_lock/bus_sync_unlock patch I poste=
d
> earlier.
>
> 5) a common function which allows to call the thread handler of the
> subdevice interrupts in the context of the main thread which takes
> care of serialization against disable/enable/request/free irq et al.
>
> Any more ?

It would also be useful to mask an edge triggered interrupt until the
thread handler has finished. The touchscreen on the G1 is connected to
an edge triggered interrupt, and the touchscreen may toggle the
interrupt line while reading its registers.

--=20
Arve Hj=F8nnev=E5g
