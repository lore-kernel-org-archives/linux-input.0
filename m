From: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH v5 2/6] i2c: add helpers to ease DMA handling
Date: Thu, 21 Sep 2017 15:05:54 +0100
Message-ID: <20170921150554.0000273b@huawei.com>
References: <20170920185956.13874-1-wsa+renesas@sang-engineering.com>
        <20170920185956.13874-3-wsa+renesas@sang-engineering.com>
        <20170921145922.000017b5@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170921145922.000017b5-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 21 Sep 2017 14:59:22 +0100
Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:

> On Wed, 20 Sep 2017 20:59:52 +0200
> Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org> wrote:
> 
> > One helper checks if DMA is suitable and optionally creates a bounce
> > buffer, if not. The other function returns the bounce buffer and makes
> > sure the data is properly copied back to the message.
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>  
> 
> One minor suggestion for wording. Otherwise looks good to me.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>

Need more coffee. See below.
 
> > ---
> >  drivers/i2c/i2c-core-base.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/i2c.h         |  3 +++
> >  2 files changed, 48 insertions(+)
> > 
> > diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> > index 56e46581b84bdb..925a22794d3ced 100644
> > --- a/drivers/i2c/i2c-core-base.c
> > +++ b/drivers/i2c/i2c-core-base.c
> > @@ -2241,6 +2241,51 @@ void i2c_put_adapter(struct i2c_adapter *adap)
> >  }
> >  EXPORT_SYMBOL(i2c_put_adapter);
> >  
> > +/**
> > + * i2c_get_dma_safe_msg_buf() - get a DMA safe buffer for the given i2c_msg
> > + * @msg: the message to be checked
> > + * @threshold: the amount of byte from which using DMA makes sense  
> 
> the minimum number of bytes for which using DMA makes sense.
> 
> > + *
> > + * Return: NULL if a DMA safe buffer was not obtained. Use msg->buf with PIO.
> > + *
> > + *	   Or a valid pointer to be used with DMA. Note that it can either be
> > + *	   msg->buf or a bounce buffer. After use, release it by calling
> > + *	   i2c_release_dma_safe_msg_buf().
> > + *
> > + * This function must only be called from process context!
> > + */
> > +u8 *i2c_get_dma_safe_msg_buf(struct i2c_msg *msg, unsigned int threshold)
> > +{
> > +	if (msg->len < threshold)
> > +		return NULL;
> > +
> > +	if (msg->flags & I2C_M_DMA_SAFE)
> > +		return msg->buf;
> > +
> > +	if (msg->flags & I2C_M_RD)
> > +		return kzalloc(msg->len, GFP_KERNEL);
> > +	else
> > +		return kmemdup(msg->buf, msg->len, GFP_KERNEL);
> > +}
> > +EXPORT_SYMBOL_GPL(i2c_get_dma_safe_msg_buf);
> > +
> > +/**
> > + * i2c_release_dma_safe_msg_buf - release DMA safe buffer and sync with i2c_msg
> > + * @msg: the message to be synced with
> > + * @buf: the buffer obtained from i2c_get_dma_safe_msg_buf(). May be NULL.
> > + */
> > +void i2c_release_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf)
> > +{
> > +	if (!buf || buf == msg->buf)
> > +		return;
> > +
> > +	if (msg->flags & I2C_M_RD)
> > +		memcpy(msg->buf, buf, msg->len);
> > +
> > +	kfree(buf);

Only free when you actually allocated it.  Seems to me like you need
to check if (!(msg->flags & I2C_M_DMA_SAFE)) before kfree.

Otherwise the logic to do this will be needed in every driver
which will get irritating fast.


> > +}
> > +EXPORT_SYMBOL_GPL(i2c_release_dma_safe_msg_buf);
> > +
> >  MODULE_AUTHOR("Simon G. Vogl <simon-nD9nYVNVf00W+b/DJNNodF6hYfS7NtTn@public.gmane.org>");
> >  MODULE_DESCRIPTION("I2C-Bus main module");
> >  MODULE_LICENSE("GPL");
> > diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> > index d501d3956f13f0..1e99342f180f45 100644
> > --- a/include/linux/i2c.h
> > +++ b/include/linux/i2c.h
> > @@ -767,6 +767,9 @@ static inline u8 i2c_8bit_addr_from_msg(const struct i2c_msg *msg)
> >  	return (msg->addr << 1) | (msg->flags & I2C_M_RD ? 1 : 0);
> >  }
> >  
> > +u8 *i2c_get_dma_safe_msg_buf(struct i2c_msg *msg, unsigned int threshold);
> > +void i2c_release_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf);
> > +
> >  int i2c_handle_smbus_host_notify(struct i2c_adapter *adap, unsigned short addr);
> >  /**
> >   * module_i2c_driver() - Helper macro for registering a modular I2C driver  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
