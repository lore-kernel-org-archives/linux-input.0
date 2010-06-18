From: Jerone Young <jerone.young@canonical.com>
Subject: Re: [patch] add quirk to fix volume wheel on Toshiba U300 laptops
Date: Fri, 18 Jun 2010 08:14:34 -0500
Message-ID: <1276866874.7383.130.camel@laptop>
References: <201006091337.10152.akohlsmith@mixdown.ca>
	 <alpine.LNX.2.00.1006181431080.13809@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:35995 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760958Ab0FRNOl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jun 2010 09:14:41 -0400
In-Reply-To: <alpine.LNX.2.00.1006181431080.13809@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Andrew Kohlsmith <akohlsmith@mixdown.ca>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Andrew

	Actually this patch should go into udev. udev now handles keyreleasing.
drivers/input/keyboard/atkbd.c is to no longer take fixes like this.

	There is a rule in udev 95-keyboard-force-release.rules .. you just
need to add these machines. There is a file common-volume-keys you would
have run for these machines .. you'll see other machines in the rules
file with the same fix.

				Jerone



On Fri, 2010-06-18 at 14:32 +0200, Jiri Kosina wrote:
> On Wed, 9 Jun 2010, Andrew Kohlsmith wrote:
> 
> > Good afternoon,
> > 
> > Here is a small patch which adds a quirk match for these laptops; the volume 
> > wheel on them does not stop when you move it (the wheel does not send 'up' 
> > keycodes).
> > 
> > Patch applies cleanly to linus' tree as of about...10 minutes ago. :-)
> 
> Hi Andrew,
> 
> this patch needs to go through Dmitry, who is current input subsystem 
> maintainer.
> 
> I have added him (and linux-input) to CC, and included the patch for 
> convenience below.
> 
> You'd also need to include your Signed-off-by: line in order for the patch 
> to be properly merged.
> 
> Thanks.
> 
> 
> 
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> index d358ef8..f1e1801 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -1715,6 +1715,22 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
>  		.callback = atkbd_setup_scancode_fixup,
>  		.driver_data = atkbd_oqo_01plus_scancode_fixup,
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite U300"),
> +		},
> +		.callback = atkbd_setup_forced_release,
> +		.driver_data = atkbd_volume_forced_release_keys,
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite Pro U300"),
> +		},
> +		.callback = atkbd_setup_forced_release,
> +		.driver_data = atkbd_volume_forced_release_keys,
> +	},
>  	{ }
>  };
>  
> 


