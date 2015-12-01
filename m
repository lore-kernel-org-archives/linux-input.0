From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] hid: usbhid: hid-core: fix recursive deadlock
Date: Tue, 1 Dec 2015 17:36:17 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1512011736030.32500@pobox.suse.cz>
References: <1447874755-8673-1-git-send-email-adi@adirat.com> <1448050742-10777-1-git-send-email-adi@adirat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51381 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754713AbbLAQgT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Dec 2015 11:36:19 -0500
In-Reply-To: <1448050742-10777-1-git-send-email-adi@adirat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ioan-Adrian Ratiu <adi@adirat.com>
Cc: pinglinux@gmail.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, joshc@ni.com

On Fri, 20 Nov 2015, Ioan-Adrian Ratiu wrote:

> The critical section protected by usbhid->lock in hid_ctrl() is too
> big and because of this it causes a recursive deadlock. "Too big" means
> the case statement and the call to hid_input_report() do not need to be
> protected by the spinlock (no URB operations are done inside them).
> 
> The deadlock happens because in certain rare cases drivers try to grab
> the lock while handling the ctrl irq which grabs the lock before them
> as described above. For example newer wacom tablets like 056a:033c try
> to reschedule proximity reads from wacom_intuos_schedule_prox_event()
> calling hid_hw_request() -> usbhid_request() -> usbhid_submit_report()
> which tries to grab the usbhid lock already held by hid_ctrl().
> 
> There are two ways to get out of this deadlock:
>     1. Make the drivers work "around" the ctrl critical region, in the
>     wacom case for ex. by delaying the scheduling of the proximity read
>     request itself to a workqueue.
>     2. Shrink the critical region so the usbhid lock protects only the
>     instructions which modify usbhid state, calling hid_input_report()
>     with the spinlock unlocked, allowing the device driver to grab the
>     lock first, finish and then grab the lock afterwards in hid_ctrl().
> 
> This patch implements the 2nd solution.
> 
> Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com>

Applied to for-4.5/core branch. Thanks,

-- 
Jiri Kosina
SUSE Labs

