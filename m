From: Liu Ying <liu.y.victor@gmail.com>
Subject: Re: [PATCH v2 1/3] Input: imx_keypad - Add device tree support
Date: Thu, 3 Jan 2013 21:06:10 +0800
Message-ID: <CA+8Hj83az-LGTrfQpb_Qh77N_9GCrbtO+374PyQ6hk4tYdCWdw@mail.gmail.com>
References: <1357010475-7331-1-git-send-email-Ying.Liu@freescale.com>
	<20130103071058.GA2566@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130103071058.GA2566@S2101-09.ap.freescale.net>
Sender: linux-doc-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Liu Ying <Ying.Liu@freescale.com>, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, dmitry.torokhov@gmail.com, s.hauer@pengutronix.de, linus.walleij@linaro.org, cjb@laptop.org, broonie@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

2013/1/3 Shawn Guo <shawn.guo@linaro.org>:
> On Tue, Jan 01, 2013 at 11:21:13AM +0800, Liu Ying wrote:
>> +#ifdef CONFIG_OF
>> +static inline int imx_keypad_check_dt(struct platform_device *pdev)
>> +{
>> +     struct device_node *np = pdev->dev.of_node;
>> +
>> +     if (!np)
>> +             return -ENODEV;
>> +
>> +     return 0;
>> +}
>> +#else
>> +static inline int imx_keypad_check_dt(struct platform_device *pdev)
>> +{
>> +     return -ENODEV;
>> +}
>> +#endif
>> +
>>  static int imx_keypad_probe(struct platform_device *pdev)
>>  {
>>       const struct matrix_keymap_data *keymap_data = pdev->dev.platform_data;
>>       struct imx_keypad *keypad;
>>       struct input_dev *input_dev;
>>       struct resource *res;
>> -     int irq, error, i;
>> +     int irq, error, i, row, col, row_shift;
>>
>> -     if (keymap_data == NULL) {
>> +     if (keymap_data == NULL && imx_keypad_check_dt(pdev)) {
>
> Shouldn't the following just equally work?
>
>         if (keymap_data == NULL && pdev->dev.of_node == NULL) {
>
> Shawn
Yes, it looks better. I will do the change. Thanks.
>
>>               dev_err(&pdev->dev, "no keymap defined\n");
>>               return -EINVAL;
>>       }
>



-- 
Liu Ying
