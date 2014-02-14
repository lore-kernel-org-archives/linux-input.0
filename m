From: Xianglong Du <Xianglong.Du@csr.com>
Subject: RE: [PATCH v3] input: sirfsoc-onkey - report onkey untouch event by
 detecting pin status
Date: Fri, 14 Feb 2014 10:32:08 +0000
Message-ID: <847BC5012124A94BB5CA1B26E022CCA3012BAFDC27@SHAASIEXM01.ASIA.ROOT.PRI>
References: <1392348001-4950-1-git-send-email-21cnbao@gmail.com>
 <20140214075717.GA14682@core.coreip.homeip.net>,
 <CAGsJ_4xqnZAO6vpkgTEHmfp9+nbWa1qwQ4pda6B2sSrEtbV3ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGsJ_4xqnZAO6vpkgTEHmfp9+nbWa1qwQ4pda6B2sSrEtbV3ZA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Barry Song <21cnbao@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rongjun Ying <Rongjun.Ying@csr.com>, DL-SHA-WorkGroupLinux <DL-SHA-WorkGroupLinux@internal.csr.com>, Barry Song <Barry.Song@csr.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Tested-by: Xianglong Du <Xianglong.Du@csr.com>

________________________________________
From: Barry Song [21cnbao@gmail.com]
Sent: Friday, February 14, 2014 16:49
To: Dmitry Torokhov
Cc: linux-input@vger.kernel.org; linux-arm-kernel@lists.infradead.org; DL-SHA-WorkGroupLinux; Xianglong Du; Rongjun Ying; Barry Song
Subject: Re: [PATCH v3] input: sirfsoc-onkey - report onkey untouch event by detecting pin status

2014-02-14 15:57 GMT+08:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Barry,
>
> On Fri, Feb 14, 2014 at 11:20:01AM +0800, Barry Song wrote:
>> From: Xianglong Du <Xianglong.Du@csr.com>
>>
>> this patch adds a delayed_work to detect the untouch of onkey since HW will
>> not generate interrupt for it.
>>
>> at the same time, we move the KEY event to POWER instead of SUSPEND, which
>> will be suitable for both Android and Linux. Userspace PowerManager Daemon
>> will decide to suspend or shutdown based on how long we have touched onkey
>>
>> Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
>> Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  -v3: move to use custom devres action
>
> Thank you for making the changes, however it seems that we can control
> whether the device generates interrupts or not and so we can implement
> open and close methods. If patch below works then your
> cancel_delayed_work() call should go into sirfosc_pwrc_close() and we do
> not need to use devm_free_irq() not custom action.

this one looks making lots of senses. it makes sure HW will not
trigger any SW behaviour before probe() finishes, and also makes sure
HW will not trigger any SW behaviour in remove(). i'd like xianglong
to give a quick test on it.

>
> Thanks.
>
> --
> Dmitry
>
>
> Input: sirfsoc-onkey - implement open and close methods
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> We can control whetehr device generates interrupts or not so let's
> implement open and close methods of input device so that we do not do any
> processing until there are users.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/misc/sirfsoc-onkey.c |   50 +++++++++++++++++++++++++++++-------
>  1 file changed, 40 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
> index e8897c3..dc7db65 100644
> --- a/drivers/input/misc/sirfsoc-onkey.c
> +++ b/drivers/input/misc/sirfsoc-onkey.c
> @@ -49,6 +49,35 @@ static irqreturn_t sirfsoc_pwrc_isr(int irq, void *dev_id)
>         return IRQ_HANDLED;
>  }
>
> +static void sirfsoc_pwrc_toggle_interrupts(struct sirfsoc_pwrc_drvdata *pwrcdrv,
> +                                          bool enable)
> +{
> +       u32 int_mask;
> +
> +       int_mask = sirfsoc_rtc_iobrg_readl(pwrcdrv->pwrc_base + PWRC_INT_MASK);
> +       if (enable)
> +               int_mask |= PWRC_ON_KEY_BIT;
> +       else
> +               int_mask &= ~PWRC_ON_KEY_BIT;
> +       sirfsoc_rtc_iobrg_writel(int_mask, pwrcdrv->pwrc_base + PWRC_INT_MASK);
> +}
> +
> +static int sirfsoc_pwrc_open(struct input_dev *input)
> +{
> +       struct sirfsoc_pwrc_drvdata *pwrcdrv = input_get_drvdata(input);
> +
> +       sirfsoc_pwrc_toggle_interrupts(pwrcdrv, true);
> +
> +       return 0;
> +}
> +
> +static void sirfsoc_pwrc_close(struct input_dev *input)
> +{
> +       struct sirfsoc_pwrc_drvdata *pwrcdrv = input_get_drvdata(input);
> +
> +       sirfsoc_pwrc_toggle_interrupts(pwrcdrv, false);
> +}
> +
>  static const struct of_device_id sirfsoc_pwrc_of_match[] = {
>         { .compatible = "sirf,prima2-pwrc" },
>         {},
> @@ -70,7 +99,7 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
>         }
>
>         /*
> -        * we can't use of_iomap because pwrc is not mapped in memory,
> +        * We can't use of_iomap because pwrc is not mapped in memory,
>          * the so-called base address is only offset in rtciobrg
>          */
>         error = of_property_read_u32(np, "reg", &pwrcdrv->pwrc_base);
> @@ -88,6 +117,11 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
>         pwrcdrv->input->phys = "pwrc/input0";
>         pwrcdrv->input->evbit[0] = BIT_MASK(EV_PWR);
>
> +       pwrcdrv->input->open = sirfsoc_pwrc_open;
> +       pwrcdrv->input->close = sirfsoc_pwrc_close;
> +
> +       input_set_drvdata(pwrcdrv->input, pwrcdrv);
> +
>         irq = platform_get_irq(pdev, 0);
>         error = devm_request_irq(&pdev->dev, irq,
>                                  sirfsoc_pwrc_isr, IRQF_SHARED,
> @@ -98,11 +132,6 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
>                 return error;
>         }
>
> -       sirfsoc_rtc_iobrg_writel(
> -               sirfsoc_rtc_iobrg_readl(pwrcdrv->pwrc_base + PWRC_INT_MASK) |
> -                       PWRC_ON_KEY_BIT,
> -               pwrcdrv->pwrc_base + PWRC_INT_MASK);
> -
>         error = input_register_device(pwrcdrv->input);
>         if (error) {
>                 dev_err(&pdev->dev,
> @@ -129,15 +158,16 @@ static int pwrc_resume(struct device *dev)
>  {
>         struct platform_device *pdev = to_platform_device(dev);
>         struct sirfsoc_pwrc_drvdata *pwrcdrv = platform_get_drvdata(pdev);
> +       struct input_dev *input = pwrcdrv->input;
>
>         /*
>          * Do not mask pwrc interrupt as we want pwrc work as a wakeup source
>          * if users touch X_ONKEY_B, see arch/arm/mach-prima2/pm.c
>          */
> -       sirfsoc_rtc_iobrg_writel(
> -               sirfsoc_rtc_iobrg_readl(
> -               pwrcdrv->pwrc_base + PWRC_INT_MASK) | PWRC_ON_KEY_BIT,
> -               pwrcdrv->pwrc_base + PWRC_INT_MASK);
> +       mutex_lock(&input->mutex);
> +       if (input->users)
> +               sirfsoc_pwrc_toggle_interrupts(pwrcdrv, true);
> +       mutex_unlock(&input->mutex);
>
>         return 0;
>  }

-barry


 To report this email as spam click https://www.mailcontrol.com/sr/MZbqvYs5QwJvpeaetUwhCQ== .


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
