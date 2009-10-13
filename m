From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Haptic class support (v2)
Date: Tue, 13 Oct 2009 13:05:52 +0200
Message-ID: <20091013110552.GD31984@elf.ucw.cz>
References: <20091006074533.GA28889@july>
 <20091011090549.GE1414@ucw.cz>
 <9c9fda240910111732x262a9510rf3dd862aa16d0bdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759429AbZJMLGi@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9c9fda240910111732x262a9510rf3dd862aa16d0bdf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, soni.trilok@gmail.com, Greg KH <greg@kroah.com>
List-Id: linux-input@vger.kernel.org

On Mon 2009-10-12 09:32:28, Kyungmin Park wrote:
> On Sun, Oct 11, 2009 at 6:05 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > On Tue 2009-10-06 16:45:33, Kyungmin Park wrote:
> >> This patch includes two haptic devices, isa1000 and isa1200
> >> ISA1000 is gpio based haptic, but isa1200 is based on I2C
> >> Both are working on Samsung SoCs and tested.
> >>
> >> To enable the haptic, echo 1 > /sys/class/haptic/${name}/enable
> >> You can adjust the level by echo ${level} > /sys/class/haptic/${name}/enable
> >> or
> >> With oneshot feature, echo ${msec time} > /sys/class/haptic/${name}/oneshot
> >
> > New device classes should certainly be documented in Documentation/.
> >
> > For example... is level 0-100?
> 
> Basically. range from 0 to 255. also each device can set max level in
> case of isa1000 it's 6.

How will userspace know the range?

> >  Is it valid to change level while 'oneshot' is running?
> 
> we usually use it under 1 sec. but I think it's possible to change it
> but not tried.

You are specifying interface here. You have to decide if it is valid
or not, then document it.

> >  Does oneshot use last level set?
> 
> Right. it used last set value.
> 
> If you don't mind to update these at Documentation please wait until
> commit first patches merged.

I'd expect your reply to be merged into the Documentation, and that to
be merged with the rest of the patches...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
