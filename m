From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] input: i8042: add quirk to implement i8042 detect for AMD
Date: Fri, 16 Oct 2015 10:58:09 +0200
Message-ID: <20151016085808.GA32193@pd.tnic>
References: <1445002020-12672-1-git-send-email-Vincent.Wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:58338 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807AbbJPI6P (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Oct 2015 04:58:15 -0400
Content-Disposition: inline
In-Reply-To: <1445002020-12672-1-git-send-email-Vincent.Wan@amd.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vincent Wan <Vincent.Wan@amd.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ray.Huang@amd.com, mcuos.com@gmail.com

On Fri, Oct 16, 2015 at 09:27:00AM -0400, Vincent Wan wrote:
> Detecting platform supports i8042 or not, AMD resorted to
> BIOS's FADT i8042 flag.
> 
> Signed-off-by: Vincent Wan <Vincent.Wan@amd.com>
> ---
>  drivers/input/serio/i8042-x86ia64io.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index c115565..bf3a605 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -9,6 +9,7 @@
>  
>  #ifdef CONFIG_X86
>  #include <asm/x86_init.h>
> +#include <linux/acpi.h>
>  #endif
>  
>  /*
> @@ -1047,6 +1048,11 @@ static int __init i8042_platform_init(void)
>  	/* Just return if pre-detection shows no i8042 controller exist */
>  	if (!x86_platform.i8042_detect())
>  		return -ENODEV;
> +
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {

Why the vendor check if you're accessing a bit defined in the ACPI spec?

> +		if (!(acpi_gbl_FADT.boot_flags & ACPI_FADT_8042))
> +			return -ENODEV;
> +	}

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
