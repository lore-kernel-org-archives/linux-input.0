From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: spaceball - mark expected switch fall-throughs
Date: Fri, 10 Nov 2017 10:24:20 -0800
Message-ID: <20171110182420.w2eelj6p3z5u5nuc@dtor-ws>
References: <20171109025559.GA12406@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:57273 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbdKJSYX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Nov 2017 13:24:23 -0500
Content-Disposition: inline
In-Reply-To: <20171109025559.GA12406@embeddedor.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 08, 2017 at 08:55:59PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 114767
> Addresses-Coverity-ID: 114768
> Addresses-Coverity-ID: 114769
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/joystick/spaceball.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
> index e9712a1..bb3faef 100644
> --- a/drivers/input/joystick/spaceball.c
> +++ b/drivers/input/joystick/spaceball.c
> @@ -162,6 +162,7 @@ static irqreturn_t spaceball_interrupt(struct serio *serio,
>  				break;
>  			}
>  			spaceball->escape = 0;
> +			/* fall through */
>  		case 'M':
>  		case 'Q':
>  		case 'S':
> @@ -169,6 +170,7 @@ static irqreturn_t spaceball_interrupt(struct serio *serio,
>  				spaceball->escape = 0;
>  				data &= 0x1f;
>  			}
> +			/* fall through */
>  		default:
>  			if (spaceball->escape)
>  				spaceball->escape = 0;
> @@ -234,11 +236,13 @@ static int spaceball_connect(struct serio *serio, struct serio_driver *drv)
>  			input_dev->keybit[BIT_WORD(BTN_A)] |= BIT_MASK(BTN_A) |
>  				BIT_MASK(BTN_B) | BIT_MASK(BTN_C) |
>  				BIT_MASK(BTN_MODE);
> +			/* fall through */
>  		default:
>  			input_dev->keybit[BIT_WORD(BTN_0)] |= BIT_MASK(BTN_2) |
>  				BIT_MASK(BTN_3) | BIT_MASK(BTN_4) |
>  				BIT_MASK(BTN_5) | BIT_MASK(BTN_6) |
>  				BIT_MASK(BTN_7) | BIT_MASK(BTN_8);
> +			/* fall through */
>  		case SPACEBALL_3003C:
>  			input_dev->keybit[BIT_WORD(BTN_0)] |= BIT_MASK(BTN_1) |
>  				BIT_MASK(BTN_8);
> -- 
> 2.7.4
> 

-- 
Dmitry
