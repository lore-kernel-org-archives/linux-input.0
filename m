From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH resend] input/spear-keyboard fix: return IRQ_NONE if
 (status reg & DATA_AVAIL)
Date: Wed, 30 Mar 2011 22:34:03 -0700
Message-ID: <20110331053402.GC31630@core.coreip.homeip.net>
References: <1301313546-24420-1-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40893 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab1CaFfA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Mar 2011 01:35:00 -0400
Received: by iwn34 with SMTP id 34so2018569iwn.19
        for <linux-input@vger.kernel.org>; Wed, 30 Mar 2011 22:35:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1301313546-24420-1-git-send-email-rajeev-dlh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shiraz.hashim@st.com, armando.visconti@st.com, viresh.kumar@st.com, amit.goel@st.com

On Mon, Mar 28, 2011 at 05:29:06PM +0530, Rajeev Kumar wrote:
> We should return IRQ_NONE from interrupt handler in case data is not
> avail for keyboard
> 

Applied, thank you Rajeev.

> Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> ---
>  drivers/input/keyboard/spear-keyboard.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
> index f18dc67..c6ab1df 100644
> --- a/drivers/input/keyboard/spear-keyboard.c
> +++ b/drivers/input/keyboard/spear-keyboard.c
> @@ -70,7 +70,7 @@ static irqreturn_t spear_kbd_interrupt(int irq, void *dev_id)
>  	u8 sts, val;
>  
>  	sts = readb(kbd->io_base + STATUS_REG);
> -	if (sts & DATA_AVAIL)
> +	if (!(sts & DATA_AVAIL))
>  		return IRQ_NONE;
>  
>  	if (kbd->last_key != KEY_RESERVED) {
> -- 
> 1.6.0.2
> 

-- 
Dmitry
