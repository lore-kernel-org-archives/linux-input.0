From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v4 14/14] HID: hid-multitouch: forwards MSC_TIMESTAMP
Date: Tue, 20 Nov 2012 21:51:47 +0100
Message-ID: <20121120205147.GA4658@polaris.bitmath.org>
References: <1352908766-4492-1-git-send-email-benjamin.tissoires@gmail.com>
 <1352908766-4492-15-git-send-email-benjamin.tissoires@gmail.com>
 <20121114195852.GA14840@polaris.bitmath.org>
 <50A40CB3.8070105@gmail.com>
 <20121116200926.GA652@polaris.bitmath.org>
 <CAN+gG=F=bHdJF0=0LHGuVQ+ObHvWKJnL0GYcAEWBeD+Z-yyGSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:49597 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737Ab2KTUvf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Nov 2012 15:51:35 -0500
Content-Disposition: inline
In-Reply-To: <CAN+gG=F=bHdJF0=0LHGuVQ+ObHvWKJnL0GYcAEWBeD+Z-yyGSA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> > In addition, it would make perfect sense to extend the validity of the
> > hardware time with the event time for longer intervals. The relative
> > error only makes a difference on milisecond intervals.
> >
> > A patch that seamlessly extends the validity of the hardware time,
> > ideally using the event time, seems like a viable solution.
> 
> Just to be sure:
> When I receive scan_time, I increment timestamp with the device value.
> When not, I find out the number of counter wrap I missed with the
> kernel timer (jiffies) to get the actual device time.
> 
> Is that ok for you?

If the device has no scan time, then no scan time is reported, of
course.  If the scan time delta _and_ the actual time delta are both
below logical_max (say), then increase the counter with the scan time
delta. Else, if the actual time delta is below 2^31, increase the
counter with the actual time delta. Else set the counter to zero.

This ought to give us the sought-after accuracy for small times, the
sought-after extension for intermediate times, and a clear definition
of unknown time.

Cheers,
Henrik
