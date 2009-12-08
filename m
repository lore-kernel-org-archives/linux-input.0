From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel IR 	system?
Date: Tue, 08 Dec 2009 14:52:00 +0100
Message-ID: <m3hbs1vain.fsf@intrepid.localdomain>
References: <20091204220708.GD25669@core.coreip.homeip.net> <BEJgSGGXqgB@lirc>
	<9e4733910912041628g5bedc9d2jbee3b0861aeb5511@mail.gmail.com>
	<1260070593.3236.6.camel@pc07.localdom.local>
	<20091206065512.GA14651@core.coreip.homeip.net>
	<4B1B99A5.2080903@redhat.com> <m3638k6lju.fsf@intrepid.localdomain>
	<9e4733910912060952h4aad49dake8e8486acb6566bc@mail.gmail.com>
	<m3skbn6dv1.fsf@intrepid.localdomain>
	<9e4733910912061323x22c618ccyf6edcee5b021cbe3@mail.gmail.com>
	<4B1D934E.7030103@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755206AbZLHNv7@vger.kernel.org>
In-Reply-To: <4B1D934E.7030103@redhat.com> (Mauro Carvalho Chehab's message of
	"Mon, 07 Dec 2009 21:44:14 -0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, hermann pitton <hermann-pitton@arcor.de>, Christoph Bartelmus <lirc@bartelmus.de>, awalls@radix.net, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, kraxel@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

Mauro Carvalho Chehab <mchehab@redhat.com> writes:

>> What is the interface for attaching an in-kernel decoder?
>
> IMO, it should use the kfifo for it. However, if we allow both raw data and
> in-kernel decoders to read data there, we'll need a spinlock to protect the
> kfifo.

This may be an option, but I think we should be able to attach protocol
decoders in parallel, directly to the IRQ handler. At least with RC-5
(that's what I personally use) it means reliable decoding, no need for
any timeouts, the code is clean, fast (can be a part of hard IRQ
handler) and simple.

The decoder needs something like
	rc5_signal_change(ptr, space_or_mark, microseconds).

At least mark->space or space->mark events must be reported. For better
reliability, both of them.
-- 
Krzysztof Halasa
