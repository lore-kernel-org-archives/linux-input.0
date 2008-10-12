From: legolas558 <legolas558@email.it>
Subject: Re: [PATCH] input: Thinkpad R31 i8042 nomux quirk
Date: Sun, 12 Oct 2008 09:51:19 +0200
Message-ID: <48F1AC77.3020503@email.it>
References: <48F0EDF0.3020702@math.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m-04.th.seeweb.it ([217.64.195.227]:40270 "EHLO
	m-04.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbYJLIAW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Oct 2008 04:00:22 -0400
In-Reply-To: <48F0EDF0.3020702@math.ucla.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Colin Macdonald <cbm@math.ucla.edu>, linux-input@vger.kernel.org

Hello,

I also have a notebook, Maxdata Pro 7000X (Fujitsu clone), which has 
such problem (needs i8042.nomux=1, perhaps kernel bug #8740).

Can we also use a patch for it?

dmidecode useful information:

Handle 0x0001, DMI type 1, 25 bytes
System Information
        Manufacturer: MAXDATA       
        Product Name: Pro 7000X     
        Version: xxxxxxxxxx
        Serial Number: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        UUID: xxxxxxxxxx-xxxxxxxxxx-xxxxxxxxxxxxxxxxxxxx
        Wake-up Type: Power Switch

Thanks,
--
  Daniele C.


Colin Macdonald ha scritto:
> Subject: [PATCH] input: Thinkpad R31 i8042 nomux quirk
> from: Colin B Macdonald <cbm@m.fsf.org>
>
> Thinkpad R31 needs i8042 nomux quirk.  Stops jittery jumping mouse
> and random keyboard input.  Fixes kernel bug #11723.  Cherry picked
> from Ubuntu who have sometimes (on-again-off-again) had a fix in
> their patched kernels.
>
> Signed-off-by: Colin B Macdonald <cbm@m.fsf.org>
>
> ---
>
> --- linux-2.6.27/drivers/input/serio/i8042-x86ia64io.h.orig	2008-10-11 01:07:22.000000000 -0700
> +++ linux-2.6.27/drivers/input/serio/i8042-x86ia64io.h	2008-10-11 01:06:24.000000000 -0700
> @@ -322,6 +322,13 @@ static struct dmi_system_id __initdata i
>  			DMI_MATCH(DMI_PRODUCT_NAME, "N34AS6"),
>  		},
>  	},
> +	{
> +		.ident = "IBM 2656",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "2656"),
> +		},
> +	},
>  	{ }
>  };
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   

