From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: add new gamepad LED constants
Date: Tue, 23 Sep 2014 09:37:56 -0700
Message-ID: <20140923163756.GC40700@core.coreip.homeip.net>
References: <1410750811-11156-1-git-send-email-michaelwr@google.com>
 <CANq1E4RY8cF1de4_rdS3Whjrf0bboYMtii4_nYNM2mEJuAKMfQ@mail.gmail.com>
 <CAON4U=OTzqOYDCeT-rFM8trvD80_kQxirZ+Yu5nOjc84v15XLA@mail.gmail.com>
 <20140915215728.GB13468@core.coreip.homeip.net>
 <CANq1E4TK1=mD0Xh5KuydoONqiex79HggvoM9XRhorogmxqBqhw@mail.gmail.com>
 <20140915225809.GA31798@core.coreip.homeip.net>
 <CANq1E4R80GwEL43ngV5-8cWXTQAchfCOwpYSxUZfL7Hxy5yVSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:62797 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755293AbaIWQiC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Sep 2014 12:38:02 -0400
Received: by mail-pd0-f180.google.com with SMTP id r10so6727860pdi.39
        for <linux-input@vger.kernel.org>; Tue, 23 Sep 2014 09:38:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANq1E4R80GwEL43ngV5-8cWXTQAchfCOwpYSxUZfL7Hxy5yVSw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Michael Wright <michaelwr@android.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Michael Wright <michaelwr@google.com>, Jiri Kosina <jkosina@suse.cz>

On Tue, Sep 16, 2014 at 12:00:26PM +0200, David Herrmann wrote:
> Hi
> 
> On Tue, Sep 16, 2014 at 12:58 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >> The LED subsystem lacks any unprivileged API to control LEDs.
> >
> > As far as I can see it is the same as for input devices. You just need
> > to make sure the device owner can access needed attributes, such as
> > brightness.
> >
> >> There's no cdev to control write-access to the LED API. /sys has never
> >> been intended as unprivileged API
> >
> > chmod/chown works just fine on sysfs attributes.
> 
> Sure it is. You can even use ACLs. But that doesn't mean it provides a
> proper API environment. Udev maintainers have always said "sysfs is
> only writable by root". Reasons mostly being the following:
> 
> * sysfs exists only once. Unlike char-devs, you cannot create multiple
> independent entry-points to the device node. Instead, there's only a
> single entry point which has to be shared between all users (across
> sessions, across containers, across user-namespaces, across
> pid-namespaces).
> 
> * sysfs does not provide per-file contexts. Unlike char-devs, sysfs
> never knows the context of the user that writes into an attribute. It
> cannot associate private data to the open file and it cannot track the
> time the user releases the device again. It cannot multiplex across
> multiple simultaneous users.
> 
> * sysfs is not "lightweight". People always say they don't want full
> blown char-devs because sysfs is much lighter. Don't know where that
> came from.. but looking at the amount of inodes and files needed for
> sysfs APIs, it's definitely not faster nor smaller than char-devs.

I do not recall anyone saying char dev is super heavy. I was only saying
that stuffing everything in input device does not make much sense and
that full-blown input device structure is quite heavy in itself, without
even talking about all interface drivers that can attach to it.

> 
> Just look at IIO to see what happens if you write evdev-like APIs
> based on sysfs attributes "because it's lightweight". It's a mess.
> 
> Sure, one solution would be to provide char-devs for LEDs.

Exactly. If something like chardev is better API for LEDs then do it.
LED subsystem allows us to create many different "triggers".

> But then
> one char-dev per LED sounds like overkill, so my proposal is to

Not really. I think it would be fine.

>
> include it in the input API like we always did. You're free to
> disagree on that. I'm just saying that sysfs APIs to access LEDs on
> GamePads (which this patch is mostly targeted at, I guess) is making
> user-space life miserable.

How can we make life not miserable, but still not merge this into input?
I see the draw of saying "this is only for gamepads", "this is only for
keyboards", etc... But then I see generic-purpose LEDs getting way into
(we already had LED_MAIL, etc creep in), we have LEDs on network cards
(which are incidentally not part of network stack), istorage enclosures
have their LEDs, and all other LEds everywhere.

> It's the same discussion we had with
> backlights for years and we're trying eagerly to merge them into the
> DRM char-devs.
> 

So keyboard backlight is going to be controlled by display chardev? Or
we are fragmenting backlights into different classes?

Thanks.

-- 
Dmitry
