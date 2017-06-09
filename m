From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Two regressions on BYT/T ASUS T100TA 4.12-rc: #2 Keyboard no
 longer works
Date: Fri, 9 Jun 2017 11:54:31 +0200
Message-ID: <20170609095431.GA23491@mail.corp.redhat.com>
References: <20170608203904.73abb5e1@lxorguk.ukuu.org.uk>
 <Pine.LNX.4.44L0.1706081545040.1949-100000@iolanthe.rowland.org>
 <CA+55aFzhO9fPORL_yKFFuS-q2WbsjeT7_f_uorUN9ZnXVkH3qw@mail.gmail.com>
 <0d3a087b-ee57-05be-a32a-a5610127db71@redhat.com>
 <alpine.LSU.2.20.1706090959150.30709@cbobk.fhfr.pm>
 <20170609082703.GA29271@kroah.com>
 <8760g5ilut.fsf@miraculix.mork.no>
 <20170609090028.GA30604@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751515AbdFIJym (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Jun 2017 05:54:42 -0400
Content-Disposition: inline
In-Reply-To: <20170609090028.GA30604@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>, Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, USB list <linux-usb@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Jun 09 2017 or thereabouts, Greg KH wrote:
> On Fri, Jun 09, 2017 at 10:52:42AM +0200, Bjørn Mork wrote:
> > Greg KH <greg@kroah.com> writes:
> > 
> > > On Fri, Jun 09, 2017 at 10:21:47AM +0200, Jiri Kosina wrote:
> > >> Longer-term, we'd ideally make 'generic' driver special and let it attach 
> > >> as a 'last resort driver' if none of the specific driver picked the device 
> > >> up during probe. But I don't think our current driver model allows this 
> > >> easily ... or is there way I am not seeing?
> > >
> > > Nope, the driver model does not provide a way for this, sorry, it's been
> > > a complaint from the very beginning that we don't really know how to
> > > handle, except to make sure the order of the drivers loaded are the
> > > priority list, and that's not really a solution at all.
> > 
> > Add a 'priority' field to struct device_driver and sort the list by this
> > field instead of load order?
> 
> We've been over this before :)

I can imagine :)

> 
> What happens when a new module is loaded, are you supposed to then
> disconnect a device from an existing driver, recan all of the existing
> drivers, and then bind the "correct" one then?

This particular case might be slightly different than a generic solution
across the tree.
HID devices are supposed to behave properly out of the box and are
expected to be reprobed by design (most input devices have a special boot
mode to be accessed to some extend by the UEFI, and then you have the
shiny proprietary driver that takes over it under windows).

So I don't think it would be an issue to "bind" a generic handling of a
device, and somehow retrigger a probe when the actual hid-specific
driver comes in (and we know we are using the default, non ideal,
handling).
The current driver model won't allow this by design, but I'll try to work
around this if it is possible in the hid tree as a specific case.

Cheers,
Benjamin

> 
> sorry,
> 
> greg k-h
