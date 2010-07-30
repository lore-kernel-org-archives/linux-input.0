From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 1/4] irq: Add new IRQ flag IRQF_NO_SUSPEND
Date: Fri, 30 Jul 2010 20:29:38 +1000
Message-ID: <1280485778.1902.9.camel@pasglop>
References: <1280398573.24292.1684.camel@zakaz.uk.xensource.com>
	<1280398595-29708-1-git-send-email-ian.campbell@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1280398595-29708-1-git-send-email-ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>
Cc: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>, xen-devel-GuqFBffKawuULHF6PoxzQEEOCMrvLtNR@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, 2010-07-29 at 11:16 +0100, Ian Campbell wrote:
> A small number of users of IRQF_TIMER are using it for the implied no
> suspend behaviour on interrupts which are not timer interrupts.
> 
> Therefore add a new IRQF_NO_SUSPEND flag, rename IRQF_TIMER to
> __IRQF_TIMER and redefine IRQF_TIMER in terms of these new flags.
> 
> Signed-off-by: Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>
> Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> Cc: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
> Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> Cc: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: xen-devel-GuqFBffKawuULHF6PoxzQEEOCMrvLtNR@public.gmane.org
> Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> ---
>  include/linux/interrupt.h |    7 ++++++-
>  kernel/irq/manage.c       |    2 +-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index c233113..a0384a4 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -53,16 +53,21 @@
>   * IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler finished.
>   *                Used by threaded interrupts which need to keep the
>   *                irq line disabled until the threaded handler has been run.
> + * IRQF_NO_SUSPEND - Do not disable this IRQ during suspend
> + *
>   */
>  #define IRQF_DISABLED		0x00000020
>  #define IRQF_SAMPLE_RANDOM	0x00000040
>  #define IRQF_SHARED		0x00000080
>  #define IRQF_PROBE_SHARED	0x00000100
> -#define IRQF_TIMER		0x00000200
> +#define __IRQF_TIMER		0x00000200
>  #define IRQF_PERCPU		0x00000400
>  #define IRQF_NOBALANCING	0x00000800
>  #define IRQF_IRQPOLL		0x00001000
>  #define IRQF_ONESHOT		0x00002000
> +#define IRQF_NO_SUSPEND		0x00004000
> +
> +#define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND)
>  
>  /*
>   * Bits used by threaded handlers:
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index e149748..c3003e9 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -216,7 +216,7 @@ static inline int setup_affinity(unsigned int irq, struct irq_desc *desc)
>  void __disable_irq(struct irq_desc *desc, unsigned int irq, bool suspend)
>  {
>  	if (suspend) {
> -		if (!desc->action || (desc->action->flags & IRQF_TIMER))
> +		if (!desc->action || (desc->action->flags & IRQF_NO_SUSPEND))
>  			return;
>  		desc->status |= IRQ_SUSPENDED;
>  	}
