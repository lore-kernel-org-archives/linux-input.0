From: Jiri Kosina <jikos@kernel.org>
Subject: Re: Two regressions on BYT/T ASUS T100TA 4.12-rc: #2 Keyboard no
 longer works
Date: Fri, 9 Jun 2017 10:21:47 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1706090959150.30709@cbobk.fhfr.pm>
References: <20170608203904.73abb5e1@lxorguk.ukuu.org.uk> <Pine.LNX.4.44L0.1706081545040.1949-100000@iolanthe.rowland.org> <CA+55aFzhO9fPORL_yKFFuS-q2WbsjeT7_f_uorUN9ZnXVkH3qw@mail.gmail.com> <0d3a087b-ee57-05be-a32a-a5610127db71@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46713 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751598AbdFIIVu (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Jun 2017 04:21:50 -0400
In-Reply-To: <0d3a087b-ee57-05be-a32a-a5610127db71@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>, USB list <linux-usb@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Fri, 9 Jun 2017, Hans de Goede wrote:

> Right, so this is not really a problem with this specific patch, but 
> with how the hid_have_special_driver array works in general currently it 
> has very few #if IS_ENABLED(CONFIG_FOO) guards around all the devices it 
> blacklists the generic HID driver for.

This is something I've been wanting to fix for ages, but never really got 
to it. So let's take this as the final impulse to do it.

> I think this is on purpose to stop things becoming one big #ifdef party, 
> but as you rightfully say this means that people may end up with not 
> having a driver at all.

Yeah, ifdef-hell is currently hardly avoidable, but I don't really see too 
many better options, at least as a short-term solution. I'll come up with 
something and send it out ASAP for 4.12-rc still.

Longer-term, we'd ideally make 'generic' driver special and let it attach 
as a 'last resort driver' if none of the specific driver picked the device 
up during probe. But I don't think our current driver model allows this 
easily ... or is there way I am not seeing?

Thanks,

-- 
Jiri Kosina
SUSE Labs

