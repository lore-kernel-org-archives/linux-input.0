From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Mon, 10 Oct 2011 23:05:34 +0200
Message-ID: <20111010210534.GA2223@polaris.bitmath.org>
References: <1318261630-24044-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:47152 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab1JJU6t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 16:58:49 -0400
Received: from iph4.telenor.se (iph4.telenor.se [195.54.127.135])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id 35803EAAA6
	for <linux-input@vger.kernel.org>; Mon, 10 Oct 2011 22:58:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318261630-24044-1-git-send-email-mjg@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-input@vger.kernel.org, dtor@mail.ru

Hi Matthew,

> The bcm5974 code takes a USB autosuspend reference on device open and
> releases it on device close. This means that the hardware won't sleep when
> anything holds it open. This is sensible for input devices that don't
> support remote wakeups on normal use (like most mice), but this hardware
> trigger wakeups on touch and so can suspend transparently to the user. Doing
> so allows the USB host controller to sleep when the machine is idle, giving
> measurable power savings.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
> 
> Correctly flag needs_remote_wake.

With this patch, autosuspend seems to work correctly after boot, while
keeping a device file open. When all device files are closed, the
looping suspend/resume behavior is still there. Moreover, when coming
back from a user suspend, rpm_suspend fails with EBUSY on my machine,
and the device will not autosuspend thereafter.

IOW, getting closer, but still no cigar, sorry.

Cheers,
Henrik
