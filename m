From: Huang Rui <ray.huang@amd.com>
Subject: Re: [PATCH] input: i8042: add quirk to implement i8042 detect for AMD
Date: Fri, 16 Oct 2015 17:06:18 +0800
Message-ID: <20151016090617.GB17783@hr-amur2>
References: <1445002020-12672-1-git-send-email-Vincent.Wan@amd.com>
 <20151016085808.GA32193@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0071.outbound.protection.outlook.com ([65.55.169.71]:65166
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751968AbbJPKlU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Oct 2015 06:41:20 -0400
Content-Disposition: inline
In-Reply-To: <20151016085808.GA32193@pd.tnic>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Aaron Lu <aaron.lu@intel.com>
Cc: "Wan, Vincent" <Vincent.Wan@amd.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mcuos.com@gmail.com" <mcuos.com@gmail.com>

On Fri, Oct 16, 2015 at 04:58:09PM +0800, Borislav Petkov wrote:
> On Fri, Oct 16, 2015 at 09:27:00AM -0400, Vincent Wan wrote:
> > Detecting platform supports i8042 or not, AMD resorted to
> > BIOS's FADT i8042 flag.
> > 
> > Signed-off-by: Vincent Wan <Vincent.Wan@amd.com>
> > ---
> >  drivers/input/serio/i8042-x86ia64io.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> > index c115565..bf3a605 100644
> > --- a/drivers/input/serio/i8042-x86ia64io.h
> > +++ b/drivers/input/serio/i8042-x86ia64io.h
> > @@ -9,6 +9,7 @@
> >  
> >  #ifdef CONFIG_X86
> >  #include <asm/x86_init.h>
> > +#include <linux/acpi.h>
> >  #endif
> >  
> >  /*
> > @@ -1047,6 +1048,11 @@ static int __init i8042_platform_init(void)
> >  	/* Just return if pre-detection shows no i8042 controller exist */
> >  	if (!x86_platform.i8042_detect())
> >  		return -ENODEV;
> > +
> > +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
> 
> Why the vendor check if you're accessing a bit defined in the ACPI spec?
> 

Yeah, I have the same concern with AMD vendor check. :)

Aaron, could you please help to check the impact at intel platfomrs if
we remove this check?

Thanks,
Rui
