From: Lee Jones <lee.jones@linaro.org>
Subject: Re: mfd: cros_ec: Check for mkbp events on resume only if supported.
Date: Mon, 10 Sep 2018 15:37:44 +0100
Message-ID: <20180910143744.GT28860@dell>
References: <20180820153419.32098-1-ravisadineni@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180820153419.32098-1-ravisadineni@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: RaviChandra Sadineni <ravisadineni@chromium.org>
Cc: dmitry.torokhov@gmail.com, ravisadineni@google.com, dtor@google.com, linux-samsung-soc@vger.kernel.org, tbroch@google.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com
List-Id: linux-input@vger.kernel.org

On Mon, 20 Aug 2018, RaviChandra Sadineni wrote:

> Currently on every resume we check for mkbp events and notify the
> clients. This helps in identifying the wakeup sources. But on devices
> that do not support mkbp protocol, we might end up querying key state of
> the keyboard in a loop which blocks the resume. Instead check for events
> only if mkbp is supported.
> 
> Signed-off-by: RaviChandra Sadineni <ravisadineni@chromium.org>
> ---
> 
>  Note: This patch fixes the suspend/resume issue on Snow and Peach-Pit
>  Chromebooks, both on vanilla v4.18 as well as linux-next from 20 August 
>  2018. Further info at: https://lkml.org/lkml/2018/6/5/1076
>  
>  drivers/mfd/cros_ec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
