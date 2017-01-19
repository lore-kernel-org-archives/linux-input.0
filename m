From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Fix sibling detection broken by 345857b
Date: Thu, 19 Jan 2017 14:24:27 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701191422320.25515@cbobk.fhfr.pm>
References: <20170117233858.21546-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60427 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752364AbdASNoz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Jan 2017 08:44:55 -0500
In-Reply-To: <20170117233858.21546-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Tue, 17 Jan 2017, Jason Gerecke wrote:

> Commit 345857b included a change to the operation and location of the call
> to 'wacom_add_shared_data' in 'wacom_parse_and_register'. The modifications
> included moving it higher up so that it would occur before the call to
> 'wacom_retrieve_hid_descriptor'. This was done to prevent a crash that would
> have occured when the report containing tablet offsets was fed into the
> driver with 'wacom_hid_report_raw_event' (specifically: the various
> 'wacom_wac_*_report' functions were written with the assumption that they
> would only be called once tablet setup had completed; 'wacom_wac_pen_report'
> in particular dereferences 'shared' which wasn't yet allocated).
> 
> Moving the call to 'wacom_add_shared_data' effectively prevented the crash
> but also broke the sibiling detection code which assumes that the HID
> descriptor has been read and the various device_type flags set.
> 
> To fix this situation, we restore the original 'wacom_add_shared_data'
> operation and location and instead implement an alternative change that
> can also prevent the crash. Specifically, we notice that the report
> functions mentioned above expect to be called only for input reports.
> By adding a check, we can prevent feature reports (such as the offset
> report) from causing trouble.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> Tested-by: Ping Cheng <pingc@wacom.com>

I've added Fixes: tag and applied to for-4.10/upstream-fixes.

Thanks,

-- 
Jiri Kosina
SUSE Labs

