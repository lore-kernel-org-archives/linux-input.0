From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/6] input/spear_keyboard: fix clock handling during
 suspend/resume
Date: Sat, 7 Jul 2012 18:11:55 -0700
Message-ID: <20120708011155.GE19007@core.coreip.homeip.net>
References: <1341211814-15173-1-git-send-email-shiraz.hashim@st.com>
 <1341211814-15173-2-git-send-email-shiraz.hashim@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33831 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab2GHBMA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Jul 2012 21:12:00 -0400
Received: by pbbrp8 with SMTP id rp8so17017095pbb.19
        for <linux-input@vger.kernel.org>; Sat, 07 Jul 2012 18:12:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1341211814-15173-2-git-send-email-shiraz.hashim@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shiraz Hashim <shiraz.hashim@st.com>
Cc: spear-devel@list.st.com, linux-input@vger.kernel.org

Hi Shiraz,

On Mon, Jul 02, 2012 at 12:20:10PM +0530, Shiraz Hashim wrote:
> SPEAr keyboard should normally disable clock during suspend and enable it
> during resume.
> 
> For cases where it is expected to act as a wakeup source the clock can
> remain in the same state i.e. kept enabled if it is being used.
> 
> Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
> ---
>  drivers/input/keyboard/spear-keyboard.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
> index 67d9afb..ef147f3 100644
> --- a/drivers/input/keyboard/spear-keyboard.c
> +++ b/drivers/input/keyboard/spear-keyboard.c
> @@ -318,12 +318,12 @@ static int spear_kbd_suspend(struct device *dev)
>  
>  	mutex_lock(&input_dev->mutex);
>  
> -	if (input_dev->users)
> -		clk_enable(kbd->clk);
> -
>  	if (device_may_wakeup(&pdev->dev)) {
>  		if (!enable_irq_wake(kbd->irq))
>  			kbd->irq_wake = 1;
> +	} else {
> +		if (input_dev->users)
> +			clk_disable(kbd->clk);
>  	}

This patch does not apply to mainline version of the driver because the
change introducing handling for enable_irq_wake() failures was rejected
from mainline. I also have not appplied the 6th patch in the series
because it depends on this one.

Also, don't you need to enable clock if device is marked as wakeup
source but happens to have no active users?

Thanks.

-- 
Dmitry
