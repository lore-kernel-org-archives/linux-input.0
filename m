From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: Re: i8042 error at booting an Intel Cherry Trail-based device
Date: Mon, 5 Dec 2016 22:56:05 -0200
Message-ID: <20161206005603.GA21703@xfiles>
References: <s5hk2bn908b.wl-tiwai@suse.de>
 <20161201022923.GG31934@dtor-ws>
 <s5hfum82k19.wl-tiwai@suse.de>
 <s5hbmwuzjlg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hbmwuzjlg.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Slaby <jslaby@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Takashi,

On Fri, Dec 02, 2016 at 11:55:07AM +0100, Takashi Iwai wrote:
> On Thu, 01 Dec 2016 08:19:46 +0100,
> Takashi Iwai wrote:
> > 
> > On Thu, 01 Dec 2016 03:29:23 +0100,
> > Dmitry Torokhov wrote:
> > > 
> > > Hi Takashi,
> > > 
> > > On Mon, Nov 28, 2016 at 02:56:36PM +0100, Takashi Iwai wrote:
> > > > Hi Dmitry,
> > > > 
> > > > I've been testing a small machine with Intel Cherry Trail chipset, and
> > > > noticed that the kernel spews errors always like:
> > > > 
> > > >  i8042: PNP: No PS/2 controller found. Probing ports directly.
> > > >  i8042: Can't read CTR while initializing i8042
> > > >  i8042: probe of i8042 failed with error -5
> > > > 
> > > > Especially the second one ("Can't read CTR...") is annoying since it's
> > > > in KERN_ERR level and thus appears even booted with quiet boot
> > > > option.  Actually this is the only error message appearing at boot, so
> > > > I'd love to get rid of it.
> > > > 
> > > > What is the preferred way to reduce this?  For example, is a patch
> > > > like below OK to simply change the log level and the error code?
> > > 
> > > No, because if controller is actually present this is a hard failure and
> > > we should be reporting it, not suppressing it.
> > > 
> > > The issue is that we did not believe PNP data and in this case we should
> > > have. Unfortunately in old days there was a lot of crap in PNP/ACPI
> > > tables, but it could be better now. We can try, in addition to PNP
> > > matching, checking 8042 flag in "Fixed ACPI Description Table Boot
> > > Architecture Flags" in FADT and if it also shows there is no 8042 then
> > > bail.
> > 
> > That sounds promising.  Indeed FACL.dsl shows like:
> > 
> > [000h 0000   4]                    Signature : "FACP"    [Fixed ACPI Description Table (FADT)]
> > [004h 0004   4]                 Table Length : 0000010C
> > ....
> >                Legacy Devices Supported (V2) : 0
> >             8042 Present on ports 60/64 (V2) : 0
> > 
> > If a test patch gets ready, let me know, I'll give it a try.
> 
> FYI, a hack like below seems working.
> 
> 
> Takashi
> 
> ---
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 073246c7d163..ed6ab702e4b7 100644
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
> @@ -1055,6 +1056,13 @@ static int __init i8042_pnp_init(void)
>  #if defined(__ia64__)
>  		return -ENODEV;
>  #else
> +#ifdef CONFIG_ACPI
> +		if (acpi_gbl_FADT.header.revision >= 3 &&
> +		    !(acpi_gbl_FADT.boot_flags & ACPI_FADT_8042)) {
> +			pr_info("PNP: No PS/2 controller found and disabled in ACPI\n");
> +			return -ENODEV;
> +		}
> +#endif
>  		pr_info("PNP: No PS/2 controller found. Probing ports directly.\n");
>  		return 0;
>  #endif

I'm not an expert in any subsystem but, maybe this "hack" could be added
to default_i8042_detect in arch/x86/kernel/x86_init.c? Currently it is
enabled by default, but different Intel platform like ce4100 and
intel-mid disables it explicit.

I mentioned "hack" because following osdev.org[1] using ACPI is the
correct way to detect if i8042 exists. Pardon me if this not applies in
this situation, or if I missed something.

[1]
http://wiki.osdev.org/%228042%22_PS/2_Controller#Step_2:_Determine_if_the_PS.2F2_Controller_Exists

Thanks,

> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
