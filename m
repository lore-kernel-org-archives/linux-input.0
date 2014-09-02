From: Benjamin Tissoires <btissoir@redhat.com>
Subject: Re: [PATCH 0/2] input: Add INPUT_PROP_POINTING_STICK property
Date: Tue, 2 Sep 2014 10:34:13 -0400
Message-ID: <20140902143413.GA25423@mail.corp.redhat.com>
References: <1409661804-10489-1-git-send-email-hdegoede@redhat.com>
 <CANq1E4TU9Q3eWm25LhySk28de7r4tjZTLaCMHLOfVo738fnoFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40775 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121AbaIBOeU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Sep 2014 10:34:20 -0400
Content-Disposition: inline
In-Reply-To: <CANq1E4TU9Q3eWm25LhySk28de7r4tjZTLaCMHLOfVo738fnoFg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi David,

On Sep 02 2014 or thereabouts, David Herrmann wrote:
> Hi
> 
> On Tue, Sep 2, 2014 at 2:43 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> > Hi,
> >
> > It is useful for userspace to know that they're not dealing with a regular
> > mouse but rather with a pointing stick (e.g. a trackpoint) so that userspace
> > can e.g. automatically enable middle button scrollwheel emulation.
> >
> > It is impossible to tell the difference from the evdev info without resorting
> > to putting a list of device / driver names in userspace, this is undesirable.
> 
> ..so it is better to put that table into the kernel?
> 
> I thought the plan was to avoid putting more hardware tables into the
> kernel. All those tables are always loaded into RAM, whereas solutions
> like udev hwdb can provide the exact same features in user-space but
> avoid loading it into RAM, except if used. hwdb is pretty nice to
> store information about hardware. It is not meant for configuration or
> volatile data, but rather as read-only lookup table for hardware
> information.

I think you misread Hans in this case. Hans stated:
- if this is not provided by the kernel, we have to create a user space
  table with all old and new future devices
- if we put this in the kernel, then we only have to add this property
  to the few generic drivers which present this feature to the user
  space, and done. See patch 1/2. There is no table in the kernel.

> 
> You could easily extend the hwdb with a trackpoint variable that marks
> specific devices as trackpoints.

I don't think this is reasonable. You will have to review all laptops
with trackstick to add them into this (huge) db.

> 
> Anyhow, if you guys want it in the kernel, go ahead. I just don't see
> the advantage of having it in kernel-space.
> 

Again, it's either 10 lines in the kernel, and we forget about it, or we
have to carry a db which has to be updated with every single different
laptop model available. I am definitively in favor of those 10 lines.

Cheers,
Benjamin
