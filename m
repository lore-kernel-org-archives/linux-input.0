From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 10/17] input/joystick/analog: Switch from rdtscl() to
 native_read_tsc()
Date: Tue, 16 Jun 2015 16:03:57 -0700
Message-ID: <20150616230357.GC17610@dtor-ws>
References: <cover.1434152603.git.luto@kernel.org>
 <0c3efbd7b70f76c5dea1d6a9958566cd5fb4a4da.1434152603.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:36700 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbbFPXEC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jun 2015 19:04:02 -0400
Content-Disposition: inline
In-Reply-To: <0c3efbd7b70f76c5dea1d6a9958566cd5fb4a4da.1434152603.git.luto@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Huang Rui <ray.huang@amd.com>, Denys Vlasenko <dvlasenk@redhat.com>, linux-input@vger.kernel.org

On Fri, Jun 12, 2015 at 04:44:50PM -0700, Andy Lutomirski wrote:
> This timing code is hideous, and this doesn't help.  It gets rid of
> one of the last users of rdtscl, though.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/joystick/analog.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
> index 4284080e481d..f871b4f00056 100644
> --- a/drivers/input/joystick/analog.c
> +++ b/drivers/input/joystick/analog.c
> @@ -143,7 +143,7 @@ struct analog_port {
>  
>  #include <linux/i8253.h>
>  
> -#define GET_TIME(x)	do { if (cpu_has_tsc) rdtscl(x); else x = get_time_pit(); } while (0)
> +#define GET_TIME(x)	do { if (cpu_has_tsc) x = (unsigned int)native_read_tsc(); else x = get_time_pit(); } while (0)
>  #define DELTA(x,y)	(cpu_has_tsc ? ((y) - (x)) : ((x) - (y) + ((x) < (y) ? PIT_TICK_RATE / HZ : 0)))
>  #define TIME_NAME	(cpu_has_tsc?"TSC":"PIT")
>  static unsigned int get_time_pit(void)
> @@ -160,7 +160,7 @@ static unsigned int get_time_pit(void)
>          return count;
>  }
>  #elif defined(__x86_64__)
> -#define GET_TIME(x)	rdtscl(x)
> +#define GET_TIME(x)	do { x = (unsigned int)native_read_tsc(); } while (0)
>  #define DELTA(x,y)	((y)-(x))
>  #define TIME_NAME	"TSC"
>  #elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_TILE)
> -- 
> 2.4.2
> 

-- 
Dmitry
