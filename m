From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: 32-rc1 aka 32-rc2: warning at manage.c:361 (set_irq_wake),
	matrix-keypad related?
Date: Wed, 7 Oct 2009 09:33:28 -0700
Message-ID: <20091007163327.GA12053@core.coreip.homeip.net>
References: <20090930200746.GA1384@ucw.cz>
	<20091006050649.GH27881@core.coreip.homeip.net>
	<20091006075816.GA1362@ucw.cz>
	<20091007043603.GC10204@core.coreip.homeip.net>
	<f17812d70910070742y5e27f9c3u38e3299b94f33613@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <f17812d70910070742y5e27f9c3u38e3299b94f33613@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, thommycheck@gmail.com, dbaryshkov@gmail.com, Cyril Hrubis <metan@ucw.cz>, arminlitzel@web.de, kernel list <linux-kernel@vger.kernel.org>, Dirk@opfer-online.de, utx@penguin.cz, lenz@cs.wisc.edu, rpurdie@rpsys.net, omegamoon@gmail.com, Pavel Machek <pavel@ucw.cz>, linux-input@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

On Wed, Oct 07, 2009 at 10:42:08PM +0800, Eric Miao wrote:
> On Wed, Oct 7, 2009 at 12:36 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Tue, Oct 06, 2009 at 09:58:17AM +0200, Pavel Machek wrote:
> >> Hi!
> >>
> >> On Mon 2009-10-05 22:06:50, Dmitry Torokhov wrote:
> >> > On Wed, Sep 30, 2009 at 10:07:46PM +0200, Pavel Machek wrote:
> >> > >
> >> > > It complains about unbalanced irq 113 wake disable. That one belon=
gs
> >> > > to matrix-keypad...
> >> >
> >> > I guess some of enable_irq_wake()s fail on your box. Do you see it if
> >> > you apply the patch below?
> >>
> >> I'll do short test. But... if you are right, your patch will just make
> >> your machine refuse to suspend... right?
> >>
> >> Ungood.
> >
> > It was just a debug patch.
> >
> >>
> >> Actually, it seems to break suspend (returns =A0-EINVAL while refusing
> >> to suspend), warnings are still there, and keyboard is dead after
> >> failed suspend... double plus ungood.
> >>
> >> Aha, so warning is solved: the one in the log is from gpio_buttons.
> >>
> >
> > OK, so it looks like your box refuses to set up one of the GPIOs as a
> > wakeup source... Hmm, either your box is wrong ;) or matrix_keypad
> > driver needs to maintain a separate list of wakeup GPIOs.
> >
> =

> This is due to the nature of PXA processor, where not every GPIO can
> be configured as a wakeup source. Mmm.... we can either return a
> pseudo value indicating setting wakeup on that GPIO is OK (which
> doesn't sound like a good idea), or we can just ignore the failure of
> enable_irq_wake() in matrix_keypad?

We ignore the failure right now in the mainline but that causes stack
traces on resume as we trying to disable not enabled wakeup GPIOs. That
was original Pavel's complaint.

-- =

Dmitry
