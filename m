From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel
 IR 	system?
Date: Tue, 08 Dec 2009 13:49:01 -0200
Message-ID: <4B1E756D.2090908@redhat.com>
References: <20091204220708.GD25669@core.coreip.homeip.net> <BEJgSGGXqgB@lirc>	<9e4733910912041628g5bedc9d2jbee3b0861aeb5511@mail.gmail.com>	<1260070593.3236.6.camel@pc07.localdom.local>	<20091206065512.GA14651@core.coreip.homeip.net>	<4B1B99A5.2080903@redhat.com> <m3638k6lju.fsf@intrepid.localdomain>	<9e4733910912060952h4aad49dake8e8486acb6566bc@mail.gmail.com>	<m3skbn6dv1.fsf@intrepid.localdomain>	<9e4733910912061323x22c618ccyf6edcee5b021cbe3@mail.gmail.com>	<4B1D934E.7030103@redhat.com> <m3hbs1vain.fsf@intrepid.localdomain>	<4B1E5DA3.7000206@redhat.com> <m3y6ldscut.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <m3y6ldscut.fsf@intrepid.localdomain>
Sender: linux-media-owner@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Jon Smirl <jonsmirl@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, hermann pitton <hermann-pitton@arcor.de>, Christoph Bartelmus <lirc@bartelmus.de>, awalls@radix.net, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, kraxel@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

Krzysztof Halasa wrote:
> Mauro Carvalho Chehab <mchehab@redhat.com> writes:
> 
>> If you use a kfifo to store the event (space_or_mark, timestamp), 
>> the IRQ handler can return immediately, and a separate kernel thread 
>> can do the decode without needing to touch at the IRQ.
> 
> But the decoding itself is a really simple thing, why complicate it?
> There is no need for the kernel thread if the handler is fast (and it
> is).

The decoding of just one protocol may be fast, but having several decoders
serialized (without kthreads, you're serializing the decoders) will possibly
not be that fast.

Also, you don't need wake the decoders kthreads for every event, but wait
for some number of events to happen before waking it. For example,
16 pulse/space events correspond to 8 bits of data on most protocols, 
so you can wake the kthread only after 16 events for really simple decoders,
or if a timeout event is detected. The number of events to wake may be customized
per decoder.

Cheers,
Mauro.
