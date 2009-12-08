From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to
	specify exact irq flags
Date: Tue, 8 Dec 2009 09:42:18 -0800
Message-ID: <20091208174218.GB14271@core.coreip.homeip.net>
References: <Pine.LNX.4.44L0.0911300956400.4478-100000@iolanthe.rowland.org> <87einfltp3.fsf@tac.ki.iif.hu> <20091206084704.GC2766@ucw.cz> <20091208042251.GB11147@core.coreip.homeip.net> <1260277410.19669.84.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:41416 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965545AbZLHRmT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Dec 2009 12:42:19 -0500
Received: by pwj9 with SMTP id 9so1753012pwj.21
        for <linux-input@vger.kernel.org>; Tue, 08 Dec 2009 09:42:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1260277410.19669.84.camel@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Ferenc Wagner <wferi@niif.hu>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Dec 08, 2009 at 03:03:30PM +0200, Artem Bityutskiy wrote:
> On Mon, 2009-12-07 at 20:22 -0800, Dmitry Torokhov wrote:
> > On Sun, Dec 06, 2009 at 09:47:04AM +0100, Pavel Machek wrote:
> > > Hi!
> > > 
> > > 
> > > > But runtime-pm.txt says for example:
> > > > 
> > > >     Generally, remote wake-up should be enabled for all input devices
> > > >     put into a low power state at run time.
> > > > 
> > > > But in this case the requirement is to suppress input events from a
> > > > given device, effectively muting and putting it into low power state,
> > > > even though it's still open by some other parties.  Runtime PM, on the
> > > > other hand tries not to interfere with the normal usage of the device.
> > > > 
> > > > Later:
> > > > 
> > > > (3) ->runtime_idle() and ->runtime_suspend() can only be executed for a
> > > >     device the usage counter of which is equal to zero _and_ [...]
> > > > 
> > > > which underlines the difference again: the usage counter (defined by
> > > > common sense) won't be zero in our case, because the device is
> > > > constantly kept open, while we want to mute it, putting it into a low
> > > > power state. 
> > > ...
> > > > Actually, this could be implemented by the various users cooperating in
> > > > closing the device, letting it go to sleep automatically.  But this
> > > > requires strictly cooperating parties and is more complicated that
> > > > flipping some master switch of the device.  We're looking for this
> > > > master switch, before needlessly building our own.
> > > 
> > > Please just close the device properly. I do not think we want 100
> > > different 'please mute keys A and G', 'please mute middle mouse button',
> > > ... interfaces anywhere near mainline.
> > > 
> > 
> > I do not think it is practical to simply close the device, given that
> > there may be several applications that have it open. I constantly see
> > embedded guys adding custom knobs to the devices allowing them to shut
> > off the device when not in use. Kind of runtame PM but user-initiated.
> > 
> > I would really love to have it implemented in the driver core so the
> > interface is the same for all drivers (that support this future).
> > 
> > > Or just do it as local patch.
> > 
> > I also see that gpio-keys is quite different in the sence that it can
> > shut off buttons selectively. I fact, at the moment every button can be
> > considered a separate device... But that would be too much overhead.
> > 
> > They could probably split the keys into 2 groups (critical that should
> > be always active) and not critical, that could be shut off, but I think
> > they want teh flexibility of controlling this at runtime instead of
> > doing it in board data.
> 
> I suggested including this into the "abstract input device" model, but
> you refuse this. But I still think it is a good idea.
> 
> Indeed, if we look at an input device as at something abstract which has
> many keys, why we cannot assume that separate keys can be
> enabled/disabled? Just imagine you have a very advanced keybord :-) And
> we simply implement an ioctl which enables/disables a specific key. The
> generic layers just pass this ioctl down to the lower lever drivers. If
> the specific input device or driver support it - fine, if not - it
> returns -EINVAL or something like that.

I refuse it because it will be supported by exactly 1 driver in the
kernel - gpio-keys. It is the only driver that allows shut half of the
"device" (because in reality it is a group of disjoint devices). It is
the only case when "muting" a button means that IRQ is shut off abnd
thus CPU can continue to sleep if that button is pressed. For all other
devices that have 1 inettrupt per device, you still have to wake up,
because you don't know whether the button that generated event is
"important" or not.

Now, there is a issue of waking up userspace task, additional scheduling
and keeping CPU running longer than necessary for "uninteresting" keys.
This can be solved by implementing a subscription model which allows
filtering uninteresing events on a per-client basis at evdev level.
This, if implemented properly, would work for _all_ input devices out
there. You were not interested into looking into it (because for your
particular and only device the otehr approach promises bigger savings)
but I think we'll get there eventually.

And the third topic - shutting (or putting into low power) entire device
upon request from userspace. This again has much wider auditory than
gpio-keys, or input devices layer for that matter. We may want to do so
for other types of devices as well. That is why the question when to
general PM list.

-- 
Dmitry
