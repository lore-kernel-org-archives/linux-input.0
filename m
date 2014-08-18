From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [Question: Drivers/input/evdev.c] What is the use of write
 function in evdev_fops?
Date: Mon, 18 Aug 2014 11:57:59 +1000
Message-ID: <20140818015759.GA13994@jelly.redhat.com>
References: <20140813170639.GA16164@core.coreip.homeip.net>
 <CADYu30-OBXKQTMD_kAmjfrYoXvO0NkcaPac5kpe1hmbXy473Ww@mail.gmail.com>
 <20140813185851.GA34103@core.coreip.homeip.net>
 <CADYu30_XWpoYmFyGB7Pe9xkG0kyCUJo03NO0U2kycBfY83J3OA@mail.gmail.com>
 <a3bd7d64-136e-42ea-98ca-e7992b48cc01@email.android.com>
 <CADYu308G3_50JTEfwOnRy4U4x8U_FTpuxqLhHqmqWiCAwAYH7w@mail.gmail.com>
 <8453fbc4-dfb7-4d93-acc9-e0151c8901ed@email.android.com>
 <CADYu30_oB94oORguEu3+Ri4YFu6Vuo1qBvsmFmFbSpZufJ49aQ@mail.gmail.com>
 <20140814201903.GB13458@core.coreip.homeip.net>
 <CADYu308JT8owRimn4i9mW4eKa3T--yjCdbGns1O9R_WWx_uF-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:48477 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbaHRB6D (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Aug 2014 21:58:03 -0400
Content-Disposition: inline
In-Reply-To: <CADYu308JT8owRimn4i9mW4eKa3T--yjCdbGns1O9R_WWx_uF-w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <aniroop.mathur@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Fri, Aug 15, 2014 at 02:01:48AM +0530, Aniroop Mathur wrote:
[...]
> >> >>
> >> >>2 separate file descriptors like below ?
> >> >>int fd1 = open("/dev/uinput", O_RDWR);
> >> >>int fd2 = open("/dev/uinput", O_RDWR);
> >> >>
> >> >>But my reading data will still come in struct input_event as mentioned
> >> >>above.
> >> >>It has only time, type, code and value.
> >> >>So, how we can use bitmask here ?
> >> >>
> >> >>struct input_event {
> >> >>struct timeval time;
> >> >>__u16 type;
> >> >>__u16 code;
> >> >>__s32 value;
> >> >> };
> >> >
> >> > By opening 2 fds you'll end up creating 2 separate input devices with separate evdev nodes, etc, so you will not mix up input events.
> >> >
> >> > I think at this time you should just try actually using uinput and that should clear things for you.
> >> >
> >>
> >> Can you please explain what do you mean by separate evdev nodes ?
> >> Do you mean two separate evdev nodes for uinput ?
> >> But as we discussed before, there is only one node in case of uinput
> >> i.e. /dev/uinput.
> >
> > Uinput allows to creating input devices driven from userspace. You can
> > create as many separate input devices as you want by opening
> > /dev/uinput several times since it creates a device per file descriptor.
> > Each of these input devices will get evdev attached to it and will get
> > it's own /dev/input/eventX node created.
> >
> > Really, please try using uinput, it will clear a lot if things for you.
> > For example, see what http://www.freedesktop.org/wiki/Evemu/ does.
> >
> 
> 
> Thank you Mr. Torokhov for the discussion and answering my queries. :)
> I will try to explore more.

I recommend you look at libevdev if you're planning to use uinput. evemu
uses that now too and it makes a whole bunch of stuff easier and less likely
to go wrong.
http://freedesktop.org/wiki/Software/libevdev/

specifically:
http://www.freedesktop.org/software/libevdev/doc/1.2/group__uinput.html

Cheers,
   Peter

