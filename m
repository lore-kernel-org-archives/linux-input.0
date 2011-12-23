From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH] misc: max8925_onkey: add function to work as wakeup source
Date: Fri, 23 Dec 2011 22:43:48 +0800
Message-ID: <CAN1soZyigBwJyhKjaVfVZdZLDC4MJO6kwuP=PEnb61m7xAC5FA@mail.gmail.com>
References: <1324544151-2040-1-git-send-email-haojian.zhuang@marvell.com>
	<20111222174338.GA21103@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62134 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab1LWOnt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Dec 2011 09:43:49 -0500
Received: by vcbfk14 with SMTP id fk14so7340947vcb.19
        for <linux-input@vger.kernel.org>; Fri, 23 Dec 2011 06:43:48 -0800 (PST)
In-Reply-To: <20111222174338.GA21103@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>, Kevin Liu <kliu5@marvell.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Fri, Dec 23, 2011 at 1:43 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Haojian,
>
> On Thu, Dec 22, 2011 at 04:55:51PM +0800, Haojian Zhuang wrote:
>> From: Kevin Liu <kliu5@marvell.com>
>>
>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>
> Since I am getting the patch from you you need to add your own
> "Signed-off-by: ..." as well.
>
>> ---
>> =A0drivers/input/misc/max8925_onkey.c | =A0 35 +++++++++++++++++++++=
++++++++++++++
>> =A01 files changed, 35 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/input/misc/max8925_onkey.c b/drivers/input/misc=
/max8925_onkey.c
>> index 7de0ded..ce07ae2 100644
>> --- a/drivers/input/misc/max8925_onkey.c
>> +++ b/drivers/input/misc/max8925_onkey.c
>> @@ -122,6 +122,7 @@ static int __devinit max8925_onkey_probe(struct =
platform_device *pdev)
>> =A0 =A0 =A0 info->idev->evbit[0] =3D BIT_MASK(EV_KEY);
>> =A0 =A0 =A0 info->idev->keybit[BIT_WORD(KEY_POWER)] =3D BIT_MASK(KEY=
_POWER);
>>
>> + =A0 =A0 device_init_wakeup(&pdev->dev, 1);
>>
>> =A0 =A0 =A0 error =3D input_register_device(info->idev);
>> =A0 =A0 =A0 if (error) {
>> @@ -158,10 +159,44 @@ static int __devexit max8925_onkey_remove(stru=
ct platform_device *pdev)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> +#ifdef CONFIG_PM
>
> #ifdef CONFIG_PM_SLEEP is better choice here.
>
>> +static int max8925_onkey_suspend(struct device *dev)
>> +{
>> + =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev);
>> + =A0 =A0 struct max8925_chip *chip =3D dev_get_drvdata(pdev->dev.pa=
rent);
>> +
>> + =A0 =A0 if (device_may_wakeup(dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 chip->wakeup_flag |=3D 1 << (onkey_irq[0] =
- chip->irq_base);
>> + =A0 =A0 =A0 =A0 =A0 =A0 chip->wakeup_flag |=3D 1 << (onkey_irq[1] =
- chip->irq_base);
>
> You don't need to actually communicate this to the device?
>
Excuse me that I missed another patch in this series. So I'll send it a=
gain.

Best Regards
Haojian
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
