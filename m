From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Input: gpio-keys-polled: don't use unit-address with
 button nodes
Date: Sat, 3 Sep 2016 10:39:43 -0700
Message-ID: <20160903173943.GA32345@dtor-ws>
References: <1472843877-6163-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1472843877-6163-1-git-send-email-vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Sep 02, 2016 at 10:17:57PM +0300, Vladimir Zapolskiy wrote:
> The change corrects an example in device tree documentation section,
> because button/key device nodes don't contain reg property there is
> no need to declare unit-address, and address and size cell properties
> are also redundant.
> 
> At the moment a compilation of the hypothetical original example
> should produce W=1 level warnings, and it is better to stop spreading
> misusage of the polled gpio keys device tree binding through this
> example.
> 
> Signed-off-by: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>

Applied, thank you.

> ---
>  Documentation/devicetree/bindings/input/gpio-keys-polled.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
> index 95d0fb1..4d9a371 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
> +++ b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
> @@ -34,11 +34,10 @@ Example nodes:
>  
>  	gpio_keys_polled {
>  			compatible = "gpio-keys-polled";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
>  			poll-interval = <100>;
>  			autorepeat;
> -			button@21 {
> +
> +			button21 {
>  				label = "GPIO Key UP";
>  				linux,code = <103>;
>  				gpios = <&gpio1 0 1>;
> -- 
> 2.8.1
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
