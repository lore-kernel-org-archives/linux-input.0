From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: Input: add MAX7359 key switch controller driver
Date: Thu, 7 May 2009 19:03:11 +0900
Message-ID: <4d34a0a70905070303r55c2c681yf58680de2f3d4a9f@mail.gmail.com>
References: <4A012C64.1020101@samsung.com> <5d5443650905060638l52b3c17dle0d138b689a23252@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f125.google.com ([209.85.221.125]:48432 "EHLO
	mail-qy0-f125.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbZEGKDc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 May 2009 06:03:32 -0400
In-Reply-To: <5d5443650905060638l52b3c17dle0d138b689a23252@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Kim Kyuwon <q1.kim@samsung.com>, LKML <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>

Hi Trilok,

Thank you for reviewing this driver and I have something to make sure
for the next better patch :)

On Wed, May 6, 2009 at 10:38 PM, Trilok Soni <soni.trilok@gmail.com> wrote:
> Hi Kim,
>
> On Wed, May 6, 2009 at 11:51 AM, Kim Kyuwon <q1.kim@samsung.com> wrote:
>> The Maxim MAX7359 is a I2C interfaced key switch controller which provides microprocessors with management of up to 64 key switches.
>> This patch adds support for the MAX7359 key switch controller.
>>
>
> Could you please restrict the commit text line to 80/72 columns? It
> will look good.

Is this restriction for commit text mandatory? It seems like I got an
email from Andrew Morton that my patch was wordwraped even commit
text.

>> +static irqreturn_t max7359_interrupt(int irq, void *dev_id)
>> +{
>> +       struct max7359_keypad *keypad = (struct max7359_keypad *) dev_id;
>
> No need of casting. Please remove.

Ok, Thanks I'll remove it.

>> +
>> +       if (!work_pending(&keypad->work)) {
>> +               disable_irq_nosync(keypad->irq);
>> +               schedule_work(&keypad->work);
>> +       } else {
>> +               dev_err(&keypad->client->dev,
>> +                               "Another job is currently pending \n");
>> +       }
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>
>> +
>> +static int __devinit max7359_probe(struct i2c_client *client,
>> +                                       const struct i2c_device_id *id)
>
> You may want to remove __devinit as it is i2c client driver . I have
> added linux-i2c for i2c specific review.

Actually I don't want to remove it :), Is there any reason why you think so?

>> +static int max7359_suspend(struct i2c_client *client, pm_message_t mesg)
>> +{
>> +       /* If no keys are pressed, enter sleep mode for 8192 ms */
>> +       max7359_write_reg(client, MAX7359_REG_SLEEP, 0x01);
>> +
>> +       return 0;
>> +}
>> +
>> +static int max7359_resume(struct i2c_client *client)
>> +{
>> +       /* Restore the default setting (autosleep for 256 ms) */
>> +       max7359_write_reg(client, MAX7359_REG_SLEEP, 0x07);
>> +
>> +       return 0;
>> +}
>
> Protect these two function with #ifdef CONFIG_PM please.

This is what I really wanted to ask. I'm trying not to use '#ifdef'.
By the way, why most of drivers use protect suspend/resume functions
with #ifdef? Just for saving code size?

>> +
>
>> +
>> +static struct i2c_driver max7359_i2c_driver = {
>> +       .driver = {
>> +               .name = "max7359",
>> +       },
>> +       .probe          = max7359_probe,
>> +       .remove         = __exit_p(max7359_remove),
>
>
>> +};
>> +
>> +
>> +MODULE_AUTHOR("Kim Kyuwon <q1.kim@samsung.com>");
>> +MODULE_DESCRIPTION("MAX7359 Key Switch Controller Driver");
>> +MODULE_LICENSE("GPL v2");
>
> MODULE_ALIAS ??

In 'include/linux/module.h'

 96 /* For userspace: you can also call me... */
 97 #define MODULE_ALIAS(_alias) MODULE_INFO(alias, _alias)

>From comment above, I think MODULE_ALIAS is optional. Do you still
think MODULE_ALIAS needs?

And when I send new version of patch, I will add [PATCH] in front of subject.
Thank you for reviewing and letting me ask.

Regards,
