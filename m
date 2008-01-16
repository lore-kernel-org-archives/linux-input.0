From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 2.6.24-rc6] ads7846:  simplify support of external vREF
	(and ads7843)
Date: Wed, 16 Jan 2008 14:13:21 -0500
Message-ID: <20080116141218.ZZRA012@mailhub.coreip.homeip.net>
References: <200801051410.19925.david-b@pacbell.net> <20080116100717.ZZRA012@mailhub.coreip.homeip.net> <20080116171616.085429BE9B@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.152]:24987 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbYAPTN1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jan 2008 14:13:27 -0500
Received: by po-out-1718.google.com with SMTP id y22so2934667pof.1
        for <linux-input@vger.kernel.org>; Wed, 16 Jan 2008 11:13:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080116171616.085429BE9B@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-input@vger.kernel.org

On Wed, Jan 16, 2008 at 09:16:16AM -0800, David Brownell wrote:
> > Date: Wed, 16 Jan 2008 10:09:10 -0500
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >
> > On Sat, Jan 05, 2008 at 02:10:19PM -0800, David Brownell wrote:
> > > This updates the ads7846 driver to handle external vREF (required
> > > on boards using ads7843 chips) without module parameters, and also
> > > removes a needless variable with its associated bogus gcc warning.
> >
> > Is there any concern about people already using this module parameter
> > in the field?
> 
> Users of ads7846 chips mostly won't need it; they use the internal vREF.
> 
> Users of ads7843 chips tend to not provide it (given the debug messages
> I periodically see!), and accordingly don't get the two general purpose
> ADC channels (via hwmon).  There aren't many ads7843 users yet; mostly
> users of two Atmel devel boards.

OK.

> 
> 
> >    Should it still be present to allow users to override
> > platform default?
> 
> There *is* no platform default ... there'd be a board-specific
> value (e.g. "3.3V" or "2.8V") that makes no sense to ever change,
> since it's hard-wired.  If there's no such value, those two ADC
> channels just won't be available.
> 
> I'd really rather just get rid of it.  The module param is hardly
> used, and doing it that way has always been a hack.  None of the
> other board-specific values use that error-prone mechanism.
> 

OK, fair enough. Queued for 2.6.25.

Thank you Dave.

-- 
Dmitry
