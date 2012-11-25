From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] input: do not use tasklet_disable before tasklet_kill
Date: Sat, 24 Nov 2012 23:58:46 -0800
Message-ID: <20121125075846.GA21091@core.coreip.homeip.net>
References: <1351670761-26749-1-git-send-email-xtfeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351670761-26749-1-git-send-email-xtfeng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiaotian Feng <xtfeng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Xiaotian Feng <dannyfeng@tencent.com>, Tony Lindgren <tony@atomide.com>, Sourav Poddar <sourav.poddar@ti.com>, Josh <joshua.taylor0@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Xiaotian,

On Wed, Oct 31, 2012 at 04:05:59PM +0800, Xiaotian Feng wrote:
> If tasklet_disable() is called before related tasklet handled,
> tasklet_kill will never be finished. tasklet_kill is enough.
> 

Could you please elaborate on this? Needing to disable tasket before
killing it is quite often needed when dealing with self-rescheduling
tasklets and so tasklet_disable() followed by tasklet_kill() must work.
If it does not we need to take care of it in softirq code instead of
individual drivers.

> Signed-off-by: Xiaotian Feng <dannyfeng@tencent.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Sourav Poddar <sourav.poddar@ti.com>
> Cc: Josh <joshua.taylor0@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-input@vger.kernel.org
> ---
>  drivers/input/keyboard/omap-keypad.c |    3 +--
>  drivers/input/serio/hil_mlc.c        |    1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
> index 4a5fcc8..6c52447 100644
> --- a/drivers/input/keyboard/omap-keypad.c
> +++ b/drivers/input/keyboard/omap-keypad.c
> @@ -362,12 +362,11 @@ static int __devexit omap_kp_remove(struct platform_device *pdev)
>  	struct omap_kp *omap_kp = platform_get_drvdata(pdev);
>  
>  	/* disable keypad interrupt handling */
> -	tasklet_disable(&kp_tasklet);
> +	tasklet_kill(&kp_tasklet);
>  	omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
>  	free_irq(omap_kp->irq, omap_kp);
>  
>  	del_timer_sync(&omap_kp->timer);
> -	tasklet_kill(&kp_tasklet);

Exactly like here. If we do not disable tasklet before disabling IRQ and
freeing timer we may get into scenario when timer schedules tasket and
tasklet schedules timer again after we canceled it.

>  
>  	/* unregister everything */
>  	input_unregister_device(omap_kp->input);
> diff --git a/drivers/input/serio/hil_mlc.c b/drivers/input/serio/hil_mlc.c
> index bfd3865..7fc1700 100644
> --- a/drivers/input/serio/hil_mlc.c
> +++ b/drivers/input/serio/hil_mlc.c
> @@ -1011,7 +1011,6 @@ static void __exit hil_mlc_exit(void)
>  {
>  	del_timer_sync(&hil_mlcs_kicker);
>  
> -	tasklet_disable(&hil_mlcs_tasklet);
>  	tasklet_kill(&hil_mlcs_tasklet);

This seems like safe change.

Thanks.

-- 
Dmitry
