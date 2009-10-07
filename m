From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: 32-rc1 aka 32-rc2: warning at manage.c:361 (set_irq_wake),
	matrix-keypad related?
Date: Tue, 6 Oct 2009 21:36:04 -0700
Message-ID: <20091007043603.GC10204@core.coreip.homeip.net>
References: <20090930200746.GA1384@ucw.cz>
	<20091006050649.GH27881@core.coreip.homeip.net>
	<20091006075816.GA1362@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20091006075816.GA1362@ucw.cz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, thommycheck@gmail.com, dbaryshkov@gmail.com, Cyril Hrubis <metan@ucw.cz>, arminlitzel@web.de, kernel list <linux-kernel@vger.kernel.org>, Dirk@Opfer-Online.de, utx@penguin.cz, lenz@cs.wisc.edu, rpurdie@rpsys.net, omegamoon@gmail.com, linux-input@vger.kernel.org, eric.y.miao@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

On Tue, Oct 06, 2009 at 09:58:17AM +0200, Pavel Machek wrote:
> Hi!
> 
> On Mon 2009-10-05 22:06:50, Dmitry Torokhov wrote:
> > On Wed, Sep 30, 2009 at 10:07:46PM +0200, Pavel Machek wrote:
> > > 
> > > It complains about unbalanced irq 113 wake disable. That one belongs
> > > to matrix-keypad...
> > 
> > I guess some of enable_irq_wake()s fail on your box. Do you see it if
> > you apply the patch below?
> 
> I'll do short test. But... if you are right, your patch will just make
> your machine refuse to suspend... right?
> 
> Ungood.

It was just a debug patch.

> 
> Actually, it seems to break suspend (returns  -EINVAL while refusing
> to suspend), warnings are still there, and keyboard is dead after
> failed suspend... double plus ungood.
> 
> Aha, so warning is solved: the one in the log is from gpio_buttons.
> 

OK, so it looks like your box refuses to set up one of the GPIOs as a
wakeup source... Hmm, either your box is wrong ;) or matrix_keypad
driver needs to maintain a separate list of wakeup GPIOs.

-- 
Dmitry
