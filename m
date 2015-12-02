From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] Implement i8042 detect by BIOS FADT i8042 flag
Date: Wed, 2 Dec 2015 12:45:10 +0100
Message-ID: <20151202114510.GC3783@pd.tnic>
References: <1449083238-13179-1-git-send-email-Vincent.Wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449083238-13179-1-git-send-email-Vincent.Wan@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wan Zongshun <Vincent.Wan@amd.com>
Cc: dmitry.torokhov@gmail.coom, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, mcuos.com@gmail.com
List-Id: linux-input@vger.kernel.org

On Wed, Dec 02, 2015 at 02:07:18PM -0500, Wan Zongshun wrote:
> Detecting x86 platform supporting i8042 or not, we should resort
> to BIOS's FADT i8042 flag per ACPI spec.
> 
> Currently, Windows is conforming to this spec, and request this
> flag to detect i8042 supporting.
> 
> Signed-off-by: Wan Zongshun <Vincent.Wan@amd.com>
> ---
>  drivers/input/serio/i8042-x86ia64io.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index c115565..73686bd 100644
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
> @@ -1047,6 +1048,9 @@ static int __init i8042_platform_init(void)
>  	/* Just return if pre-detection shows no i8042 controller exist */
>  	if (!x86_platform.i8042_detect())
>  		return -ENODEV;
> +
> +	if (!(acpi_gbl_FADT.boot_flags & ACPI_FADT_8042))
> +		return -ENODEV;
>  #endif

Acked-by: Borislav Petkov <bp@suse.de>

with the small remark that whoever commits it, could add the URL of the
microsoft document to the commit message for further reference.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
