From: Barry Song <21cnbao@gmail.com>
Subject: Re: [RFC PATCH] Input: gpio_keys - trigger input event if key is
 pressed in boot stage
Date: Thu, 21 May 2015 06:44:56 +0800
Message-ID: <CAGsJ_4y9O-AYm+cEipKnwhfqg+vF5kw1p4jnF5KW9rNM51+2UQ@mail.gmail.com>
References: <CAGsJ_4z-CZShfCQ2JNgOKX1dtfGksX+Naj++4tugPCriiY=ESg@mail.gmail.com>
 <20150520163736.GA23809@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36367 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216AbbETWpR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2015 18:45:17 -0400
Received: by pabts4 with SMTP id ts4so82616054pab.3
        for <linux-input@vger.kernel.org>; Wed, 20 May 2015 15:45:16 -0700 (PDT)
In-Reply-To: <20150520163736.GA23809@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Andy.Sun@csr.com

2015-05-21 0:37 GMT+08:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Barry,
>
> On Wed, May 20, 2015 at 06:02:36PM +0800, Barry Song wrote:
>> sometimes we press a key to boot, and the boot stage need to get this
>> event.
>> the current codes use edge trigger, so we have no chance to report
>> the cold-touch event.
>> but our user sceneries like Linux navigator does need it.
>
> Input events that come before input device is opened (either by
> userspace or by a kernel consumer) are ignored by input core and we
> already call gpio_keys_report_state() from gpio_keys_open() so I do not
> think this patch has any effect.

Dmitry,
you are right. i missed gpio_keys_open() has done that once it is opened.

556 static int gpio_keys_open(struct input_dev *input)
557 {
558         struct gpio_keys_drvdata *ddata = input_get_drvdata(input);
559         const struct gpio_keys_platform_data *pdata = ddata->pdata;
560         int error;
561
562         if (pdata->enable) {
563                 error = pdata->enable(input->dev.parent);
564                 if (error)
565                         return error;
566         }
567
568         /* Report current state of buttons that are connected to GPIOs */
569         gpio_keys_report_state(ddata);
570
571         return 0;
572 }


>
> Thanks.
>
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  -RFC: for the moment, only an idea
>>
>>  drivers/input/keyboard/gpio_keys.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/input/keyboard/gpio_keys.c
>> b/drivers/input/keyboard/gpio_keys.c
>> index ddf4045..77fe0dd 100644
>> --- a/drivers/input/keyboard/gpio_keys.c
>> +++ b/drivers/input/keyboard/gpio_keys.c
>> @@ -766,6 +766,19 @@ static int gpio_keys_probe(struct platform_device *pdev)
>>
>>      device_init_wakeup(&pdev->dev, wakeup);
>>
>> +    /* if the key is pressed while system boot, force an interrupt */
>> +    for (i = 0; i < pdata->nbuttons; i++) {
>> +        const struct gpio_keys_button *button = &pdata->buttons[i];
>> +        struct gpio_button_data *bdata = &ddata->data[i];
>> +        int state;
>> +
>> +        if (gpio_is_valid(button->gpio)) {
>> +            state = (gpio_get_value_cansleep(button->gpio) ? 1 : 0) ^
>> button->active_low;
>> +            if (state)
>> +                gpio_keys_gpio_isr(bdata->irq, bdata);
>> +        }
>> +    }
>> +
>>      return 0;
>>
>>  err_remove_group:
>> --
>> 1.9.1
>
> --
> Dmitry


-barry
