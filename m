From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v6 17/22] x86/olpc/xo1/sci: Use newly added
 power_supply_put API
Date: Thu, 12 Mar 2015 12:20:57 +0100
Message-ID: <20150312112057.GB8475@gmail.com>
References: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
 <1425976046-20973-18-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425976046-20973-18-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.orglinux-
List-Id: linux-input@vger.kernel.org


* Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:

> Replace direct usage of put_device() with new API: power_supply_put().
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Reviewed-by: Sebastian Reichel <sre@kernel.org>
> ---
>  arch/x86/platform/olpc/olpc-xo1-sci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/olpc-xo1-sci.c
> index e4ed28bbf79d..7fa8b3b53bc0 100644
> --- a/arch/x86/platform/olpc/olpc-xo1-sci.c
> +++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
> @@ -61,7 +61,7 @@ static void battery_status_changed(void)
>  
>  	if (psy) {
>  		power_supply_changed(psy);
> -		put_device(&psy->dev);
> +		power_supply_put(psy);
>  	}
>  }
>  
> @@ -71,7 +71,7 @@ static void ac_status_changed(void)
>  
>  	if (psy) {
>  		power_supply_changed(psy);
> -		put_device(&psy->dev);
> +		power_supply_put(psy);
>  	}
>  }

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
