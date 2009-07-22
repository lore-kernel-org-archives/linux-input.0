From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 16:30:15 -0700
Message-ID: <d6200be20907221630j67677654tbec5f27824ab3a96@mail.gmail.com>
References: <5d5443650907151033w36008b71pe4b32bcea9489b75@mail.gmail.com>
	 <alpine.LFD.2.00.0907222226270.2813@localhost.localdomain>
	 <d6200be20907221457r4e2f6d29g57146586fd13776a@mail.gmail.com>
	 <200907221515.07835.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:47553 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbZGVXaQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jul 2009 19:30:16 -0400
In-Reply-To: <200907221515.07835.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Trilok Soni <soni.trilok@gmail.com>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, linux-input@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-i2c@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, m.szyprowski@samsung.com, t.fujak@samsung.com, kyungmin.park@samsung.com, Daniel Ribeiro <drwyrm@gmail.com>

2009/7/22 David Brownell <david-b@pacbell.net>:
> On Wednesday 22 July 2009, Arve Hj=F8nnev=E5g wrote:
>> It would also be useful to mask an edge triggered interrupt until th=
e
>> thread handler has finished. The touchscreen on the G1 is connected =
to
>> an edge triggered interrupt, and the touchscreen may toggle the
>> interrupt line while reading its registers.
>
> To clarify: =A0if it does toggle, do you want that event to be
> queued up so the IRQ is re-issued -- or not? =A0That "oneshot"
> mechanism does some of that, though it's for level triggers.

=46or this driver yes the event should normally be queued up. If there
is an error detected though, there is no need to queue up interrupts
that are generated during the reinit.

Also, if you implement a keypad matrix driver using a threaded
interrupt handler, you will not want the interrupt to be re-issues
unless it occured after the last key was released since the scan
itself always generated more interrupts. This is not specific to
threaded interrupt handlers though, and could be handled by adding a
clear-interrupt function.

>
> Parts of that might be appropriate to handle in the threaded
> IRQ handler itself. =A0It seems a bit device-specific.

Yes, the driver could request a threaded one-shot interrupt so that it
will work when it is connected to a level triggered interrupt, and
also call disable_interrupt/enable_interrrupt in the handler to avoid
extra interrupts when it is connected to an edge triggered source.
But, it would be nicer if requesting a one-shot interrupt always
works. Also, waiting until the threaded handler runs before masking
the interrupt would not work well if the interrupt line needs software
debouncing.

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
