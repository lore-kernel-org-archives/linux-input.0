From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: egalax_ts: optmize driver for more fluency touch
 feelling
Date: Mon, 12 Dec 2011 00:34:15 -0800
Message-ID: <20111212083415.GH4682@core.coreip.homeip.net>
References: <1323249002-28397-1-git-send-email-jiejing.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43017 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab1LLIeV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Dec 2011 03:34:21 -0500
Received: by iaeh11 with SMTP id h11so2873331iae.19
        for <linux-input@vger.kernel.org>; Mon, 12 Dec 2011 00:34:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323249002-28397-1-git-send-email-jiejing.zhang@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhang Jiejing <jiejing.zhang@freescale.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Hi Zhang,

On Wed, Dec 07, 2011 at 05:10:02PM +0800, Zhang Jiejing wrote:
> egalax_ts use threaded_irq to report touch event, it will wake up the
> irq thread and stop the thread irq after process one touch event, so
> even user touch the screen very fast, the fastest event report speed
> is depends on the scheduler, so the event reported is a uniform speed.

I am not sure what you mean by "the event reported is a uniform speed"
but since I2C operations generally sleep you are at the mercy of
scheduler anyways. But since IRQ thread is a real-time one it should get
scheduled immediately.

> 
> This patch will let thread irq check the gpio's status, if the gpio
> is down, means still have more events, it will not exit the irq handler
> and continue process another new event, it can improve user experience.

Does it really or it is your opinion that it would?

Also, your change means that the driver can not be stopped/unloaded as
long as user had finger on the touchpad. This would need to be corrected
(but first you need to prove that the change is actually needed).

Thanks.

-- 
Dmitry
