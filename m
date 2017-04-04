From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/5] Input: pm8xxx-vib: reorder header alphabetically
Date: Tue, 4 Apr 2017 16:31:25 -0700
Message-ID: <20170404233125.GA19744@dtor-ws>
References: <20170404154153.19901-1-damien.riegel@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35756 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbdDDXb3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Apr 2017 19:31:29 -0400
Received: by mail-pg0-f68.google.com with SMTP id g2so39873243pge.2
        for <linux-input@vger.kernel.org>; Tue, 04 Apr 2017 16:31:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170404154153.19901-1-damien.riegel@savoirfairelinux.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kernel@savoirfairelinux.com

On Tue, Apr 04, 2017 at 11:41:49AM -0400, Damien Riegel wrote:
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>

Applied the lot, thank you.

> ---
>  drivers/input/misc/pm8xxx-vibrator.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
> index 5113877153d7..580448170342 100644
> --- a/drivers/input/misc/pm8xxx-vibrator.c
> +++ b/drivers/input/misc/pm8xxx-vibrator.c
> @@ -10,13 +10,13 @@
>   * GNU General Public License for more details.
>   */
>  
> -#include <linux/module.h>
> -#include <linux/kernel.h>
>  #include <linux/errno.h>
> -#include <linux/platform_device.h>
>  #include <linux/input.h>
> -#include <linux/slab.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/slab.h>
>  
>  #define VIB_DRV			0x4A
>  
> -- 
> 2.12.1
> 

-- 
Dmitry
