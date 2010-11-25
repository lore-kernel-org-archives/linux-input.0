From: Fabien Marteau <fabien.marteau@armadeus.com>
Subject: Re: [PATCH] input: joystick: Adding Austria Microsystem AS5011 joystick
 driver
Date: Thu, 25 Nov 2010 11:32:23 +0100
Message-ID: <4CEE3B37.6030801@armadeus.com>
References: <4CEBED7E.7010101@armadeus.com> <AANLkTi=UNGfPxp+7-cCu8U=g2CyEQJ5npjJjzEbYCO84@mail.gmail.com>
Reply-To: fabien.marteau@armadeus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 31.mail-out.ovh.net ([213.186.62.10]:39732 "HELO
	31.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751621Ab0KYKc1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Nov 2010 05:32:27 -0500
In-Reply-To: <AANLkTi=UNGfPxp+7-cCu8U=g2CyEQJ5npjJjzEbYCO84@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anirudh Ghayal <anirudhghayal@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Scott Moreau <oreaus@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Anirudh,

Thanks for your code review.

>> +static void as5011_update_axes(struct work_struct *work)
>> +{
>> +       struct as5011_platform_data *plat_dat =
>> +               container_of(work,
>> +                            struct as5011_platform_data,
>> +                            update_axes_work);
>> +       signed char x, y;
>> +
>> +       x = as5011_i2c_read(plat_dat->i2c_client, AS5011_X_RES_INT);
>> +       y = as5011_i2c_read(plat_dat->i2c_client, AS5011_Y_RES_INT);
> 
> What if the read call returns an error ?
It's a problem yes. But I don't know how to manage this error in this context.

>> +static int as5011_probe(struct i2c_client *client,
>> +                       const struct i2c_device_id *id)
>> +{
> 
> __devinit as5011_probe()

Ok, done.

>> +       if (request_irq(plat_dat->int_irq, as5011_int_interrupt,
>> +                       0, plat_dat->int_irq_name, (void *)plat_dat)) {
> 
> How about using request_any_context_irq() ?

Hmm, in fact my platform use a hard IRQ and I used it without question.
I will see how to improve it.
> 
>> +               dev_err(&client->dev, "as5011: Can't allocate int irq %d\n",
>> +                       plat_dat->int_irq);
>> +               retval = -EBUSY;
>> +               goto request_int_irq_error;
>> +       }
>> +
>> +       retval = input_register_device(plat_dat->input_dev);
> 
> Its better to register your device at the end, after all the initialization.

Yes it was a mistake. Done.
> 
>> +       if (retval) {
>> +               dev_err(&client->dev, "as5011: Failed to register device\n");
>> +               retval = -EINVAL;
>> +               goto input_register_device_error;
>> +       }
>> +
>> +       retval = plat_dat->init_gpio();
> 
> Please check if the function pointer is NULL.

Ok, done.

>> +       plat_dat->exit_gpio();
> 
> Please check if the function pointer is NULL.
done.

>> +       plat_dat->exit_gpio();
> 
> Same here.
done.


>> +       .remove         = as5011_remove,
> 
> __devexit_p (as5011_remove)
done.

Thanks.
Fabien

