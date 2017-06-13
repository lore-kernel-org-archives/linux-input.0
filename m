From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: let generic driver yield control iff specific driver
 has been enabled (was Re: Two regressions on BYT/T ASUS T100TA 4.12-rc: #2
 Keyboard no longer works)
Date: Tue, 13 Jun 2017 16:54:29 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1706131653250.30709@cbobk.fhfr.pm>
References: <20170608203904.73abb5e1@lxorguk.ukuu.org.uk> <Pine.LNX.4.44L0.1706081545040.1949-100000@iolanthe.rowland.org> <CA+55aFzhO9fPORL_yKFFuS-q2WbsjeT7_f_uorUN9ZnXVkH3qw@mail.gmail.com> <0d3a087b-ee57-05be-a32a-a5610127db71@redhat.com>
 <alpine.LSU.2.20.1706090959150.30709@cbobk.fhfr.pm> <alpine.LSU.2.20.1706091323270.30709@cbobk.fhfr.pm> <05b492e4-5b76-5665-18a8-4ceddb15d220@redhat.com> <alpine.LSU.2.20.1706131134380.30709@cbobk.fhfr.pm> <20170613134128.GE29589@mail.corp.redhat.com>
 <20170613140247.GF29589@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37684 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753175AbdFMOyd (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Jun 2017 10:54:33 -0400
In-Reply-To: <20170613140247.GF29589@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>, USB list <linux-usb@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, 13 Jun 2017, Benjamin Tissoires wrote:

> > I tried to cook some script that formats the list in the same way than
> > yours.
> > 
> > I just noticed that you have in CONFIG_HID_CHICONY:
> > 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D) },
> > while in v4.12-rc5 it's:
> > 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_AK1D) },
> 
> False alert on this one. I applied Jiri's patch on top of his for-next
> branch, and in this branch, this has been renamed into
> USB_DEVICE_ID_ASUS_AK1D.

Yeah, this is going to generate conflict in -next, but easy to resolve 
once it appears. I'll fix that up as soon as this patch hits Linus' tree.

> > Rest is almost OK with respect to device/driver allocation:
> > 
> > Also, comparing the raw number of devices, there are 356 devices in
> > 4.12-rc5, and you have 360 in your patch:
> > - { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL) }
> >   is added twice (the one in CONFIG_HID_LOGITECH should be dropped IMO).
> 
> Only this one is would require a change now.

This single change has now been done to the branch.

Thanks,

-- 
Jiri Kosina
SUSE Labs

