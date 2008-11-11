From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Input: i8042 - add Dell XPS M1530 to nomux list
Date: Tue, 11 Nov 2008 10:40:09 +0100
Message-ID: <491952F9.8030807@op5.se>
References: <200811101434.04830.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.op5.se ([193.201.96.20]:43906 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753531AbYKKJtI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2008 04:49:08 -0500
In-Reply-To: <200811101434.04830.herton@mandriva.com.br>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Cc: linux-input@vger.kernel.org

Herton Ronaldo Krzesinski wrote:
> Dell XPS M1530 needs i8042.nomux=1 for ALPS touchpad to work as reported on
> https://qa.mandriva.com/show_bug.cgi?id=43532
> 
> It is said that before A08 bios version this isn't needed (I don't have the
> hardware so can't check), and suppose this will not break with bios versions
> before A08.
> 
> Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> 

I've got bios A08 (can't downgrade though). It works here, so:

Tested-by: Andreas Ericsson <ae@op5.se>

> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index eec375c..5db1d0b 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -337,6 +337,13 @@ static struct dmi_system_id __initdata i8042_dmi_nomux_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "2656"),
>  		},
>  	},
> +	{
> +		.ident = "Dell XPS M1530",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "XPS M1530"),
> +		},
> +	},
>  	{ }
>  };
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
