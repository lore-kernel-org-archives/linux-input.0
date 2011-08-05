From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Remove CLOCK_TICK_RATE from analog joystick driver
Date: Thu, 4 Aug 2011 23:40:25 -0700
Message-ID: <20110805064025.GA31974@core.coreip.homeip.net>
References: <20110804000640.GC23503@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:43557 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab1HEGkc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Aug 2011 02:40:32 -0400
Received: by iye16 with SMTP id 16so3090401iye.1
        for <linux-input@vger.kernel.org>; Thu, 04 Aug 2011 23:40:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110804000640.GC23503@plexity.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dsaxena@plexity.net
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-input@vger.kernel.org

On Wed, Aug 03, 2011 at 05:06:40PM -0700, Deepak Saxena wrote:
> The analog joystick driver is written for x86 systems. This
> patch updates it to use the the PIT_TICK_RATE value instead
> of CLOCK_TICK_RATE as they are equivalent on x86 and we 
> want to depecrate the later.
> 
> Signed-off-by: Deepak Saxena <dsaxena@linaro.org>

Applied, thank you Deepak.

> ---
>  drivers/input/joystick/analog.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
> index 9882971..358cd7e 100644
> --- a/drivers/input/joystick/analog.c
> +++ b/drivers/input/joystick/analog.c
> @@ -139,7 +139,7 @@ struct analog_port {
>  #include <linux/i8253.h>
>  
>  #define GET_TIME(x)	do { if (cpu_has_tsc) rdtscl(x); else x = get_time_pit(); } while (0)
> -#define DELTA(x,y)	(cpu_has_tsc ? ((y) - (x)) : ((x) - (y) + ((x) < (y) ? CLOCK_TICK_RATE / HZ : 0)))
> +#define DELTA(x,y)	(cpu_has_tsc ? ((y) - (x)) : ((x) - (y) + ((x) < (y) ? PIT_TICK_RATE / HZ : 0)))
>  #define TIME_NAME	(cpu_has_tsc?"TSC":"PIT")
>  static unsigned int get_time_pit(void)
>  {
> -- 
> 1.7.4.1
> 

-- 
Dmitry
