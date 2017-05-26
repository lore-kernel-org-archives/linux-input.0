From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: mousedev - fix implicit conversion warning
Date: Fri, 26 May 2017 10:07:46 -0700
Message-ID: <20170526170746.GA40877@dtor-ws>
References: <20170526153427.7830-1-nick.desaulniers@gmail.com>
 <20170526154029.9405-1-nick.desaulniers@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33823 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdEZRHt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 May 2017 13:07:49 -0400
Content-Disposition: inline
In-Reply-To: <20170526154029.9405-1-nick.desaulniers@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 26, 2017 at 08:40:28AM -0700, Nick Desaulniers wrote:
> Clang warns:
> 
> drivers/input/mousedev.c:653:63: error: implicit conversion from 'int'
> to 'signed char' changes value from 200 to -56
> [-Wconstant-conversion]
>   client->ps2[1] = 0x60; client->ps2[2] = 3; client->ps2[3] = 200;
>                                                             ~ ^~~
> 
> As far as I can tell, from
> 
> http://www.computer-engineering.org/ps2mouse/
> 
> Under "Command Set" > "0xE9 (Status Request)"
> 
> the value 200 is a valid sample rate. Using unsigned char, rather than
> signed char, for client->ps2 silences this warning.
> 
> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> ---
> * Additionally change function signature for the lone function dealing
>   with ps2 data.
> 
>  drivers/input/mousedev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
> index 0e0ff84088fd..0e31a109b1b4 100644
> --- a/drivers/input/mousedev.c
> +++ b/drivers/input/mousedev.c
> @@ -103,7 +103,7 @@ struct mousedev_client {
>  	spinlock_t packet_lock;
>  	int pos_x, pos_y;
>  
> -	signed char ps2[6];
> +	unsigned char ps2[6];
>  	unsigned char ready, buffer, bufsiz;
>  	unsigned char imexseq, impsseq;
>  	enum mousedev_emul mode;
> @@ -577,7 +577,7 @@ static inline int mousedev_limit_delta(int delta, int limit)
>  }
>  
>  static void mousedev_packet(struct mousedev_client *client,
> -			    signed char *ps2_data)
> +	unsigned char *ps2_data)
>  {
>  	struct mousedev_motion *p = &client->packets[client->tail];

If you look at the code of this fucntion we really use ps2_data as
signed in calculations, and this change would break that. While making
ps2_data u8 might be beneficial we'd need to rework mousedev_packet() to
use signed temporaries for dx, dy and dz before stufifng them into
ps2_data.

Thanks.

-- 
Dmitry
