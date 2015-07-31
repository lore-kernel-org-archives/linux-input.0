From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 05/15] drivers: input: Drop unlikely before
 IS_ERR(_OR_NULL)
Date: Fri, 31 Jul 2015 09:58:41 -0700
Message-ID: <20150731165841.GD5613@dtor-ws>
References: <cover.1438331416.git.viresh.kumar@linaro.org>
 <72b53f2cabc15cf3d019041a0ed605ca7c24d19b.1438331416.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33361 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbbGaQ6q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jul 2015 12:58:46 -0400
Content-Disposition: inline
In-Reply-To: <72b53f2cabc15cf3d019041a0ed605ca7c24d19b.1438331416.git.viresh.kumar@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: akpm@linux-foundation.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Masaki Ota <masaki.ota@jp.alps.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>

On Fri, Jul 31, 2015 at 02:08:25PM +0530, Viresh Kumar wrote:
> IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag and there
> is no need to do that again from its callers. Drop it.

I'd rather keep it as it documents the expected behavior and double
unlikely should work just fine.

> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/input/mouse/alps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 113d6f1516a5..cef3611a4ccd 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -1365,7 +1365,7 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
>  		/* On V2 devices the DualPoint Stick reports bare packets */
>  		dev = priv->dev2;
>  		dev2 = psmouse->dev;
> -	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
> +	} else if (IS_ERR_OR_NULL(priv->dev3)) {
>  		/* Register dev3 mouse if we received PS/2 packet first time */
>  		if (!IS_ERR(priv->dev3))
>  			psmouse_queue_work(psmouse, &priv->dev3_register_work,
> -- 
> 2.4.0
> 

Thanks.

-- 
Dmitry
