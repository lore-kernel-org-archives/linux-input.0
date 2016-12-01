From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: i8042 error at booting an Intel Cherry Trail-based device
Date: Wed, 30 Nov 2016 18:29:23 -0800
Message-ID: <20161201022923.GG31934@dtor-ws>
References: <s5hk2bn908b.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hk2bn908b.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Takashi,

On Mon, Nov 28, 2016 at 02:56:36PM +0100, Takashi Iwai wrote:
> Hi Dmitry,
> 
> I've been testing a small machine with Intel Cherry Trail chipset, and
> noticed that the kernel spews errors always like:
> 
>  i8042: PNP: No PS/2 controller found. Probing ports directly.
>  i8042: Can't read CTR while initializing i8042
>  i8042: probe of i8042 failed with error -5
> 
> Especially the second one ("Can't read CTR...") is annoying since it's
> in KERN_ERR level and thus appears even booted with quiet boot
> option.  Actually this is the only error message appearing at boot, so
> I'd love to get rid of it.
> 
> What is the preferred way to reduce this?  For example, is a patch
> like below OK to simply change the log level and the error code?

No, because if controller is actually present this is a hard failure and
we should be reporting it, not suppressing it.

The issue is that we did not believe PNP data and in this case we should
have. Unfortunately in old days there was a lot of crap in PNP/ACPI
tables, but it could be better now. We can try, in addition to PNP
matching, checking 8042 flag in "Fixed ACPI Description Table Boot
Architecture Flags" in FADT and if it also shows there is no 8042 then
bail.

Thanks.

> 
> 
> thanks,
> 
> Takashi
> 
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] i8042: Reduce the log level of i8042 CTR read error
> 
> The error message "Can't read CTR while initializing i8042" appears on
> Cherry Trail-based devices at each boot time:
> 
>   i8042: PNP: No PS/2 controller found. Probing ports directly.
>   i8042: Can't read CTR while initializing i8042
>   i8042: probe of i8042 failed with error -5
> 
> This is annoying, since it's the only error message with KERN_ERR
> level appearing during the boot.
> 
> This patch changes the kernel log level to KERN_INFO for that message,
> and replaces the error code to -ENODEV so that this probe failure
> won't be complained like the above.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/input/serio/i8042.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index b4e1ac5c9ea8..2c2683e357e9 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -980,8 +980,8 @@ static int i8042_controller_init(void)
>  			udelay(50);
>  
>  		if (i8042_command(&ctr[n++ % 2], I8042_CMD_CTL_RCTR)) {
> -			pr_err("Can't read CTR while initializing i8042\n");
> -			return -EIO;
> +			pr_info("Can't read CTR while initializing i8042\n");
> +			return -ENODEV;
>  		}
>  
>  	} while (n < 2 || ctr[0] != ctr[1]);
> -- 
> 2.10.2
> 

-- 
Dmitry
