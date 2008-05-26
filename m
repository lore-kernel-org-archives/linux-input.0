From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: i8042 resume timing
Date: Mon, 26 May 2008 12:35:19 -0400
Message-ID: <200805261235.20588.dtor@insightbb.com>
References: <Pine.LNX.4.64.0805261509250.6718@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qmta09.emeryville.ca.mail.comcast.net ([76.96.30.96]:39599 "EHLO
	QMTA09.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754723AbYEZQfb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 May 2008 12:35:31 -0400
In-Reply-To: <Pine.LNX.4.64.0805261509250.6718@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, hschaa@novell.com

Hi Jiri,

On Monday 26 May 2008 09:19, Jiri Kosina wrote:
> Hi Dmitry,
> 
> There are systems [1] that fail in i8042_resume(), as 
> i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR) call returns error (not sure 
> about the exact error yet, the reporter didn't yet collect i8042.debug 
> output during the failure, as it is not completely reproducible), but 
> retrying after small amount of time succeeds.
> 
> Looks like a buggy hardware to me, which we should workaround. Would you 
> prefer DMI-based match for this retry logic with respect to CTR register 
> on the resume path, or would you accept this as a general retry logic on 
> resume path? (which is very probably not needed on vast majority of 
> systems though).


I think just retrying a couple of times in case of failure is the most
sensible thing to do.

Thanks.

-- 
Dmitry
