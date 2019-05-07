From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: libps2 - mark expected switch fall-through
Date: Tue, 7 May 2019 12:27:44 -0700
Message-ID: <20190507192744.GA248929@dtor-ws>
References: <20190507182409.GA11027@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190507182409.GA11027@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
List-Id: linux-input@vger.kernel.org

On Tue, May 07, 2019 at 01:24:09PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/input/serio/libps2.c: In function ‘ps2_handle_ack’:
> drivers/input/serio/libps2.c:407:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (ps2dev->flags & PS2_FLAG_NAK) {
>       ^
> drivers/input/serio/libps2.c:417:2: note: here
>   case 0x00:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/serio/libps2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
> index e6a07e68d1ff..22b8e05aa36c 100644
> --- a/drivers/input/serio/libps2.c
> +++ b/drivers/input/serio/libps2.c
> @@ -409,6 +409,7 @@ bool ps2_handle_ack(struct ps2dev *ps2dev, u8 data)
>  			ps2dev->nak = PS2_RET_ERR;
>  			break;
>  		}
> +		/* Fall through */
>  
>  	/*
>  	 * Workaround for mice which don't ACK the Get ID command.
> -- 
> 2.21.0
> 

-- 
Dmitry
