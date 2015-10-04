From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 1/9] Input: goodix - sort includes alphabetically
Date: Sun, 4 Oct 2015 21:46:32 +0200
Message-ID: <20151004194632.GA27633@xo-6d-61-c0.localdomain>
References: <1441636583-14188-1-git-send-email-irina.tirdea@intel.com>
 <1441636583-14188-2-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58271 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbbJDTqn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Oct 2015 15:46:43 -0400
Content-Disposition: inline
In-Reply-To: <1441636583-14188-2-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Mon 2015-09-07 17:36:15, Irina Tirdea wrote:
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> ---
>  drivers/input/touchscreen/goodix.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Don't.

Yes, we sometimes sort includes... to avoid patch rejects.

This is guaranteed to cause rejects.

If we do sort them, we use "longest-first" usually.

> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index e36162b..6ae28c5 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -14,18 +14,18 @@
>   * Software Foundation; version 2 of the License.
>   */
>  
> -#include <linux/kernel.h>
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
>  #include <linux/dmi.h>
>  #include <linux/i2c.h>
>  #include <linux/input.h>
>  #include <linux/input/mt.h>
> -#include <linux/module.h>
> -#include <linux/delay.h>
> -#include <linux/irq.h>
>  #include <linux/interrupt.h>
> -#include <linux/slab.h>
> -#include <linux/acpi.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/slab.h>
>  #include <asm/unaligned.h>
>  
>  struct goodix_ts_data {
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
