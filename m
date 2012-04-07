From: Joachim  Eastwood <manabian@gmail.com>
Subject: Re: [PATCH] Input: eeti_ts: Mark as CONFIG_BROKEN
Date: Sat, 7 Apr 2012 23:04:54 +0200
Message-ID: <CAGhQ9VwBBF97uM7kjfLz_VH12P7HpoKajBoF26vH7QAmQFDcFw@mail.gmail.com>
References: <1333777207-4151-1-git-send-email-olof@lixom.net>
 <20120407070206.GA17623@core.coreip.homeip.net>
 <4F8089A9.6080704@raumfeld.com>
 <CAOesGMiPZ0so-ZN0HCHHhw16oPWWgfVD5t--wKSvEUtzQx94CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOesGMiPZ0so-ZN0HCHHhw16oPWWgfVD5t--wKSvEUtzQx94CA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olof Johansson <olof@lixom.net>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sven Neumann <s.neumann@raumfeld.com>, linux-kernel@vger.kernel.org, Daniel Mack <zonque@gmail.com>, Daniel Mack <daniel@caiaq.de>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Sat, Apr 7, 2012 at 10:32 PM, Olof Johansson <olof@lixom.net> wrote:
> On Sat, Apr 7, 2012 at 11:38 AM, Sven Neumann <s.neumann@raumfeld.com> wr=
ote:
>> Hi,
>>
>>
>> On 07.04.12 09:02, Dmitry Torokhov wrote:
>>>
>>> On Fri, Apr 06, 2012 at 10:40:07PM -0700, Olof Johansson wrote:
>>>>
>>>> This seems to have been broken since 2010, so obviously noone actually
>>>> cares about the driver:
>>>>
>>>> make[4]: *** [drivers/input/touchscreen/eeti_ts.o] Error 1
>>>> drivers/input/touchscreen/eeti_ts.c: In function 'eeti_ts_irq_active':
>>>> drivers/input/touchscreen/eeti_ts.c:65:2: error: implicit declaration =
of
>>>> function 'irq_to_gpio' [-Werror=3Dimplicit-function-declaration]
>>>>
>>>> irq_to_gpio isn't available on most platforms today, so the driver
>>>> will need some rework by someone who has hardware access and can test
>>>> (to make sure that, for example, switching to level interrupts and just
>>>> keep taking them while there's more to process works).
>>>>
>>>> I guess it could just be scheduled for removal, but let's start with
>>>> marking it CONFIG_BROKEN.
>>>
>>>
>>> Well, it probably works quite well on arches that do have irq_to_gpio(),
>>> let's ask Daniel and Sven if they still have this hardware and if they
>>> can try the patch below that implements what you suggested.
>>
>>
>> This hardware is still in use and we also still follow kernel development
>> and try to update our customer devices to recent kernel versions regular=
ly.
>> Currently we are at 3.1.10 and the touchscreen works well with that. I'll
>> try to update to a more recent kernel next week and will try your patch.
>
> Ah, you're right, and this was my bad. Looks like this change was
> introduced in 3.2 and broke this and one more driver (ezx-pcap):
>
> Author: =A0 =A0 Haojian Zhuang <haojian.zhuang@marvell.com>
> AuthorDate: Mon Oct 10 16:03:51 2011 +0800
> Commit: =A0 =A0 Haojian Zhuang <haojian.zhuang@marvell.com>
> CommitDate: Mon Nov 14 21:07:59 2011 +0800
>
> =A0 =A0ARM: pxa: rename gpio_to_irq and irq_to_gpio
>
> =A0 =A0Avoid to define gpio_to_irq() and irq_to_gpio() for potential name
> =A0 =A0confliction since multiple architecture will be built together.
>
> =A0 =A0Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>
>
> Haojian, I think it was probably premature to do the multiplatform
> change like that, since it means that a PXA-only kernel has no mapping
> from irq_to_gpio to pxa_irq_to_gpio. Can you please address this as a
> fix for 3.4?
>
>
> Thanks,
>
> -Olof

It's the same story with AT91. Here irq_to_gpio was also removed some
time ago. I believe it's the same for a lot of other ARM architectures
also.
Currently there 7 drivers that uses irq_to_gpio, these are obviously
broken on architectures that not provide the function.

I think it would be better to fix the drivers rather than resurrect
irq_to_gpio on the individual architectures.

Users of irq_to_gpio in drivers:
pata_rb532_cf, eeti_ts, egalax_ts, ezx-pcap, db1xxx_ss, tosa_battery, lis3l=
02dq

regards
Joachim Eastwood

> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
