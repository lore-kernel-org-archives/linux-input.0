From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 0/2] hid: sony: Clear and restore controller state on
 suspend and resume
Date: Thu, 19 Nov 2015 11:17:08 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511191116490.20111@pobox.suse.cz>
References: <1447253378-13939-1-git-send-email-frank.praznik@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40287 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758206AbbKSKRJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2015 05:17:09 -0500
In-Reply-To: <1447253378-13939-1-git-send-email-frank.praznik@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: linux-input@vger.kernel.org, ao2@ao2.it

On Wed, 11 Nov 2015, Frank Praznik wrote:

> On systems with standby power for charging devices the LEDs and rumble on the
> controller can continue to function even when the system is in standby since
> the state is not cleared when the system goes to sleep.
> 
> The state on wakeup can also differ from the state when the system entered
> standby as the LEDs can be cleared when the device is reset on wakeup.
> 
> The first patch refactors the output report functions to allow sending an
> output report without going through the work queue.  This is necessary when
> clearing the state of the controller before the system is goes into standby
> since the work might not be executed before the system goes to sleep.
> 
> The second patch implements the suspend and resume callbacks which serializes
> and clears the LEDs on suspend and restores them on resume.
> 
> Force-feedback is cleared on suspend but the state is not restored on resume
> since it can potentially result in hardware damage if the device is unattended
> when the system wakes.  A new event will be required to resume force-feedback.

Applied to for-4.5/sony. Thanks Frank,

-- 
Jiri Kosina
SUSE Labs

