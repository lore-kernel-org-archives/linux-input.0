From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: Add regulator-haptic device node for
 exynos3250-rinato
Date: Tue, 25 Nov 2014 10:02:42 +0900
Message-ID: <5473D532.10206@samsung.com>
References: <1416840651-17141-1-git-send-email-jaewon02.kim@samsung.com>
 <1416840651-17141-3-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:45190 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbaKYBCp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Nov 2014 20:02:45 -0500
In-reply-to: <1416840651-17141-3-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pankaj Dubey <pankaj.dubey@samsung.com>, Dan Murphy <dmurphy@ti.com>, Hyunhee Kim <hyunhee.kim@samsung.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>

On 11/24/2014 11:50 PM, Jaewon Kim wrote:
> This patch adds regulator-haptic device node controlled by regulator.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250-rinato.dts |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
> index 84380fa..da03005 100644
> --- a/arch/arm/boot/dts/exynos3250-rinato.dts
> +++ b/arch/arm/boot/dts/exynos3250-rinato.dts
> @@ -104,6 +104,13 @@
>  			};
>  		};
>  	};
> +
> +	haptics {
> +		compatible = "regulator-haptic";
> +		haptic-supply = <&motor_reg>;
> +		min-microvolt = <1100000>;
> +		max-microvolt = <2700000>;
> +	};
>  };
>  
>  &adc {
> 

Looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
