From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/3] bitmap: Add bitmap_alloc(), bitmap_zalloc() and
 bitmap_free()
Date: Mon, 04 Jun 2018 12:59:54 +0300
Message-ID: <cfe3fa909edd73ba84dd367a11a570866647a3f4.camel@linux.intel.com>
References: <20180601083120.40352-1-andriy.shevchenko@linux.intel.com>
         <20180601183343.GA222005@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180601183343.GA222005@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 2018-06-01 at 11:33 -0700, Dmitry Torokhov wrote:
> Hi Andy,
> 
> On Fri, Jun 01, 2018 at 11:31:18AM +0300, Andy Shevchenko wrote:
> > A lot of code become ugly because of open coding allocations for
> > bitmaps.
> > 
> > Introduce three helpers to allow users be more clear of intention
> > and keep their code neat.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This looks nice and I like how it simplifies drivers.

Thanks!

>  How do we merge
> this? 

I suppose through 'input' tree if there is no objections.

> > ---
> >  include/linux/bitmap.h | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> > index 1ee46f492267..845822425393 100644
> > --- a/include/linux/bitmap.h
> > +++ b/include/linux/bitmap.h
> > @@ -6,6 +6,7 @@
> >  
> >  #include <linux/types.h>
> >  #include <linux/bitops.h>
> > +#include <linux/slab.h>
> >  #include <linux/string.h>
> >  #include <linux/kernel.h>
> >  
> > @@ -104,6 +105,21 @@
> >   * contain all bit positions from 0 to 'bits' - 1.
> >   */
> >  
> > +static inline unsigned long *bitmap_alloc(unsigned int nbits, gfp_t
> > flags)
> > +{
> > +	return kmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned
> > long), flags);
> > +}
> > +
> > +static inline unsigned long *bitmap_zalloc(unsigned int nbits,
> > gfp_t flags)
> > +{
> > +	return kcalloc(BITS_TO_LONGS(nbits), sizeof(unsigned long),
> > flags);
> 
> 	retrun bitmap_alloc(nbits, flags | __GFP_ZERO);
> 
> ?

I though about this, but decide not to rely on linux/gfp.h.
If you think explicit __GFP_ZERO is better, I can replace in v2, or if
you have a chance to do that when applying it would be appreciated.

> 
> > +}
> > +
> > +static inline void bitmap_free(const unsigned long *bitmap)
> > +{
> > +	kfree(bitmap);
> > +}
> > +
> >  /*
> >   * lib/bitmap.c provides these functions:
> >   */
> > -- 
> > 2.17.0
> > 
> 
> Thanks.
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
