From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH] input: ff-core: Fix spelling mistake in ff-core
Date: Tue, 5 May 2015 07:05:40 -0500
Message-ID: <5548B214.8000501@ti.com>
References: <1429899401-7629-1-git-send-email-dmurphy@ti.com> <1429899401-7629-2-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59930 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161644AbbEEMFl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 May 2015 08:05:41 -0400
In-Reply-To: <1429899401-7629-2-git-send-email-dmurphy@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

bump
On 04/24/2015 01:16 PM, Dan Murphy wrote:
> Fix spelling of magnitude
> s/manginude/magnitude
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/input/ff-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
> index b81c88c..d10154e 100644
> --- a/drivers/input/ff-core.c
> +++ b/drivers/input/ff-core.c
> @@ -70,12 +70,11 @@ static int compat_effect(struct ff_device *ff, struct ff_effect *effect)
>  			return -EINVAL;
>  
>  		/*
> -		 * calculate manginude of sine wave as average of rumble's
> +		 * calculate magnitude of sine wave as average of rumble's
>  		 * 2/3 of strong magnitude and 1/3 of weak magnitude
>  		 */
>  		magnitude = effect->u.rumble.strong_magnitude / 3 +
>  			    effect->u.rumble.weak_magnitude / 6;
> -
>  		effect->type = FF_PERIODIC;
>  		effect->u.periodic.waveform = FF_SINE;
>  		effect->u.periodic.period = 50;


-- 
------------------
Dan Murphy

