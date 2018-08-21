From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: mfd: cros_ec: Check for mkbp events on resume only if
 supported.
Date: Tue, 21 Aug 2018 09:28:17 +0200
Message-ID: <20180821072819eucas1p24b9038a7a2a1b1eae0d7c91bc31fe1b2~M1an4a6Av2511925119eucas1p2u@eucas1p2.samsung.com>
References: <CGME20180820153427epcas3p366f998ada5f2f37f1198a1321e9e10be@epcas3p3.samsung.com>
        <20180820153419.32098-1-ravisadineni@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820153419.32098-1-ravisadineni@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: RaviChandra Sadineni <ravisadineni@chromium.org>, lee.jones@linaro.org, dmitry.torokhov@gmail.com, ravisadineni@google.com, dtor@google.com, linux-samsung-soc@vger.kernel.org, tbroch@google.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, tfiga@chromium.org
List-Id: linux-input@vger.kernel.org

Hi Ravi,

On 2018-08-20 17:34, RaviChandra Sadineni wrote:
> Currently on every resume we check for mkbp events and notify the
> clients. This helps in identifying the wakeup sources. But on devices
> that do not support mkbp protocol, we might end up querying key state of
> the keyboard in a loop which blocks the resume. Instead check for events
> only if mkbp is supported.
>
> Signed-off-by: RaviChandra Sadineni <ravisadineni@chromium.org>

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>
>   Note: This patch fixes the suspend/resume issue on Snow and Peach-Pit
>   Chromebooks, both on vanilla v4.18 as well as linux-next from 20 August
>   2018. Further info at: https://lkml.org/lkml/2018/6/5/1076
>   
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
