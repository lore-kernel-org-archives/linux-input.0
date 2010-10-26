From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 06/10] drivers/input/serio/i8042: Use pr_<level>, pr_fmt.
  Fix dbg and __FILE__ use
Date: Tue, 26 Oct 2010 08:50:28 -0700
Message-ID: <20101026155028.GA13097@core.coreip.homeip.net>
References: <cover.1288059486.git.joe@perches.com>
 <63a8deabb7c8167128d0415998692d15279ecb8c.1288059486.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <63a8deabb7c8167128d0415998692d15279ecb8c.1288059486.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Jiri Kosina <trivial@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Joe,

On Mon, Oct 25, 2010 at 07:44:24PM -0700, Joe Perches wrote:
> Standardized message logging prefixes.
> Removed \n from dbg macro, added \n to each dbg call site.

Did you test it? It looks for call like:

> +             dbg("%02x <- i8042 (flush, %s)\n",
> +                 data, str & I8042_STR_AUXDATA ? "aux" : "kbd");

the result will be:

printk(KERN_DEBUG "i8042: %02x <- i8042 (flush, %s)\n [%d]", ...)

which is not exactly what you want...

>  
> @@ -1268,7 +1262,7 @@ static void __init i8042_register_ports(void)
>  
>  	for (i = 0; i < I8042_NUM_PORTS; i++) {
>  		if (i8042_ports[i].serio) {
> -			printk(KERN_INFO "serio: %s at %#lx,%#lx irq %d\n",
> +			pr_info("%s at %#lx,%#lx irq %d\n",
>  				i8042_ports[i].serio->name,
>  				(unsigned long) I8042_DATA_REG,
>  				(unsigned long) I8042_COMMAND_REG,

Not quite equivalent conversion, right now every port is registered with
message "serio: XXX at YYY". I would be OK with having driver prefix
going in front but I'd like to keep word serio in (like "i8042: serio
XXX at YYY").

Thanks.

-- 
Dmitry
