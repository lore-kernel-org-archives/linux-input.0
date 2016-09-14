From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] HID: input: ignore System Control application usages
 if not System Controls
Date: Wed, 14 Sep 2016 17:44:20 +0200
Message-ID: <20160914154420.GM25951@mail.corp.redhat.com>
References: <1473760358-31999-1-git-send-email-benjamin.tissoires@redhat.com>
 <1473760358-31999-2-git-send-email-benjamin.tissoires@redhat.com>
 <CAAZ5spCtj6O+d6t7G2x7-m6rj4fSNQsak_QGeuqf4Bf2bqW7Cg@mail.gmail.com>
 <20160913135759.GG25951@mail.corp.redhat.com>
 <CAAZ5spC9VX7QuMjfZUb-F_-i+ktz3HUpyP-3Ess2APTmyNQ5Dw@mail.gmail.com>
 <CAAZ5spBHTytyXg6cGhHEBsZM=FWuL_v-BzUQ+J4pHp=OYtdcAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760246AbcINPo7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2016 11:44:59 -0400
Content-Disposition: inline
In-Reply-To: <CAAZ5spBHTytyXg6cGhHEBsZM=FWuL_v-BzUQ+J4pHp=OYtdcAg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michel Hermier <michel.hermier@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Jason Gerecke <killertofu@gmail.com>

On Sep 13 2016 or thereabouts, Michel Hermier wrote:
> Le 13 sept. 2016 15:58, "Benjamin Tissoires" <benjamin.tissoires@redhat.com>
> a écrit :
> >
> > On Sep 13 2016 or thereabouts, Michel Hermier wrote:
> > > Hi,
> > >
> > > Le 13 sept. 2016 11:54 AM, "Benjamin Tissoires" <
> > > benjamin.tissoires@redhat.com> a écrit :
> > > >
> > > > Microsoft is reusing its report descriptor again and again, and part
> of it
> > > > looks like this:
> > > >
> > > > 0x05, 0x01,                    // Usage Page (Generic Desktop)
> 299
> > > > 0x09, 0x80,                    // Usage (System Control)
> 301
> > > > 0xa1, 0x01,                    // Collection (Application)
> 303
> > > > 0x85, 0x03,                    //  Report ID (3)
> 305
> > > > 0x19, 0x00,                    //  Usage Minimum (0)
> 307
> > > > 0x29, 0xff,                    //  Usage Maximum (255)
> 309
> > > > 0x15, 0x00,                    //  Logical Minimum (0)
> 311
> > > > 0x26, 0xff, 0x00,              //  Logical Maximum (255)
> 313
> > > > 0x81, 0x00,                    //  Input (Data,Arr,Abs)
>  316
> > > > 0xc0,                          // End Collection
> 318
> > > >
> > > > While there is nothing wrong in term of processing, we do however
> blindly
> > > > map the full usage range (it's an array) from 0x00 to 0xff, which
> creates
> > > > some interesting axis, like ABS_X|Y, and a bunch of ABS_MISC + n.
> > > >
> > > > While libinput and other stacks don't care that much (we can detect
> them),
> > > > joydev is very happy and attaches itself to the mouse or keyboard.
> > > >
> > > > The problem is that joydev now handles the device as a joystick, but
> given
> > > > that we have a HID array, it sets all the ABS_* values to 0. And in
> its
> > > > world, 0 means -32767 (minimum value), which sends spurious events to
> > > games
> > > > (think Steam).
> > > >
> > > > It looks like hid-microsoft tries to tackle the very same problem
> with its
> > > > .report_fixup callback. But fixing the report descriptor is an endless
> > > task
> > > > and is quite obfuscated.
> > >
> > > Do you plan to remove those various fixup in a later patch series, or do
> > > you have other plans?
> >
> > Well, I don't have the affected hardware on hid-microsoft, so I was
> planing
> > on just leaving the code as it is.
> >
> > If you have some and can test/verify, then do not hesitate to remove
> > those quirks.
> 
> I'm the original author of the 2011 bug, and I still own one of the
> Microsoft keyboard with the issue. But not one that has a fix, but one that
> have the exact same broken report descriptor. When I'll get some time to
> test the patch, on success I think it would be safe to remove one of the 2
> fixup available, since they seems to have reused the exact same descriptor
> for the whole family.

TBH, I think it should be safe to remove the whole report_fixup in
hid-microsoft. If there is enough push, I'll do it.

> 
> > >
> > > >
> > > > So take the hammer, and decide that if the application is meant to be
> > > > System Control, any other usage not in the System Control range should
> > > > be ignored.
> > >
> > > To be on a safe side, shouldn't there be a flag to bypass that change in
> > > case it makes some situations worse? (Thought I agree we should be
> pretty
> > > safe here)
> >
> > Well, we are safe unless Hardware makers start doing weird things. But
> > hardware makers always like doing weird things.
> >
> > I think I am more willing to try fixing this one out, and if somebody
> > else starts complaining about, then we can always add more guards (one
> > could be to check if the wrong usage min/max are 0-255). We could also
> > simply add "if vendor == MICROSOFT" or something in that spirit.
> >
> > Right now I'd better try this just in case this wrong report descriptor
> > is used in different hardware.
> >
> > Regarding the flag solution, if you are thinking at a kernel module
> > parameter,  I'd better not to. The reason being that once the word is
> > spread that you can "fix" your device by adding a simple module
> > parameter, people tend to forget to report bugs. I have seen countless
> > of forums/threads saying that you have to disable i2c-hid to have your
> > touchpad working, even when this is just not required.
> >
> > Well, if Jiri is willing to add more checks and flags, we can always,
> > but I'd rather not.
> >
> > Last, I'll request those patches to be included in Fedora when Jiri
> > takes them (or a future revision). We should have enough angry users
> > once it hits Fedora if there are some :)
> 
> Nice, what is the window, so I can plan testing the patch and report if you
> can remove one of the quirk? Unfortunately this is the period where I get
> really busy at work, this is why I ask.

There is already a scratch kernel available in the Red Hat bug:
https://bugzilla.redhat.com/show_bug.cgi?id=1325354#c8

If the device is supported already by hid-microsoft, starting the kernel
with hid.ignore_special_drivers=1 should force hid-generic to handle the
keyboard.

I can't really give an estimate on when this will land Fedora stable
though. It depends on when Jiri picks up the patch, when I remember to
ask for the inclusion in Fedora, then the maintainers have to take the
patch and build a new build. Everything is quite quick, but there are
some uncertainties that prevent me to give you a good estimate.

> 
> Also maybe, attach the patch to my bug so it tries to get a little bit
> more  spread/visibility.

k, will do.

Cheers,
Benjamin

> 
> Cheers,
>    Michel
> 
> >
> > Cheers,
> > Benjamin
> >
> > >
> > > Cheers,
> > >    Michek
> > >
> > > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=1325354
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=28912
> > > > Link: https://github.com/ValveSoftware/steam-for-linux/issues/3384
> > > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=1325354
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=37982
> > > >
> > > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > > ---
> > > >  drivers/hid/hid-input.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > > > index 14dd974..55db584 100644
> > > > --- a/drivers/hid/hid-input.c
> > > > +++ b/drivers/hid/hid-input.c
> > > > @@ -604,6 +604,15 @@ static void hidinput_configure_usage(struct
> > > hid_input *hidinput, struct hid_fiel
> > > >                         break;
> > > >                 }
> > > >
> > > > +               /*
> > > > +                * Some lazy vendors declare 255 usages for System
> > > Control,
> > > > +                * leading to the creation of ABS_X|Y axis and too
> many
> > > others.
> > > > +                * It wouldn't be a problem if joydev doesn't
> consider the
> > > > +                * device as a joystick then.
> > > > +                */
> > > > +               if (field->application == HID_GD_SYSTEM_CONTROL)
> > > > +                       goto ignore;
> > > > +
> > > >                 if ((usage->hid & 0xf0) == 0x90) {      /* D-pad */
> > > >                         switch (usage->hid) {
> > > >                         case HID_GD_UP:    usage->hat_dir = 1; break;
> > > > --
> > > > 2.7.4
> > > >
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe
> linux-input" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
