From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c-hid: explicitly cast parametrs to follow specifiers
Date: Wed, 04 Sep 2013 14:51:14 +0300
Message-ID: <1378295474.22798.15.camel@smile>
References: <1372163081-11394-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <alpine.LNX.2.00.1309041317030.3684@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3971 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757410Ab3IDLv3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Sep 2013 07:51:29 -0400
In-Reply-To: <alpine.LNX.2.00.1309041317030.3684@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On Wed, 2013-09-04 at 13:17 +0200, Jiri Kosina wrote: 
> On Tue, 25 Jun 2013, Andy Shevchenko wrote:
> 
> > The vendor and product parameters are defined as __u32, but used as short int.
> > Let's do an explicit casting for them.
> 
> Is this fixing any compiler warning you have seen?

It was found by static analyzer.

> 
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/hid/i2c-hid/i2c-hid.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> > index 879b0ed..d595f2a 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid.c
> > @@ -1009,7 +1009,7 @@ static int i2c_hid_probe(struct i2c_client *client,
> >  	hid->product = le16_to_cpu(ihid->hdesc.wProductID);
> >  
> >  	snprintf(hid->name, sizeof(hid->name), "%s %04hX:%04hX",
> > -		 client->name, hid->vendor, hid->product);
> > +		 client->name, (short int)hid->vendor, (short int)hid->product);

...and it's probably better to use (unsigned short int) if this patch is
going anywhere.

> >  
> >  	ret = hid_add_device(hid);
> >  	if (ret) {
> > -- 
> > 1.8.3.1
> > 
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
