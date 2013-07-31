From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC 0/8] HID: Transport Driver Cleanup
Date: Wed, 31 Jul 2013 11:03:50 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1307311102450.18809@pobox.suse.cz>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com> <alpine.LNX.2.00.1307311035320.18809@pobox.suse.cz> <CANq1E4TTKgVtCp0t3h0SKhHqyfGePBxz_B3NZpD+FDjLgmbpEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49451 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755835Ab3GaJDy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Jul 2013 05:03:54 -0400
In-Reply-To: <CANq1E4TTKgVtCp0t3h0SKhHqyfGePBxz_B3NZpD+FDjLgmbpEQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>

On Wed, 31 Jul 2013, David Herrmann wrote:

> >> This series provides some cleanups for HID transport drivers:
> >
> > Hi David,
> >
> > thanks a lot for your work, again.
> >
> > I have now applied all the patches from the series, except for:
> >
> > - 3/8, waiting for v2
> 
> Ugh, patches 4-6 use the generic helper from 3 implicitly. So with the
> current tree, they will not be able to send any LED events. I think my
> conclusion in the discussion on #3 was wrong. I cannot rebase it on
> the end of the series. Sorry, I missed that.
> 
> For v2, as mentioned in the thread, I cannot write a generic fallback
> for hid_hw_request() without patch #8. That's because the transport
> drivers handle the raw reports differently. #8 fixes that.
> 
> So imho we should apply #3 as it is now. If we ever have a generic
> hid_hw_request(), we can just move the code from the LED handler to
> hid_hw_request_generic().

Bah, brainfart on my side as well. You are right. I am now pulling 3/8 
into the tree as well and pushing it out.

-- 
Jiri Kosina
SUSE Labs
