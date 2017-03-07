From: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: exynos: Add stmfts touchscreen node
 for TM2 and TM2E
Date: Tue, 7 Mar 2017 21:55:33 +0200
Message-ID: <20170307195533.biokjsffiri364vt@kozik-lap>
References: <20170210021721.12218-1-andi.shyti@samsung.com>
 <CGME20170210021729epcas5p4101902873e65e0a8faeb2f9cbea5843c@epcas5p4.samsung.com>
 <20170210021721.12218-4-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170210021721.12218-4-andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Feb 10, 2017 at 11:17:21AM +0900, Andi Shyti wrote:
> TM2 and TM2E devices are provided with a ST-Microelectronics
> Finger Tip S device with small differences:
> 
>  - screen size
>  - TM2E uses the stmfts also as a touchkey for "back" and "menu"
> 
> In this commit the initial value of the interrupt line is set to
> EXYNOS_PIN_PULL_UP as the interrupt is triggered when the line
> goes down.
> 
> Signed-off-by: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Reviewed-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 15 ++++++++++++++-
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts         |  5 +++++
>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts        |  7 +++++++
>  3 files changed, 26 insertions(+), 1 deletion(-)
> 

Thanks, applied.

Best regards,
Krzysztof

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
