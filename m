From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Sun, 13 Jul 2014 16:03:52 +0200
Message-ID: <53C291C8.6050303@nod.at>
References: <53C1F7DE.3060102@gmail.com>	<201407130545.23004.marex@denx.de> <CAF0htA60juBVkPo2HQKMDGcEr-wRzRVL_6JgHAa+7WVE_E8M0Q@mail.gmail.com> <53C25551.1050909@nod.at> <53C288F0.3070001@metafoo.de> <53C28C4A.70907@nod.at> <53C29015.5070607@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <53C29015.5070607@metafoo.de>
Sender: linux-pwm-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Lennox Wu <lennox.wu@gmail.com>, Marek Vasut <marex@denx.de>, Chen Gang <gang.chen.5i5j@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com, thierry.reding@gmail.com, jic23@kernel.org, wim@iguana.be, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kys@microsoft.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, teg@jklm.no, Mischa.Jonker@synopsys.com, msalter@redhat.com, knaack.h@gmx.de, rdunlap@infradead.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, devel@driverdev.osuosl.org, linux-watchdog@vger.kernel.org, Liqin Chen <liqin.linux@gmail.com>
List-Id: linux-input@vger.kernel.org

Am 13.07.2014 15:56, schrieb Lars-Peter Clausen:
> On 07/13/2014 03:40 PM, Richard Weinberger wrote:
>> Am 13.07.2014 15:26, schrieb Lars-Peter Clausen:
>>> On 07/13/2014 11:45 AM, Richard Weinberger wrote:
>>>> Am 13.07.2014 11:27, schrieb Lennox Wu:
>>>>> As I said before, some configurations don't make sense.
>>>>
>>>> If such a configuration can be achieved using allmod/yesconfig it has to be fixed.
>>>> Chen's fixes seem reasonable as not all architectures support iomem.
>>>
>>> Maybe we should stub out ioremap() and friends when COMPILE_TEST is enabled to avoid these linker errors. That's in my opinion better than turning most of the 'depends on
>>> COMPILE_TEST' into 'depends on COMPILE_TEST && HAS_IOMEM'. The issue comes up quite a lot and it is often overlooked when adding a driver that can be build when COMPILE_TEST is
>>> enabled.
>>
>> And what should this stub do?
>> Except calling BUG()...
> 
> return NULL;
> 
> It's for compile testing, it's not meant to work at runtime.

Hm, I really don't like the idea of having a non-working kernel.
IMHO either it should build _and_ run and nothing else.
Greg, what do you think?

Thanks,
//richard
