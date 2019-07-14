From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/8] Input: synaptics: Fix misuse of strlcpy
Date: Sun, 14 Jul 2019 11:29:27 -0700
Message-ID: <20190714182927.GB190835@dtor-ws>
References: <cover.1562283944.git.joe@perches.com>
 <070330472a7314a21d85c42dd66cdd43222559c3.1562283944.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <070330472a7314a21d85c42dd66cdd43222559c3.1562283944.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jul 04, 2019 at 04:57:41PM -0700, Joe Perches wrote:
> Probable cut&paste typo - use the correct field size.

Applied, thank you.

Luckily both sizes (name and phys) are the same, so we need not to have
this in any of the stables.

> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/input/mouse/synaptics.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 1080c0c49815..00a0cf14f27f 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -705,7 +705,7 @@ static void synaptics_pt_create(struct psmouse *psmouse)
>  
>  	serio->id.type = SERIO_PS_PSTHRU;
>  	strlcpy(serio->name, "Synaptics pass-through", sizeof(serio->name));
> -	strlcpy(serio->phys, "synaptics-pt/serio0", sizeof(serio->name));
> +	strlcpy(serio->phys, "synaptics-pt/serio0", sizeof(serio->phys));
>  	serio->write = synaptics_pt_write;
>  	serio->start = synaptics_pt_start;
>  	serio->stop = synaptics_pt_stop;
> -- 
> 2.15.0
> 

-- 
Dmitry
