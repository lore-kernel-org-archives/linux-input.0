From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] Input: ambakmi - Use managed interfaces
Date: Sun, 13 Jul 2014 20:11:29 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1407132010130.2060@localhost6.localdomain6>
References: <20140713173051.GA4299@himangi-Dell> <20140713175308.GL21766@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:45893
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750767AbaGMSLc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Jul 2014 14:11:32 -0400
In-Reply-To: <20140713175308.GL21766@n2100.arm.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Himangi Saraogi <himangi774@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr

On Sun, 13 Jul 2014, Russell King - ARM Linux wrote:

> On Sun, Jul 13, 2014 at 11:00:51PM +0530, Himangi Saraogi wrote:
> > @@ -23,6 +23,7 @@
> >  #include <linux/clk.h>
> >  
> >  #include <asm/io.h>
> > +#include <linux/io.h>
> 
> NAK - please include either linux/io.h _or_ asm/io.h but not both.
> 
> > @@ -112,19 +113,10 @@ static int amba_kmi_probe(struct amba_device *dev,
> >  {
> >  	struct amba_kmi_port *kmi;
> >  	struct serio *io;
> > -	int ret;
> > -
> > -	ret = amba_request_regions(dev, NULL);
> > -	if (ret)
> > -		return ret;
> 
> I'm /really/ not happy about that going.

Could you explain why?  I looked at the code several times, and I couldn't 
see how it was different than request_mem_region, which is merged into 
devm_ioremap_resource.

thanks,
julia

> 
> > -
> > -	kmi = kzalloc(sizeof(struct amba_kmi_port), GFP_KERNEL);
> > -	io = kzalloc(sizeof(struct serio), GFP_KERNEL);
> > -	if (!kmi || !io) {
> > -		ret = -ENOMEM;
> > -		goto out;
> > -	}
> >  
> > +	io = devm_kzalloc(&dev->dev, sizeof(struct serio), GFP_KERNEL);
> > +	if (!io)
> > +		return -ENOMEM;
> >  
> >  	io->id.type	= SERIO_8042;
> >  	io->write	= amba_kmi_write;
> > @@ -135,32 +127,20 @@ static int amba_kmi_probe(struct amba_device *dev,
> >  	io->port_data	= kmi;
> >  	io->dev.parent	= &dev->dev;
> >  
> > +	kmi->base	= devm_ioremap_resource(&dev->dev, &dev->res);
> > +	if (IS_ERR(kmi->base))
> > +		return PTR_ERR(kmi->base);
> 
> NAK.  Look carefully through the above changes to work out why.  Please,
> if you don't understand what you're doing, or don't even bother with a
> build test of the code you've modified, don't even modify it in the
> first place.
> 
> -- 
> FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
> according to speedtest.net.
> 
