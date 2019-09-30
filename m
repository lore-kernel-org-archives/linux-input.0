From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: hyperv-keyboard: Add the support of hibernation
Date: Mon, 30 Sep 2019 16:06:52 -0700
Message-ID: <20190930230652.GW237523@dtor-ws>
References: <1568244975-66795-1-git-send-email-decui@microsoft.com>
 <20190919161752.GS237523@dtor-ws>
 <PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190928003156.GU237523@dtor-ws>
 <PU1P153MB0169C315F7F9EBEBED4C7A7DBF820@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169C315F7F9EBEBED4C7A7DBF820@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Dexuan Cui <decui@microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 30, 2019 at 10:09:27PM +0000, Dexuan Cui wrote:
> > From: dmitry.torokhov@gmail.com <dmitry.torokhov@gmail.com>
> > Sent: Friday, September 27, 2019 5:32 PM
> > > ...
> > > pm_wakeup_pending() is tested in a lot of places in the suspend
> > > process and eventually an unintentional keystroke (or mouse movement,
> > > when it comes to the Hyper-V mouse driver drivers/hid/hid-hyperv.c)
> > > causes the whole hibernation process to be aborted. Usually this
> > > behavior is not expected by the user, I think.
> > 
> > Why not? If a device is configured as wakeup source, then it activity
> > should wake up the system, unless you disable it.
> 
> Generally speaking, I agree, but compared to a physical machine, IMO 
> the scenario is a little differnet when it comes to a VM running on Hyper-V:
> on the host there is a window that represents the VM, and the user can
> unintentionally switch the keyboard input focus to the window (or move
> the mouse/cursor over the window) and then the host automatically 
> sends some special keystrokes (and mouse events) , and this aborts the
> hibernation process.  
> 
> And, when it comes to the Hyper-V mouse device, IMO it's easy for the
> user to unintentionally move the mouse after the "hibernation" button
> is clicked. I suppose a physical machine would have the same issue, though.

If waking the machine up by mouse/keyboard activity is not desired in
Hyper-V environment, then simply disable them as wakeup sources.

> 
> > > So, I use the notifier to set the flag variable and with it the driver can
> > > know when it should not call pm_wakeup_hard_event().
> > 
> > No, please implement hibernation support properly, as notifier + flag is
> > a hack. 
> 
> The keyboard/mouse driver can avoid the flag by disabling the 
> keyboard/mouse event handling, but the problem is that they don't know
> when exactly they should disable the event handling. I think the PM
> notifier is the only way to tell the drivers a hibernation process is ongoing.

Whatever initiates hibernation (in userspace) can adjust wakeup sources
as needed if you want them disabled completely.

> 
> Do you think this idea (notifer + disabling event handling) is acceptable?

No, I believe this a hack, that is why I am pushing back on this.

> 
> If not, then I'll have to remove the notifer completely, and document this as
> a known issue to the user: when a hibernation process is started, be careful
> to not switch input focus and not touch the keyboard/mouse until the
> hibernation process is finished. :-)
> 
> > In this particular case you do not want to have your
> > hv_kbd_resume() to be called in place of pm_ops->thaw() as that is what
> > reenables the keyboard vmbus channel and causes the undesired wakeup
> > events. 
> 
> This is only part of the issues. Another example: before the
> pm_ops()->freeze()'s of all the devices are called, pm_wakeup_pending()
> is already tested in a lot of places (e.g. in try_to_freeze_tasks ()) in the 
> suspend process, and can abort the whole suspend process upon the user's
> unintentional input focus switch, keystroke and mouse movement.

How long is the prepare() phase on your systems? User may wiggle mouse
at any time really, even before the notifier fires up.

> 
> > Your vmbus implementation should allow individual drivers to
> > control the set of PM operations that they wish to use, instead of
> > forcing everything through suspend/resume.
> > 
> > Dmitry
> 
> Since the devices are pure software-emulated devices, no PM operation was
> supported in the past, and now suspend/resume are the only two PM operations
> we're going to support. If the idea (notifer + disabling event handling) is not
> good enough, we'll have to document the issue to the user, as I described above.

¯\_(ツ)_/¯ If you do not want to implement hibernation properly in vmbus
code that is totally up to you (have you read in pm.h how freeze() is
different from suspend()?).

Thanks.

-- 
Dmitry
