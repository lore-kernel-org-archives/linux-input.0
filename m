From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: Input: cros_ec_keyb: Remove check before calling
 pm_wakeup_event.
Date: Mon, 20 Aug 2018 10:52:41 +0200
Message-ID: <20180820085242eucas1p23f693665452400f3a57676393ce08939~Mi7BqhC1Y0964309643eucas1p2V@eucas1p2.samsung.com>
References: <20180810082344eucas1p2c525a61cb176b4ab1dab22347afd539b~JeE3uTBkU1731217312eucas1p2T@eucas1p2.samsung.com>
        <CGME20180817212153epcas2p4aa217751a7d24f1ababc6038d2e4c9b7@epcas2p4.samsung.com>
        <20180817212135.222689-1-ravisadineni@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180817212135.222689-1-ravisadineni@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: RaviChandra Sadineni <ravisadineni@chromium.org>, dmitry.torokhov@gmail.com, ravisadineni@google.com, dtor@google.com, linux-samsung-soc@vger.kernel.org, tbroch@google.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, tfiga@chromium.org
List-Id: linux-input@vger.kernel.org

Hi Ravi,

On 2018-08-17 23:21, RaviChandra Sadineni wrote:
> From: RaviChandra Sadineni <ravisadineni@google.com>
>
> hi Merek,
>
> Unfortunately I could not get the device to boot even after using the exynos_defconfig.
> Can you please try this patch and see if this fixes the issue. If not can you enable the
> debug logs and send me the logs.
>
>
> Currently on every resume we check for mkbp events and notify the
> clients. This helps in identifying the wakeup sources. But on devices
> that do not support mkbp protocol, we might end up getting key state of
> the keyboard in a loop and block the resume. Instead check for events only
> if  mkbp is supported.
>
> Signed-off-by: RaviChandra Sadineni <ravisadineni@chromium.org>

This patch fixes the suspend/resume issue on Snow and Peach-Pit
Chromebooks, both on vanilla v4.18 as well as linux-next from 20 August 
2018.

Thanks!

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

A small hint: to merge it please resend with proper subject and put the note
should be after '---' mark, so it will be dropped by the 'git am' command.

> ---
>   drivers/mfd/cros_ec.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index 65a9757a6d21..fe6f83766144 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -218,7 +218,8 @@ EXPORT_SYMBOL(cros_ec_suspend);
>   
>   static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
>   {
> -	while (cros_ec_get_next_event(ec_dev, NULL) > 0)
> +	while (ec_dev->mkbp_event_supported &&
> +	       cros_ec_get_next_event(ec_dev, NULL) > 0)
>   		blocking_notifier_call_chain(&ec_dev->event_notifier,
>   					     1, ec_dev);
>   }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
