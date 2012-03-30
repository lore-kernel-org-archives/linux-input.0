From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH V2 1/4] Input: pxa27x_keypad keep clock on as wakeup source
Date: Fri, 30 Mar 2012 09:53:38 +0800
Message-ID: <CAN1soZydBRqAChxKPKfz5pN8JSKKKbWBYua5KLfnQR8ZnQL-EA@mail.gmail.com>
References: <1333072698-15344-1-git-send-email-chao.xie@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62372 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759654Ab2C3Bxi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 21:53:38 -0400
Received: by vcqp1 with SMTP id p1so102465vcq.19
        for <linux-input@vger.kernel.org>; Thu, 29 Mar 2012 18:53:38 -0700 (PDT)
In-Reply-To: <1333072698-15344-1-git-send-email-chao.xie@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chao Xie <chao.xie@marvell.com>
Cc: linux-input@vger.kernel.org, eric.y.miao@gmail.com, haojian.zhuang@marvell.com, linux-arm-kernel@lists.infradead.org

On Fri, Mar 30, 2012 at 9:58 AM, Chao Xie <chao.xie@marvell.com> wrote:
> When the keypad is used as wake up source, the clock can not
> be disabled. Or it can not detect key pressing.
> If the keypad is used as wake up source, when resume back,
> do not enable the clock and configure it again because the
> register content is retained.
>
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
> =A0drivers/input/keyboard/pxa27x_keypad.c | =A0 27 ++++++++++++++++++=
---------
> =A01 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/k=
eyboard/pxa27x_keypad.c
> index 29fe1b2..1c5752f 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -419,10 +419,14 @@ static int pxa27x_keypad_suspend(struct device =
*dev)
> =A0 =A0 =A0 =A0struct platform_device *pdev =3D to_platform_device(de=
v);
> =A0 =A0 =A0 =A0struct pxa27x_keypad *keypad =3D platform_get_drvdata(=
pdev);
>
> - =A0 =A0 =A0 clk_disable(keypad->clk);
> -
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If the keypad is used a wake up source, clock can =
not be disabled.
> + =A0 =A0 =A0 =A0* Or it can not detect the key pressing.
> + =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0if (device_may_wakeup(&pdev->dev))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enable_irq_wake(keypad->irq);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(keypad->clk);
I prefer to add one patch to use clk_prepare_enable() &
clk_disable_unprepare() in keypad driver.

>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -433,19 +437,24 @@ static int pxa27x_keypad_resume(struct device *=
dev)
> =A0 =A0 =A0 =A0struct pxa27x_keypad *keypad =3D platform_get_drvdata(=
pdev);
> =A0 =A0 =A0 =A0struct input_dev *input_dev =3D keypad->input_dev;
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If the keypad is used as wake up source, the clock=
 is not turned
> + =A0 =A0 =A0 =A0* off. So do not need configure it again.
> + =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0if (device_may_wakeup(&pdev->dev))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0disable_irq_wake(keypad->irq);
> + =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&input_dev->mutex);
>
> - =A0 =A0 =A0 mutex_lock(&input_dev->mutex);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (input_dev->users) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable unit clock */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(keypad->clk)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pxa27x_keypad_config(ke=
ypad);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 if (input_dev->users) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable unit clock */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(keypad->clk);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pxa27x_keypad_config(keypad);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&input_dev->mutex);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 mutex_unlock(&input_dev->mutex);
> -
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> --
> 1.7.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
