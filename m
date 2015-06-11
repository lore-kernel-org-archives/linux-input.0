From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1 linux-next] Input: cyttsp4 - use swap() in
 cyttsp4_get_touch()
Date: Thu, 11 Jun 2015 13:08:44 -0700
Message-ID: <20150611200844.GA10293@dtor-pixel>
References: <1433953903-23653-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f65.google.com ([209.85.192.65]:36695 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbbFKUWV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Jun 2015 16:22:21 -0400
Content-Disposition: inline
In-Reply-To: <1433953903-23653-1-git-send-email-fabf@skynet.be>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, Ferruh Yigit <fery@cypress.com>, linux-input@vger.kernel.org

On Wed, Jun 10, 2015 at 06:31:43PM +0200, Fabian Frederick wrote:
> Use kernel.h macro definition.
> 
> Thanks to Julia Lawall for Coccinelle scripting support.
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Applied, thank you.

> ---
>  drivers/input/touchscreen/cyttsp4_core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
> index 568a3d3..5ed3105 100644
> --- a/drivers/input/touchscreen/cyttsp4_core.c
> +++ b/drivers/input/touchscreen/cyttsp4_core.c
> @@ -775,7 +775,6 @@ static void cyttsp4_get_touch(struct cyttsp4_mt_data *md,
>  	struct device *dev = &md->input->dev;
>  	struct cyttsp4_sysinfo *si = md->si;
>  	enum cyttsp4_tch_abs abs;
> -	int tmp;
>  	bool flipped;
>  
>  	for (abs = CY_TCH_X; abs < CY_TCH_NUM_ABS; abs++) {
> @@ -790,9 +789,7 @@ static void cyttsp4_get_touch(struct cyttsp4_mt_data *md,
>  	}
>  
>  	if (md->pdata->flags & CY_FLAG_FLIP) {
> -		tmp = touch->abs[CY_TCH_X];
> -		touch->abs[CY_TCH_X] = touch->abs[CY_TCH_Y];
> -		touch->abs[CY_TCH_Y] = tmp;
> +		swap(touch->abs[CY_TCH_X], touch->abs[CY_TCH_Y]);
>  		flipped = true;
>  	} else
>  		flipped = false;
> -- 
> 2.4.2
> 
