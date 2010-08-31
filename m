From: "Mark F. Brown" <mark.brown314@gmail.com>
Subject: Re: [PATCH 4/5] ARM: pxa168: added special case handler for keypad interrupts
Date: Tue, 31 Aug 2010 03:13:04 -0400
Message-ID: <AANLkTi=RgZcykxPnUcneGfZnETo9nK_72Qoa=8rKh2rD@mail.gmail.com>
References: <1282814339-10934-1-git-send-email-mark.brown314@gmail.com>
	<1282814339-10934-5-git-send-email-mark.brown314@gmail.com>
	<AANLkTimvudYv4fwyGWjL5c10QrM9GtC2SXjPZzcV20_s@mail.gmail.com>
	<AANLkTinEtFhC6kB3asuBXLxCgYf9yOTLTTwRQJXKcu2n@mail.gmail.com>
	<AANLkTi=0ECTN8ro3H6=CUZy5qzJjhC0C02yPKzS-+0r5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63739 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756582Ab0HaHNG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Aug 2010 03:13:06 -0400
In-Reply-To: <AANLkTi=0ECTN8ro3H6=CUZy5qzJjhC0C02yPKzS-+0r5@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

On Tue, Aug 31, 2010 at 3:05 AM, Eric Miao <eric.y.miao@gmail.com> wrot=
e:
> On Tue, Aug 31, 2010 at 2:28 PM, Mark F. Brown <mark.brown314@gmail.c=
om> wrote:
>> On Tue, Aug 31, 2010 at 12:53 AM, Haojian Zhuang
>> <haojian.zhuang@gmail.com> wrote:
>>> On Thu, Aug 26, 2010 at 5:18 PM, Mark F. Brown <mark.brown314@gmail=
=2Ecom> wrote:
>>>> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
>>>> ---
>>>> =A0arch/arm/mach-mmp/irq-pxa168.c | =A0 23 ++++++++++++++++++++++-
>>>> =A01 files changed, 22 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-mmp/irq-pxa168.c b/arch/arm/mach-mmp/ir=
q-pxa168.c
>>>> index 52ff2f0..bfb0984 100644
>>>> --- a/arch/arm/mach-mmp/irq-pxa168.c
>>>> +++ b/arch/arm/mach-mmp/irq-pxa168.c
>>>> @@ -17,6 +17,8 @@
>>>> =A0#include <linux/io.h>
>>>>
>>>> =A0#include <mach/regs-icu.h>
>>>> +#include <mach/regs-apmu.h>
>>>> +#include <mach/cputype.h>
>>>>
>>>> =A0#include "common.h"
>>>>
>>>> @@ -42,6 +44,19 @@ static struct irq_chip icu_irq_chip =3D {
>>>> =A0 =A0 =A0 =A0.unmask =3D icu_unmask_irq,
>>>> =A0};
>>>>
>>>> +void handle_pxa168_keypad_irq(unsigned int irq, struct irq_desc *=
desc)
>>>> +{
>>>> + =A0 =A0 =A0 uint32_t val;
>>>> + =A0 =A0 =A0 uint32_t mask =3D APMU_PXA168_KP_WAKE_CLR;
>>>> +
>>>> + =A0 =A0 =A0 /* clear keypad wake event */
>>>> + =A0 =A0 =A0 val =3D __raw_readl(APMU_WAKE_CLR);
>>>> + =A0 =A0 =A0 __raw_writel(val | =A0mask, APMU_WAKE_CLR);
>>>> +
>>>> + =A0 =A0 =A0 /* handle irq */
>>>> + =A0 =A0 =A0 handle_level_irq(irq, desc);
>>>> +}
>>>> +
>>>
>>> Why should you clear wakeup event status in IRQ handler? If system =
is
>>> resumed by keypad event, you should clear this wakeup source in res=
ume
>>> code. I think that IRQ code should not be binded with wakeup event =
at
>>> here.
>>>
>>>> =A0void __init icu_init_irq(void)
>>>> =A0{
>>>> =A0 =A0 =A0 =A0int irq;
>>>> @@ -49,7 +64,13 @@ void __init icu_init_irq(void)
>>>> =A0 =A0 =A0 =A0for (irq =3D 0; irq < 64; irq++) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0icu_mask_irq(irq);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_irq_chip(irq, &icu_irq_chip);
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_irq_handler(irq, handle_level_ir=
q);
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* special handler for keypad */
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_pxa168() && irq =3D=3D IR=
Q_PXA168_KEYPAD)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_irq_handler(irq,=
 handle_pxa168_keypad_irq);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_irq_handler(irq,=
 handle_level_irq);
>>>> +
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_irq_flags(irq, IRQF_VALID);
>>>> =A0 =A0 =A0 =A0}
>>>> =A0}
>>>> --
>>>> 1.7.0.4
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-ke=
rnel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>>>> Please read the FAQ at =A0http://www.tux.org/lkml/
>>>>
>>>
>>
>> Haojian, this is an usual case, but without that clear wake event yo=
u
>> will not be able to clear the keypad interrupt. For my push to open
>> source I re-wrote the workaround code and added it as a special case
>> IRQ handler. In the Marvell pxa168 code base it is actually located =
in
>> the keypad interrupt handler as the function clear_wakeup(). I felt =
it
>> was better to isolate this code in the mmp common code base instead.
>
> I'd rather the irq handler not being changed and use platform_data in=
stead.
> How about something below:
>
> diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h
> b/arch/arm/mach-mmp/include/mach/pxa168.h
> index 27e1bc7..d2b7946 100644
> --- a/arch/arm/mach-mmp/include/mach/pxa168.h
> +++ b/arch/arm/mach-mmp/include/mach/pxa168.h
> @@ -5,6 +5,7 @@ struct sys_timer;
>
> =A0extern struct sys_timer pxa168_timer;
> =A0extern void __init pxa168_init_irq(void);
> +extern void pxa168_clear_keypad_wakeup(void);
>
> =A0#include <linux/i2c.h>
> =A0#include <mach/devices.h>
> @@ -97,4 +98,10 @@ static inline int pxa168_add_nand(struct
> pxa3xx_nand_platform_data *info)
> =A0{
> =A0 =A0 =A0 =A0return pxa_register_device(&pxa168_device_nand, info, =
sizeof(*info));
> =A0}
> +
> +static inline int pxa168_add_keypad(struct pxa27x_keypad_platform_da=
ta *info)
> +{
> + =A0 =A0 =A0 info->clear_wakeup =3D pxa168_clear_keypad_wakeup;
> + =A0 =A0 =A0 return pxa_register_device(&pxa168_device_keypad, info,=
 sizeof(*info));
> +}
> =A0#endif /* __ASM_MACH_PXA168_H */
> diff --git a/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
> b/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
> index 7b4eadc..3a6bfe7 100644
> --- a/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
> +++ b/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
> @@ -52,6 +52,7 @@ struct pxa27x_keypad_platform_data {
>
> =A0 =A0 =A0 =A0/* key debounce interval */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0debounce_interval;
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*clear_wakeup);
> =A0};
>
> =A0extern void pxa_set_keypad_info(struct pxa27x_keypad_platform_data=
 *info);
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c
> b/drivers/input/keyboard/pxa27x_keypad.c
> index f32404f..3fb94fe 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -330,10 +330,20 @@ static void pxa27x_keypad_scan_direct(struct
> pxa27x_keypad *keypad)
> =A0 =A0 =A0 =A0keypad->direct_key_state =3D new_state;
> =A0}
>
> +static void clear_wakeup(struct pxa27x_keypad *keypad)
> +{
> + =A0 =A0 =A0 struct pxa27x_keypad_platform_data *pdata =3D keypad->p=
data;
> +
> + =A0 =A0 =A0 if (pdata->clear_wakeup)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata->clear_wakeup)();
> +}
> +
> =A0static irqreturn_t pxa27x_keypad_irq_handler(int irq, void *dev_id=
)
> =A0{
> =A0 =A0 =A0 =A0struct pxa27x_keypad *keypad =3D dev_id;
> - =A0 =A0 =A0 unsigned long kpc =3D keypad_readl(KPC);
> + =A0 =A0 =A0 unsigned long kpc;
> +
> + =A0 =A0 =A0 kpc =3D keypad_readl(KPC);
>
> =A0 =A0 =A0 =A0if (kpc & KPC_DI)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pxa27x_keypad_scan_direct(keypad);
>

Ok if you are fine with that I will make that change and resubmit!

Regards,
-- Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
