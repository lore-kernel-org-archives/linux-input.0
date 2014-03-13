From: Robert Baldyga <r.baldyga@samsung.com>
Subject: Re: [PATCH v3 0/4] mfd: max8997: add regmap support
Date: Thu, 13 Mar 2014 11:52:57 +0100
Message-ID: <53218E09.1040200@samsung.com>
References: <1394703532-494-1-git-send-email-r.baldyga@samsung.com>
 <53218786.7010208@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-reply-to: <53218786.7010208@samsung.com>
Sender: linux-leds-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: sameo@linux.intel.com, lee.jones@linaro.org, myungjoo.ham@samsung.com, dmitry.torokhov@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, rtc-linux@googlegroups.com, m.szyprowski@samsung.com, k.kozlowski@samsung.com
List-Id: linux-input@vger.kernel.org

Hi,

On 03/13/2014 11:25 AM, Chanwoo Choi wrote:
> Hi Robert,
> 
> On 03/13/2014 06:38 PM, Robert Baldyga wrote:
>> Hi,
>>
>> This patchset modifies max8997 driver and associated function drivers to use
>> register maps instead of operating directly on i2c bus. This change allowed
>> to simplify irq handling, and to move some initializations to individual
>> function drivers. Hence now when some functions are not enabled, their i2c
>> clients, regmaps and irqs are not registered.
>>
>> Best regards
>> Robert Baldyga
>> Samsung R&D Institute Poland
>>
>> Changelog:
>>
>> v3:
>> - fix error handling
>> - fix deinitializations order
>> - move muic irq enum values renaming to separate patch
>>
>> v2: https://lkml.org/lkml/2014/3/12/237
>> - rebase patches on Lee Jones' MFD tree
>> - add missing selects in Kconfig
>> - add missing deinitializations
>> - add interrupt disabling when suspend
>> - few minor changes and typo fixes
>>
>> v1: https://lkml.org/lkml/2014/3/11/291
>>
>> Robert Baldyga (4):
>>   mfd: max8997: use regmap to access registers
>>   mfd: max8997: handle IRQs using regmap
>>   mfd: max8997: change irq names to upper case
>>   mfd: max8997: move regmap handling to function drivers
>>
>>  drivers/extcon/extcon-max8997.c     |  181 +++++++++++++---
>>  drivers/input/misc/max8997_haptic.c |  121 +++++++++--
>>  drivers/leds/leds-max8997.c         |   13 +-
>>  drivers/mfd/Kconfig                 |    3 +-
>>  drivers/mfd/Makefile                |    2 +-
>>  drivers/mfd/max8997-irq.c           |  387 -----------------------------------
>>  drivers/mfd/max8997.c               |  236 +++++++--------------
>>  drivers/power/max8997_charger.c     |   33 +--
>>  drivers/regulator/max8997.c         |   87 ++++----
>>  drivers/rtc/rtc-max8997.c           |  102 ++++++---
>>  include/linux/mfd/max8997-private.h |   88 ++++++--
>>  11 files changed, 532 insertions(+), 721 deletions(-)
>>  delete mode 100644 drivers/mfd/max8997-irq.c
>>
> 
> This patch fix many parts of previous max8997.
> When I testd kernel build, it is ok. 
> 
> But, I have a question.
> The max8997 is used on trats board based on exynos4210.
> Did you test this patchset?

Yes, I have tested it on this board. Some function drivers requiring
platform data would not work yet, but it's not related to this patchset.
They didn't work before.

I'm actually working on patches for extcon-max8997.

Best regards
Robert Baldyga
