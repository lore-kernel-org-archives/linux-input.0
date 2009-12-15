From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel
	IR  system?
Date: Tue, 15 Dec 2009 12:47:13 +0100
Message-ID: <20091215114712.GA1385@ucw.cz>
References: <20091206065512.GA14651@core.coreip.homeip.net> <BENgzeZHqgB@lirc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BENgzeZHqgB@lirc>
Sender: linux-media-owner@vger.kernel.org
To: Christoph Bartelmus <lirc@bartelmus.de>
Cc: dmitry.torokhov@gmail.com, awalls@radix.net, hermann-pitton@arcor.de, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, jonsmirl@gmail.com, khc@pm.waw.pl, kraxel@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@redhat.com, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

On Sun 2009-12-06 12:59:00, Christoph Bartelmus wrote:
> Hi Dmitry,
> 
> on 05 Dec 09 at 22:55, Dmitry Torokhov wrote:
> [...]
> > I do not believe you are being realistic. Sometimes we just need to say
> > that the device is a POS and is just not worth it. Remember, there is
> > still "lirc hole" for the hard core people still using solder to produce
> > something out of the spare electronic components that may be made to
> > work (never mind that it causes the CPU constantly poll the device, not
> > letting it sleep and wasting electricity as a result - just hypotetical
> > example here).
> 
> The still seems to be is a persistent misconception that the home-brewn  
> receivers need polling or cause heavy CPU load. No they don't. All of them  
> are IRQ based.

I have at least one that needs polling/signal
processing... somewhere. IR LED connected to mic input.

Anyway, clearly hacked-up devices like that are better left for
userland solutions.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
