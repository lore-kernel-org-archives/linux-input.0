From: Jiri Kosina <jkosina@suse.cz>
Subject: i8042 resume timing
Date: Mon, 26 May 2008 15:19:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0805261509250.6718@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:60014 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751697AbYEZNTD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 May 2008 09:19:03 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, hschaa@novell.com

Hi Dmitry,

There are systems [1] that fail in i8042_resume(), as 
i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR) call returns error (not sure 
about the exact error yet, the reporter didn't yet collect i8042.debug 
output during the failure, as it is not completely reproducible), but 
retrying after small amount of time succeeds.

Looks like a buggy hardware to me, which we should workaround. Would you 
prefer DMI-based match for this retry logic with respect to CTR register 
on the resume path, or would you accept this as a general retry logic on 
resume path? (which is very probably not needed on vast majority of 
systems though).

Thanks.

[1] https://bugzilla.novell.com/show_bug.cgi?id=351119

-- 
Jiri Kosina
SUSE Labs
