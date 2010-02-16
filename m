From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: polldev can cause crash in case of polling
 disabled
Date: Tue, 16 Feb 2010 09:50:47 -0800
Message-ID: <20100216175047.GB15376@core.coreip.homeip.net>
References: <1266331481-2094-1-git-send-email-samu.p.onkalo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38711 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933024Ab0BPRvK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2010 12:51:10 -0500
Received: by vws8 with SMTP id 8so370052vws.19
        for <linux-input@vger.kernel.org>; Tue, 16 Feb 2010 09:51:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1266331481-2094-1-git-send-email-samu.p.onkalo@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: linux-input@vger.kernel.org

Hi Samu,

On Tue, Feb 16, 2010 at 04:44:41PM +0200, Samu Onkalo wrote:
> If polling is set to disabled value and polled input device
> is opened and closed several times, address to workqueue will probably
> change at some point. Since nothing is queued (due to polled disabled
> state), content of the work struct contains pointer to the old and non-existent
> workqueue.

This I do not quite understand. The work struct as far as I can see does
not reference workqueue at all. There is a list entry but if we do not
poll the device that entry should be always detached from any lists. We
properly initialize WQ entry when we create the device and it shoudl
remain valid until the device is destroyed.

> When the device is closed again, cancel_delayed_work_sync
> goes crazy due to pointer to nonexisting workqueue.
> 

What kind of failure do you see? Is there a stack trace or something?

> In case on disabled polling, init work struct to initial value to
> clean up the old values.
> 

Also, why would not we see the same issue with enabled polling? The
workqueue is being created and destroyed in this case as well.

Thanks.

-- 
Dmitry
