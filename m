From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v9 9/9] Input: goodix - sort includes using inverse Xmas
 tree order
Date: Mon, 12 Oct 2015 16:39:16 +0100
Message-ID: <20151012153916.GF7452@leverpostej>
References: <1444663477-30062-1-git-send-email-irina.tirdea@intel.com>
 <1444663477-30062-10-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444663477-30062-10-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Why?

Mark.

On Mon, Oct 12, 2015 at 06:24:37PM +0300, Irina Tirdea wrote:
> Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Tested-by: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
> Tested-by: Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/input/touchscreen/goodix.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index b958b37..22bfc4b 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -14,21 +14,22 @@
>   * Software Foundation; version 2 of the License.
>   */
>  
> -#include <linux/kernel.h>
> -#include <linux/dmi.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/interrupt.h>
>  #include <linux/firmware.h>
> -#include <linux/gpio.h>
> -#include <linux/i2c.h>
> -#include <linux/input.h>
>  #include <linux/input/mt.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
> -#include <linux/irq.h>
> -#include <linux/interrupt.h>
> -#include <linux/slab.h>
> +#include <linux/input.h>
>  #include <linux/acpi.h>
> +#include <linux/gpio.h>
> +#include <linux/slab.h>
> +#include <linux/dmi.h>
> +#include <linux/i2c.h>
> +#include <linux/irq.h>
>  #include <linux/of.h>
> -#include <linux/pm_runtime.h>
> +
>  #include <asm/unaligned.h>
>  
>  struct goodix_ts_data {
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
