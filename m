From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: byd - update copyright header
Date: Mon, 9 May 2016 09:32:55 -0700
Message-ID: <20160509163255.GC15535@dtor-ws>
References: <1462491979-21271-1-git-send-email-chris@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35183 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbcEIQc7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 May 2016 12:32:59 -0400
Received: by mail-pf0-f170.google.com with SMTP id 77so77557340pfv.2
        for <linux-input@vger.kernel.org>; Mon, 09 May 2016 09:32:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1462491979-21271-1-git-send-email-chris@diamand.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Diamand <chris@diamand.org>
Cc: Richard Pospesel <pospeselr@gmail.com>, linux-input@vger.kernel.org

On Fri, May 06, 2016 at 12:46:19AM +0100, Chris Diamand wrote:
> As pointed out by Richard, the changes to the comment got missed off
> the absolute mode patch somehow.
> 
> CC: Richard Pospesel <pospeselr@gmail.com>
> Signed-off-by: Chris Diamand <chris@diamand.org>

Applied, thank you.

> ---
>  drivers/input/mouse/byd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
> index ec73f75..b27aa63 100644
> --- a/drivers/input/mouse/byd.c
> +++ b/drivers/input/mouse/byd.c
> @@ -2,6 +2,10 @@
>   * BYD TouchPad PS/2 mouse driver
>   *
>   * Copyright (C) 2015 Chris Diamand <chris@diamand.org>
> + * Copyright (C) 2015 Richard Pospesel
> + * Copyright (C) 2015 Tai Chi Minh Ralph Eastwood
> + * Copyright (C) 2015 Martin Wimpress
> + * Copyright (C) 2015 Jay Kuri
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License version 2 as published by
> -- 
> 2.8.1
> 

-- 
Dmitry
