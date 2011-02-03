From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 5/8] HID: roccat: Added ioctl command to retreive report
 size from chardev
Date: Thu, 3 Feb 2011 11:17:24 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1102031116100.2160@pobox.suse.cz>
References: <1296391105.2283.184.camel@neuromancer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1296391105.2283.184.camel@neuromancer>
Sender: linux-doc-owner@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Mauro Carvalho Chehab <mchehab@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Thomas Weber <weber@corscience.de>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 30 Jan 2011, Stefan Achatz wrote:

> diff --git a/include/linux/roccat.h b/include/linux/roccat.h
> new file mode 100644
> index 0000000..24e1ca0
> --- /dev/null
> +++ b/include/linux/roccat.h
> @@ -0,0 +1,29 @@
> +#ifndef __HID_ROCCAT_H
> +#define __HID_ROCCAT_H
> +
> +/*
> + * Copyright (c) 2010 Stefan Achatz <erazor_de@users.sourceforge.net>
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + */
> +
> +#include <linux/hid.h>
> +#include <linux/types.h>
> +
> +#define ROCCATIOCGREPSIZE _IOR('H', 0xf1, int)
> +
> +#ifdef __KERNEL__
> +
> +int roccat_connect(struct class *klass, struct hid_device *hid,
> +		int report_size);
> +void roccat_disconnect(int minor);
> +int roccat_report_event(int minor, u8 const *data);
> +
> +#endif
> +
> +#endif

I think something like include/linux/hid-roccat.h would be better here.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
