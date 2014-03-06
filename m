From: Robert Baldyga <r.baldyga@samsung.com>
Subject: Re: [PATCH v2] mfd: max8997: use regmap to access registers
Date: Thu, 06 Mar 2014 07:42:30 +0100
Message-ID: <531818D6.3080500@samsung.com>
References: <1394031497-16648-1-git-send-email-r.baldyga@samsung.com>
 <20140305185439.GC5453@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-reply-to: <20140305185439.GC5453@core.coreip.homeip.net>
Sender: linux-leds-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: sameo@linux.intel.com, lee.jones@linaro.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, cooloney@gmail.com, rpurdie@rpsys.net, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, rtc-linux@googlegroups.com, m.szyprowski@samsung.com, k.kozlowski@samsung.com
List-Id: linux-input@vger.kernel.org

Hi,

On 03/05/2014 07:54 PM, Dmitry Torokhov wrote:
> Hi Robert,
> 
> On Wed, Mar 05, 2014 at 03:58:17PM +0100, Robert Baldyga wrote:
>>  
>> -int max8997_write_reg(struct i2c_client *i2c, u8 reg, u8 value)
>> +int max8997_write_reg(struct regmap *map, u8 reg, u8 value)
> 
> Why don't you make read/write reg to take struct max8997_dev as argument
> instead of regmap? regmap seems to be the current implementation du jur,
> but that is core's detail, functions do not need to care.
> 
> Thanks.
> 

It's because there are few regmaps in max8997_dev, and read/write reg
functions has no way to check which regmap should be used. I think it
would be clearer if I remove this functions and use regmap_read and
regmap_write instead, because there is no particular purpose for them.

Best regards
Robert Baldyga
Samsung R&D Institute Poland
