From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: atakbd.c - fix Atari CapsLock behaviour
Date: Mon, 17 Sep 2018 12:43:10 -0700
Message-ID: <20180917194310.GA171258@dtor-ws>
References: <1536277243-3821-1-git-send-email-schmitzmic@gmail.com>
 <1536277243-3821-3-git-send-email-schmitzmic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-68k=debian-68k=m.gmane.org@lists.debian.org>
Content-Disposition: inline
In-Reply-To: <1536277243-3821-3-git-send-email-schmitzmic@gmail.com>
Resent-Message-ID: <RkA0zXJWnTF.A.auB.LfAobB@bendel>
List-URL: <https://lists.debian.org/debian-68k/>
List-Post: <mailto:debian-68k@lists.debian.org>
List-Help: <mailto:debian-68k-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-68k-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-68k-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/20180917194310.GA171258@dtor-ws
To: Michael Schmitz <schmitzmic@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>
Cc: linux-input@vger.kernel.org, debian-68k@lists.debian.org, linux-m68k@lists.linux-m68k.org
List-Id: linux-input@vger.kernel.org

On Fri, Sep 07, 2018 at 11:40:43AM +1200, Michael Schmitz wrote:
> The CapsLock key on Atari keyboards is not a toggle, it does send the
> normal make and break scancodes.
> 
> Drop the CapsLock toggle handling code, which did cause the CapsLock
> key to merely act as a Shift key.
> 
> Tested-by: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

Andreas, I have no idea how Atari keyboards work, can you add your
signed-off-by (or NAK) to this one as well please?

> 
> ---
>  drivers/input/keyboard/atakbd.c |   10 ++--------
>  1 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/keyboard/atakbd.c b/drivers/input/keyboard/atakbd.c
> index e989574..6caee80 100644
> --- a/drivers/input/keyboard/atakbd.c
> +++ b/drivers/input/keyboard/atakbd.c
> @@ -185,14 +185,8 @@ static void atakbd_interrupt(unsigned char scancode, char down)
>  
>  		scancode = atakbd_keycode[scancode];
>  
> -		if (scancode == KEY_CAPSLOCK) {	/* CapsLock is a toggle switch key on Amiga */
> -			input_report_key(atakbd_dev, scancode, 1);
> -			input_report_key(atakbd_dev, scancode, 0);
> -			input_sync(atakbd_dev);
> -		} else {
> -			input_report_key(atakbd_dev, scancode, down);
> -			input_sync(atakbd_dev);
> -		}
> +		input_report_key(atakbd_dev, scancode, down);
> +		input_sync(atakbd_dev);
>  	} else				/* scancodes >= 0xf3 are mouse data, most likely */
>  		printk(KERN_INFO "atakbd: unhandled scancode %x\n", scancode);
>  
> -- 
> 1.7.0.4
> 
