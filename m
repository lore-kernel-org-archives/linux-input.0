From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: introduce managed input devices (add devres support)
Date: Mon, 29 Oct 2012 15:12:20 -0700
Message-ID: <8202410.zO713iQhxO@dtor-d630.eng.vmware.com>
References: <20121023053513.GA15642@core.coreip.homeip.net> <20121029204023.GB13256@core.coreip.homeip.net> <20121029213254.GA15390@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121029213254.GA15390@polaris.bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
List-Id: linux-input@vger.kernel.org

On Monday, October 29, 2012 10:32:54 PM Henrik Rydberg wrote:
> > > Either way, the code looks functional to me.
> > 
> > So is that "reviewed-by"?
> 
> I was thinking about this hunk:
> > @@ -1972,7 +2084,20 @@ int input_register_device(struct input_dev *dev)
> > 
> >         mutex_unlock(&input_mutex);
> > 
> > +       if (dev->devres_managed) {
> > +               dev_info(dev->dev.parent, "%s: registerign %s with
> > devres.\n", +                       __func__, dev->name ?: "N/A");
> > +               devres_add(dev->dev.parent, devres);
> > +       }
> > 
> >         return 0;
> > 
> > +
> > +err_device_del:
> > +       device_del(&dev->dev);
> > +err_free_vals:
> > +       kfree(dev->vals);
> 
> Won't this yield a double free once we reach release()?

Nicely spotted, we need "dev->vals = NULL;" here.

-- 
Dmitry
