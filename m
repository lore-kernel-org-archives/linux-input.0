From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/8] i2c: export i2c_client_type structure
Date: Wed, 15 Mar 2017 16:50:50 -0700
Message-ID: <20170315235050.GB7126@dtor-ws>
References: <20170309221644.17035-1-dmitry.torokhov@gmail.com>
 <20170309221644.17035-2-dmitry.torokhov@gmail.com>
 <20170309231246.GA4300@tetsubishi>
 <20170313145045.427cad3e@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170313145045.427cad3e@endymion>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jean,

On Mon, Mar 13, 2017 at 02:50:45PM +0100, Jean Delvare wrote:
> Hi Dmitry,
> 
> On Fri, 10 Mar 2017 00:12:46 +0100, Wolfram Sang wrote:
> > On Thu, Mar 09, 2017 at 02:16:37PM -0800, Dmitry Torokhov wrote:
> > > i2c bus has 2 different types of device belonging to the same bus and
> > > bus notifiers use device type to distinguish between adapters and clients.
> 
> Out of curiosity, is this something unusual, or other bus types do the
> same?

I think I2C is somewhat special because of compounding of multiple
factors:

1. It uses several device types (clients and adapters) on the same bus.
It is not unique in this way, many buses do that (w1 for example), but
others do not (spi).

2. We are starting using i2c bus notifiers more and more because x86
platform is shitty at describing i2c devices. Even if device is
described in ACPI, there is high chance that description is incomplete,
and if it is "complete", then it is quite likely wrong. Or they may not
be described in ACPI at all and require vendor drivers on Windows to
activate and operate (as with these SMBus companions to PS/2 devices).
Thankfully SPI is not as popular on X86, or we'd have the same mess
there.

So we create bunch of notifiers and try to "fix" stuff, but we need to
verify that we are dealing with the right device type. We already have
to_verified_client() and to_verified_adapter(), and i2c_adapter_type was
already exported, so in cases where I need to work with both adapters
and clients I wanted to export i2c_client_type as well. So if we ever
add a 3rd type we do not have to go back and adjust existing code. I
think it looks makes code easier to read if you test for equality to
client if you want clients.

> 
> > > Previously we only had i2c_adapter_type exported, which made code wanting
> > > to work with i2c_client devices test for type not equal to adapter type.
> > > This unfortunately is not safe if we ever add another type to the bus,
> > > so let's export i2c_client_type as well.
> > > 
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > > 
> > > Wolfram, this is the patch I was talking about in the other mail.
> > 
> > I see. From a glimpse, I am fine with the patch. I'll add Jean Delvare
> > to CC, though, in case I missed some detail he still knows. Furthermore,
> > while I agree that testing for "not adapter" when one means "is client"
> > is not nice, is there a bigger benefit than being correct in your queue?
> 
> No objection from me.
> 
> Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks!

> 
> > > 
> > >  drivers/i2c/i2c-core.c | 4 ++--
> > >  include/linux/i2c.h    | 1 +
> > >  2 files changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > > index 34a5115484dd..446e341e9508 100644
> > > --- a/drivers/i2c/i2c-core.c
> > > +++ b/drivers/i2c/i2c-core.c
> > > @@ -74,7 +74,6 @@
> > >  static DEFINE_MUTEX(core_lock);
> > >  static DEFINE_IDR(i2c_adapter_idr);
> > >  
> > > -static struct device_type i2c_client_type;
> > >  static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver);
> > >  
> > >  static struct static_key i2c_trace_msg = STATIC_KEY_INIT_FALSE;
> > > @@ -1096,11 +1095,12 @@ struct bus_type i2c_bus_type = {
> > >  };
> > >  EXPORT_SYMBOL_GPL(i2c_bus_type);
> > >  
> > > -static struct device_type i2c_client_type = {
> > > +struct device_type i2c_client_type = {
> > >  	.groups		= i2c_dev_groups,
> > >  	.uevent		= i2c_device_uevent,
> > >  	.release	= i2c_client_dev_release,
> > >  };
> > > +EXPORT_SYMBOL_GPL(i2c_client_type);
> > >  
> > >  
> > >  /**
> > > diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> > > index 2cc3988d127b..89ca5e56b433 100644
> > > --- a/include/linux/i2c.h
> > > +++ b/include/linux/i2c.h
> > > @@ -37,6 +37,7 @@
> > >  
> > >  extern struct bus_type i2c_bus_type;
> > >  extern struct device_type i2c_adapter_type;
> > > +extern struct device_type i2c_client_type;
> > >  
> > >  /* --- General options ------------------------------------------------	*/
> > >  
> > > -- 
> > > 2.12.0.246.ga2ecc84866-goog
> > > 
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support

-- 
Dmitry
