From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] Input: hyperv-keyboard: Add the support of hibernation
Date: Wed, 25 Sep 2019 19:49:40 +0000
Message-ID: <PU1P153MB01698478F34A45271B11D1CCBF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568244975-66795-1-git-send-email-decui@microsoft.com>
 <20190919161752.GS237523@dtor-ws>
 <PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dexuan Cui <decui@microsoft.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>
List-Id: linux-input@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Dexuan Cui
> Sent: Friday, September 20, 2019 11:56 PM
> To: dmitry.torokhov@gmail.com
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; sashal@kernel.org;
> linux-hyperv@vger.kernel.org; linux-input@vger.kernel.org;
> linux-kernel@vger.kernel.org; Michael Kelley <mikelley@microsoft.com>
> Subject: RE: [PATCH] Input: hyperv-keyboard: Add the support of hibernati=
on
>=20
> > From: dmitry.torokhov@gmail.com <dmitry.torokhov@gmail.com>
> > Sent: Thursday, September 19, 2019 9:18 AM
> >
> > Hi Dexuan,
> >
> > On Wed, Sep 11, 2019 at 11:36:20PM +0000, Dexuan Cui wrote:
> > > We need hv_kbd_pm_notify() to make sure the pm_wakeup_hard_event()
> > call
> > > does not prevent the system from entering hibernation: the hibernatio=
n
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
>=20
> Hi,
> In the patch I do implement hv_kbd_suspend() and hv_kbd_resume(), and
> add them into the hv_kbd_drv struct:
>=20
> @@ -416,6 +472,8 @@ static struct  hv_driver hv_kbd_drv =3D {
>         .id_table =3D id_table,
>         .probe =3D hv_kbd_probe,
>         .remove =3D hv_kbd_remove,
> +       .suspend =3D hv_kbd_suspend,
> +       .resume =3D hv_kbd_resume,
>=20
> The .suspend and .resume callbacks are inroduced by another patch (which
> uses the dev_pm_ops struct):
> 271b2224d42f ("Drivers: hv: vmbus: Implement suspend/resume for VSC
> drivers for hibernation")
> (which is on the Hyper-V tree's hyperv-next branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?=
h=3Dhyperv-next&id=3D271b2224d42f88870e6b060924ee374871c131fc
> )
>=20
> The only purpose of the notifier is to set the variable
> kbd_dev->hibernation_in_progress to true during the hibernation process.
>=20
> As I explained in the changelog, the hibernation is a long process (which
> can take 10+ seconds), during which the user may unintentionally touch
> the keyboard, causing key up/down events, which are still handled by
> hv_kbd_on_receive(), which calls pm_wakeup_hard_event(), which
> calls some other functions which increase the global counter
> "pm_abort_suspend", and hence pm_wakeup_pending() becomes true.
>=20
> pm_wakeup_pending() is tested in a lot of places in the suspend
> process and eventually an unintentional keystroke (or mouse movement,
> when it comes to the Hyper-V mouse driver drivers/hid/hid-hyperv.c)
> causes the whole hibernation process to be aborted. Usually this
> behavior is not expected by the user, I think.
>=20
> So, I use the notifier to set the flag variable and with it the driver ca=
n
> know when it should not call pm_wakeup_hard_event().
>=20
> -- Dexuan

Hi Dmitry,
Does my answer make sense? If yes, can I have an Acked-by from you?

Thanks,
-- Dexuan
