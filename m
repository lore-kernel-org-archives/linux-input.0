From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH, RFC] i8042: add Dritek keyboard extension quirk
Date: Tue, 15 Jan 2008 16:35:32 -0500
Message-ID: <20080115163052.ZZRA012@mailhub.coreip.homeip.net>
References: <200801120122.38648.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:36477 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339AbYAOVgB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jan 2008 16:36:01 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6996wah.23
        for <linux-input@vger.kernel.org>; Tue, 15 Jan 2008 13:36:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200801120122.38648.carlos@strangeworlds.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-input@vger.kernel.org

Hi Carlos,

On Sat, Jan 12, 2008 at 01:22:38AM +0000, Carlos Corbacho wrote:
> 
> Can you please check the i8042_command() call is correct, I'm having
> trouble getting my head around the call semantics. What I'm trying to do
> is send the command 0x59 with one argument, 0x90.
>

Yep, this should work.

> +static unsigned int i8042_dritek = 0;
> +module_param_named(dritek, i8042_dritek, bool, 0);
> +MODULE_PARM_DESC(dritek, "Force enable the Dritek keyboard extension");

I think this should be wrapped in CONFIG_X86. Also it does not make sense
to 0-initialize static variables.

> @@ -1171,6 +1176,13 @@ static int __devinit i8042_probe(struct platform_device *dev)
>   */
>  	i8042_register_ports();
>  
> +	if (i8042_dritek) {
> +		param = 0x90;
> +		error = i8042_command(&param, 0x1059);
> +		if (error)
> +			goto out_fail;
> +	}
> +

I think this call should be moved above i8042_register_ports() so atkbd
will have i8042 fully setup before pribing.

Let me know if you agree, I have the above fixedon my side. Thanks!

-- 
Dmitry

