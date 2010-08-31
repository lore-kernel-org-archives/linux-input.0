From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 4/5] ARM: pxa168: added special case handler for keypad interrupts
Date: Tue, 31 Aug 2010 15:15:44 +0800
Message-ID: <AANLkTi==d-YW4mVT7Pvr_NqfiHeXZ=DZjv69Z_Dhg6Gb@mail.gmail.com>
References: <1282814339-10934-1-git-send-email-mark.brown314@gmail.com>
 <1282814339-10934-5-git-send-email-mark.brown314@gmail.com>
 <AANLkTimvudYv4fwyGWjL5c10QrM9GtC2SXjPZzcV20_s@mail.gmail.com>
 <AANLkTinEtFhC6kB3asuBXLxCgYf9yOTLTTwRQJXKcu2n@mail.gmail.com>
 <AANLkTi=0ECTN8ro3H6=CUZy5qzJjhC0C02yPKzS-+0r5@mail.gmail.com> <AANLkTi=RgZcykxPnUcneGfZnETo9nK_72Qoa=8rKh2rD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52198 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172Ab0HaHQG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Aug 2010 03:16:06 -0400
In-Reply-To: <AANLkTi=RgZcykxPnUcneGfZnETo9nK_72Qoa=8rKh2rD@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Mark F. Brown" <mark.brown314@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

On Tue, Aug 31, 2010 at 3:13 PM, Mark F. Brown <mark.brown314@gmail.com=
> wrote:
> On Tue, Aug 31, 2010 at 3:05 AM, Eric Miao <eric.y.miao@gmail.com> wr=
ote:
>> On Tue, Aug 31, 2010 at 2:28 PM, Mark F. Brown <mark.brown314@gmail.=
com> wrote:
>>> On Tue, Aug 31, 2010 at 12:53 AM, Haojian Zhuang
>>> <haojian.zhuang@gmail.com> wrote:
>>>> On Thu, Aug 26, 2010 at 5:18 PM, Mark F. Brown <mark.brown314@gmai=
l.com> wrote:
>>>>> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
>>>>> ---
>>>>> =C2=A0arch/arm/mach-mmp/irq-pxa168.c | =C2=A0 23 ++++++++++++++++=
++++++-
>>>>> =C2=A01 files changed, 22 insertions(+), 1 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-mmp/irq-pxa168.c b/arch/arm/mach-mmp/i=
rq-pxa168.c
>>>>> index 52ff2f0..bfb0984 100644
>>>>> --- a/arch/arm/mach-mmp/irq-pxa168.c
>>>>> +++ b/arch/arm/mach-mmp/irq-pxa168.c
>>>>> @@ -17,6 +17,8 @@
>>>>> =C2=A0#include <linux/io.h>
>>>>>
>>>>> =C2=A0#include <mach/regs-icu.h>
>>>>> +#include <mach/regs-apmu.h>
>>>>> +#include <mach/cputype.h>
>>>>>
>>>>> =C2=A0#include "common.h"
>>>>>
>>>>> @@ -42,6 +44,19 @@ static struct irq_chip icu_irq_chip =3D {
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.unmask =3D icu_unmask_irq,
>>>>> =C2=A0};
>>>>>
>>>>> +void handle_pxa168_keypad_irq(unsigned int irq, struct irq_desc =
*desc)
>>>>> +{
>>>>> + =C2=A0 =C2=A0 =C2=A0 uint32_t val;
>>>>> + =C2=A0 =C2=A0 =C2=A0 uint32_t mask =3D APMU_PXA168_KP_WAKE_CLR;
>>>>> +
>>>>> + =C2=A0 =C2=A0 =C2=A0 /* clear keypad wake event */
>>>>> + =C2=A0 =C2=A0 =C2=A0 val =3D __raw_readl(APMU_WAKE_CLR);
>>>>> + =C2=A0 =C2=A0 =C2=A0 __raw_writel(val | =C2=A0mask, APMU_WAKE_C=
LR);
>>>>> +
>>>>> + =C2=A0 =C2=A0 =C2=A0 /* handle irq */
>>>>> + =C2=A0 =C2=A0 =C2=A0 handle_level_irq(irq, desc);
>>>>> +}
>>>>> +
>>>>
>>>> Why should you clear wakeup event status in IRQ handler? If system=
 is
>>>> resumed by keypad event, you should clear this wakeup source in re=
sume
>>>> code. I think that IRQ code should not be binded with wakeup event=
 at
>>>> here.
>>>>
>>>>> =C2=A0void __init icu_init_irq(void)
>>>>> =C2=A0{
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int irq;
>>>>> @@ -49,7 +64,13 @@ void __init icu_init_irq(void)
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (irq =3D 0; irq < 64; irq++) {
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0icu_mask_i=
rq(irq);
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_irq_ch=
ip(irq, &icu_irq_chip);
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_irq_handle=
r(irq, handle_level_irq);
>>>>> +
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* special han=
dler for keypad */
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_is_pxa=
168() && irq =3D=3D IRQ_PXA168_KEYPAD)
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 set_irq_handler(irq, handle_pxa168_keypad_irq);
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 set_irq_handler(irq, handle_level_irq);
>>>>> +
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_irq_fl=
ags(irq, IRQF_VALID);
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>>> =C2=A0}
>>>>> --
>>>>> 1.7.0.4
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-k=
ernel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-inf=
o.html
>>>>> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>>>>>
>>>>
>>>
>>> Haojian, this is an usual case, but without that clear wake event y=
ou
>>> will not be able to clear the keypad interrupt. For my push to open
>>> source I re-wrote the workaround code and added it as a special cas=
e
>>> IRQ handler. In the Marvell pxa168 code base it is actually located=
 in
>>> the keypad interrupt handler as the function clear_wakeup(). I felt=
 it
>>> was better to isolate this code in the mmp common code base instead=
=2E
>>
>> I'd rather the irq handler not being changed and use platform_data i=
nstead.
>> How about something below:
>>
>> diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h
>> b/arch/arm/mach-mmp/include/mach/pxa168.h
>> index 27e1bc7..d2b7946 100644
>> --- a/arch/arm/mach-mmp/include/mach/pxa168.h
>> +++ b/arch/arm/mach-mmp/include/mach/pxa168.h
>> @@ -5,6 +5,7 @@ struct sys_timer;
>>
>> =C2=A0extern struct sys_timer pxa168_timer;
>> =C2=A0extern void __init pxa168_init_irq(void);
>> +extern void pxa168_clear_keypad_wakeup(void);
>>
>> =C2=A0#include <linux/i2c.h>
>> =C2=A0#include <mach/devices.h>
>> @@ -97,4 +98,10 @@ static inline int pxa168_add_nand(struct
>> pxa3xx_nand_platform_data *info)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return pxa_register_device(&pxa168_device=
_nand, info, sizeof(*info));
>> =C2=A0}
>> +
>> +static inline int pxa168_add_keypad(struct pxa27x_keypad_platform_d=
ata *info)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 info->clear_wakeup =3D pxa168_clear_keypad_wa=
keup;
>> + =C2=A0 =C2=A0 =C2=A0 return pxa_register_device(&pxa168_device_key=
pad, info, sizeof(*info));
>> +}
>> =C2=A0#endif /* __ASM_MACH_PXA168_H */
>> diff --git a/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
>> b/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
>> index 7b4eadc..3a6bfe7 100644
>> --- a/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
>> +++ b/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
>> @@ -52,6 +52,7 @@ struct pxa27x_keypad_platform_data {
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* key debounce interval */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0debounce_interv=
al;
>> + =C2=A0 =C2=A0 =C2=A0 void =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
(*clear_wakeup);
>> =C2=A0};
>>
>> =C2=A0extern void pxa_set_keypad_info(struct pxa27x_keypad_platform_=
data *info);
>> diff --git a/drivers/input/keyboard/pxa27x_keypad.c
>> b/drivers/input/keyboard/pxa27x_keypad.c
>> index f32404f..3fb94fe 100644
>> --- a/drivers/input/keyboard/pxa27x_keypad.c
>> +++ b/drivers/input/keyboard/pxa27x_keypad.c
>> @@ -330,10 +330,20 @@ static void pxa27x_keypad_scan_direct(struct
>> pxa27x_keypad *keypad)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0keypad->direct_key_state =3D new_state;
>> =C2=A0}
>>
>> +static void clear_wakeup(struct pxa27x_keypad *keypad)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct pxa27x_keypad_platform_data *pdata =3D=
 keypad->pdata;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (pdata->clear_wakeup)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (pdata->clear_wak=
eup)();
>> +}
>> +
>> =C2=A0static irqreturn_t pxa27x_keypad_irq_handler(int irq, void *de=
v_id)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pxa27x_keypad *keypad =3D dev_id;
>> - =C2=A0 =C2=A0 =C2=A0 unsigned long kpc =3D keypad_readl(KPC);
>> + =C2=A0 =C2=A0 =C2=A0 unsigned long kpc;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 kpc =3D keypad_readl(KPC);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kpc & KPC_DI)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pxa27x_keypad=
_scan_direct(keypad);
>>
>
> Ok if you are fine with that I will make that change and resubmit!
>

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
