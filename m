From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [1/2] Revert "HID: multitouch: enable palm rejection if device
 implements confidence usage"
Date: Thu, 30 Jun 2016 09:39:44 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606300939070.6874@cbobk.fhfr.pm>
References: <1466670690-77458-1-git-send-email-allen_hung@dell.com> <57741413.5050009@dell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55386 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203AbcF3Hjq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jun 2016 03:39:46 -0400
In-Reply-To: <57741413.5050009@dell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Allen Hung <allen_hung@dell.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Wed, 29 Jun 2016, Mario Limonciello wrote:

> Would you also submit this to -stable? 
> I think it should be generally applicable at least a few releases back
> since Allen's original submit.

Both commits (already in Linus' tree as of today) contain the -stable 
kernel annotation.

-- 
Jiri Kosina
SUSE Labs

