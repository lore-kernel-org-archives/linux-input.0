From: "Mark F. Brown" <mark.brown314@gmail.com>
Subject: Re: [PATCH 4/5] ARM: pxa168: added special case handler for keypad interrupts
Date: Tue, 31 Aug 2010 02:28:59 -0400
Message-ID: <AANLkTinEtFhC6kB3asuBXLxCgYf9yOTLTTwRQJXKcu2n@mail.gmail.com>
References: <1282814339-10934-1-git-send-email-mark.brown314@gmail.com>
	<1282814339-10934-5-git-send-email-mark.brown314@gmail.com>
	<AANLkTimvudYv4fwyGWjL5c10QrM9GtC2SXjPZzcV20_s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:57604 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756024Ab0HaG3B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Aug 2010 02:29:01 -0400
In-Reply-To: <AANLkTimvudYv4fwyGWjL5c10QrM9GtC2SXjPZzcV20_s@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

On Tue, Aug 31, 2010 at 12:53 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Thu, Aug 26, 2010 at 5:18 PM, Mark F. Brown <mark.brown314@gmail.c=
om> wrote:
>> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
>> ---
>> =A0arch/arm/mach-mmp/irq-pxa168.c | =A0 23 ++++++++++++++++++++++-
>> =A01 files changed, 22 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-mmp/irq-pxa168.c b/arch/arm/mach-mmp/irq-=
pxa168.c
>> index 52ff2f0..bfb0984 100644
>> --- a/arch/arm/mach-mmp/irq-pxa168.c
>> +++ b/arch/arm/mach-mmp/irq-pxa168.c
>> @@ -17,6 +17,8 @@
>> =A0#include <linux/io.h>
>>
>> =A0#include <mach/regs-icu.h>
>> +#include <mach/regs-apmu.h>
>> +#include <mach/cputype.h>
>>
>> =A0#include "common.h"
>>
>> @@ -42,6 +44,19 @@ static struct irq_chip icu_irq_chip =3D {
>> =A0 =A0 =A0 =A0.unmask =3D icu_unmask_irq,
>> =A0};
>>
>> +void handle_pxa168_keypad_irq(unsigned int irq, struct irq_desc *de=
sc)
>> +{
>> + =A0 =A0 =A0 uint32_t val;
>> + =A0 =A0 =A0 uint32_t mask =3D APMU_PXA168_KP_WAKE_CLR;
>> +
>> + =A0 =A0 =A0 /* clear keypad wake event */
>> + =A0 =A0 =A0 val =3D __raw_readl(APMU_WAKE_CLR);
>> + =A0 =A0 =A0 __raw_writel(val | =A0mask, APMU_WAKE_CLR);
>> +
>> + =A0 =A0 =A0 /* handle irq */
>> + =A0 =A0 =A0 handle_level_irq(irq, desc);
>> +}
>> +
>
> Why should you clear wakeup event status in IRQ handler? If system is
> resumed by keypad event, you should clear this wakeup source in resum=
e
> code. I think that IRQ code should not be binded with wakeup event at
> here.
>
>> =A0void __init icu_init_irq(void)
>> =A0{
>> =A0 =A0 =A0 =A0int irq;
>> @@ -49,7 +64,13 @@ void __init icu_init_irq(void)
>> =A0 =A0 =A0 =A0for (irq =3D 0; irq < 64; irq++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0icu_mask_irq(irq);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_irq_chip(irq, &icu_irq_chip);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_irq_handler(irq, handle_level_irq)=
;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* special handler for keypad */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_pxa168() && irq =3D=3D IRQ_=
PXA168_KEYPAD)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_irq_handler(irq, h=
andle_pxa168_keypad_irq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_irq_handler(irq, h=
andle_level_irq);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_irq_flags(irq, IRQF_VALID);
>> =A0 =A0 =A0 =A0}
>> =A0}
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at =A0http://www.tux.org/lkml/
>>
>

Haojian, this is an usual case, but without that clear wake event you
will not be able to clear the keypad interrupt. For my push to open
source I re-wrote the workaround code and added it as a special case
IRQ handler. In the Marvell pxa168 code base it is actually located in
the keypad interrupt handler as the function clear_wakeup(). I felt it
was better to isolate this code in the mmp common code base instead.

Regards,
-- Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
