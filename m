From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v4] pinctrl: mediatek: Implement wake handler and suspend resume
Date: Tue, 15 Sep 2015 10:43:59 +0800
Message-ID: <CAGS+omBP1B_xTJC1SNi6Hjsrr3-TBcKgHTonGky901CUPmp+bA@mail.gmail.com>
References: <1439541486-22203-1-git-send-email-maoguang.meng@mediatek.com>
 <55DB4609.5040904@arm.com> <CAGS+omBnoitju07KQ1Y7JHTbce6+DO4WqWHTaKz5D+T157zEJA@mail.gmail.com>
 <1441535972.22230.5.camel@mhfsdcap03> <55EEAA24.6080706@arm.com>
 <55EF11E6.7030307@arm.com> <1442051454.5661.12.camel@mhfsdcap03> <55F6AC87.4040301@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36629 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbbIOCoV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2015 22:44:21 -0400
Received: by ykdt18 with SMTP id t18so152032516ykd.3
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2015 19:44:19 -0700 (PDT)
In-Reply-To: <55F6AC87.4040301@arm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: maoguang meng <maoguang.meng@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Hongzhou Yang <hongzhou.yang@mediatek.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, =?UTF-8?B?WWluZ2pvZSBDaGVuICjpmbPoi7HmtLIp?= <Yingjoe.Chen@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Input <linux-input@vger.kernel.org>

Adding dtor & linux-input as we are now discussing the elan trackpad driver...

On Mon, Sep 14, 2015 at 7:16 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 12/09/15 10:50, maoguang meng wrote:
>> hi Sudeep:
>>
>> I test flowlling your blow suggestions,but the system can not be woken.
>>
>> beacuse,mtk_eint_suspend will mask it.As we know if eint wakeup system
>> it must be unmasked before enter suspend flow.
>>
>> e.x
>>
>> static int __maybe_unused elan_suspend(struct device *dev)
>> {
>>       struct i2c_client *client = to_i2c_client(dev);
>>       struct elan_tp_data *data = i2c_get_clientdata(client);
>>       int ret;
>>
>>       /*
>>        * We are taking the mutex to make sure sysfs operations are
>>        * complete before we attempt to bring the device into low[er]
>>        * power mode.
>>        */
>>       ret = mutex_lock_interruptible(&data->sysfs_mutex);
>>       if (ret)
>>               return ret;
>>
>>       disable_irq(client->irq);
>>
>>       if (device_may_wakeup(dev)) {
>>               ret = elan_sleep(data);
>>               /* Enable wake from IRQ */
>>               data->irq_wake = (enable_irq_wake(client->irq) == 0);
>
> This is wrong assumption in the driver. enable_irq_wake doesn't
> implicitly enable the IRQ. So the disable_irq should be moved to else.
> And the resume patch also needs to be fixed accordingly, otherwise you
> may get unbalanced irq. But this should not be the reason for fixing the
> pinctrl suspend/resume.
>
> Regards,
> Sudeep
>
> --->8
>
> diff --git a/drivers/input/mouse/elan_i2c_core.c
> b/drivers/input/mouse/elan_i2c_core.c
> index fa945304b9a5..7de26b04f45c 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1117,13 +1117,13 @@ static int __maybe_unused elan_suspend(struct
> device *dev)
>         if (ret)
>                 return ret;
>
> -       disable_irq(client->irq);
> -
>         if (device_may_wakeup(dev)) {
>                 ret = elan_sleep(data);
>                 /* Enable wake from IRQ */
>                 data->irq_wake = (enable_irq_wake(client->irq) == 0);
>         } else {
> +               disable_irq(client->irq);
> +
>                 ret = elan_disable_power(data);
>         }
