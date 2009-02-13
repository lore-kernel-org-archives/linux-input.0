From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch for 2.6.29? 1/2] input: introduce a tougher i8042.reset
Date: Fri, 13 Feb 2009 00:44:39 -0800
Message-ID: <20090213004035.ZZRA012@mailhub.coreip.homeip.net>
References: <200902112110.n1BLAfJA008014@imap1.linux-foundation.org> <alpine.LRH.1.10.0902120142500.22097@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.180]:22793 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbZBMIow (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Feb 2009 03:44:52 -0500
Received: by el-out-1112.google.com with SMTP id b25so751346elf.1
        for <linux-input@vger.kernel.org>; Fri, 13 Feb 2009 00:44:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LRH.1.10.0902120142500.22097@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: akpm@linux-foundation.org, linux-input@vger.kernel.org, arjan@linux.intel.com

Hi Jiri, Andrew,

On Thu, Feb 12, 2009 at 01:45:15AM +0100, Jiri Kosina wrote:
> On Wed, 11 Feb 2009, akpm@linux-foundation.org wrote:
> 
> > Some touchpads don't reset right the first time (MSI Wind U-100 for
> > example).  This patch will retry the reset up to 5 times.
> 
> Yes, I agree we should seriously consider this a 2.6.29 material if we 
> want to avoid a lot of repeating bugreports in the future, as more and 
> more people start buying these toys.
> 

We have never reset KBC on x86 leaving BIOS deal with it so that's the
first. Is there a bug report or thread I could read a bit more about the
problem?

> In addition to that, I'd propose the patch below also for 2.6.29. Dmitry, 
> what do you think?
> 

No, not in the current form. We already have psmouse_reset() on resume
(and during ordinary detect). If we need it earlier that is fine but
we don't need to do it twice. The option has to go too, since we
currently are resetting the device I don't think it is needed.

> 
> From: Andy Whitcroft <apw@canonical.com>
> Subject: [PATCH 1/1] psmouse/synaptics: ensure we reset the device on resume
> 
> When resuming from suspend newer Synaptics touchpads do not recover
> correctly.  Analysis of the resume sequence as applied in Linux was
> compared to that of other operating systems.  This indicated that the
> other OSs were resetting the mouse before attempting to detect it (for
> all Synaptics touchpads, old and new).  Applying this same modification
> fixes these newer Synaptics touchpads and brings the driver into line
> with common OS reset behaviour.
> 
> This patch adds this reset by default providing a module option to
> restore the previous non-reset behaviour:
> 
> 	psmouse.synaptics_resume_reset=N
> 
> Also a message is emmitted on resume hinting as to how to fix a broken
> touchpad.
> 
> Signed-off-by: Andy Whitcroft <apw@canonical.com>
> ---
>  drivers/input/mouse/synaptics.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index d349c4a..5b01c14 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -60,11 +60,21 @@ static int synaptics_mode_cmd(struct psmouse *psmouse, unsigned char mode)
>  	return 0;
>  }
>  
> +static int synaptics_resume_reset = 1;
> +module_param(synaptics_resume_reset, bool, 0);
> +MODULE_PARM_DESC(synaptics_resume_reset,
> +				"Enable reset on resume for Synaptics");
> +
>  int synaptics_detect(struct psmouse *psmouse, int set_properties)
>  {
>  	struct ps2dev *ps2dev = &psmouse->ps2dev;
>  	unsigned char param[4];
>  
> +	if (synaptics_resume_reset) {
> +		printk(KERN_CRIT "WARNING: synaptics was reset on resume, see synaptics_resume_reset if you have trouble on resume\n");
> +		psmouse_reset(psmouse);
> +	}
> +
>  	param[0] = 0;
>  
>  	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
> 

-- 
Dmitry
