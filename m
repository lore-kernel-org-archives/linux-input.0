From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] input: serio: drop warnings in case of EPROBE_DEFER from serio_find_driver()
Date: Fri, 15 Jan 2016 21:53:14 +0100
Message-ID: <9158432.BHbKetFqR6@vostro.rjw.lan>
References: <1452880875-4148-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452880875-4148-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, lkp@01.org
List-Id: linux-input@vger.kernel.org

On Friday, January 15, 2016 08:01:15 PM Grygorii Strashko wrote:
> Now serio_find_driver() will print warnings in case device_attach()
> returns -EPROBE_DEFER. Those warnings are obsolete, in genral, because:
> - DD core can report the same if required
> - since commit 013c074f8642 ("PM / sleep: prohibit devices probing
> during suspend/hibernation") the devices probing is prohibited during
> System suspend and deferred device will be carefully reprobed once
> Resume is finished.
> 
> Hence, drop warnings in case of EPROBE_DEFER from serio_find_driver().
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/input/serio/serio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> index 8f82897..1ca7f55 100644
> --- a/drivers/input/serio/serio.c
> +++ b/drivers/input/serio/serio.c
> @@ -134,7 +134,7 @@ static void serio_find_driver(struct serio *serio)
>  	int error;
>  
>  	error = device_attach(&serio->dev);
> -	if (error < 0)
> +	if (error < 0 && error != -EPROBE_DEFER)
>  		dev_warn(&serio->dev,
>  			 "device_attach() failed for %s (%s), error: %d\n",
>  			 serio->phys, serio->name, error);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
