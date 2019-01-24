From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Fix the CONFIG_SPARC64 mixup
Date: Thu, 24 Jan 2019 00:29:55 -0800
Message-ID: <20190124082955.GA139904@dtor-ws>
References: <20190121014914.2328-1-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190121014914.2328-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, davem@davemloft.net, y2038@lists.linaro.org
List-Id: linux-input@vger.kernel.org

On Sun, Jan 20, 2019 at 05:49:14PM -0800, Deepa Dinamani wrote:
> Arnd Bergmann pointed out that CONFIG_* cannot be used
> in a uapi header. Override with an equivalent conditional.
> 
> Fixes: 2e746942ebac ("Input: input_event - provide override for sparc64")
> Fixes: 152194fe9c3f ("Input: extend usable life of event timestamps to 2106 on 32 bit systems")
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

Applied, thank you.

> ---
>  include/uapi/linux/input.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index ffab958bc512..f056b2a00d5c 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -32,7 +32,7 @@ struct input_event {
>  #define input_event_usec time.tv_usec
>  #else
>  	__kernel_ulong_t __sec;
> -#ifdef CONFIG_SPARC64
> +#if defined(__sparc__) && defined(__arch64__)
>  	unsigned int __usec;
>  #else
>  	__kernel_ulong_t __usec;
> -- 
> 2.17.1
> 

-- 
Dmitry
