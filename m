From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Fix poor prox handling in 'wacom_pl_irq'
Date: Thu, 26 Jan 2017 21:52:30 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701262152200.25515@cbobk.fhfr.pm>
References: <20170126170622.6760-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46427 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753423AbdAZVD6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 26 Jan 2017 16:03:58 -0500
In-Reply-To: <20170126170622.6760-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Thu, 26 Jan 2017, Jason Gerecke wrote:

> Commit 025bcc1 performed cleanup work on the 'wacom_pl_irq' function, making
> it follow the standards used in the rest of the codebase. The change
> unintiontionally allowed the function to send input events from reports
> that are not marked as being in prox. This can cause problems as the
> report values for X, Y, etc. are not guaranteed to be correct. In
> particular, occasionally the tablet will send a report with these values
> set to zero. If such a report is received it can caus an unexpected jump
> in the XY position.
> 
> This patch surrounds more of the processing code with a proximity check,
> preventing these zeroed reports from overwriting the current state. To
> be safe, only the tool type and ABS_MISC events should be reported when
> the pen is marked as being out of prox.
> 
> Fixes: 025bcc1540 ("HID: wacom: Simplify 'wacom_pl_irq'")
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

