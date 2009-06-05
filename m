From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: Re: [PATCH, v2] input/imx2x: generic keypad handler for i.MX SoCs
Date: Fri, 5 Jun 2009 11:51:48 +0200
Message-ID: <ba4215e10906050251s1b825821kef6ae4645a10bf1b@mail.gmail.com>
References: <200904171640.14294.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:54896 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbZFEJvr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Jun 2009 05:51:47 -0400
Received: by ewy6 with SMTP id 6so1944574ewy.37
        for <linux-input@vger.kernel.org>; Fri, 05 Jun 2009 02:51:48 -0700 (PDT)
In-Reply-To: <200904171640.14294.hs4233@mail.mn-solutions.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Holger Schurig <hs4233@mail.mn-solutions.de>
Cc: linux-input@vger.kernel.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.arm.linux.org.uk

Hi Holger,

I've got your keypad driver running on my i.MX21 board - I had a few
problems mainly when trying to use it as a module -comments below.

> --- linux.orig/arch/arm/mach-mx2/devices.c
> +++ linux/arch/arm/mach-mx2/devices.c
=2E..
> +
> +#ifdef CONFIG_KEYBOARD_MXC

=46or module needs to be
#if defined(CONFIG_KEYBOARD_MXC) || defined(CONFIG_KEYBOARD_MXC_MODULE)

But  I notice the other resource definitions in this file SDHC etc
aren't conditionally compiled at all - what is the policy on this?

> +static struct resource mxc_resource_keypad[] =3D {
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0x10008000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0x10008014,

Why not use KPP_BASE_ADDR?


> +++ linux/drivers/input/keyboard/mxc_keypad.c
> +static void mxc_keypad_scan(unsigned long data)
> +{
> + =A0 =A0 =A0 struct mxc_keypad *kp =3D (struct mxc_keypad *)data;

I changed this to directly take a struct mxc_keypad *  rather than a
long with a cast


> + =A0 =A0 =A0 /* Quick-discharge by setting to totem-pole, */
> + =A0 =A0 =A0 /* then turn back to open-drain */
> + =A0 =A0 =A0 __raw_writew(kp->pdata->output_pins, kp->base + KPCR);
> + =A0 =A0 =A0 wmb();
> + =A0 =A0 =A0 udelay(2);
> + =A0 =A0 =A0 __raw_writew(kp->pdata->output_pins |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kp->pdata->input_pins, kp->base + KPCR)=
;
> +

I think the first write should be input_pins (need to set the output
pins bits to zero in KPCR to switch to totem pole mode.
Where does the udelay(2) come from?

Also (more for my information - I'm a bit sketchy on this) why
__raw_writel + wmb() rather than plain writel ?


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (col_bit & kp->pdata->output_pins) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writew(~col_bit, =
kp->base + KPDR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wmb();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D ~__raw_readw(kp=
->base + KPDR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keystate_cur[snum] =3D =
reg & kp->pdata->input_pins;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (snum++ >=3D MAX_INP=
UTS)

I was getting bounces with this - increasing the udelay(2) to 10 fixed
it but I preferred to do :

		if (col_bit & kp->pdata->output_pins) {
			u16 last_reg =3D 0;
			int debounce =3D 0;

			__raw_writew(~col_bit, kp->base + KPDR);
			wmb();

			while (debounce < 3) {
				udelay(1);
				reg =3D ~__raw_readw(kp->base + KPDR);
				if (reg =3D=3D last_reg)
					debounce++;
				else
					debounce =3D 0;
				last_reg =3D reg;
			}
			keystate_cur[snum] =3D reg & kp->pdata->input_pins;

			if (snum++ >=3D MAX_INPUTS)


On my keyboard this exits after 4-6 loops.

> +static irqreturn_t mxc_keypad_irq_handler(int irq, void *data)
> +{
> + =A0 =A0 =A0 struct mxc_keypad *kp =3D data;
> + =A0 =A0 =A0 u16 stat;
> +
=2E..
> +
> + =A0 =A0 =A0 mxc_keypad_scan((unsigned long)kp);
> +
mxc_keypad_scan(kp);  as mentionned above?


> +static int __devinit mxc_keypad_probe(struct platform_device *pdev)
> +{
=2E..
> + =A0 =A0 =A0 error =3D request_irq(irq, mxc_keypad_irq_handler,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_DISABLED, pdev->name, kp);
>
=2E.
> +failed_free_irq:
> + =A0 =A0 =A0 free_irq(irq, pdev);

This needs to be free_irq(irq, kp)  to match the request_irq

> +static int __devexit mxc_keypad_remove(struct platform_device *pdev)
> +{
=2E.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(kp->irq, pdev);

Idem - this caused module ulooad / reload to fail since the IRQ was
not freed and was seen as busy the second time;

Regards,

Martin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
