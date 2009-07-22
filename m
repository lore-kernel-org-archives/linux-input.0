From: David Brownell <david-b@pacbell.net>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 09:51:53 -0700
Message-ID: <200907220951.54419.david-b@pacbell.net>
References: <5d5443650907151033w36008b71pe4b32bcea9489b75@mail.gmail.com> <20090722121800.GD21171@rakim.wolfsonmicro.main> <alpine.LFD.2.00.0907221427380.2813@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753899AbZGVQv5@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0907221427380.2813@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Trilok Soni <soni.trilok@gmail.com>, Pavel Machek <pavel@ucw.cz>, Arve Hj?nnev?g <arve@android.com>, kernel list <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, linux-input@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-i2c@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, m.szyprowski@samsung.com, t.fujak@samsung.com, kyungmin.park@samsung.com, Peter Zijlstra <peterz@infradead.org>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: linux-input@vger.kernel.org

On Wednesday 22 July 2009, Thomas Gleixner wrote:
> main interrupt
> =A0 =A0 =A0hardirq handler wakes main thread handler
>=20
> main thread handler
> =A0 =A0 bus magic
> =A0 =A0=A0=A0=A0=A0=A0subdevice1 "hardirq" handler wakes subdevice1 i=
rq thread
> =A0 =A0=A0=A0=A0=A0=A0subdevice2 "hardirq" handler wakes subdevice2 i=
rq thread

Why force this wasteful/undesired "all subdevices must
have their own IRQ handling thread" policy?

As previously noted, a single thread typically suffices.
There's no need to waste a dozen (or so) pages of memory
for such purposes ... these events are (as noted most
recently by Mark) infrequent/rare and performance isn't
a functionality gatekeeper.  Plus ...


> =A0 =A0 main thread handler waits for subdevice1/2 handlers to comple=
te

=2E.. sharing that thread can eliminate that synchronization
problem, and simplify the whole process.


> subdevice1 thread handler
> =A0 =A0 bus magic
> =A0 =A0 ....
> =A0 =A0 thread_fn returns
> =A0 =A0 signal main thread handler via completion
>=20
> subdevice2 thread handler
> =A0 =A0 bus magic
> =A0 =A0 ....
> =A0 =A0 thread_fn returns
> =A0 =A0 signal main thread handler via completion
>=20
> main thread handler resumes
> =A0 =A0 bus magic
> =A0 =A0 main thread handler returns from thread_fn
> =A0 =A0 unmask main interrupt
