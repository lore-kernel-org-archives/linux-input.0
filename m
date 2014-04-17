From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: HID: hid-logitech - missing HID_OUTPUT_REPORT 0
Date: Thu, 17 Apr 2014 13:37:23 -0400
Message-ID: <20140417173723.GC10689@mail.corp.redhat.com>
References: <6452400bfacafd7e1f0d0f7a98b06248.squirrel@mungewell.org>
 <CAGXu5jKTcV9m70tgsxrBhUXWp5eXdXRJkCdYJDhpdOtB16b=6w@mail.gmail.com>
 <796aa99e55f8812aa6422d35610d4ed3.squirrel@mungewell.org>
 <CAGXu5jL4H2ukqQDV4syME148bbD3wcSqM0NscvOujnMYtW5w1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40202 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104AbaDQRhh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Apr 2014 13:37:37 -0400
Content-Disposition: inline
In-Reply-To: <CAGXu5jL4H2ukqQDV4syME148bbD3wcSqM0NscvOujnMYtW5w1g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: simon@mungewell.org, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Elias Vanderstuyft <elias.vds@gmail.com>

On Apr 17 2014 or thereabouts, Kees Cook wrote:
> On Thu, Apr 17, 2014 at 9:35 AM,  <simon@mungewell.org> wrote:
> >
> >> I don't know the lg driver very well, but it looks like it's expecting
> >> a single report ID (0), but the device is showing two report IDs: 1
> >> and 2. So, from the perspective of the driver, this is correct: it
> >> wouldn't know how to deal with things since it is only expecting
> >> Report ID 0. It seems like the driver needs to be updated for this
> >> different device.
> >
> > Hi,
> > The 'hid-lgff.c' driver supports lots of devices (see end of 'hid-lg.c'),
> > and presumably these devices offer up a wide/varied range of HID
> > descriptors.
> >
> > Does the recently introduced(/changed) check need to have prior knowledge
> > of which 'Report ID's are actually used? If so, it possible that the
> > change has broken a number of devices...
> >
> > I am trying to get the end user to test with an older kernel to see
> > whether his device was always 'broken'.
> 
> Ah-ha, actually, when taking a closer look at this, I see that lgff
> isn't using ID "0", it's actually using "the first report in the
> list", without using an ID at all. This appears to be true for all the
> lg*ff devices, actually. Instead of validating ID 0, it needs to
> validate "the first report".
> 
> Documentation for hid_validate_values says:
>  * @id: which report ID to examine (0 for first)
> 
> Benjamin, does that mean "first report in the list", or is that a hint

yep

> that IDs are 0-indexed? 

nope :)

page 46 of the HID 1.11 spec (http://www.usb.org/developers/devclass_docs/HID1_11.pdf)
says: "Report ID zero is reserved and should not be used."

> What do you think is the best way to handle
> this? Seems like passing something for "id" that means "whatever is
> first in list" would be safest? I don't think overloading the meaning
> of "0" is good, in case a driver really is using a 0 index but no
> report with that ID exists in the list.

"Overloading" 0 here is fine because reportID==0 can not exist according
to the spec. Actually, a HID device is not forced to use report IDs at
all if it sends only one type of reports.
So in the various transport layers, 0 is handled as a special case
anyway, and that means that there is no report ID. And when there is no
report ID, there should be only one which is the first in the list :)

Still, hid-lg should not use this trick to find the first report, but
this driver has quite a lot of history, so I will not try to fix it.

Anyway, it looks like hid_validate_values has to be fixed to handle HID
devices without a report ID (which would fix hid-lg too).

> Or if we do change the
> meaning, make sure drivers always use the report returned by
> hid_validate_values instead of re-finding it later.

As explained above, it shouldn't matter. And it's more likely a bug in
hid_validate_values that I should have spot when reviewing it :/

Cheers,
Benjamin

