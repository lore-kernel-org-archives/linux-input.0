From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v3] Input: gpio_keys: Add level trigger support for GPIO keys
Date: Thu, 1 Mar 2018 15:35:23 +0800
Message-ID: <CAMz4kuLNbsZjDPW19V96yL3DzY-bJsjRR=o+w0x4PGyxZFZ0dg@mail.gmail.com>
References: <826093167e8fb24723f474b0272f3dcab1b6a97e.1519821626.git.baolin.wang@linaro.org>
 <CAK8P3a1v2GanneaFKpXWjWLt1YzibJ9Bh7vUcd_SH-4jGN_1+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1v2GanneaFKpXWjWLt1YzibJ9Bh7vUcd_SH-4jGN_1+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, gregkh <gregkh@linuxfoundation.org>, stephen lu <lumotuwe@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Joseph Lo <josephl@nvidia.com>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-input@vger.kernel.org

On 28 February 2018 at 22:44, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Feb 28, 2018 at 1:44 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> On some platforms (such as Spreadtrum platform), the GPIO keys can only
>> be triggered by level type. So this patch introduces one property to
>> indicate if the GPIO trigger type is level trigger or edge trigger.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes since v2:
>>  - Use 'interrupt' property to indicate the irq type.
>>
>> Changes since v1:
>>  - Diable the GPIO irq until reversing the GPIO level type.
>
> I've looked at your patch in more detail now, and given it a bit more thought.
>
> I wonder if you could move that logic into your gpiochip/irqchip driver instead.
> It seems that what you do in the gpio-keys driver is to emulate edge triggered
> behavior on a level triggered irqchip.
>
> If you put the same logic into the gpio driver, you could simply make it
> pretend to support an edge trigger on both edges and call into the interrupt
> handler whenever the state changes.
>

That is really a good suggestion, which can avoid duplicate level
reverse logic in different drivers. So this patch can be simplified
just adding one trigger_type to indicate the interrupt type (not
always edge trigger). Thanks for your suggestion.

-- 
Baolin.wang
Best Regards
