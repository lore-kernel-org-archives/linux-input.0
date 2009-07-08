From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] input:Add clk api support for w90p910 touchscreen
Date: Wed, 8 Jul 2009 22:06:53 +0800
Message-ID: <e68bb3470907080706l68a0c635v10527a3e36365cbc@mail.gmail.com>
References: <4A535B97.4010700@gmail.com>
	 <5d5443650907071019w45474b2dhd0a175a0ffac4f3a@mail.gmail.com>
	 <4A542D30.2040003@gmail.com>
	 <20090708065130.GD3309@dtor-d630.eng.vmware.com>
	 <4A54465D.1020105@gmail.com>
	 <5d5443650907080334k48deef98w562c1543b74433f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:63789 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbZGHOGy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jul 2009 10:06:54 -0400
Received: by wf-out-1314.google.com with SMTP id 26so2029242wfd.4
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2009 07:06:54 -0700 (PDT)
In-Reply-To: <5d5443650907080334k48deef98w562c1543b74433f4@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>, Eric miao <eric.y.miao@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

Dear  Trilok =EF=BC=8C


2009/7/8 Trilok Soni <soni.trilok@gmail.com>:
> Hi Wan ZongShun,
>
>>
>> ---
>> =C2=A0drivers/input/touchscreen/w90p910_ts.c | =C2=A0 25 +++++++++++=
+-------------
>> =C2=A01 files changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/w90p910_ts.c b/drivers/input/=
touchscreen/w90p910_ts.c
>> index 6071f58..7bef19e 100644
>> --- a/drivers/input/touchscreen/w90p910_ts.c
>> +++ b/drivers/input/touchscreen/w90p910_ts.c
>> @@ -13,6 +13,7 @@
>> =C2=A0#include <linux/module.h>
>> =C2=A0#include <linux/platform_device.h>
>> =C2=A0#include <linux/io.h>
>> +#include <linux/clk.h>
>> =C2=A0#include <linux/input.h>
>> =C2=A0#include <linux/interrupt.h>
>>
>> @@ -47,8 +48,8 @@ enum ts_state {
>> =C2=A0struct w90p910_ts {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct input_dev *input;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct timer_list timer;
>> + =C2=A0 =C2=A0 =C2=A0 struct clk *clk;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int irq_num;
>> - =C2=A0 =C2=A0 =C2=A0 void __iomem *clocken;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *ts_reg;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t lock;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0enum ts_state state;
>> @@ -166,8 +167,7 @@ static int w90p910_open(struct input_dev *dev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long val;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* enable the ADC clock */
>> - =C2=A0 =C2=A0 =C2=A0 val =3D __raw_readl(w90p910_ts->clocken);
>> - =C2=A0 =C2=A0 =C2=A0 __raw_writel(val | ADC_CLK_EN, w90p910_ts->cl=
ocken);
>> + =C2=A0 =C2=A0 =C2=A0 clk_enable(w90p910_ts->clk);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0__raw_writel(ADC_RST1, w90p910_ts->ts_reg=
);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0msleep(1);
>> @@ -211,8 +211,8 @@ static void w90p910_close(struct input_dev *dev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0del_timer_sync(&w90p910_ts->timer);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* stop the ADC clock */
>> - =C2=A0 =C2=A0 =C2=A0 val =3D __raw_readl(w90p910_ts->clocken);
>> - =C2=A0 =C2=A0 =C2=A0 __raw_writel(val & ~ADC_CLK_EN, w90p910_ts->c=
locken);
>> + =C2=A0 =C2=A0 =C2=A0 clk_disable(w90p910_ts->clk);
>> + =C2=A0 =C2=A0 =C2=A0 clk_put(w90p910_ts->clk);
>
>
> why you are doing clk_put on _close? I think you are calling clk_get
> only on _probe, so there is a mismatch here. Also I don't see
> clk_disable/clk_put in driver remove function.

Just imitate the method from pxa27x_keypad.c.
Do you mean  there is no need to free the clock source here?

> --
> ---Trilok Soni
> http://triloksoni.wordpress.com
> http://www.linkedin.com/in/triloksoni
>



--=20
Wan z.s
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
