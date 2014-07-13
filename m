From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Sun, 13 Jul 2014 23:02:28 +0800
Message-ID: <53C29F84.6010108@gmail.com>
References: <53C1F7DE.3060102@gmail.com>	<201407130545.23004.marex@denx.de>
 <CAF0htA60juBVkPo2HQKMDGcEr-wRzRVL_6JgHAa+7WVE_E8M0Q@mail.gmail.com>
 <53C25551.1050909@nod.at> <53C288F0.3070001@metafoo.de>
 <53C28C4A.70907@nod.at> <53C29015.5070607@metafoo.de>
 <53C291C8.6050303@nod.at> <53C296C2.30304@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <53C296C2.30304@metafoo.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: dmitry.torokhov@gmail.com, linux-iio@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, teg@jklm.no, thierry.reding@gmail.com, Lennox Wu <lennox.wu@gmail.com>, Marek Vasut <marex@denx.de>, Liqin Chen <liqin.linux@gmail.com>, Richard Weinberger <richard@nod.at>, msalter@redhat.com, linux-pwm@vger.kernel.org, devel@driverdev.osuosl.org, linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, knaack.h@gmx.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, Mischa.Jonker@synopsys.com, jic23@kernel.org
List-Id: linux-input@vger.kernel.org

On 07/13/2014 10:25 PM, Lars-Peter Clausen wrote:
> On 07/13/2014 04:03 PM, Richard Weinberger wrote:
>> Am 13.07.2014 15:56, schrieb Lars-Peter Clausen:
>>> On 07/13/2014 03:40 PM, Richard Weinberger wrote:
>>>> Am 13.07.2014 15:26, schrieb Lars-Peter Clausen:
>>>>> On 07/13/2014 11:45 AM, Richard Weinberger wrote:
>>>>>> Am 13.07.2014 11:27, schrieb Lennox Wu:
>>>>>>> As I said before, some configurations don't make sense.
>>>>>>
>>>>>> If such a configuration can be achieved using allmod/yesconfig it has to be fixed.
>>>>>> Chen's fixes seem reasonable as not all architectures support iomem.
>>>>>
>>>>> Maybe we should stub out ioremap() and friends when COMPILE_TEST is enabled to avoid these linker errors. That's in my opinion better than turning most of the 'depends on
>>>>> COMPILE_TEST' into 'depends on COMPILE_TEST && HAS_IOMEM'. The issue comes up quite a lot and it is often overlooked when adding a driver that can be build when COMPILE_TEST is
>>>>> enabled.
>>>>
>>>> And what should this stub do?
>>>> Except calling BUG()...
>>>
>>> return NULL;
>>>
>>> It's for compile testing, it's not meant to work at runtime.
>>
>> Hm, I really don't like the idea of having a non-working kernel.
>> IMHO either it should build _and_ run and nothing else.
>> Greg, what do you think?
> 
> The kernel will still be working fine and you can run it on a system. The drivers which use ioremap() or similar are probably not instantiated on a system that does not provide HAS_IOMEM. But even if it was the driver should handle ioremap() returning NULL gracefully and abort the driver probe. That said you'll probably not run a kernel that was built with COMPILE_TEST on your real hardware since it contains so many drivers that are completely useless on your hardware. The idea of COMPILE_TEST is to have as much compile test exposure as possible to the code that is enabled by COMPILE_TEST. Stubbing out ioremap() and friends when HAS_IOMEM is not set and COMPILE_TEST is set makes it easier to get there.
> 

For me, welcome Greg's idea or suggestion for it.

And also if the reply contents are wrapped (e.g. within 80 or less), that
will generate a better display under other members' email clients.


Thanks
-- 
Chen Gang

Open share and attitude like air water and life which God blessed
