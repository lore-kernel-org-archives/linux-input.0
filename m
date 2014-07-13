From: Lennox Wu <lennox.wu@gmail.com>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Sun, 13 Jul 2014 17:27:44 +0800
Message-ID: <CAF0htA60juBVkPo2HQKMDGcEr-wRzRVL_6JgHAa+7WVE_E8M0Q@mail.gmail.com>
References: <53C1F7DE.3060102@gmail.com>
	<201407130545.23004.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <201407130545.23004.marex@denx.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, teg@jklm.no, thierry.reding@gmail.com, Chen Gang <gang.chen.5i5j@gmail.com>, devel@driverdev.osuosl.org, Liqin Chen <liqin.linux@gmail.com>, lars@metafoo.de, Richard Weinberger <richard@nod.at>, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, msalter@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dmitry.torokhov@gmail.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, knaack.h@gmx.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, Mischa.Jonker@synopsys.com, jic23@kernel.org
List-Id: linux-input@vger.kernel.org

As I said before, some configurations don't make sense.
I don't think all of the patches are necessary.

Best,
Lennox

2014-07-13 11:45 GMT+08:00 Marek Vasut <marex@denx.de>:
> On Sunday, July 13, 2014 at 05:07:10 AM, Chen Gang wrote:
>> Several drivers need 'devm_ioremap_resource' which need HAS_IOMEM enabled.
>> So let them depend on HAS_IOMEM.
>>
>> The related error (with allmodconfig under score):
>>
>>     MODPOST 1365 modules
>>   ERROR: "devm_ioremap_resource" [drivers/watchdog/tegra_wdt.ko] undefined!
>>   ERROR: "devm_ioremap_resource" [drivers/watchdog/of_xilinx_wdt.ko]
>> undefined! ERROR: "devm_ioremap_resource"
>> [drivers/staging/iio/adc/mxs-lradc.ko] undefined! ERROR:
>> "devm_ioremap_resource" [drivers/pwm/pwm-clps711x.ko] undefined! ERROR:
>> "devm_ioremap_resource" [drivers/input/serio/olpc_apsp.ko] undefined!
>> ERROR: "devm_ioremap_resource" [drivers/input/serio/arc_ps2.ko] undefined!
>
> This stuff should go through different trees, so I'd suggest to split this into
> multiple patches. Thanks for catching this stuff !
>
> Best regards,
> Marek Vasut
