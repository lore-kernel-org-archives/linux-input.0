From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - use %ph to form F34
 configuration ID
Date: Thu, 1 Jun 2017 22:10:33 -0700
Message-ID: <20170602051033.GB18657@dtor-ws>
References: <20170530044944.GA33451@dtor-ws>
 <20170530082358.GB1293@mail.corp.redhat.com>
 <20170530165913.GD12922@dtor-ws>
 <20170531211114.GB16264@lava.h.shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34587 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbdFBFKh (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 2 Jun 2017 01:10:37 -0400
Content-Disposition: inline
In-Reply-To: <20170531211114.GB16264@lava.h.shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>

On Wed, May 31, 2017 at 10:11:14PM +0100, Nick Dyer wrote:
> On Tue, May 30, 2017 at 09:59:13AM -0700, Dmitry Torokhov wrote:
> > On Tue, May 30, 2017 at 10:23:58AM +0200, Benjamin Tissoires wrote:
> > > On May 29 2017 or thereabouts, Dmitry Torokhov wrote:
> > > > Instead of printing bytes one by one, let's use %phN to print the buffer in
> > > > one go.
> > > > 
> > > > Also use hweight8 to count number of partitions instead of inspecting it
> > > > bit by bit.
> > > > 
> > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > ---
> > > 
> > > Looks good to me:
> > > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > 
> > Hm, I just realized taht we'd go from upper to lowercase hex digits. I
> > think it should be OK, but I'd like to hear interested parties (Nick).
> > 
> > Or we'd need to introduce %pH I guess.
> 
> Hi Dmitry-
> 
> I can't see any issue with this: all the firmwares I've encountered are
> purely numerical anyway.
> 
> Tested-by: Nick Dyer <nick@shmanahar.org>

Thanks Nick!

> 
> > 
> > > 
> > > Cheers,
> > > Benjamin
> > > 
> > > >  drivers/input/rmi4/rmi_f34v7.c | 22 ++++++++--------------
> > > >  1 file changed, 8 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/drivers/input/rmi4/rmi_f34v7.c b/drivers/input/rmi4/rmi_f34v7.c
> > > > index ae2db1c3aebf..3991d2943660 100644
> > > > --- a/drivers/input/rmi4/rmi_f34v7.c
> > > > +++ b/drivers/input/rmi4/rmi_f34v7.c
> > > > @@ -9,13 +9,14 @@
> > > >   * the Free Software Foundation.
> > > >   */
> > > >  
> > > > +#include <linux/bitops.h>
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/rmi.h>
> > > >  #include <linux/firmware.h>
> > > > -#include <asm/unaligned.h>
> > > >  #include <linux/delay.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/jiffies.h>
> > > > +#include <asm/unaligned.h>
> > > >  
> > > >  #include "rmi_driver.h"
> > > >  #include "rmi_f34.h"
> > > > @@ -464,7 +465,7 @@ static int rmi_f34v7_read_queries_bl_version(struct f34_data *f34)
> > > >  static int rmi_f34v7_read_queries(struct f34_data *f34)
> > > >  {
> > > >  	int ret;
> > > > -	int i, j;
> > > > +	int i;
> > > >  	u8 base;
> > > >  	int offset;
> > > >  	u8 *ptable;
> > > > @@ -519,9 +520,6 @@ static int rmi_f34v7_read_queries(struct f34_data *f34)
> > > >  
> > > >  	if (query_0 & HAS_CONFIG_ID) {
> > > >  		u8 f34_ctrl[CONFIG_ID_SIZE];
> > > > -		int i = 0;
> > > > -		u8 *p = f34->configuration_id;
> > > > -		*p = '\0';
> > > >  
> > > >  		ret = rmi_read_block(f34->fn->rmi_dev,
> > > >  				f34->fn->fd.control_base_addr,
> > > > @@ -531,13 +529,11 @@ static int rmi_f34v7_read_queries(struct f34_data *f34)
> > > >  			return ret;
> > > >  
> > > >  		/* Eat leading zeros */
> > > > -		while (i < sizeof(f34_ctrl) && !f34_ctrl[i])
> > > > -			i++;
> > > > +		for (i = 0; i < sizeof(f34_ctrl) - 1 && !f34_ctrl[i]; i++)
> > > > +			/* Empty */;
> > > >  
> > > > -		for (; i < sizeof(f34_ctrl); i++)
> > > > -			p += snprintf(p, f34->configuration_id
> > > > -				      + sizeof(f34->configuration_id) - p,
> > > > -				      "%02X", f34_ctrl[i]);
> > > > +		snprintf(f34->configuration_id, sizeof(f34->configuration_id),
> > > > +			 "%*phN", (int)sizeof(f34_ctrl) - i, f34_ctrl + i);
> > > >  
> > > >  		rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev, "Configuration ID: %s\n",
> > > >  			f34->configuration_id);
> > > > @@ -545,9 +541,7 @@ static int rmi_f34v7_read_queries(struct f34_data *f34)
> > > >  
> > > >  	f34->v7.partitions = 0;
> > > >  	for (i = 0; i < sizeof(query_1_7.partition_support); i++)
> > > > -		for (j = 0; j < 8; j++)
> > > > -			if (query_1_7.partition_support[i] & (1 << j))
> > > > -				f34->v7.partitions++;
> > > > +		f34->v7.partitions += hweight8(query_1_7.partition_support[i]);
> > > >  
> > > >  	rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev, "%s: Supported partitions: %*ph\n",
> > > >  		__func__, sizeof(query_1_7.partition_support),
> > > > -- 
> > > > 2.13.0.219.gdb65acc882-goog
> > > > 
> > > > 
> > > > -- 
> > > > Dmitry
> > 
> > -- 
> > Dmitry

-- 
Dmitry
