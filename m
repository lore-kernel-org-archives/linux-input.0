From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add support for PowerOn(PonKey) button on the
 AB8500 MFD
Date: Thu, 2 Sep 2010 10:22:23 -0700
Message-ID: <20100902172222.GA17386@core.coreip.homeip.net>
References: <1283326551-13751-1-git-send-email-sundar.iyer@stericsson.com>
 <20100901165142.GB6908@core.coreip.homeip.net>
 <20100902065537.GA26429@bnru01.bnr.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42951 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966Ab0IBRW3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Sep 2010 13:22:29 -0400
Received: by iwn5 with SMTP id 5so688585iwn.19
        for <linux-input@vger.kernel.org>; Thu, 02 Sep 2010 10:22:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100902065537.GA26429@bnru01.bnr.st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: Sundar R IYER <sundar.iyer@stericsson.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

On Thu, Sep 02, 2010 at 12:25:37PM +0530, Rabin Vincent wrote:
> On Wed, Sep 01, 2010 at 18:51:42 +0200, Dmitry Torokhov wrote:
> > On Wed, Sep 01, 2010 at 01:05:51PM +0530, Sundar Iyer wrote:
> > > +	ret = request_threaded_irq(info->irq_dbr, NULL, ab8500_ponkey_handler,
> > > +					0, "ab8500-ponkey-dbr", info);
> > > +	if (ret < 0) {
> > > +		dev_err(ab8500->dev, "Failed to request dbr IRQ#%d: %d\n",
> > > +				info->irq_dbr, ret);
> > > +		goto out_irq_dbf;
> > > +	}
> > > +
> > 
> > Why threaded IRQs? The interrupt handlers do not do _anything_ except for
> > passing the event up. Do you really think that starting 2 kernel threads
> > to handle 1 button is the best use of the resources???
> 
> Because the parent MFD uses nested threads for handling interrupts, you
> must specify a thread function.  No new thread is started; this
> interrupt handler is called from the parent MFD's interrupt thread.
> 

I see.

> > 
> > I'll change it to use normal interrupts locally, no need to resubmit.
> 
> Changing it to request_irq() will cause it to fail, because __setup_irq
> will error out if this is a nested thread interrupt and no interrupt
> thread is specified.  request_any_context_irq() should work, if you
> would like to get rid of explicitly asking for a threaded irq.
> 

OK, request_any_context_irq() it is then.

-- 
Dmitry
