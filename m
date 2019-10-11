From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] HID: i2c-hid: Remove runtime power management
Date: Fri, 11 Oct 2019 13:21:18 +0300
Message-ID: <20191011102118.GD2819@lahna.fi.intel.com>
References: <20191008153829.24766-1-kai.heng.feng@canonical.com>
 <d096582b-c96b-69a2-bcc5-cba2984705e7@redhat.com>
 <CAO-hwJJoy3=a_m9V6ZseisGgWp=jJpYr3ub85SaLiQFiioZ7ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO-hwJJoy3=a_m9V6ZseisGgWp=jJpYr3ub85SaLiQFiioZ7ew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Jiri Kosina <jikos@kernel.org>, You-Sheng Yang <vicamo.yang@canonical.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Oct 11, 2019 at 11:27:10AM +0200, Benjamin Tissoires wrote:
> Hi,
> 
> [Adding Mika, who introduced runpm in i2c-hid]
> 
> few questions, remarks:
> 
> On Tue, Oct 8, 2019 at 10:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi,
> >
> > On 08-10-2019 17:38, Kai-Heng Feng wrote:
> > > Runtime power management in i2c-hid brings lots of issues, such as:
> > > - When transitioning from display manager to desktop session, i2c-hid
> > > was closed and opened, so the device was set to SLEEP and ON in a short
> > > period. Vendors confirmed that their devices can't handle fast ON/SLEEP
> > > command because Windows doesn't have this behavior.
> > >
> > > - When rebooting, i2c-hid was closed, and the driver core put the device
> > > back to full power before shutdown. This behavior also triggers a quick
> > > SLEEP and ON commands that some devices can't handle, renders an
> > > unusable touchpad after reboot.
> > >
> > > - Runtime power management is only useful when i2c-hid isn't opened,
> > > i.e. a laptop without desktop session, which isn't that common.
> 
> There is also one GPM-like driver that uses libinput (can't remember
> from the top of my head), but you can have the i2c-hid device opened
> on a vt too (with 2 finger gestures for scrolling and what not) :)
> 
> And there is also the use case of a 2-in-1 when the laptop is in
> tablet mode. In some cases, the compositor will close the inputs to
> ignore the touchpad events.
> 
> Anyway, Mika, is there any drawbacks of not having runpm on i2c-hid
> devices? Maybe at the IRQ level?

Nothing comes to mind except that power consumption might increase if
the device is not used but if that's not an issue then no objections
from my side :)
