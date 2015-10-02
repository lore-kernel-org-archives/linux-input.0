From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: Re: [PATCH] Input: da9052_onkey: Convert to managed resources
Date: Sat, 3 Oct 2015 00:05:44 +0530
Message-ID: <CAK-LDbLM=0i+npuLVRQsPAAhmpwt8cMJ+z8yZ5Q5EMv4Kx62_A@mail.gmail.com>
References: <20150727025616.GA4227@vaishali-Ideapad-Z570>
	<6ED8E3B22081A4459DAC7699F3695FB7014B2605BA@SW-EX-MBX02.diasemi.com>
	<20151002174326.GC8437@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38469 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbbJBSfp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Oct 2015 14:35:45 -0400
In-Reply-To: <20151002174326.GC8437@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>

On Fri, Oct 2, 2015 at 11:13 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Aug 04, 2015 at 12:52:53PM +0000, Opensource [Steve Twiss] wrote:
>> On 27 July 2015 03:56, Vaishali Thakkar wrote:
>>
>> > Subject: [PATCH] Input: da9052_onkey: Convert to managed resources
>> >
>> > Use managed resource functions devm_input_allocate_device and
>> > devm_kzalloc. To be compatible with the change, replace various
>> > gotos by direct returns and drop unneeded labels.
>> >
>> > Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
>> > ---
>> >  drivers/input/misc/da9052_onkey.c | 15 ++++-----------
>> >  1 file changed, 4 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/drivers/input/misc/da9052_onkey.c
>> > b/drivers/input/misc/da9052_onkey.c
>> > index 266e07f..3243fe9 100644
>> > --- a/drivers/input/misc/da9052_onkey.c
>> > +++ b/drivers/input/misc/da9052_onkey.c
>> > @@ -84,12 +84,11 @@ static int da9052_onkey_probe(struct
>> > platform_device *pdev)
>> >             return -EINVAL;
>> >     }
>> >
>> > -   onkey = kzalloc(sizeof(*onkey), GFP_KERNEL);
>> > -   input_dev = input_allocate_device();
>> > +   onkey = devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
>> > +   input_dev = devm_input_allocate_device(&pdev->dev);
>> >     if (!onkey || !input_dev) {
>> >             dev_err(&pdev->dev, "Failed to allocate memory\n");
>> > -           error = -ENOMEM;
>> > -           goto err_free_mem;
>> > +           return -ENOMEM;
>> >     }
>> >
>> >     onkey->input = input_dev;
>> > @@ -108,7 +107,7 @@ static int da9052_onkey_probe(struct
>> > platform_device *pdev)
>> >     if (error < 0) {
>> >             dev_err(onkey->da9052->dev,
>> >                     "Failed to register ONKEY IRQ: %d\n", error);
>> > -           goto err_free_mem;
>> > +           return error;
>> >     }
>> >
>> >     error = input_register_device(onkey->input);
>> > @@ -124,9 +123,6 @@ static int da9052_onkey_probe(struct
>> > platform_device *pdev)
>> >  err_free_irq:
>> >     da9052_free_irq(onkey->da9052, DA9052_IRQ_NONKEY, onkey);
>> >     cancel_delayed_work_sync(&onkey->work);
>> > -err_free_mem:
>> > -   input_free_device(input_dev);
>> > -   kfree(onkey);
>> >
>> >     return error;
>> >  }
>> > @@ -138,9 +134,6 @@ static int da9052_onkey_remove(struct
>> > platform_device *pdev)
>> >     da9052_free_irq(onkey->da9052, DA9052_IRQ_NONKEY, onkey);
>> >     cancel_delayed_work_sync(&onkey->work);
>> >
>> > -   input_unregister_device(onkey->input);
>> > -   kfree(onkey);
>> > -
>> >     return 0;
>> >  }
>> >
>> > --
>> > 1.9.1
>>
>> Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
>>
>
> I prefer not to mix stategies of managing resources in a single driver.
> I.e. either everything is devm* or nothing is.

Yeah, I understand. I guess this is an old patch. You can drop it.

Thanks

> Thanks.
>
> --
> Dmitry



-- 
Vaishali
