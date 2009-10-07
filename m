From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 32-rc1 aka 32-rc2: warning at manage.c:361 (set_irq_wake),
	matrix-keypad related?
Date: Wed, 7 Oct 2009 23:12:26 +0200
Message-ID: <20091007211225.GB17805@elf.ucw.cz>
References: <20090930200746.GA1384@ucw.cz>
	<20091006050649.GH27881@core.coreip.homeip.net>
	<20091006075816.GA1362@ucw.cz>
	<20091007043603.GC10204@core.coreip.homeip.net>
	<f17812d70910070742y5e27f9c3u38e3299b94f33613@mail.gmail.com>
	<20091007163327.GA12053@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20091007163327.GA12053@core.coreip.homeip.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Eric Miao <eric.y.miao@gmail.com>, dbaryshkov@gmail.com, Cyril Hrubis <metan@ucw.cz>, arminlitzel@web.de, kernel list <linux-kernel@vger.kernel.org>, Dirk@opfer-online.de, utx@penguin.cz, lenz@cs.wisc.edu, rpurdie@rpsys.net, omegamoon@gmail.com, linux-input@vger.kernel.org, thommycheck@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org


> > > OK, so it looks like your box refuses to set up one of the GPIOs as a
> > > wakeup source... Hmm, either your box is wrong ;) or matrix_keypad
> > > driver needs to maintain a separate list of wakeup GPIOs.
> > >
> > 
> > This is due to the nature of PXA processor, where not every GPIO can
> > be configured as a wakeup source. Mmm.... we can either return a
> > pseudo value indicating setting wakeup on that GPIO is OK (which
> > doesn't sound like a good idea), or we can just ignore the failure of
> > enable_irq_wake() in matrix_keypad?
> 
> We ignore the failure right now in the mainline but that causes stack
> traces on resume as we trying to disable not enabled wakeup GPIOs. That
> was original Pavel's complaint.

Yep...

I'd say that BUG() simply should not trigger if wakeup can not be
enabled/disabled for particular source...?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
