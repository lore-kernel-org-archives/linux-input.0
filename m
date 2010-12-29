From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 3/3 v2] input - wacom_w8001: Add one finger touch support
Date: Wed, 29 Dec 2010 14:54:14 -0800
Message-ID: <AANLkTi=C1np-r2jxgFPwwgm2LOs6Yb-aKMK1MwUMGJdU@mail.gmail.com>
References: <1292607474-22674-1-git-send-email-pinglinux@gmail.com>
	<20101229074058.GA13061@core.coreip.homeip.net>
	<20101229074220.GB13061@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57974 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab0L2WyP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Dec 2010 17:54:15 -0500
Received: by wwa36 with SMTP id 36so11140122wwa.1
        for <linux-input@vger.kernel.org>; Wed, 29 Dec 2010 14:54:14 -0800 (PST)
In-Reply-To: <20101229074220.GB13061@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Dec 28, 2010 at 11:42 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Dec 28, 2010 at 11:40:58PM -0800, Dmitry Torokhov wrote:
>> Hi Ping,
>>
>> On Fri, Dec 17, 2010 at 09:37:54AM -0800, Ping Cheng wrote:
>> > Signed-off-by: Ping Cheng <pingc@wacom.com>
>> > ---
>> > =A0drivers/input/touchscreen/wacom_w8001.c | =A0 89 ++++++++++++++=
++++++++++++++---
>> > =A01 files changed, 82 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/inp=
ut/touchscreen/wacom_w8001.c
>> > index 59664a8..763eb8f 100644
>> > --- a/drivers/input/touchscreen/wacom_w8001.c
>> > +++ b/drivers/input/touchscreen/wacom_w8001.c
>> > @@ -3,6 +3,7 @@
>> > =A0 *
>> > =A0 * Copyright (c) 2008 Jaya Kumar
>> > =A0 * Copyright (c) 2010 Red Hat, Inc.
>> > + * Copyright (c) 2010 Ping Cheng, Wacom. <pingc@wacom.com>
>> > =A0 *
>> > =A0 * This file is subject to the terms and conditions of the GNU =
General Public
>> > =A0 * License. See the file COPYING in the main directory of this =
archive for
>> > @@ -86,6 +87,12 @@ struct w8001 {
>> > =A0 =A0 char phys[32];
>> > =A0 =A0 int type;
>> > =A0 =A0 unsigned int pktlen;
>> > + =A0 bool pen_in_prox;
>> > + =A0 bool has_touch;
>>
>> We already have type, why do we need these 2 fields a well?
>>
>> Actually, I tried massaging the patch a bit, could you please tell m=
e if
>> the patch below still works for you?
>>
>> Thanks.
>>
>
> And while we are at it could you please try this patch as well...
>
> Thank you!
>
> --
> Dmitry
>
> Input: wacom_w8001 - add single-touch pointer emulation
>
> Let's emit single-touch compatible events for the 2-finger panels so =
that
> they can be used with legacy clients.

Depending on which legacy clients we are talking about, this patch may
introduce issue instead of support. We added
mt_report_pointer_emulation for Bamboo since it is a touchpad, that
can be driven by xf86-input-synaptics in relative mode. This device is
a touchscreen, that should be run in absolute mode. If we emulate ST
events, which X driver do we expect it to use? xf86-input-wacom does
not process emulated single touch data once we know MT is supported.
That's why I didn't want to add ST emulation for this device.

We expect clients that support this MT device will be in MT format
since this driver is new and the clients have to run inputattach to
enable the port before they can talk to the device. The client must
have a reason to do so. Do you see any legacy clients would like to
walk the extra mile to use this driver?

Ping

> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =A0drivers/input/touchscreen/wacom_w8001.c | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
>
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/=
touchscreen/wacom_w8001.c
> index ce8c8e1..01489f7 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -145,6 +145,7 @@ static void parse_multi_touch(struct w8001 *w8001=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 input_mt_report_pointer_emulation(dev, true);
> =A0 =A0 =A0 =A0input_sync(dev);
> =A0}
>
> @@ -420,6 +421,9 @@ static int w8001_setup(struct w8001 *w8001)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A00, touch.y, 0, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(d=
ev, ABS_MT_TOOL_TYPE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A00, MT_TOOL_MAX, 0, 0);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_DOUB=
LETAP, dev->keybit);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
