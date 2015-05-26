From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input:mouse:cyapa_gen5.c - Fix for typos in comment in
 function cyapa_gen5_irq_cmd_handler().
Date: Tue, 26 May 2015 14:43:33 -0700
Message-ID: <20150526214333.GB10343@dtor-ws>
References: <1432575677-3462-1-git-send-email-shailendra.capricorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38821 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbbEZVnh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 May 2015 17:43:37 -0400
Content-Disposition: inline
In-Reply-To: <1432575677-3462-1-git-send-email-shailendra.capricorn@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shailendra Verma <shailendra.capricorn@gmail.com>
Cc: Dudley Du <dudl@cypress.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 25, 2015 at 11:11:17PM +0530, Shailendra Verma wrote:
> 
> Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>

There were a few more typos, I fixed those up as well and applied.

> ---
>  drivers/input/mouse/cyapa_gen5.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
> index 5b611dd..a12c32a 100644
> --- a/drivers/input/mouse/cyapa_gen5.c
> +++ b/drivers/input/mouse/cyapa_gen5.c
> @@ -2547,8 +2547,8 @@ static bool cyapa_gen5_irq_cmd_handler(struct cyapa *cyapa)
>  				gen5_pip->irq_cmd_buf, length))) {
>  			/*
>  			 * Cover the Gen5 V1 firmware issue.
> -			 * The issue is there is no interrut will be
> -			 * asserted to notityf host to read a command
> +			 * The issue is there is no interrupt will be
> +			 * asserted to notify host to read a command
>  			 * data out when always has finger touch on
>  			 * trackpad during the command is issued to
>  			 * trackad device.
> -- 
> 1.7.9.5
> 

-- 
Dmitry
