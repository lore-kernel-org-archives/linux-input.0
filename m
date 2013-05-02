From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Game Controllers
Date: Thu, 2 May 2013 13:18:08 -0700
Message-ID: <20130502201807.GE28625@core.coreip.homeip.net>
References: <2483279.JlnWrOX8Uv@dtor-d630.eng.vmware.com>
 <CAFmpkyiS+L6OsGmobjHqqJ8AFNNiDk4DYYFo_1GQx2kV_dam1Q@mail.gmail.com>
 <20130502083547.279d08a3cbd7a115489de4b7@studenti.unina.it>
 <CAFmpkygZ+xvpwp9KQr6O4emk2f1Bn0EBS0WeN1ji0qVUJz2rwA@mail.gmail.com>
 <CANq1E4QstEwpxEReYOsmJhPMED+eWv3SBSEMzYMNVq5Ywme38g@mail.gmail.com>
 <CAFmpkyj+MV0+v8zKiKVAYX4uQHLv3jdCo=VR4nb=-M9NOUGYWg@mail.gmail.com>
 <20130502163824.GA28625@core.coreip.homeip.net>
 <CAFmpkyjO8WwUxOJ2BtULwOTcfYs7sjdWMS_=Fcho996VijEFHg@mail.gmail.com>
 <20130502182935.GD28625@core.coreip.homeip.net>
 <CAFmpkyhRSi5Q2uwsJ7eH6VYJ40zFzp2T6=6fFU9eU09dWkg0zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:36231 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762084Ab3EBUSM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 May 2013 16:18:12 -0400
Received: by mail-da0-f50.google.com with SMTP id i23so464394dad.23
        for <linux-input@vger.kernel.org>; Thu, 02 May 2013 13:18:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFmpkyhRSi5Q2uwsJ7eH6VYJ40zFzp2T6=6fFU9eU09dWkg0zA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Showalter <todd@electronjump.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Antonio Ospite <ospite@studenti.unina.it>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Thu, May 02, 2013 at 03:54:45PM -0400, Todd Showalter wrote:
> On Thu, May 2, 2013 at 2:29 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> 
> >> - any mapping library is going to have to be a mirror of the kernel
> >> code, which means it's basically just a lot of duplicated effort with
> >> the added penalty of update lag
> >
> > The library can do much more than that. You also need to calibrate the
> > device (per user), adjust it to user's tastes and so on. Maybe you have
> > a user that is left-handed and you'd like to remap some keys? It is
> > certainly not kernel's job.
> 
>     I think calibration, dead-zones, easing, button remapping and the
> like are a totally orthogonal problem.  They are nice to have, but
> that's the kind of thing that belongs in a desktop environment's
> accessibility settings, not at the input protocol level.
> 
> > There also should not be lag if new devices follow the agreed upon
> > mapping.
> 
>     If we can have that, at least, it means the problem is eventually
> fixed.  Maybe not for years, but at least someday.
> 
> > The same thing can be done in a library. Libraries are easier then
> > kernels, you do not need to consume memory until needed and you do not
> > need to do the conversion if it is not needed. And it should be possible
> > to update the library whereas with kernel you mist likely need to reboot
> > the box.
> >
> > Why do people believe that patching the kernel is easier than updating
> > userspace?
> 
>     The kernel is the core of the system; Linux isn't Linux without
> the Linux kernel.  If I make a game input library and try to get
> people to use it, there's a whole chicken-and-egg problem of getting
> developers to support something nobody has installed, and getting
> users to install something no developers support.  I have to convince
> the distros to pick it up, and to keep updating it.  I have to monitor
> changes in the kernel codebase to see if the library needs updating.
> I have to deal with the possibility that the library becomes a useful
> bandaid, with people saying "meh, this is a hard problem, punt the fix
> to the library".  I have to hope that telling players to install
> another dependency isn't going to lose me customers.

Until you get a traction with the new you might need to distribute it
with your game. Another option would be to extend already established
library, such as SDL, with the required functionality.

> 
>     The kernel has authority that a library does not, and it has a
> distribution mechanism that a library does not.  The kernel is
> effectively the source of the data; all I can do outside of that is
> provide a filter and hope people use it.

No, I do not think so. Kernel provides a level of abstraction, but so
does X, ALSA, given desktop environment and so forth. If a task does not
require hardware access (and translating input events form one type to
another does not) one should think really hard whether it should be
done in kernel.

Thanks.

-- 
Dmitry
