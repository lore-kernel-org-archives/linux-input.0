From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Thu, 13 Oct 2011 10:20:16 +0200
Message-ID: <20111013082016.GA2209@polaris.bitmath.org>
References: <20111012183306.GA10397@polaris.bitmath.org>
 <Pine.LNX.4.44L0.1110121518510.2093-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:47303 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab1JMINQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Oct 2011 04:13:16 -0400
Received: from iph5.telenor.se (iph5.telenor.se [195.54.127.136])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 642EAE9EFC
	for <linux-input@vger.kernel.org>; Thu, 13 Oct 2011 10:13:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1110121518510.2093-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Oliver Neukum <oliver@neukum.org>, linux-input@vger.kernel.org, dtor@mail.ru

> It's always a bug.  However, the patch I sent to Matthew should fix the 
> immediate problem.
> 
> In fact, the original autosuspend design intended to allow drivers to 
> do this -- keep devices awake by failing suspend requests even though 
> the usage count is 0.  Under some conditions, that's the approach with 
> the least overhead.  But the code to handle this got lost by mistake, 
> so now it needs to be added back.

I tried the patch out, unfortunately it did not work. The second
suspend request returns with a -EINPROGRESS, here:

	if (dev->power.runtime_status == RPM_SUSPENDING) {
		DEFINE_WAIT(wait);

		if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
			retval = -EINPROGRESS;
			goto out;
		}

		/* Wait for the other suspend running in parallel with us. */
		for (;;) {

The reason is above my horizon, although RPM_ASYNC looks suspicious.
In general, we are re-entering rpm_suspend from within the driver
handler, so the exit condition of rpm_suspend may not have been
satisfied yet.

Thanks,
Henrik
