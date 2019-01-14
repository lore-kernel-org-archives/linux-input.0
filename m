From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input_event: Provide override for sparc64
Date: Sun, 13 Jan 2019 22:52:33 -0800
Message-ID: <20190114065233.GB217283@dtor-ws>
References: <20181229183514.24644-1-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181229183514.24644-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, davem@davemloft.net, y2038@lists.linaro.org
List-Id: linux-input@vger.kernel.org

On Sat, Dec 29, 2018 at 10:35:14AM -0800, Deepa Dinamani wrote:
> The usec part of the timeval is defined as
> __kernel_suseconds_t	tv_usec; /* microseconds */
> 
> Arnd noticed that sparc64 is the only architecture
> that defines __kernel_suseconds_t as int rather than long.
> 
> This breaks the current y2038 fix for kernel as we only
> access and define the timeval struct for non-kernel use cases.
> But, this was hidden by an another typo in the use of __KERNEL__
> qualifier.
> 
> Fix the typo, and provide an override for sparc64.
> 
> Fixes: 152194fe9c3f ("Input: extend usable life of event timestamps to 2106 on 32 bit systems")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

Applied, thank you.

> ---
>  include/uapi/linux/input.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index fb78f6f500f3..ffab958bc512 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -26,13 +26,17 @@
>   */
>  
>  struct input_event {
> -#if (__BITS_PER_LONG != 32 || !defined(__USE_TIME_BITS64)) && !defined(__KERNEL)
> +#if (__BITS_PER_LONG != 32 || !defined(__USE_TIME_BITS64)) && !defined(__KERNEL__)
>  	struct timeval time;
>  #define input_event_sec time.tv_sec
>  #define input_event_usec time.tv_usec
>  #else
>  	__kernel_ulong_t __sec;
> +#ifdef CONFIG_SPARC64
> +	unsigned int __usec;
> +#else
>  	__kernel_ulong_t __usec;
> +#endif
>  #define input_event_sec  __sec
>  #define input_event_usec __usec
>  #endif
> -- 
> 2.17.1
> 

-- 
Dmitry
