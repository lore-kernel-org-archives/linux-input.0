From: Benjamin Tissoires <btissoir@redhat.com>
Subject: Re: hid-multitouch stuck taps, possibly 4.5 regression?
Date: Mon, 27 Jun 2016 09:47:12 +0200
Message-ID: <20160627074712.GR24234@mail.corp.redhat.com>
References: <20160316084716.GR22340@mail.corp.redhat.com>
 <CALCETrWRi8nM6h234ppeQZ3VaAqL4d37VmZvt6HSYwDYddO3Kw@mail.gmail.com>
 <20160317080612.GN1793@lahna.fi.intel.com>
 <CALCETrWzDhwMP6Ld4U_OO0Q+Bpb=tmb01iC2xRTpjfY6=p_8cg@mail.gmail.com>
 <CAE7eX3+WOOO=6KVpFaqVDeEegRjz5Atofj8r-bEGfn6KshyDEQ@mail.gmail.com>
 <CALCETrWsxoL83fNRFrv5ga1mNc=Uh+263T+qXajHNt+9YkYfAA@mail.gmail.com>
 <CAE7eX3K8XKc2aFbL61btco0aRSUi-+ZUsgsMZ4YKPi7b-Qc=MA@mail.gmail.com>
 <CALCETrVfp0LcLxbgHAnkyi8o+rzxOmTFZkE5E-5sU2wU8hSi3A@mail.gmail.com>
 <CALCETrU_PBH81oUHomwZhOLJ3CFOBa5hotavsOxymV=Qd6mT-A@mail.gmail.com>
 <CALCETrU__KCTyfJxbMwEdVx0dUjmqBxTDoVakpkfh01M9VX27w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56930 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385AbcF0HrS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2016 03:47:18 -0400
Content-Disposition: inline
In-Reply-To: <CALCETrU__KCTyfJxbMwEdVx0dUjmqBxTDoVakpkfh01M9VX27w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andrew Duggan <andrew.duggan@gmail.com>, Mario Limonciello <mario_limonciello@dell.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Pratyush Anand <pratyush.anand@gmail.com>

On Jun 26 2016 or thereabouts, Andy Lutomirski wrote:
> On Sun, Jun 26, 2016 at 4:37 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> > On Fri, Apr 22, 2016 at 9:37 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> >> Adding Mario.
> >>
> >> On Fri, Mar 18, 2016 at 11:53 AM, Andrew Duggan <andrew.duggan@gmail.com> wrote:
> >>> On Fri, Mar 18, 2016 at 10:42 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> >>>> On Thu, Mar 17, 2016 at 1:24 PM, Andrew Duggan <andrew.duggan@gmail.com> wrote:
> >>>>> On Thu, Mar 17, 2016 at 11:43 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> >>>>>> On Thu, Mar 17, 2016 at 1:06 AM, Mika Westerberg
> >>>>>> <mika.westerberg@linux.intel.com> wrote:
> >>>>>>> On Wed, Mar 16, 2016 at 02:59:48PM -0700, Andy Lutomirski wrote:
> >>>>>>>> [add i2c-designware maintainers]
> >>>>>>>>
> >>>>>>>> On Wed, Mar 16, 2016 at 1:47 AM, Benjamin Tissoires <btissoir@redhat.com> wrote:
> >>>>>>>> > Hi Andy,
> >>>>>>>> >
> >>>>>>>> > On Mar 15 2016 or thereabouts, Andy Lutomirski wrote:
> >>>>>>>> >> Hi-
> >>>>>>>> >>
> >>>>>>>> >> In 4.5 and several 4.5 rcs, I see occasional stuck taps (I think) on
> >>>>>>>> >> my XPS 13 9350's touchpad.  The effect is that trying to left-click
> >>>>>>>> >> ends up middle-clicking.  I think it's a kernel issue and not a
> >>>>>>>> >> hardware or libinput issue, but I'm not 100% sure.  I don't think I
> >>>>>>>> >> had this issue in 4.4.
> >>>>>>>> >>
> >>>>>>>> >> I've attached what I think is an evtest issue of my fixing the issue
> >>>>>>>> >> by pressing three fingers down in sequence and then releasing them.
> >>>>>>>> >> After doing that, left-clicks worked.
> >>>>>>>> >
> >>>>>>>> > I think I already have been reported the issue here:
> >>>>>>>> > https://bugs.freedesktop.org/show_bug.cgi?id=93948
> >>>>>>>> >
> >>>>>>>> > The result was that it was more likely an I2C transport bug than a
> >>>>>>>> > hid-multitouch one (see comment #8 in the fdo bug).
> >>>>>>>> >
> >>>>>>>> > You can try to run hid-recorder when you see the problems, and then
> >>>>>>>> > parse the output (or just send it to me). There is huge chances that
> >>>>>>>> > there will be no events from I2C sending the release.
> >>>>>>>> >
> >>>>>>>> > And again, I am not sure how we could end up debugging this in the
> >>>>>>>> > i2c-designware driver :(
> >>>>>>>> >
> >>>>>>>>
> >>>>>>>> Does this ring a bell?
> >>>>>>>
> >>>>>>> i2c-designware usually prints errors to dmesg if it fails to transfer
> >>>>>>> messages. Can you include dmesg of the failure as well?
> >>>>>>
> >>>>>> Nothing shows up at all.  All I have is:
> >>>>>>
> >>>>>> input: DLL0704:01 06CB:76AE Touchpad as
> >>>>>> /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-7/i2c-DLL0704:01/0018:06CB:76AE.0001/input/input12
> >>>>>
> >>>>> What is the fw id? I have a 9343 with the same touchpad and have not
> >>>>> noticed an issue. This is the dmesg output for my touchpad.
> >>>>>
> >>>>> [    5.216319] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1,
> >>>>> id: 0x1e2b1, caps: 0xd00123/0x840300/0x12e800/0x0, board id: 3038, fw
> >>>>> id: 1832324
> >>>>
> >>>> Mine is shinier and newer, apparently.
> >>>>
> >>>> psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2a1,
> >>>> caps: 0xf00223/0x840300/0x12e800/0x0, board id: 3038, fw id: 2011643
> >>>
> >>> It looks like you actually have a slightly newer revision of the
> >>> module (76AE vs my 76AD). So I can't quite do a direct comparison.
> >>> However, the 9350 system listed in the bug does have my exact module.
> >>> Which is why we think it might be a problem with the embedded I2C
> >>> chipset in the 9350.
> >
> > I don't know if this was a change in Fedora 24 or a change in the BIOS
> > 1.4.3, but this problem has gotten *much* worse.  It seems to trigger
> > every 30 seconds or so for me now.
> >

It's actually a change in both. The new bios fixes some issues but also
changed the firmware were the palm detection patch you mention below is
screwing things up.

> 
> After fiddling for a bit, this seems to be somehow related to palm
> detection or typing detection.  I can't seem to trigger it with just
> pointer movements, but if I type (with my palms necessarily near the
> touchpad), it triggers quickly.
> 
> hid-recorder output attached.  I don't know how to decode it sort of
> playing it back with hid-replay, and that doesn't seem terribly
> helpful.  It's plausible that this is a userspace bug, and the
> hid-recorder output should make it clear either way.

Allen Hung submitted a fix for that:
http://www.spinics.net/lists/linux-input/msg45375.html
http://www.spinics.net/lists/linux-input/msg45376.html

I still need to review it, but I was sick last Thu/Fri and couldn't get
anything done properly.

Cheers,
Benjamin

> 
> --Andy


