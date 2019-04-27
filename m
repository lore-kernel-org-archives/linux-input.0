From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: pm8xxx-vibrator: fix a potential NULL pointer
 dereference
Date: Fri, 26 Apr 2019 17:27:08 -0700
Message-ID: <20190427002708.GC42369@dtor-ws>
References: <20190309053922.22212-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190309053922.22212-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Kangjie,

On Fri, Mar 08, 2019 at 11:39:21PM -0600, Kangjie Lu wrote:
> In case of_device_get_match_data fails to find the matched data,
> returns -ENODEV

How can this happen? We will not match again the device if compatible is
not present in the table.

If this happens I'd rather we crash and burn instead of silently
ignoring the failure.

Thanks.

> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/input/misc/pm8xxx-vibrator.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
> index 7dd1c1fbe42a..740e59c11808 100644
> --- a/drivers/input/misc/pm8xxx-vibrator.c
> +++ b/drivers/input/misc/pm8xxx-vibrator.c
> @@ -196,6 +196,8 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
>  	vib->vib_input_dev = input_dev;
>  
>  	regs = of_device_get_match_data(&pdev->dev);
> +	if (unlikely(!regs))
> +		return -ENODEV;
>  
>  	/* operate in manual mode */
>  	error = regmap_read(vib->regmap, regs->drv_addr, &val);
> -- 
> 2.17.1
> 

-- 
Dmitry
