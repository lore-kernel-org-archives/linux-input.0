From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: Synchronizing evdev readers and drivers?
Date: Sat, 04 Dec 2010 17:46:20 +0000
Message-ID: <4CFA7E6C.60809@cam.ac.uk>
References: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:44424 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657Ab0LDRjq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Dec 2010 12:39:46 -0500
In-Reply-To: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linux-input@vger.kernel.org

On 12/02/10 17:26, Bill Gatliff wrote:
> Guys:
> 
> 
> Is there any  way for an input device driver (e.g. something that
> calls input_report_abs() and input_sync()) to know when there is a
> reader of its associated /dev/input/eventX?
> 
> I would love to know when something calls evdev_read() and/or
> evdev_poll(), so that I could then initiate a sampling operation on
> the hardware itself.  Otherwise, I'm forced to periodically poll the
> hardware and that means I'm either gathering data that no application
> wants, or I'm gathering it before (or faster than) an application is
> actually asking for it.
> 
> I have stared at a lot of the evdev and related code, and can't find
> anything that looks like what I want.  Am I just not seeing it, or am
> I looking in the wrong place?
Hi Bill,

It's not entirely relevant, but I thought I'd take this opportunity
to say how we would do the same in IIO.  In our case we have
explicit triggers that cause data to be captured.  At the moment
they are things like dataready signals and periodic timers, but
they are intended to be more general.  The big requirement we have
is that more than one device can be sampled from based on a single
hardware or software event.  This is crucial for some inertial algorithms where
we have to get readings from a number of sensors as close as possible
in time.

On the todo list that exists in my head is a userspace trigger.  That
would allow us to set up as many devices as we want to capture on
a poke from userspace (sysfs file write or something else if lower
overheads are needed).

In our case this fine control of phase of capture is a key requirement
and one that we don't have completely covered as yet.  Right now there
is no consideration of how long a given device takes to get a sample
and they are merely triggered in series. Obviously that time delay
is dependant on hardware state (particularly if low power modes exist
on the device).

Of course this is not all that relevant to input, just thought I'd
mention similar work elsewhere.

Jonathan
