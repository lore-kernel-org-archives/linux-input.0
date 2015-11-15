From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH v2 0/2] hid: sony: Clear and restore controller state on
 suspend and resume
Date: Sun, 15 Nov 2015 16:30:49 +0100
Message-ID: <20151115163049.a5dc8380db1280ca1532f112@ao2.it>
References: <1447253378-13939-1-git-send-email-frank.praznik@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:21247 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbbKOPaz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Nov 2015 10:30:55 -0500
In-Reply-To: <1447253378-13939-1-git-send-email-frank.praznik@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

On Wed, 11 Nov 2015 09:49:36 -0500
Frank Praznik <frank.praznik@gmail.com> wrote:

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
> 

Hi Frank, the changes are basically OK, but there are warnings and
errors from scripts/checkpatch.pl

Would you care to send a v3 which fixes those?

Thanks a lot,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
