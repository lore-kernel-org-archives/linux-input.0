From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Can I expect in-kernel decoding to work out of box?
Date: Wed, 28 Jul 2010 09:46:26 -0400
Message-ID: <AANLkTinCs7f6zF-tYZqJ49CAjNWF=2MPGh0VRuU=VLzq@mail.gmail.com>
References: <1280269990.21278.15.camel@maxim-laptop>
	<1280273550.32216.4.camel@maxim-laptop>
	<AANLkTi=493LW6ZBURCtyeSYPoX=xfz6n6z77Lw=a2C9D@mail.gmail.com>
	<AANLkTimN1t-1a0v3S1zAXqk4MXJepKdsKP=cx9bmo=6g@mail.gmail.com>
	<1280298606.6736.15.camel@maxim-laptop>
	<AANLkTingNgxFLZcUszp-WDZocH+VK_+QTW8fB2PAR7XS@mail.gmail.com>
	<4C502CE6.80106@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <4C502CE6.80106@redhat.com>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Jarod Wilson <jarod@wilsonet.com>, linux-input <linux-input@vger.kernel.org>, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Let's be really sure it is NEC and not JVC.

> >    8850     4350      525     1575      525     1575
> >     525      450      525      450      525      450
> >     525      450      525     1575      525      450
> >     525     1575      525      450      525     1575
> >     525      450      525      450      525     1575
> >     525      450      525      450      525    23625


NEC timings are 9000 4500 560 1680 560 560 etc

JVC timings are 8400 4200 525 1575 525 525

It is a closer match to the JVC timing.  But neither protocol uses a
different mark/space timing -- 450 vs 525

Also look at the repeats. This is repeating at about 25ms. NEC repeat
spacing is 110ms. JVC is supposed to be at 50-60ms. NEC does not
repeat the entire command and JVC does. The repeats are closer to
following the JVC model.

I'd say this is a JVC command. So the question is, why didn't JVC
decoder get out of state zero?

-- 
Jon Smirl
jonsmirl@gmail.com
