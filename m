From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] HID: i2c-hid: support the regulator
Date: Wed, 14 Sep 2016 15:55:06 +0800
Message-ID: <20160914075505.GA14271@localhost>
References: <1473027116-13892-1-git-send-email-wxt@rock-chips.com>
 <1473027116-13892-2-git-send-email-wxt@rock-chips.com>
 <20160914073603.GH25951@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160914073603.GH25951-/m+UfqrgI5QNLKR9yMNcA1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Dmitry Torokhov <dtor-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Guohua Zhong <ghzhong-COaM65pZ/3cNIbNsV2NXlwC/G2K4zDHf@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Zhonghui\"" <zhonghui.fu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

On Wed, Sep 14, 2016 at 09:36:03AM +0200, Benjamin Tissoires wrote:
> On Sep 05 2016 or thereabouts, Caesar Wang wrote:
> > diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> > index b3ec4f2..07cc7aa 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/acpi.h>
> >  #include <linux/of.h>
> >  #include <linux/gpio/consumer.h>
> > +#include <linux/regulator/consumer.h>
> >  
> >  #include <linux/i2c/i2c-hid.h>
> >  
> > @@ -152,6 +153,7 @@ struct i2c_hid {
> >  
> >  	bool			irq_wake_enabled;
> >  	struct mutex		reset_lock;
> > +	struct regulator	*supply;
> >  };
> >  
> >  static int __i2c_hid_command(struct i2c_client *client,
> > @@ -968,6 +970,21 @@ static int i2c_hid_probe(struct i2c_client *client,
> >  	if (!ihid)
> >  		return -ENOMEM;
> >  
> > +	ihid->supply = devm_regulator_get(&client->dev, "power");
> > +	if (IS_ERR(ihid->supply)) {
> 
> I am not familiar with regulators, but what if (like 99% of the
> available i2c-hid devices) there is no regulator attached to the device?
> 
> Will the pointer be null? Will there be a dummy regulator?
> 
> It seems at first sight that you are adding a requirement on the devices
> which is not part of the spec, and which will break every existing
> systems but yours. Again, I might be wrong, so please provide more
> information.

The default behavior of regulator_get() is to provide a dummy regulator
if none is found. So the pointer is never NULL, and it won't break
devices without a regulator. If you don't want a dummy regulator you
would use regulator_get_optional() instead, and you would then need to
handle ERR_PTR(-ENODEV) specifically.

Brian
