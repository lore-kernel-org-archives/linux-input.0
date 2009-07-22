From: David Brownell <david-b@pacbell.net>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 09:39:32 -0700
Message-ID: <200907220939.33399.david-b@pacbell.net>
References: <20090714100634.GA4054@elf.ucw.cz> <20090721160436.GD4352@dtor-d630.eng.vmware.com> <alpine.LFD.2.00.0907212225030.2813@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp102.sbc.mail.gq1.yahoo.com ([67.195.15.61]:26873 "HELO
	smtp102.sbc.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753512AbZGVQje (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jul 2009 12:39:34 -0400
In-Reply-To: <alpine.LFD.2.00.0907212225030.2813@localhost.localdomain>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Trilok Soni <soni.trilok@gmail.com>, Pavel Machek <pavel@ucw.cz>, Arve Hj?nnev?g <arve@android.com>, kernel list <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, linux-input@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-i2c@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, m.szyprowski@samsung.com, t.fujak@samsung.com, kyungmin.park@samsung.com, Peter Zijlstra <peterz@infradead.org>

On Tuesday 21 July 2009, Thomas Gleixner wrote:
> =A0 =A0 =A0 See http://lkml.org/lkml/2009/7/17/174=20

Interesting.  The model is then to switch over to __set_irq_handler(),
or maybe set_irq_chip_and_handler(), to replace the toplevel dispatch
code for will-be-threaded IRQs which happen to be hooked up to inputs
that don't sense edges.  (Agree, that seems like a goof.  But hardware
designers sometimes have any choices there.)

The normal model is that boards don't get involved with that level of
logic ... all IRQs get set up once on generic code, and flow handlers
don't change.  Or if they do change, it's done when changing the IRQ's
trigger mode from edge to level, or vice versa.

Can that be cleaned up a bit, so that the handle_level_oneshot_irq()
and unmask_oneshot_irq() stuff kicks in automatically when needed,
instead of requiring board-specific (or driver-specific) code to get
that stuff right?

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
