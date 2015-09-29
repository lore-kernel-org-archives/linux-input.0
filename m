From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch] Input: ff-core - silence an underflow warning
Date: Tue, 29 Sep 2015 16:03:15 -0700
Message-ID: <20150929230315.GA29469@dtor-ws>
References: <20150922132643.GA5751@mwanda>
 <20150929002830.GD30653@dtor-ws>
 <20150929131258.GC7340@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150929131258.GC7340@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Sep 29, 2015 at 04:12:58PM +0300, Dan Carpenter wrote:
> On Mon, Sep 28, 2015 at 05:28:30PM -0700, Dmitry Torokhov wrote:
> > On Tue, Sep 22, 2015 at 04:26:43PM +0300, Dan Carpenter wrote:
> > > My static checker complains that "value" comes from the user in
> > > evdev_do_ioctl() and we check that it's not too large here but we don't
> > > check that it's negative.  It's harmless because the ->set_gain() and
> > > ->set_autocenter() functions truncate it to a valid u16 value, but we
> > > may as well fix it just to make the static checker happy.
> > > 
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > 
> > > diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
> > > index c642082..6a94c5f 100644
> > > --- a/drivers/input/ff-core.c
> > > +++ b/drivers/input/ff-core.c
> > > @@ -273,14 +273,14 @@ int input_ff_event(struct input_dev *dev, unsigned int type,
> > >  
> > >  	switch (code) {
> > >  	case FF_GAIN:
> > > -		if (!test_bit(FF_GAIN, dev->ffbit) || value > 0xffff)
> > > +		if (!test_bit(FF_GAIN, dev->ffbit) || value > 0xffffUL)
> > >  			break;
> > >  
> > >  		ff->set_gain(dev, value);
> > >  		break;
> > >  
> > >  	case FF_AUTOCENTER:
> > > -		if (!test_bit(FF_AUTOCENTER, dev->ffbit) || value > 0xffff)
> > > +		if (!test_bit(FF_AUTOCENTER, dev->ffbit) || value > 0xffffUL)
> > 
> > Why UL and not U?
> > 
> 
> You're right.  That could just be U.  I'll resend.

That's fine, I'll adjust on my side.

Thanks.

-- 
Dmitry
