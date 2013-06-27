From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: Adding DT support for keyreset tuneables
Date: Thu, 27 Jun 2013 11:25:00 -0700
Message-ID: <20130627182500.GB12961@core.coreip.homeip.net>
References: <1372349605-4500-1-git-send-email-mathieu.poirier@linaro.org>
 <1372349605-4500-2-git-send-email-mathieu.poirier@linaro.org>
 <20130627162820.GA12070@core.coreip.homeip.net>
 <51CC7CD5.5090508@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:54096 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378Ab3F0SZF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jun 2013 14:25:05 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so1411208pac.1
        for <linux-input@vger.kernel.org>; Thu, 27 Jun 2013 11:25:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51CC7CD5.5090508@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: grant.likely@linaro.org, devicetree-discuss@lists.ozlabs.org, john.stultz@linaro.org, kernel-team@android.com, linux-input@vger.kernel.org

On Thu, Jun 27, 2013 at 11:56:37AM -0600, Mathieu Poirier wrote:
> On 13-06-27 10:28 AM, Dmitry Torokhov wrote:
> > Hi Mathieu,
> > 
> > On Thu, Jun 27, 2013 at 10:13:25AM -0600, mathieu.poirier@linaro.org wrote:
> >> From: "Mathieu J. Poirier" <mathieu.poirier@linaro.org>
> >>
> >> This patch adds the possibility to get the keyreset and timeout
> >> values from the device tree.
> >>
> >> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> ---
> >>  drivers/tty/sysrq.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 54 insertions(+)
> >>
> >> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> >> index b51c154..91d081c 100644
> >> --- a/drivers/tty/sysrq.c
> >> +++ b/drivers/tty/sysrq.c
> >> @@ -44,6 +44,7 @@
> >>  #include <linux/uaccess.h>
> >>  #include <linux/moduleparam.h>
> >>  #include <linux/jiffies.h>
> >> +#include <linux/of.h>
> >>  
> >>  #include <asm/ptrace.h>
> >>  #include <asm/irq_regs.h>
> >> @@ -671,6 +672,50 @@ static void sysrq_detect_reset_sequence(struct sysrq_state *state,
> >>  	}
> >>  }
> >>  
> >> +static void sysrq_of_get_keyreset_config(void)
> >> +{
> >> +	unsigned short key;
> >> +	struct device_node *np;
> >> +	const struct property *prop;
> >> +	const __be32 *val;
> >> +	int count, i;
> >> +
> >> +	np = of_find_node_by_path("/sysrq");
> >> +	if (!np) {
> >> +		pr_info("No sysrq node found");
> > 
> > I do not think this should be an info as majority would not have it
> > defined I think.
> 
> I fail to understand your point - could you please be more specific ?

pr_info() will clutter everyone's dmesg because I expect majority of
installs will not have this enabled. Please change to pr_debug or just
drop it.

> 
> > 
> >> +		goto out;
> >> +	}
> >> +
> >> +	prop = of_find_property(np, "linux,input-keyset", NULL);
> > 
> > Maybe "linux,input-key*re*set"?
> 
> I do not agree.  We want the binding to be generic and not tied
> specifically to the keyreset functionality.  As such 'input-keyset' or
> 'input-keychord' are more appropriate.

The binding is defined specifically for sysrq and specifically to
perform reset action.

> 
> > 
> >> +	if (!prop || !prop->value) {
> >> +		pr_err("Invalid input-keyset");
> >> +		goto out;
> >> +	}
> >> +
> >> +	count = prop->length / sizeof(u32);
> >> +	val = prop->value;
> >> +
> >> +	if (count > SYSRQ_KEY_RESET_MAX)
> >> +		count = SYSRQ_KEY_RESET_MAX;
> >> +
> >> +	/* reset in case a __weak definition was present */
> >> +	sysrq_reset_seq_len = 0;
> > 
> > Hmm, my preference for ordering would be software over firmware, so that
> > user could override firmware data, if needed.
> 
> The idea is to offer flexibility.  The same kernel can be used on
> multiple device.  As such DT information should be prioritised over a
> __weak symbol, otherwise it defeats the purpose.

The weak symbol should defined in board data, so it won't get picked up
on multiple boards. But I guess I do not care that much as indeed we can
change the sequence from userspace so we won't be stuck with firmware
choices.

> 
> Once the system is loaded user can still configure the keyreset
> specifics by using the /sysfs interface.
> 
> > 
> > Please also add the documenation describing the binding.
> 
> The documentation describing the binding is in patch 1/2.  You suggest
> that I add the documentation in this patch too ?

I simply missed your other patch as it hit my mailbox after this one.
But I would just combine the 2 together.

-- 
Dmitry
