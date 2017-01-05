From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] sysrq: attach sysrq handler correctly for 32-bit kernel
Date: Thu, 5 Jan 2017 14:14:44 -0800
Message-ID: <20170105221444.GA20478@dtor-ws>
References: <1483636456-23336-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483636456-23336-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-input@vger.kernel.org

On Fri, Jan 06, 2017 at 02:14:16AM +0900, Akinobu Mita wrote:
> The sysrq input handler should be attached to the input device which has
> a left alt key.
> 
> On 32-bit kernels, some input devices which has a left alt key cannot
> attach sysrq handler.  Because the keybit bitmap in struct input_device_id
> for sysrq is not correctly initialized.  KEY_LEFTALT is 56 which is
> greater than BITS_PER_LONG on 32-bit kernels.
> 
> I found this problem when using a matrix keypad device which defines
> a KEY_LEFTALT (56) but doesn't have a KEY_O (24 == 56%32).
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I guess Greg will take it through TTY tree. Might go to stable as well,
although apparently not pressing since it was only noticed now.

> ---
>  drivers/tty/sysrq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 52bbd27..701c085 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -946,8 +946,8 @@ static const struct input_device_id sysrq_ids[] = {
>  	{
>  		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
>  				INPUT_DEVICE_ID_MATCH_KEYBIT,
> -		.evbit = { BIT_MASK(EV_KEY) },
> -		.keybit = { BIT_MASK(KEY_LEFTALT) },
> +		.evbit = { [BIT_WORD(EV_KEY)] = BIT_MASK(EV_KEY) },
> +		.keybit = { [BIT_WORD(KEY_LEFTALT)] = BIT_MASK(KEY_LEFTALT) },
>  	},
>  	{ },
>  };
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
