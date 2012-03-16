From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC 1/1] HID: User-space I/O driver support for HID subsystem
Date: Fri, 16 Mar 2012 09:00:15 -0700
Message-ID: <1331913615.14217.152.camel@aeonflux>
References: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
	 <1331909617-22106-2-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1331909617-22106-2-git-send-email-dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, chen.ganir-l0cyMroinI0@public.gmane.org, claudio.takahasi-430g2QfJUUCGglJvpFV4uA@public.gmane.org, jprvita-430g2QfJUUCGglJvpFV4uA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vijaykumar.Dadmode-kQvG35nSl+M@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi David,

<snip>

> new file mode 100644
> index 0000000..1a7df0d
> --- /dev/null
> +++ b/include/linux/uhid.h
> @@ -0,0 +1,71 @@
> +#ifndef __UHID_H_
> +#define __UHID_H_
> +
> +/*
> + * User-space I/O driver support for HID subsystem
> + * Copyright (c) 2012 David Herrmann
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + */
> +
> +#include <linux/input.h>
> +#include <linux/types.h>
> +
> +enum uhid_event_type {
> +	UHID_CREATE,
> +	UHID_DESTROY,
> +	UHID_START,
> +	UHID_STOP,
> +	UHID_OPEN,
> +	UHID_CLOSE,
> +	UHID_OUTPUT,
> +	UHID_OUTPUT_EV,
> +	UHID_INPUT,
> +};
> +
> +struct uhid_create_req {
> +	__u8 __user name[128];
> +	__u8 __user *rd_data;
> +	__u16 rd_size;
> +

we need the bus here as well. With HIDP it was implicit, but here it is
no longer implicit.

> +	__u16 vendor;
> +	__u16 product;
> +	__u16 version;
> +	__u8 country;

What are we using country for these days?

> +};
> +
> +#define UHID_DATA_MAX 4096
> +
> +enum uhid_report_type {
> +	UHID_FEATURE_REPORT,
> +	UHID_OUTPUT_REPORT,
> +};
> +
> +struct uhid_data_req {
> +	__u8 data[UHID_DATA_MAX];
> +	__u16 size;
> +	__u8 rtype;
> +};
> +
> +struct uhid_data_ev_req {
> +	__u16 type;
> +	__u16 code;
> +	__s32 value;
> +};
> +
> +struct uhid_event {
> +	__u32 type;
> +
> +	union {
> +		struct uhid_create_req create;
> +		struct uhid_data_req data;
> +		struct input_event data_ev;
> +	} u;
> +};
> +
> +#endif /* __UHID_H_ */

Regards

Marcel
