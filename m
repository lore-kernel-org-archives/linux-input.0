From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: ALPS - remove redundant unlikely()
Date: Tue, 26 Sep 2017 11:57:06 +0200
Message-ID: <20170926095706.GR22190@pali>
References: <20170926092951.26721-1-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34206 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935119AbdIZJ5J (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 Sep 2017 05:57:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id k20so2069378wre.1
        for <linux-input@vger.kernel.org>; Tue, 26 Sep 2017 02:57:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170926092951.26721-1-tklauser@distanz.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Tuesday 26 September 2017 11:29:51 Tobias Klauser wrote:
> IS_ERR_OR_NULL() already implies unlikely(), so it can be omitted.

Hi Tobias! Exactly same patch was sent 2 years ago. See discussion about
it why it is not a good idea to apply it:

https://lists.gt.net/linux/kernel/2269724

> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  drivers/input/mouse/alps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 850b00e3ad8e..2aaceb1e9d4f 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -1486,7 +1486,7 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
>  		/* On V2 devices the DualPoint Stick reports bare packets */
>  		dev = priv->dev2;
>  		dev2 = psmouse->dev;
> -	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
> +	} else if (IS_ERR_OR_NULL(priv->dev3)) {
>  		/* Register dev3 mouse if we received PS/2 packet first time */
>  		if (!IS_ERR(priv->dev3))
>  			psmouse_queue_work(psmouse, &priv->dev3_register_work,

-- 
Pali Rohár
pali.rohar@gmail.com
