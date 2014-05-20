From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/6] input: cyapa: enable/disable trackpad device based on LID state
Date: Tue, 20 May 2014 23:07:18 +0200
Message-ID: <3078365.io3T8cjti2@vostro.rjw.lan>
References: <77BC725C9062764F874D79F51E1F1A8F40C14099@S04-MBX01-01.s04.local> <1507406.BNOsJcxmP9@vostro.rjw.lan> <20140520152551.GB9444@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140520152551.GB9444@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Dudley Du <dudl@cypress.com>, Benson Leung <bleung@google.com>, Daniel Kurtz <djkurtz@google.com>, David Solda <dso@cypress.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tuesday, May 20, 2014 08:25:51 AM Dmitry Torokhov wrote:
> On Tue, May 20, 2014 at 02:40:12PM +0200, Rafael J. Wysocki wrote:
> > On Monday, May 19, 2014 08:43:02 PM Dmitry Torokhov wrote:
> > > Hi Dudley,
> > > 
> > > On Wed, Apr 16, 2014 at 08:39:34AM +0000, Dudley Du wrote:
> > > > Rely on EV_SW and SW_LID bits to identify a LID device, and hook
> > > > up our filter to listen for SW_LID events to enable/disable touchpad when
> > > > LID is open/closed.
> > > > TEST=test on Chomebooks.
> > > 
> > > This is a policy and it does not belong in the kernel. Please work with
> > > Rafael to establish generic interface to put devices into low power mode
> > > (like accelerating runtime PM idle timeout)
> > 
> > I'm not really sure what you mean here, care to be more specific?
> 
> I think we chatted about this before - we need a uniform interface for
> userspace to put devices into low power mode on demand.

I'm still not sure what you mean exactly.

If you mean an interface for user space to *force* transitions into low-power
states, we can't have it, because user space doesn't know when it is safe to
do that.  The /sys/devices/.../power/control interface is the best we can
give to user space to this end.

Adding Alan Stern to the recipient list, because he was inovlved in discussions
about that.

But if you mean an interface for user space to poke at pm_runtime_idle() to
possibly trigger a runtime suspend, that we can add I think.  Alan?

> As implementation detail I thought we could require runtime PM for that and
> simply pretend that the PM timeout expired early when userspace invokes
> that API.

That'd be overly complicated IMHO.  Calling pm_runtime_idle() should suffice.

> > 
> > > and use it when userspace detects that lid is closed.
> > 
> > I guess we get an event then, don't we?
> 
> Right, userspace gets EV_SW/SW_LID input event and needs to react. In
> this particular case the desire is to power down touchpad (since it is
> unaccessible). I am not sure why system suspend (which I expect happen
> in reaction to lid closing) is not enough, but that's question for
> Dudley.

OK

Rafael
