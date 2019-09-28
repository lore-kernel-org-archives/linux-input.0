From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: hyperv-keyboard: Add the support of hibernation
Date: Fri, 27 Sep 2019 17:31:56 -0700
Message-ID: <20190928003156.GU237523@dtor-ws>
References: <1568244975-66795-1-git-send-email-decui@microsoft.com>
 <20190919161752.GS237523@dtor-ws>
 <PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Dexuan Cui <decui@microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>
List-Id: linux-input@vger.kernel.org

On Sat, Sep 21, 2019 at 06:56:04AM +0000, Dexuan Cui wrote:
> > From: dmitry.torokhov@gmail.com <dmitry.torokhov@gmail.com>
> > Sent: Thursday, September 19, 2019 9:18 AM
> > 
> > Hi Dexuan,
> > 
> > On Wed, Sep 11, 2019 at 11:36:20PM +0000, Dexuan Cui wrote:
> > > We need hv_kbd_pm_notify() to make sure the pm_wakeup_hard_event()
> > call
> > > does not prevent the system from entering hibernation: the hibernation
> > > is a relatively long process, which can be aborted by the call
> > > pm_wakeup_hard_event(), which is invoked upon keyboard events.
> > >
> > > diff --git a/drivers/input/serio/hyperv-keyboard.c
> > b/drivers/input/serio/hyperv-keyboard.c
> > > index 88ae7c2..277dc4c 100644
> > > --- a/drivers/input/serio/hyperv-keyboard.c
> > > +++ b/drivers/input/serio/hyperv-keyboard.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/hyperv.h>
> > >  #include <linux/serio.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/suspend.h>
> > >
> > >  /*
> > >   * Current version 1.0
> > > @@ -95,6 +96,9 @@ struct hv_kbd_dev {
> > >  	struct completion wait_event;
> > >  	spinlock_t lock; /* protects 'started' field */
> > >  	bool started;
> > > +
> > > +	struct notifier_block pm_nb;
> > > +	bool hibernation_in_progress;
> > 
> > Why do you use notifier block instead of exposing proper PM methods if
> > you want to support hibernation?
> > 
> > Dmitry
> 
> Hi,
> In the patch I do implement hv_kbd_suspend() and hv_kbd_resume(), and
> add them into the hv_kbd_drv struct:
> 
> @@ -416,6 +472,8 @@ static struct  hv_driver hv_kbd_drv = {
>         .id_table = id_table,
>         .probe = hv_kbd_probe,
>         .remove = hv_kbd_remove,
> +       .suspend = hv_kbd_suspend,
> +       .resume = hv_kbd_resume,
> 
> The .suspend and .resume callbacks are inroduced by another patch (which
> uses the dev_pm_ops struct):
> 271b2224d42f ("Drivers: hv: vmbus: Implement suspend/resume for VSC drivers for hibernation")
> (which is on the Hyper-V tree's hyperv-next branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?h=hyperv-next&id=271b2224d42f88870e6b060924ee374871c131fc )
> 
> The only purpose of the notifier is to set the variable 
> kbd_dev->hibernation_in_progress to true during the hibernation process.
> 
> As I explained in the changelog, the hibernation is a long process (which
> can take 10+ seconds), during which the user may unintentionally touch
> the keyboard, causing key up/down events, which are still handled by
> hv_kbd_on_receive(), which calls pm_wakeup_hard_event(), which
> calls some other functions which increase the global counter
> "pm_abort_suspend", and hence pm_wakeup_pending() becomes true.
> 
> pm_wakeup_pending() is tested in a lot of places in the suspend
> process and eventually an unintentional keystroke (or mouse movement,
> when it comes to the Hyper-V mouse driver drivers/hid/hid-hyperv.c)
> causes the whole hibernation process to be aborted. Usually this
> behavior is not expected by the user, I think.

Why not? If a device is configured as wakeup source, then it activity
should wake up the system, unless you disable it.

> 
> So, I use the notifier to set the flag variable and with it the driver can
> know when it should not call pm_wakeup_hard_event().

No, please implement hibernation support properly, as notifier + flag is
a hack. In this particular case you do not want to have your
hv_kbd_resume() to be called in place of pm_ops->thaw() as that is what
reenables the keyboard vmbus channel and causes the undesired wakeup
events. Your vmbus implementation should allow individual drivers to
control the set of PM operations that they wish to use, instead of
forcing everything through suspend/resume.

Thanks.

-- 
Dmitry
