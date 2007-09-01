From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Console keyboard events and accessibility
Date: Sat, 1 Sep 2007 12:32:58 +0000
Message-ID: <20070901123258.GA4612@ucw.cz>
References: <20070821005718.GD3658@interface.famille.thibault.fr> <Pine.LNX.4.64.0708210732270.5333@fbirervta.pbzchgretzou.qr> <20070821204951.GC3658@interface.famille.thibault.fr> <20070712191932.GA3947@ucw.cz> <20070901122604.GA3251@implementation.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070901122604.GA3251@implementation.famille.thibault.fr>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Engelhardt <jengelh@computergmbh.de>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org


> > > > They can use the raw xlation for that.
> > > 
> > > For userland, yes.  This is for kernel modules.
> > 
> > And should speakup be a kernel module? Why?
> 
> Because userland only begins quite late in the boot process, and
> userland may hang.

Initrd means userland is started very early on most machines these
days, and kernel may hang, too.

> > What is missing? Yes, you may want to do a small kernel module to read
> > kernel bootup messages.
> 
> That's what it's all about.

But this small module should not need keyboard leds support, as those are not used during
boot. If all you want is to read kernel bootup messages, you should
just register a special console. Actually serial console should do.

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
