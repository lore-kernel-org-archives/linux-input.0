From: Terry Lambert <tlambert@chromium.org>
Subject: Re: [PATCH] Input: fixed EVIOCGRAB iterative grab/release.
Date: Thu, 10 Feb 2011 16:41:52 -0800
Message-ID: <AANLkTinjPG-KY-ee3ya7bca8F5QechRhE88+uO6odgjE@mail.gmail.com>
References: <1297381370-16388-1-git-send-email-tlambert@chromium.org>
	<20110210235447.GA12313@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110210235447.GA12313@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Sure.  First patch to linux in 16 years and all, I didn't want to be
too noisy...

Problem:

If you use EVIOCGRAB, such as when you are using a Cr-48 with the
Synaptics trackpad driver, the grab on the input device has to be
dropped before you zero out the grab on the evdev, or you can't grab
it again without rebooting.  The X Server does this; it's usually not
an issue for Chromium OS because it tends to just reboot, but everyone
else gets a locked up pointer.

I found this when copying the evdev_grab/input_device_grab() &
input_release_device()/evdev_ungrab() design pattern into some new
code to use for automated testing (record & playback of arbitrary
event streams) and for training software for gesture recognition.
When doing this sort of thing, you tend to repeat operations to obtain
large training sets, or string together a series of test gestures with
scripts, and the problem became obvious.

This is pretty easy to reproduce with a modified evtest program that
does an EVIOCGRAB, if you don't have a Synaptics touchpad to use for
testing (but you won't get whatever you grab back unless you use the
same fd or reboot).

I have some patches to a number of bugs in the Synaptics driver, and
some additional code cleanup vs. checkpatch.pl for
drivers/input/evdev.c too, but I thought I'd start small.

-- Terry

On Thu, Feb 10, 2011 at 3:54 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Thu, Feb 10, 2011 at 03:42:50PM -0800, tlambert@chromium.org wrote=
:
> > From: Terry Lambert <tlambert@chromium.org>
> >
> > Fixed order of calls in evdev_ungrab to allow iterative use of
> > code which grabs and releases input event devices.
> >
>
> Sorry, could you =A0please be more verbose?
>
> > Signed-off-by: Terry Lambert <tlambert@chromium.org>
> > ---
> > =A0drivers/input/evdev.c | =A0 =A02 +-
> > =A01 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> > index c8471a2..0bac8da 100644
> > --- a/drivers/input/evdev.c
> > +++ b/drivers/input/evdev.c
> > @@ -160,9 +160,9 @@ static int evdev_ungrab(struct evdev *evdev, st=
ruct evdev_client *client)
> > =A0 =A0 =A0 if (evdev->grab !=3D client)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =A0-EINVAL;
> >
> > + =A0 =A0 input_release_device(&evdev->handle);
> > =A0 =A0 =A0 rcu_assign_pointer(evdev->grab, NULL);
> > =A0 =A0 =A0 synchronize_rcu();
> > - =A0 =A0 input_release_device(&evdev->handle);
> >
> > =A0 =A0 =A0 return 0;
> > =A0}
> > --
> > 1.7.3.1
> >
>
> --
> Dmitry
