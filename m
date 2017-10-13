From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 1/2] Input: goodix - support gt1151 touchpanel
Date: Fri, 13 Oct 2017 18:40:42 +0200
Message-ID: <1507912842.5910.39.camel@hadess.net>
References: <20171012150443.27542-1-m.niestroj@grinn-global.com>
         <20171013180221.76b67869cf4eed7eeec3f56f@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171013180221.76b67869cf4eed7eeec3f56f-qKGr9MkilAE@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antonio Ospite <ao2-qKGr9MkilAE@public.gmane.org>, Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, 2017-10-13 at 18:02 +0200, Antonio Ospite wrote:
> On Thu, 12 Oct 2017 17:04:42 +0200
> Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org> wrote:
> 
> > Support was added based on Goodix GitHub repo [1]. There are two
> > major
> > differences between gt1151 and currently supported devices (gt9x):
> >  * CONFIG_DATA register has 0x8050 address instead of 0x8047,
> >  * config data checksum has 16-bit width instead of 8-bit.
> > 
> > Also update goodix_i2c_test() function, so it reads ID register
> > (which
> > has the same address for all devices) instead of CONFIG_DATA
> > (because
> > its address is known only after reading ID of the device).
> > 
> > [1] https://github.com/goodix/gt1x_driver_generic
> > 
> > Signed-off-by: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
> > ---
> > Patch was developed and tested on top of 4.14-rc4 using custom
> > board.
> > 
> 
> Just a suggestion, you could use a function pointer for the
> device-specific checksum routines and have the check on the device id
> only once in goodix_ts_probe(), see below.

Function pointer is fine, but this is how I'd implement it:

typedef enum {
  GOODIX_CONFIG_TYPE_GT911 = 0,
  GOODIX_CONFIG_TYPE_GT1151
} GoodixConfigType;

static func_pointer config_funcs[] = {
  goodix_gt911_get_config,
  goodix_gt1151_get_config
};

Store the GoodixConfigType in the device structure, and access the
function pointer as:
config_funcs[config_type] (...

That's what I'd prefer, but whatever Dmitry prefers style-wise. This
seems more extensible in case we have different functions needing
similar changes in the future, allowing us to either extend the
function pointer array, or use switch/case statements for smaller
functions.

Cheers
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
