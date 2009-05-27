From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] usb1400_ts: fix access to "device data" in resume
	function
Date: Wed, 27 May 2009 06:28:21 -0700
Message-ID: <20090527132821.GA3741@dtor-d630.eng.vmware.com>
References: <20090526170440.GA4993@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:36026 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760642AbZE0N3J (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 May 2009 09:29:09 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1454307rvb.1
        for <linux-input@vger.kernel.org>; Wed, 27 May 2009 06:29:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090526170440.GA4993@www.tglx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Manuel Traut <manut@linutronix.de>, linux-input@vger.kernel.org, Marek Vasiut <marek.vasut@gmail.com>

On Tue, May 26, 2009 at 07:04:40PM +0200, Sebastian Andrzej Siewior wrote:
> From: Manuel Traut <manut@linutronix.de>
> 
> platform_data != driver_data
> 
> driver data is actually the "correct" place of the struct however it is
> not placed there due to the need of the ac97 struct. This is broken since
> d9105c2b01 aka "[ARM] 5184/1: Split ucb1400_ts into core and touchscreen"
> 
> Signed-off-by: Manuel Traut <manut@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied, to 'for-linus' branch, thank you Sebastian.

> ---
> This is suspend/resume tested.
> What happend actually to [0]? It is not merged.
> 
> [0] http://markmail.org/message/cp5koxmiotxrf4xl

Just applied it to my 'next' branch.

-- 
Dmitry
