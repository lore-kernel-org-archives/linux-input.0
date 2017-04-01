From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: cros_ec_keyb: Add an EC event for sysrq
Date: Sat, 1 Apr 2017 10:16:27 -0700
Message-ID: <20170401171627.GJ17130@dtor-ws>
References: <20170330221807.2983-1-rajatja@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35998 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbdDARQa (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Apr 2017 13:16:30 -0400
Content-Disposition: inline
In-Reply-To: <20170330221807.2983-1-rajatja@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com, dtor@google.com

On Thu, Mar 30, 2017 at 03:18:07PM -0700, Rajat Jain wrote:
> Some form factors (detachables / tablets) may not have a keyboard and
> thus user may have to resort to using a defined EC UI to send sysrq(s)
> to the kernel in order to collect crash info etc. This UI typically
> is in the form of user pressing volume / power buttons in some specific
> sequence and for some specific time. Add a new EC event that allows EC
> to communicate the sysrq to the AP.
> 
> (We're skipping event number 5 because it has been reserved for
> something else)
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

Lee, is it OK to route through my tree or you want to take it?

> ---
>  drivers/input/keyboard/cros_ec_keyb.c | 7 +++++++
>  include/linux/mfd/cros_ec_commands.h  | 4 ++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 6a250d65f8fe..00a3a830cd3a 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -30,6 +30,7 @@
>  #include <linux/notifier.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/sysrq.h>
>  #include <linux/input/matrix_keypad.h>
>  #include <linux/mfd/cros_ec.h>
>  #include <linux/mfd/cros_ec_commands.h>
> @@ -260,6 +261,12 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>  				     ckdev->ec->event_size);
>  		break;
>  
> +	case EC_MKBP_EVENT_SYSRQ:
> +		val = get_unaligned_le32(&ckdev->ec->event_data.data.sysrq);
> +		dev_dbg(ckdev->dev, "sysrq code from EC : %#x\n", val);
> +		handle_sysrq(val);
> +		break;
> +
>  	case EC_MKBP_EVENT_BUTTON:
>  	case EC_MKBP_EVENT_SWITCH:
>  		/*
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index f1ef6388c233..c93e7e0300ef 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -2041,6 +2041,9 @@ enum ec_mkbp_event {
>  	/* The state of the switches have changed. */
>  	EC_MKBP_EVENT_SWITCH = 4,
>  
> +	/* EC sent a sysrq command */
> +	EC_MKBP_EVENT_SYSRQ = 6,
> +
>  	/* Number of MKBP events */
>  	EC_MKBP_EVENT_COUNT,
>  };
> @@ -2053,6 +2056,7 @@ union ec_response_get_next_data {
>  
>  	uint32_t   buttons;
>  	uint32_t   switches;
> +	uint32_t   sysrq;
>  } __packed;
>  
>  struct ec_response_get_next_event {
> -- 
> 2.12.2.564.g063fe858b8-goog
> 

-- 
Dmitry
