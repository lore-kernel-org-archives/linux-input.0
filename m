From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: sidewinder - mark expected switch fall-throughs
Date: Fri, 10 Nov 2017 10:24:27 -0800
Message-ID: <20171110182427.45cji4wltdb2toh6@dtor-ws>
References: <20171109030250.GA13692@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:37124 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753515AbdKJSYa (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Nov 2017 13:24:30 -0500
Content-Disposition: inline
In-Reply-To: <20171109030250.GA13692@embeddedor.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 08, 2017 at 09:02:50PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 114763
> Addresses-Coverity-ID: 114764
> Addresses-Coverity-ID: 114765
> Addresses-Coverity-ID: 114766
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/joystick/sidewinder.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
> index 4a95b22..5e602a6 100644
> --- a/drivers/input/joystick/sidewinder.c
> +++ b/drivers/input/joystick/sidewinder.c
> @@ -672,16 +672,16 @@ static int sw_connect(struct gameport *gameport, struct gameport_driver *drv)
>  
>  			switch (i * m) {
>  				case 60:
> -					sw->number++;
> +					sw->number++;			/* fall through */
>  				case 45:				/* Ambiguous packet length */
>  					if (j <= 40) {			/* ID length less or eq 40 -> FSP */
>  				case 43:
>  						sw->type = SW_ID_FSP;
>  						break;
>  					}
> -					sw->number++;
> +					sw->number++;			/* fall through */
>  				case 30:
> -					sw->number++;
> +					sw->number++;			/* fall through */
>  				case 15:
>  					sw->type = SW_ID_GP;
>  					break;
> @@ -697,9 +697,9 @@ static int sw_connect(struct gameport *gameport, struct gameport_driver *drv)
>  						sw->type = SW_ID_PP;
>  					break;
>  				case 66:
> -					sw->bits = 3;
> +					sw->bits = 3;			/* fall through */
>  				case 198:
> -					sw->length = 22;
> +					sw->length = 22;		/* fall through */
>  				case 64:
>  					sw->type = SW_ID_3DP;
>  					if (j == 160)
> -- 
> 2.7.4
> 

-- 
Dmitry
