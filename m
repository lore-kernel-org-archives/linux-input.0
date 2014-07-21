From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND 4/5] Input: uinput - add new UINPUT_DEV_SETUP ioctl
Date: Mon, 21 Jul 2014 13:11:55 -0700
Message-ID: <20140721201155.GA10889@core.coreip.homeip.net>
References: <1405775445-4454-1-git-send-email-dh.herrmann@gmail.com>
 <1405775445-4454-5-git-send-email-dh.herrmann@gmail.com>
 <20140721010110.GD22552@core.coreip.homeip.net>
 <CANq1E4S0=h=PccuHVAFPMgdMvGWyBLitpaeJAkZ--PmuTT0xxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:63726 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbaGUUMA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jul 2014 16:12:00 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so10509605pad.38
        for <linux-input@vger.kernel.org>; Mon, 21 Jul 2014 13:11:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANq1E4S0=h=PccuHVAFPMgdMvGWyBLitpaeJAkZ--PmuTT0xxg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>

On Mon, Jul 21, 2014 at 08:22:09AM +0200, David Herrmann wrote:
> Hi
> 
> On Mon, Jul 21, 2014 at 3:01 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi David,
> >
> > On Sat, Jul 19, 2014 at 03:10:44PM +0200, David Herrmann wrote:
> >> This adds a new ioctl UINPUT_DEV_SETUP that replaces the old device setup
> >> method (by write()'ing "struct uinput_user_dev" to the node). The old
> >> method is not easily extendable and requires huge payloads. Furthermore,
> >> overloading write() without properly versioned objects is error-prone.
> >>
> >> Therefore, we introduce a new ioctl to replace the old method. The ioctl
> >> supports all features of the old method, plus a "resolution" field for
> >> absinfo. Furthermore, it's properly forward-compatible to new ABS codes
> >> and a growing "struct input_absinfo" structure.
> >>
> >> The ioctl also allows user-space to skip unknown axes if not set. The
> >> payload-size can now be specified by the caller. There is no need to copy
> >> the whole array temporarily into the kernel, but instead we can iterate
> >> over it and copy each value manually.
> >>
> >> Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
> >> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> >> ---
> >>  drivers/input/misc/uinput.c | 69 +++++++++++++++++++++++++++++++++++++++++++--
> >>  include/uapi/linux/uinput.h | 55 ++++++++++++++++++++++++++++++++++--
> >>  2 files changed, 118 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> >> index a2a3895..0f45595 100644
> >> --- a/drivers/input/misc/uinput.c
> >> +++ b/drivers/input/misc/uinput.c
> >> @@ -371,8 +371,67 @@ static int uinput_allocate_device(struct uinput_device *udev)
> >>       return 0;
> >>  }
> >>
> >> -static int uinput_setup_device(struct uinput_device *udev,
> >> -                            const char __user *buffer, size_t count)
> >> +static int uinput_dev_setup(struct uinput_device *udev,
> >> +                         struct uinput_setup __user *arg)
> >> +{
> >> +     struct uinput_setup setup;
> >> +     struct input_dev *dev;
> >> +     int i, retval;
> >> +
> >> +     if (udev->state == UIST_CREATED)
> >> +             return -EINVAL;
> >> +     if (copy_from_user(&setup, arg, sizeof(setup)))
> >> +             return -EFAULT;
> >> +     if (!setup.name[0])
> >> +             return -EINVAL;
> >> +     /* So far we only support the original "struct input_absinfo", but be
> >> +      * forward compatible and allow larger payloads. */
> >> +     if (setup.absinfo_size < sizeof(struct input_absinfo))
> >> +             return -EINVAL;
> >
> > No, we can not do this, as it breaks backward compatibility (the most
> > important one!). If we were to increase size of in-kernel input_absinfo
> > in let's say 3.20, userspace compiled against older kernel headers
> > (but using the new ioctl available let's say since 3.16 - don't hold me
> > to the numbers ;) ), would break since it wold start tripping on thi
> > check.
> >
> > The proper way to handle it is to convert "old" absinfo into new one,
> > applying as much as we can.
> 
> I know, but there is no "old absinfo". Once we extend "struct absinfo"
> I expect this code to change to:
> 
> {
>         /* initially supported absinfo had size 24 */
>         if (setup.absinfo_size < 24)
>                return -EINVAL;
> 
>         /* ...pseudo code... */
>         memset(&absinfo, 0, sizeof(absinfo));
>         memcpy(&absinfo, sth->absinfo, MIN(setup.absinfo_size,
> sizeof(absinfo)));
> }
> 
> This allows you to use this ioctl with old absinfo objects. I can
> change the current code to this already, if you want? I tried to avoid
> it, because a memset() is not neccessarily an appropriate way to
> initialize unset fields.
> I cal also add support for "absinfo" without the "resolution" field,
> which I think is the only field that wasn't available in the initial
> structure.

I think for now I would do:

	/*
	 * Whoever is changing struct input_absinfo will have to take
	 * care of backwards compatibility.
	 */
	BUILD_BUG_ON(sizeof(struct input_absinfo)) != 24);
	if (setup.absinfo_size != sizeof(struct input_absinfo))
		return -EINVAL;

	...

and later when we detect setup.absinfo_size < sizeof(struct
input_absinfo) we'll have to take care about backwards compatibility. We
do not need to take care of forward compatibility as we do not know if
userspace will be satisfied with partial results or not and newer
userspace can deal with proper handling of older kernels.

By the way, I realize I do not like the new IOCTL as it is - it's too
big and would be hard to extend if we want to change items other than
absinfo. Why don't we create UI_DEV_SETUP that only sets name, id, and
number of effects, and add UI_SET_ABSAXIS that would take:

	struct uinput_abs_setup {
		__u16	code;	/* axis code */
		/* __u16 filler; */
		struct input_absinfo absinfo;
	}

By the way, while you are hacking on uinput can we also fix formatting
style of switch/case and switch printk() to pr_debug() and friends? I'd
do it myself but do not want to step on your toes.

Thanks!

-- 
Dmitry
