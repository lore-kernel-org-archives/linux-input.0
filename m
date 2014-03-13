From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 2/3] mfd: max8997: handle IRQs using regmap
Date: Thu, 13 Mar 2014 17:03:50 +0900
Message-ID: <53216666.4080500@samsung.com>
References: <1394631466-6429-1-git-send-email-r.baldyga@samsung.com>
 <1394631466-6429-3-git-send-email-r.baldyga@samsung.com>
 <532111FA.2010706@samsung.com> <53216272.7050304@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-reply-to: <53216272.7050304@samsung.com>
Sender: linux-leds-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: sameo@linux.intel.com, lee.jones@linaro.org, myungjoo.ham@samsung.com, dmitry.torokhov@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, rtc-linux@googlegroups.com, m.szyprowski@samsung.com, k.kozlowski@samsung.com
List-Id: linux-input@vger.kernel.org

Hi Robert,

On 03/13/2014 04:46 PM, Robert Baldyga wrote:
> Hi,
> On 03/13/2014 03:03 AM, Chanwoo Choi wrote:
>> Hi Robert,
>>
>> On 03/12/2014 10:37 PM, Robert Baldyga wrote:
>>> This patch modifies mfd driver to use regmap for handling interrupts.
>>> It allows to simplify irq handling process. This modifications needed
>>> to make small changes in function drivers, which use interrupts.
>>>
>>> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
>>> ---
>>>  drivers/extcon/extcon-max8997.c     |   35 ++--
>>>  drivers/mfd/Kconfig                 |    2 +-
>>>  drivers/mfd/Makefile                |    2 +-
>>>  drivers/mfd/max8997-irq.c           |  373 -----------------------------------
>>>  drivers/mfd/max8997.c               |  113 ++++++++++-
>>>  drivers/rtc/rtc-max8997.c           |    2 +-
>>>  include/linux/mfd/max8997-private.h |   65 +++++-
>>>  7 files changed, 183 insertions(+), 409 deletions(-)
>>>  delete mode 100644 drivers/mfd/max8997-irq.c
>>>
>>> diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
>>> index f258c08..15fc5c0 100644
>>> --- a/drivers/extcon/extcon-max8997.c
>>> +++ b/drivers/extcon/extcon-max8997.c
>>> @@ -46,15 +46,15 @@ struct max8997_muic_irq {
>>>  };
>>>  
>>>  static struct max8997_muic_irq muic_irqs[] = {
>>> -	{ MAX8997_MUICIRQ_ADCError,	"muic-ADCERROR" },
>>> -	{ MAX8997_MUICIRQ_ADCLow,	"muic-ADCLOW" },
>>> -	{ MAX8997_MUICIRQ_ADC,		"muic-ADC" },
>>> -	{ MAX8997_MUICIRQ_VBVolt,	"muic-VBVOLT" },
>>> -	{ MAX8997_MUICIRQ_DBChg,	"muic-DBCHG" },
>>> -	{ MAX8997_MUICIRQ_DCDTmr,	"muic-DCDTMR" },
>>> -	{ MAX8997_MUICIRQ_ChgDetRun,	"muic-CHGDETRUN" },
>>> -	{ MAX8997_MUICIRQ_ChgTyp,	"muic-CHGTYP" },
>>> -	{ MAX8997_MUICIRQ_OVP,		"muic-OVP" },
>>> +	{ MAX8997_MUICIRQ_ADCERROR,	"MUIC-ADCERROR" },
>>> +	{ MAX8997_MUICIRQ_ADCLOW,	"MUIC-ADCLOW" },
>>> +	{ MAX8997_MUICIRQ_ADC,		"MUIC-ADC" },
>>> +	{ MAX8997_MUICIRQ_VBVOLT,	"MUIC-VBVOLT" },
>>> +	{ MAX8997_MUICIRQ_DBCHG,	"MUIC-DBCHG" },
>>> +	{ MAX8997_MUICIRQ_DCDTMR,	"MUIC-DCDTMR" },
>>> +	{ MAX8997_MUICIRQ_CHGDETRUN,	"MUIC-CHGDETRUN" },
>>> +	{ MAX8997_MUICIRQ_CHGTYP,	"MUIC-CHGTYP" },
>>> +	{ MAX8997_MUICIRQ_OVP,		"MUIC-OVP" },
>>>  };
>>
>>
>> Why did you modify interrput name? Did you have some reason?
>> I think this modification don't need it.
> 
> I did it to have one naming convention in max8997-private.h file. Any
> other interrupt names uses upper case, but MUIC iqr's from some reason
> uses CamelCase. I think it's much better to have consistent style in
> entire file.

If you want to modify interrupt name, I think you better separate patch for
this modification. This patch handle only regmap according to the title of this patch.

Thanks,
Chanwoo Choi
