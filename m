From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] input: driver for touchscreen on iPaq h3xxx
Date: Wed, 23 Jul 2014 10:10:16 +0200
Message-ID: <CACRpkdZimiX2NPfcpTcYsS2LF-VTL8J=hYA9kZFw8U36w+YnaA@mail.gmail.com>
References: <1405157481-10348-1-git-send-email-linus.walleij@linaro.org>
	<20140713025936.GA29513@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:53970 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757092AbaGWIKR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2014 04:10:17 -0400
Received: by mail-oi0-f47.google.com with SMTP id x69so603814oia.34
        for <linux-input@vger.kernel.org>; Wed, 23 Jul 2014 01:10:16 -0700 (PDT)
In-Reply-To: <20140713025936.GA29513@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Dmitry Artamonow <mad_soft@inbox.ru>, Alessandro GARDICH <gremlin@gremlin.it>

On Sun, Jul 13, 2014 at 4:59 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Linus, Dmitry,
>
> On Sat, Jul 12, 2014 at 11:31:21AM +0200, Linus Walleij wrote:
>> From: Dmitry Artamonow <mad_soft@inbox.ru>
>
> So is this Dmitry's or Alessandro's work?

Multiple authors. Alessandro, Dmitry and me. In order of sign-off...
The only viable rule I have for multiple authors is to attribute it
to the author who wrote the bulk of the code, and that comes
from Dmitry.

>> +#include <linux/mfd/ipaq-micro.h>
>
> Has this been merged already?

Yes. v3.16 merge window.

>> +static void micro_ts_receive(void *data, int len, unsigned char *msg)
>> +{
>> +     struct touchscreen_data *ts = data;
>> +
>> +     if (len == 4) {
>> +             input_report_abs(ts->input, ABS_X, (msg[2]<<8)+msg[3]);
>
> be16_to_cpup()?

Yes! Replacing everywhere.

>> +             input_report_abs(ts->input, ABS_Y, (msg[0]<<8)+msg[1]);
>> +             input_report_abs(ts->input, ABS_PRESSURE, 1);
>
> Please no fake pressure events, update your tslib instead.
>
>> +             input_report_key(ts->input, BTN_TOUCH, 0);
>
> This seems completely backwards.

Yeah... I wonder what happened here.

>> +     ts->input = input_allocate_device();
>
> Error handling please; also consider using devm_input_allocate_device().
>
>> +
>> +     ts->input->evbit[0] = BIT(EV_ABS);
>> +     ts->input->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
>> +     input_set_abs_params(ts->input, ABS_X, 0, 1023, 0, 0);
>> +     input_set_abs_params(ts->input, ABS_Y, 0, 1023, 0, 0);
>> +     input_set_abs_params(ts->input, ABS_PRESSURE, 0x0, 0x1, 0, 0);
>> +
>
> You are missing setting BTN_TOUCH in capabilities so events you are
> trying to send in micro_ts_receive will not go anywhere.

Yeah. And I switched this to using just input_set_capability().

>> +     spin_lock(&ts->micro->lock);
>> +     ts->micro->ts = NULL;
>> +     ts->micro->ts_data = NULL;
>> +     spin_unlock(&ts->micro->lock);
>
> What is the point here?

Unregistering the callbacks so the MFD core device will stop
calling them. Or we will crash the kernel when removing the
driver as next event arrives.

Sending v2 soon.

Yours,
Linus Walleij
