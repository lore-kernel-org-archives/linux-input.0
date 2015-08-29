From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/6] input: pwm-beeper: Fix module autoload for OF
 platform driver
Date: Fri, 28 Aug 2015 17:00:42 -0700
Message-ID: <CAKdAkRQhyZBHJKTBZD3_YxT_BOFrUZdyZvKEC+N=yCwUjZs0hw@mail.gmail.com>
References: <20150827165909.GA5506@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:32896 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbbH2AAn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Aug 2015 20:00:43 -0400
In-Reply-To: <20150827165909.GA5506@goodgumbo.baconseed.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Jingoo Han <jg1.han@samsung.com>, Wolfram Sang <wsa@the-dreams.de>, Olivier Sobrie <olivier@sobrie.be>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>

Hi Luis,

On Thu, Aug 27, 2015 at 9:59 AM, Luis de Bethencourt
<luis@debethencourt.com> wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
>
> Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
> ---
>  drivers/input/misc/pwm-beeper.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
> index e82edf8..a02b9a4 100644
> --- a/drivers/input/misc/pwm-beeper.c
> +++ b/drivers/input/misc/pwm-beeper.c
> @@ -175,6 +175,8 @@ static const struct of_device_id pwm_beeper_match[] = {
>  };
>  #endif
>
> +MODULE_DEVICE_TABLE(of, pwm_beeper_match);
> +

I'm fairly certain this (ano others) blow up in case of !CONFIG_OF.
Please bring MODULE_DEVICE_TABLE into #ifdef block above.

>  static struct platform_driver pwm_beeper_driver = {
>         .probe  = pwm_beeper_probe,
>         .remove = pwm_beeper_remove,
> --
> 2.4.6
>

Thanks.

-- 
Dmitry
