From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 0/2] input: Add INPUT_PROP_POINTING_STICK property
Date: Wed, 3 Sep 2014 13:24:52 +1000
Message-ID: <20140903032451.GC17684@jelly.redhat.com>
References: <1409661804-10489-1-git-send-email-hdegoede@redhat.com>
 <CANq1E4TU9Q3eWm25LhySk28de7r4tjZTLaCMHLOfVo738fnoFg@mail.gmail.com>
 <5405D6D4.4070406@redhat.com>
 <CANq1E4RMKmM3Qk09-hd49VSH2On_n8-x7sOp7OKd9Ww-48sLzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:39012 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbaICDY4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Sep 2014 23:24:56 -0400
Content-Disposition: inline
In-Reply-To: <CANq1E4RMKmM3Qk09-hd49VSH2On_n8-x7sOp7OKd9Ww-48sLzw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Tue, Sep 02, 2014 at 04:50:53PM +0200, David Herrmann wrote:
> Hi
> 
> On Tue, Sep 2, 2014 at 4:40 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> > On 09/02/2014 02:55 PM, David Herrmann wrote:
> >> Hi
> >>
> >> On Tue, Sep 2, 2014 at 2:43 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> >>> Hi,
> >>>
> >>> It is useful for userspace to know that they're not dealing with a regular
> >>> mouse but rather with a pointing stick (e.g. a trackpoint) so that userspace
> >>> can e.g. automatically enable middle button scrollwheel emulation.
> >>>
> >>> It is impossible to tell the difference from the evdev info without resorting
> >>> to putting a list of device / driver names in userspace, this is undesirable.
> >>
> >> ..so it is better to put that table into the kernel?
> >
> > No not a table, at the kernel level we actually have different drivers
> > for pointer sticks and for other mouse (and mouse like devices), so this is
> > a simple matter of adding a single line of code to all of 4 drivers.
> >
> > We could have a table in userspace matching the driver/model strings used
> > by those 4 drivers, but what if a 5th pops up ?
> 
> Ok, for now it's pretty easy as all "pointing stick" drivers are
> already separate in the kernel. But imagine a new generation of
> "pointing stick" devices is an HID device handled by hid-input.c. What
> do you do? To set the INPUT_PROPERTY bit, you need to add a driver for
> this vid/did combination. Seems overkill, so we'd probably not set
> this property bit for this device and let user-space deal with it. Now
> we end up with two places to store such information.

right now, there's no ioctl to set a property on a device. that'd be a
requirement for a udev hwdb-like thing, unless you want clients to rely on
pulling the information from two places and merging it in some strategy
that's not well defined yet.

I'm all for a userspace hwdb, but this is some bigger project that afaik
hasn't been worked on beyond the libinputmapper discussions we had a year or
so ago.

Cheers,
   Peter

> We already fix scancode/keycode mappings via hwdb as it would be
> excessive to write kernel drivers for all devices just to fix those.
> Imo, device properties are very similar to this. We have to draw a
> line between properties the kernel should detect and expose, and
> properties we detect in user-space. We already gave up defining ABS_
> axes for everything (I mean, we report all kinds of data via ABS_X,
> ranging from trackpad, to pressure and accelerometer data). User-space
> needs to detect what devices it deals with, to know what the different
> axes event-bits mean.
> 
> Yeah, the POINTING_STICK property turns out to be trivial, so please
> go ahead. I just want to remind you, that we need a user-space
> database, anyway. And hwdb entries can be added via simple distro
> updates (even users can regenerate it themselves). Kernel driver
> changes are way more heavy.. and slow.
> 
> Thanks
> David
> --
