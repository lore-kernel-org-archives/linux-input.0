From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: Adding DT support for keyreset tuneables
Date: Thu, 27 Jun 2013 09:28:58 -0700
Message-ID: <20130627162858.GB12070@core.coreip.homeip.net>
References: <1372349605-4500-1-git-send-email-mathieu.poirier@linaro.org>
 <1372349605-4500-2-git-send-email-mathieu.poirier@linaro.org>
 <20130627162820.GA12070@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:44663 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab3F0Q3D (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jun 2013 12:29:03 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so1256989pab.39
        for <linux-input@vger.kernel.org>; Thu, 27 Jun 2013 09:29:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130627162820.GA12070@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: grant.likely@linaro.org, devicetree-discuss@lists.ozlabs.org, john.stultz@linaro.org, kernel-team@android.com, linux-input@vger.kernel.org

On Thu, Jun 27, 2013 at 09:28:20AM -0700, Dmitry Torokhov wrote:
> Hi Mathieu,
> 
> On Thu, Jun 27, 2013 at 10:13:25AM -0600, mathieu.poirier@linaro.org wrote:
> > From: "Mathieu J. Poirier" <mathieu.poirier@linaro.org>
> > 
> > This patch adds the possibility to get the keyreset and timeout
> > values from the device tree.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  drivers/tty/sysrq.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> > 
> > diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> > index b51c154..91d081c 100644
> > --- a/drivers/tty/sysrq.c
> > +++ b/drivers/tty/sysrq.c
> > @@ -44,6 +44,7 @@
> >  #include <linux/uaccess.h>
> >  #include <linux/moduleparam.h>
> >  #include <linux/jiffies.h>
> > +#include <linux/of.h>
> >  
> >  #include <asm/ptrace.h>
> >  #include <asm/irq_regs.h>
> > @@ -671,6 +672,50 @@ static void sysrq_detect_reset_sequence(struct sysrq_state *state,
> >  	}
> >  }
> >  
> > +static void sysrq_of_get_keyreset_config(void)
> > +{
> > +	unsigned short key;
> > +	struct device_node *np;
> > +	const struct property *prop;
> > +	const __be32 *val;
> > +	int count, i;
> > +
> > +	np = of_find_node_by_path("/sysrq");
> > +	if (!np) {
> > +		pr_info("No sysrq node found");
> 
> I do not think this should be an info as majority would not have it
> defined I think.
> 
> > +		goto out;
> > +	}
> > +
> > +	prop = of_find_property(np, "linux,input-keyset", NULL);
> 
> Maybe "linux,input-key*re*set"?
> 
> > +	if (!prop || !prop->value) {
> > +		pr_err("Invalid input-keyset");
> > +		goto out;
> > +	}
> > +
> > +	count = prop->length / sizeof(u32);
> > +	val = prop->value;
> > +
> > +	if (count > SYSRQ_KEY_RESET_MAX)
> > +		count = SYSRQ_KEY_RESET_MAX;
> > +
> > +	/* reset in case a __weak definition was present */
> > +	sysrq_reset_seq_len = 0;
> 
> Hmm, my preference for ordering would be software over firmware, so that
> user could override firmware data, if needed.
> 
> Please also add the documenation describing the binding.

Ah, I see the other patch now. I'd just combine the two.

-- 
Dmitry
