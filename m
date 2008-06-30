From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: Xilinx: PS2: Added new XPS PS2 driver
Date: Mon, 30 Jun 2008 12:53:17 -0600
Message-ID: <20080630185317.GB19249@secretlab.ca>
References: <20080630142451.516A41D1006C@mail57-sin.bigfish.com> <20080630171628.GF17916@secretlab.ca> <20080630135531.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:64011 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760006AbYF3Sx3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2008 14:53:29 -0400
Received: by yw-out-2324.google.com with SMTP id 9so812676ywe.1
        for <linux-input@vger.kernel.org>; Mon, 30 Jun 2008 11:53:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080630135531.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: John Linn <john.linn@xilinx.com>, linuxppc-dev@ozlabs.org, Sadanand <sadanan@xilinx.com>, linux-input@vger.kernel.org

On Mon, Jun 30, 2008 at 02:10:23PM -0400, Dmitry Torokhov wrote:
> Hi Grant, John,
> 
> On Mon, Jun 30, 2008 at 11:16:28AM -0600, Grant Likely wrote:
> > On Mon, Jun 30, 2008 at 07:24:48AM -0700, John Linn wrote:
<snip>
> > > +/*
> > > + * sxps2_write() sends a byte out through the PS/2 interface.
> > > + *
> > > + * The sole purpose of drvdata->tx_end is to prevent the driver
> > > + * from locking up in the do {} while; loop when nothing is connected
> > > + * to the given PS/2 port. That's why we do not try to recover
> > > + * from the transmission failure.
> > > + * drvdata->tx_end needs not to be initialized to some "far in the
> > > + * future" value, as the very first attempt to xps2_send() a byte
> > > + * is always successful, and drvdata->tx_end will be set to a proper
> > > + * value at that moment - before the 1st use in the comparison.
> > > + */
> > 
> > Good comment block.
> > 
> > nitpick: can you reformat the comment blocks to be in kerneldoc format?
> > That will allow the automatic document generation tools to parse it.
> > 
> > see: Documentation/kernel-doc-nano-HOWTO.txt
> 
> This is an internal function so its not going to be exposed in
> kerneldoc though.

Just to complete this discussion, quoting from kernel-doc-nano-HOWTO.txt:

  "We also recommend providing kernel-doc formatted documentation
  for private (file "static") routines, for consistency of kernel
  source code layout.  But this is lower priority and at the
  discretion of the MAINTAINER of that kernel source file."

but it's just a nitpick, and I'll say nothing more about it.

g.
