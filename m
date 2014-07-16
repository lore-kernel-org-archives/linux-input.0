From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Power-managing devices that are not of interest at some point
 in time
Date: Wed, 16 Jul 2014 14:08:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1407161400150.1028-100000@iolanthe.rowland.org>
References: <CAE_wzQ82xsuDQrw8Q6auoG9fowr4VZkcUgciPXe2s9PTAmJ=RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAE_wzQ82xsuDQrw8Q6auoG9fowr4VZkcUgciPXe2s9PTAmJ=RA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@google.com>
Cc: Patrik Fimml <patrikf@chromium.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benson Leung <bleung@google.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 16 Jul 2014, Dmitry Torokhov wrote:

> > The general design of Linux's runtime PM is that the PM core tells
> > drivers when their devices are no longer being used, and it's up to the
> > driver to select an appropriate low-power state.  That philosophy
> > doesn't fit well with the problem you want to solve, because you want
> > to turn off devices even when they _are_ still in use.
> 
> This does not sound quite right to me. We can tell PM core when
> devices absolutely can not go to low power mode, but certain devices
> can go into lower power state and wake up themselves even if there are
> users: i.e. mice and keyboards with autosuspend. I guess it depends
> what you define as being "in use".

True.  Right now the PM core relies on subsystems and drivers to tell 
it when a device is or isn't in use.

> > A separate sysfs interface might work out better.
> >
> 
> I am not so much concerned about userspace, but about reusing of as
> much of existing PM framework in the drivers. Right now it is very
> hard to correctly track dependencies between general open/close,
> system suspend/resume, and various runtime-PM transitions. Adding yet
> another PM mechanism into the mix will just add more complexity.

Would it make sense to unbind the drivers for these devices when the 
lid is closed?  With the drivers gone, there would naturally be no I/O 
interactions with the hardware and the class devices would disappear.

The respective subsystems could then use their own runtime PM
mechanisms to power down the driverless devices.  (Except for PCI,
unfortunately, which has a policy of leaving driverless devices at full
power.  I was told this is a relic from the days before in-kernel mode
switching for displays was common, when user programs like the X server
would drive displays directly, without using a kernel driver.)

Alan Stern

