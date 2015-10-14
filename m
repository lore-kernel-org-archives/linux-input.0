From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC 1/4] Input: edt-ft5x06 - Use max support points to
 determine how much to read
Date: Wed, 14 Oct 2015 16:39:04 -0700
Message-ID: <20151014233904.GA3673@dtor-ws>
References: <1444220501-23623-1-git-send-email-fcooper@ti.com>
 <1444220501-23623-2-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444220501-23623-2-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: fcooper@ti.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, maxime.ripard@free-electrons.com, LW@KARO-electronics.de, jg1.han@samsung.com, asaf.vertz@tandemg.com
List-Id: linux-input@vger.kernel.org

On Wed, Oct 07, 2015 at 07:21:38AM -0500, fcooper@ti.com wrote:
> From: Franklin S Cooper Jr <fcooper@ti.com>
> 
> Calculate the amount of data that needs to be read for the specified max
> number of support points. If the maximum number of support points changes
> then the amount that is read from the touch screen controller should
> reflect this.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 7239c31..1e0ed6e 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -178,14 +178,16 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
>  		cmd = 0xf9; /* tell the controller to send touch data */
>  		offset = 5; /* where the actual touch data starts */
>  		tplen = 4;  /* data comes in so called frames */
> -		datalen = 26; /* how much bytes to listen for */
> +
> +		/* how many bytes to listen for */
> +		datalen = tplen * MAX_SUPPORT_POINTS + offset + 1;
>  		break;
>  
>  	case M09:
>  		cmd = 0x02;
>  		offset = 1;
>  		tplen = 6;
> -		datalen = 29;
> +		datalen = tplen * MAX_SUPPORT_POINTS - cmd + 1;
>  		break;


Hmm, why would formulae for datalen be different depending on the
firmware? And I think original 29 it too low: we need 30 bytes for 5
contacts + 1 to account for offset.

I also wonder why we need extra 1 byte in M06 case.

Lothar?

Thanks.

-- 
Dmitry
