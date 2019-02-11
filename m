From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: mark expected switch fall-through
Date: Mon, 11 Feb 2019 14:48:16 -0800
Message-ID: <20190211224816.GE149505@dtor-ws>
References: <20190211222555.GA5472@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190211222555.GA5472@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
List-Id: linux-input@vger.kernel.org

On Mon, Feb 11, 2019 at 04:25:55PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/input/joystick/db9.c: In function ‘db9_saturn_read_packet’:
> drivers/input/joystick/db9.c:256:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (tmp == 0xff) {
>       ^
> drivers/input/joystick/db9.c:263:2: note: here
>   default:
>   ^~~~~~~
> 
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/joystick/db9.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
> index 804b1b80a8be..5a52b65bef9a 100644
> --- a/drivers/input/joystick/db9.c
> +++ b/drivers/input/joystick/db9.c
> @@ -259,7 +259,7 @@ static unsigned char db9_saturn_read_packet(struct parport *port, unsigned char
>  			db9_saturn_write_sub(port, type, 3, powered, 0);
>  			return data[0] = 0xe3;
>  		}
> -		/* else: fall through */
> +		/* fall through */
>  	default:
>  		return data[0];
>  	}
> -- 
> 2.20.1
> 

-- 
Dmitry
