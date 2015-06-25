From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] i8042: Add debug_kbd option
Date: Thu, 25 Jun 2015 13:00:11 -0700
Message-ID: <1435262411.9377.42.camel@perches.com>
References: <1435260310-10074-1-git-send-email-cpaul@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0028.hostedemail.com ([216.40.44.28]:48402 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751469AbbFYUAP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Jun 2015 16:00:15 -0400
In-Reply-To: <1435260310-10074-1-git-send-email-cpaul@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: cpaul@redhat.com
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>

On Thu, 2015-06-25 at 15:25 -0400, cpaul@redhat.com wrote:
> From: Stephen Chandler Paul <cpaul@redhat.com>
> 
> A big problem with the current i8042 debugging option is that it outputs
> data going to and from the keyboard by default. As a result, many dmesg
> logs uploaded by users will unintentionally contain sensitive information
> such as their password, as such it's probably a good idea not to output
> data coming from the keyboard unless specifically enabled by the user.

Seems sensible.  Coupla trivial bits:

> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
[]
> @@ -88,6 +88,23 @@ MODULE_PARM_DESC(nopnp, "Do not use PNP to detect controller settings");
>  static bool i8042_debug;
>  module_param_named(debug, i8042_debug, bool, 0600);
>  MODULE_PARM_DESC(debug, "Turn i8042 debugging mode on and off");
> +
> +static bool i8042_debug_kbd;
> +module_param_named(debug_kbd, i8042_debug_kbd, bool, 0600);
> +MODULE_PARM_DESC(i8042_kbd, "Turn i8042 kbd debugging output on or off");

It's unclear this depends on i8042_debug.
Maybe add something like " (enabling requires i8042_debug=1)"

> +#define str_dbg(str, data, format, args...)			\
> +	do {							\
> +		if (!i8042_debug)				\
> +			break;					\
> +								\
> +		if (str & I8042_STR_AUXDATA || i8042_debug_kbd)	\
> +			dbg("%02x " format, data, ##args);	\
> +		else						\
> +			dbg("** " format, ##args);		\
> +	} while (0)
> +#else
> +#define str_dbg(str, data, format, args...) do { } while (0)
>  #endif

This should probably go into i8042.h
where the dbg macro is #defined


