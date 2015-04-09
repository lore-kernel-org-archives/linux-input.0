From: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Subject: Re: [PATCH V1 1/2] input: misc: da9063: OnKey driver
Date: Thu, 09 Apr 2015 10:47:53 +0200
Message-ID: <1428569273.14000.17.camel@x220>
References: <cover.1428504804.git.stwiss.opensource@diasemi.com>
	 <0219212ab4e2b01256f2dac92d9a0d848c44197a.1428504804.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0219212ab4e2b01256f2dac92d9a0d848c44197a.1428504804.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

A license mismatch was all I spotted.

On Wed, 2015-04-08 at 15:53 +0100, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> 
> Add OnKey driver support for DA9063
> 
> This patch is dependent on PATCH V1 2/2 

(But I also spotted this line. And then I checked 2/2, which has:
    This patch is dependent on PATCH V1 1/2

Which makes it all rather confusing.

Anyhow, neither patch should need to carry such a line. The 1/2 and 2/2
in the Subject: line should suffice.)

> Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> 
> ---
> This patch applies against linux-next and v4.0-rc6 

> --- /dev/null
> +++ b/drivers/input/misc/da9063-onkey.c
> @@ -0,0 +1,227 @@
> +/* da9063-onkey.c - Onkey device driver for DA9063
> + * Copyright (C) 2013  Dialog Semiconductor Ltd.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Library General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Library General Public License for more details.
> + */

This states the license is GPL v2 or later.

> +MODULE_LICENSE("GPL v2");

And (according to include/linux/module.h) this states the license is
(just) GPL v2.


Paul Bolle

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
