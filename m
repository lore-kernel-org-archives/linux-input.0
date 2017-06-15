From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: let generic driver yield control iff specific
 driver has been enabled (was Re: Two regressions on BYT/T ASUS T100TA
 4.12-rc: #2 Keyboard no longer works)
Date: Thu, 15 Jun 2017 16:45:16 +0200
Message-ID: <20170615144515.GK5085@mail.corp.redhat.com>
References: <20170608203904.73abb5e1@lxorguk.ukuu.org.uk>
 <Pine.LNX.4.44L0.1706081545040.1949-100000@iolanthe.rowland.org>
 <CA+55aFzhO9fPORL_yKFFuS-q2WbsjeT7_f_uorUN9ZnXVkH3qw@mail.gmail.com>
 <0d3a087b-ee57-05be-a32a-a5610127db71@redhat.com>
 <alpine.LSU.2.20.1706090959150.30709@cbobk.fhfr.pm>
 <alpine.LSU.2.20.1706091323270.30709@cbobk.fhfr.pm>
 <05b492e4-5b76-5665-18a8-4ceddb15d220@redhat.com>
 <alpine.LSU.2.20.1706131134380.30709@cbobk.fhfr.pm>
 <20170613134128.GE29589@mail.corp.redhat.com>
 <alpine.LSU.2.20.1706151245440.30709@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752316AbdFOOpZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Jun 2017 10:45:25 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1706151245440.30709@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>, USB list <linux-usb@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Jun 15 2017 or thereabouts, Jiri Kosina wrote:
> On Tue, 13 Jun 2017, Benjamin Tissoires wrote:
> 
> > BTW, the merge with your for-next branch is going to be tricky :(
> 
> I've just pushed the for-next merge. Second/third pair of eyes (scripted 
> eyes even better :) ) would be appreciated.
> 

Thanks!

Looks like HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110)
is assigned to hid-multitouch while it's handled in hid-asus.

The rest of the list looks fine, according to a home-made script that
converts the various id_tables into this hid_have_special_driver[].

Cheers,
Benjamin
