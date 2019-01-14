From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] Input: uinput - fix undefined behavior in
 uinput_validate_absinfo()
Date: Tue, 15 Jan 2019 08:41:14 +1000
Message-ID: <20190114224114.GA18464@jelly>
References: <20190114220448.GA241112@dtor-ws>
 <20190114220756.GF117329@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190114220756.GF117329@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>, rydberg@bitmath.org, DaeRyong Jeong <threeearcat@gmail.com>, syzkaller@googlegroups.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jan 14, 2019 at 02:07:56PM -0800, Dmitry Torokhov wrote:
> On Mon, Jan 14, 2019 at 02:04:48PM -0800, Dmitry Torokhov wrote:
> > An integer overflow may arise in uinput_validate_absinfo() if "max - min"
> > can't be represented by an "int". We should check for overflow before
> > trying to use the result.
> > 
> > Reported-by: Kyungtae Kim <kt0755@gmail.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/misc/uinput.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> > index 8ec483e8688b..26ec603fe220 100644
> > --- a/drivers/input/misc/uinput.c
> > +++ b/drivers/input/misc/uinput.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/init.h>
> >  #include <linux/fs.h>
> >  #include <linux/miscdevice.h>
> > +#include <linux/overflow.h>
> >  #include <linux/input/mt.h>
> >  #include "../input-compat.h"
> >  
> > @@ -405,7 +406,7 @@ static int uinput_open(struct inode *inode, struct file *file)
> >  static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
> >  				   const struct input_absinfo *abs)
> >  {
> > -	int min, max;
> > +	int min, max, range;
> >  
> >  	min = abs->minimum;
> >  	max = abs->maximum;
> > @@ -417,7 +418,7 @@ static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
> >  		return -EINVAL;
> >  	}
> >  
> > -	if (abs->flat > max - min) {
> > +	if (check_sub_overflow(max, min, &range) && abs->flat > range) {
> 
> This should be !check_sub_overflow(...) of course.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net> with that in place,
thanks.

Cheers,
   Peter
 

> >  		printk(KERN_DEBUG
> >  		       "%s: abs_flat #%02x out of range: %d (min:%d/max:%d)\n",
> >  		       UINPUT_NAME, code, abs->flat, min, max);
> > -- 
> > 2.20.1.97.g81188d93c3-goog
> > 
> > 
> > -- 
> > Dmitry
> 
> -- 
> Dmitry
