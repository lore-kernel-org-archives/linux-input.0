From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: WM97xx touchscreen updates
Date: Fri, 18 Apr 2008 00:48:45 -0400
Message-ID: <20080418044844.GA15686@anvil.corenet.prv>
References: <20080415144535.GA20619@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:6526 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbYDREs5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Apr 2008 00:48:57 -0400
Received: by yw-out-2324.google.com with SMTP id 5so265352ywb.1
        for <linux-input@vger.kernel.org>; Thu, 17 Apr 2008 21:48:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080415144535.GA20619@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Brownell <david-b@pacbell.net>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 15, 2008 at 03:45:35PM +0100, Mark Brown wrote:
> This patch series updates the WM97xx touchscreen drivers with a couple
> of small cleanups and the addition of support for use of the WM97xx
> touchpanels to wake up from suspend.  Since the last submission I have:
> 
>  - Updated the commit message for scheduling of the interrupt handler. 
>  - Hooked the touchscreen into the driver model wakeup infrastructure.
> 
> It is also available in the git repository at:
> 
>   git://opensource.wolfsonmicro.com/linux-2.6-touch upstream
> 
> Mark Brown (3):
>       wm97xx-core: Only schedule interrupt handler if not already scheduled
>       wm97xx-core: Use IRQF_SAMPLE_RANDOM
>       wm97xx-core: Support use as a wakeup source
> 
>  drivers/input/touchscreen/wm97xx-core.c |   56 ++++++++++++++++++++++++++----
>  include/linux/wm97xx.h                  |    3 ++
>  2 files changed, 51 insertions(+), 8 deletions(-)
> 

Applied the lot, thank you Mark.

-- 
Dmitry
