From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v5 1/9] Input: goodix - sort includes alphabetically
Date: Wed, 09 Sep 2015 18:58:00 +0200
Message-ID: <1441817880.27328.27.camel@hadess.net>
References: <1441636583-14188-1-git-send-email-irina.tirdea@intel.com>
	 <1441636583-14188-2-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441636583-14188-2-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 2015-09-07 at 17:36 +0300, Irina Tirdea wrote:
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>

Acked-by: Bastien Nocera <hadess@hadess.net>

> ---
>  drivers/input/touchscreen/goodix.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c
> b/drivers/input/touchscreen/goodix.c
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
