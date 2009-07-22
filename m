From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 09:57:15 -0700
Message-ID: <200907220957.16499.david-b@pacbell.net>
References: <5d5443650907151033w36008b71pe4b32bcea9489b75@mail.gmail.com> <alpine.LFD.2.00.0907221427380.2813@localhost.localdomain> <1248269443.27058.1449.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1248269443.27058.1449.camel@twins>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Arve Hj?nnev?g <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.fujak-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wednesday 22 July 2009, Peter Zijlstra wrote:
> Wouldn't it be better if we could express the nesting property from
> within genirq, so that we can do things like:
>=20
> =A0 register_chip_nested(parent_chip, parent_irq, slave_chip);
>=20
> And let genirq set-up the needed magic to make the nesting work.

I've been requesting such IRQ chaining support for some time
now ... if the ears are now listening, that kind of direction
should be pursued.


> Also, how important is it that subhandler1..n run in their own thread=
?

Completely unimportant in a practical sense.  Undesirable, even;
wasteful to allocate all those stack pages and keep them idle
most of the time.

There might be an argument that the design isn't technicaly done
until that model *can* be supported.  On the flip side, last time
this came up there was no "customer demand" for that ... it was
all "supplier push".


> That is, can't we let them run from the thread that is otherwise wait=
ing
> for the completino anyway?

That would be far preferable, yes.

- Dave
