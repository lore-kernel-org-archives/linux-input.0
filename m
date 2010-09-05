From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH v2 4/6 RESEND] ARM: pxa27x_keypad: added wakeup event
 handler	for keypad interrupts
Date: Sun, 05 Sep 2010 11:02:35 +0300
Message-ID: <4C834E9B.5080505@compulab.co.il>
References: <1283552891-13966-1-git-send-email-mark.brown314@gmail.com> <1283552891-13966-5-git-send-email-mark.brown314@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:48574 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753189Ab0IEICm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 5 Sep 2010 04:02:42 -0400
In-Reply-To: <1283552891-13966-5-git-send-email-mark.brown314@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Mark F. Brown" <mark.brown314@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

 On 09/04/10 01:28, Mark F. Brown wrote:
> mach-mmp needs to clear wake event in order to clear the keypad interrupt
>
> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
> ---
>  arch/arm/plat-pxa/include/plat/pxa27x_keypad.h |    1 +
>  drivers/input/keyboard/pxa27x_keypad.c         |   10 ++++++++++
>  2 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
> index 7b4eadc..73dacda 100644
> --- a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
> +++ b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
> @@ -52,6 +52,7 @@ struct pxa27x_keypad_platform_data {
>  
>  	/* key debounce interval */
>  	unsigned int	debounce_interval;
> +	void		(*clear_wakeup_event)(void);

I understand, this is a bit late... but still I want to ask a question:
As I understand, the clear_wakeup_event() function is called in interrupt context,
wouldn't it be wiser to add a comment on this, so platform (current/future) code
will be aware and will make no heavy stuff in it (accidentally).

>  };
>  
>  extern void pxa_set_keypad_info(struct pxa27x_keypad_platform_data *info);
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
> index 0610d10..b36d2be 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -330,11 +330,21 @@ static void pxa27x_keypad_scan_direct(struct pxa27x_keypad *keypad)
>  	keypad->direct_key_state = new_state;
>  }
>  
> +static void clear_wakeup_event(struct pxa27x_keypad *keypad)
> +{
> +	struct pxa27x_keypad_platform_data *pdata = keypad->pdata;
> +
> +	if (pdata->clear_wakeup_event)
> +		(pdata->clear_wakeup_event)();
> +}
> +
>  static irqreturn_t pxa27x_keypad_irq_handler(int irq, void *dev_id)
>  {
>  	struct pxa27x_keypad *keypad = dev_id;
>  	unsigned long kpc = keypad_readl(KPC);
>  
> +	clear_wakeup_event(keypad);
> +
>  	if (kpc & KPC_DI)
>  		pxa27x_keypad_scan_direct(keypad);
>  

-- 
Regards,
Igor.

