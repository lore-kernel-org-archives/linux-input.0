From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.25-rc3] omap-keypad buildfix
Date: Fri, 29 Feb 2008 07:59:38 -0800
Message-ID: <20080229155938.GK15339@atomide.com>
References: <20080225031432.D53A228DE41@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:51402 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932825AbYB2Q1t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Feb 2008 11:27:49 -0500
Content-Disposition: inline
In-Reply-To: <20080225031432.D53A228DE41@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [080224 19:14]:
> Build fixes:
> 
> drivers/input/keyboard/omap-keypad.c: In function 'omap_kp_probe':
> drivers/input/keyboard/omap-keypad.c:418: warning: 'row_idx' is used uninitialized in this function
> drivers/input/keyboard/omap-keypad.c:421: warning: 'col_idx' is used uninitialized in this function
> 
> These variables are useful when cpu_is_omap24xx(), and otherwise just
> for probe() cleanup.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> The OMAP tree has the same bug.
> 
>  drivers/input/keyboard/omap-keypad.c |    3 +++
>  1 files changed, 3 insertions(+)
> 
> --- a/drivers/input/keyboard/omap-keypad.c	2008-02-24 18:50:32.000000000 -0800
> +++ b/drivers/input/keyboard/omap-keypad.c	2008-02-24 19:10:17.000000000 -0800
> @@ -352,6 +352,9 @@ static int __init omap_kp_probe(struct p
>  			}
>  			omap_set_gpio_direction(row_gpios[row_idx], 1);
>  		}
> +	} else {
> +		col_idx = 0;
> +		row_idx = 0;
>  	}
>  
>  	setup_timer(&omap_kp->timer, omap_kp_timer, (unsigned long)omap_kp);

Pushing today.

Tony
