From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [RFC] Should we create a raw input interface for IR's ? - Was: Re: [PATCH 1/3 v2] lirc core device driver infrastructure
Date: Wed, 25 Nov 2009 17:53:49 +0100
Message-ID: <m3fx827dgi.fsf@intrepid.localdomain>
References: <BDRae8rZjFB@christoph>
	<1259024037.3871.36.camel@palomino.walls.org>
	<6D934408-B713-49B6-A197-46CE663455AC@wilsonet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <6D934408-B713-49B6-A197-46CE663455AC@wilsonet.com> (Jarod
	Wilson's message of "Tue, 24 Nov 2009 08:32:40 -0500")
Sender: linux-media-owner@vger.kernel.org
To: Jarod Wilson <jarod@wilsonet.com>
Cc: Andy Walls <awalls@radix.net>, Christoph Bartelmus <lirc@bartelmus.de>, dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@redhat.com, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

Jarod Wilson <jarod@wilsonet.com> writes:

> The bulk of breakage in lirc I've personally had to deal with has
> mostly come in the form of kernel interface changes, which would
> definitely be mitigated by not having to maintain the drivers
> out-of-tree any longer.

Certainly.

> Now, I'm all for "improving" things and integrating better with the
> input subsystem, but what I don't really want to do is break
> compatibility with the existing setups on thousands (and thousands?)
> of MythTV boxes around the globe. The lirc userspace can be pretty
> nimble. If we can come up with a shiny new way that raw IR can be
> passed out through an input device, I'm pretty sure lirc userspace can
> be adapted to handle that.

Lirc can already handle input layer. Since both ways require userspace
changes, why not do it the right way the first time? Most of the code
is already written.

> If a new input-layer-based transmit interface is developed, we can
> take advantage of that too. But there's already a very mature lirc
> interface for doing all of this. So why not start with adding things
> more or less as they exist right now and evolve the drivers into an
> idealized form? Getting *something* into the kernel in the first place
> is a huge step in that direction.

What I see as potentially problematic is breaking compatibility multiple
times.
-- 
Krzysztof Halasa
