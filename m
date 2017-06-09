From: Greg KH <greg@kroah.com>
Subject: Re: Two regressions on BYT/T ASUS T100TA 4.12-rc: #2 Keyboard no
 longer works
Date: Fri, 9 Jun 2017 10:27:03 +0200
Message-ID: <20170609082703.GA29271@kroah.com>
References: <20170608203904.73abb5e1@lxorguk.ukuu.org.uk>
 <Pine.LNX.4.44L0.1706081545040.1949-100000@iolanthe.rowland.org>
 <CA+55aFzhO9fPORL_yKFFuS-q2WbsjeT7_f_uorUN9ZnXVkH3qw@mail.gmail.com>
 <0d3a087b-ee57-05be-a32a-a5610127db71@redhat.com>
 <alpine.LSU.2.20.1706090959150.30709@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38405 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751690AbdFII1K (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Jun 2017 04:27:10 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1706090959150.30709@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, USB list <linux-usb@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Fri, Jun 09, 2017 at 10:21:47AM +0200, Jiri Kosina wrote:
> Longer-term, we'd ideally make 'generic' driver special and let it attach 
> as a 'last resort driver' if none of the specific driver picked the device 
> up during probe. But I don't think our current driver model allows this 
> easily ... or is there way I am not seeing?

Nope, the driver model does not provide a way for this, sorry, it's been
a complaint from the very beginning that we don't really know how to
handle, except to make sure the order of the drivers loaded are the
priority list, and that's not really a solution at all.

thanks,

greg k-h
