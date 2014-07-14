From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Mon, 14 Jul 2014 10:57:10 +0200
Message-ID: <53C39B66.4060500@nod.at>
References: <201407130545.23004.marex@denx.de>
 <CAF0htA60juBVkPo2HQKMDGcEr-wRzRVL_6JgHAa+7WVE_E8M0Q@mail.gmail.com>
 <53C25551.1050909@nod.at> <53C288F0.3070001@metafoo.de>
 <53C28C4A.70907@nod.at> <53C29015.5070607@metafoo.de>
 <53C291C8.6050303@nod.at> <53C296C2.30304@metafoo.de>
 <20140713192202.GA19090@kroah.com> <53C2DF12.6040507@nod.at>
 <20140713201753.GA29955@kroah.com> <53C39569.9020802@nod.at>
 <53C3994C.1010309@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <53C3994C.1010309@metafoo.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marek Vasut <marex@denx.de>, Liqin Chen <liqin.linux@gmail.com>, devel@driverdev.osuosl.org, Chen Gang <gang.chen.5i5j@gmail.com>, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, dmitry.torokhov@gmail.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, teg@jklm.no, Martin Schwidefsky <schwidefsky@de.ibm.com>, thierry.reding@gmail.com, jic23@kernel.org, msalter@redhat.com, knaack.h@gmx.de, linux-input@vger.kernel.org, Mischa.Jonker@synopsys.com, Lennox Wu <lennox.wu@gmail.com>, linux-watchdog@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am 14.07.2014 10:48, schrieb Lars-Peter Clausen:
> On 07/14/2014 10:31 AM, Richard Weinberger wrote:
>> Am 13.07.2014 22:17, schrieb Greg Kroah-Hartman:
>>> On Sun, Jul 13, 2014 at 09:33:38PM +0200, Richard Weinberger wrote:
>>>> Maybe we could add COMPILE_TEST to the version string too?
>>>> Just to detect such kernels fast in user bug reports...
>>>
>>> What kind of bug report are you going to get?
>>
>> User manages to enable CONFIG_FOO by selecting COMPILE_TEST and
>> complains that it does not work. :)
> 
> These drivers are typically drivers for some SoC peripheral and the device will simply physically not exist on a platform that does not provide HAS_IOMEM. This is not really any
> different from making the driver selectable via COMPILE_TEST for any other platform. To hit the issue you'd have to instantiate a device driver instance for a device that
> physically does not exist. This will always result in a failure.

Okay, you have convinced me. :)

Thanks,
//richard
