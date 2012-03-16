From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [RFC 1/1] HID: User-space I/O driver support for HID subsystem
Date: Fri, 16 Mar 2012 19:51:19 +0100
Message-ID: <CANq1E4ROxW_XfkP8=s9FsHuxXMYGXomqRhsuAc4Ow5uBSAE6Gg@mail.gmail.com>
References: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
	<1331909617-22106-2-git-send-email-dh.herrmann@googlemail.com>
	<1331913615.14217.152.camel@aeonflux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:51530 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab2CPSvV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Mar 2012 14:51:21 -0400
In-Reply-To: <1331913615.14217.152.camel@aeonflux>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chen.ganir@ti.com, claudio.takahasi@openbossa.org, jprvita@openbossa.org, linux-bluetooth@vger.kernel.org, Vijaykumar.Dadmode@csr.com

Hi Marcel

On Fri, Mar 16, 2012 at 5:00 PM, Marcel Holtmann <marcel@holtmann.org> =
wrote:
> Hi David,
>
> <snip>
>
>> new file mode 100644
>> index 0000000..1a7df0d
>> --- /dev/null
>> +++ b/include/linux/uhid.h
>> @@ -0,0 +1,71 @@
>> +#ifndef __UHID_H_
>> +#define __UHID_H_
>> +
>> +/*
>> + * User-space I/O driver support for HID subsystem
>> + * Copyright (c) 2012 David Herrmann
>> + */
>> +
>> +/*
>> + * This program is free software; you can redistribute it and/or mo=
dify it
>> + * under the terms of the GNU General Public License as published b=
y the Free
>> + * Software Foundation; either version 2 of the License, or (at you=
r option)
>> + * any later version.
>> + */
>> +
>> +#include <linux/input.h>
>> +#include <linux/types.h>
>> +
>> +enum uhid_event_type {
>> + =A0 =A0 UHID_CREATE,
>> + =A0 =A0 UHID_DESTROY,
>> + =A0 =A0 UHID_START,
>> + =A0 =A0 UHID_STOP,
>> + =A0 =A0 UHID_OPEN,
>> + =A0 =A0 UHID_CLOSE,
>> + =A0 =A0 UHID_OUTPUT,
>> + =A0 =A0 UHID_OUTPUT_EV,
>> + =A0 =A0 UHID_INPUT,
>> +};
>> +
>> +struct uhid_create_req {
>> + =A0 =A0 __u8 __user name[128];
>> + =A0 =A0 __u8 __user *rd_data;
>> + =A0 =A0 __u16 rd_size;
>> +
>
> we need the bus here as well. With HIDP it was implicit, but here it =
is
> no longer implicit.

Uh, yeah, I will add that, thanks. I also need to find a proper way to
get a hid->dev.parent pointer.

>> + =A0 =A0 __u16 vendor;
>> + =A0 =A0 __u16 product;
>> + =A0 =A0 __u16 version;
>> + =A0 =A0 __u8 country;
>
> What are we using country for these days?

I copied it from HIDP. If we don't need this, I can remove it. USBHID
doesn't use it as far as I can see.

>> +};
>> +
>> +#define UHID_DATA_MAX 4096
>> +
>> +enum uhid_report_type {
>> + =A0 =A0 UHID_FEATURE_REPORT,
>> + =A0 =A0 UHID_OUTPUT_REPORT,
>> +};
>> +
>> +struct uhid_data_req {
>> + =A0 =A0 __u8 data[UHID_DATA_MAX];
>> + =A0 =A0 __u16 size;
>> + =A0 =A0 __u8 rtype;
>> +};
>> +
>> +struct uhid_data_ev_req {
>> + =A0 =A0 __u16 type;
>> + =A0 =A0 __u16 code;
>> + =A0 =A0 __s32 value;
>> +};
>> +
>> +struct uhid_event {
>> + =A0 =A0 __u32 type;
>> +
>> + =A0 =A0 union {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct uhid_create_req create;
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct uhid_data_req data;
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct input_event data_ev;
>> + =A0 =A0 } u;
>> +};
>> +
>> +#endif /* __UHID_H_ */
>
> Regards
>
> Marcel

Thanks
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
