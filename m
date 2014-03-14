From: Robert Baldyga <r.baldyga@samsung.com>
Subject: Re: [PATCH v3 4/4] mfd: max8997: move regmap handling to function
 drivers
Date: Fri, 14 Mar 2014 12:21:55 +0100
Message-ID: <5322E653.90107@samsung.com>
References: <1394703532-494-1-git-send-email-r.baldyga@samsung.com>
 <1394703532-494-5-git-send-email-r.baldyga@samsung.com>
 <532191E6.6080108@samsung.com> <20140313125504.GA10356@lee--X1>
 <20140313140901.GW366@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-reply-to: <20140313140901.GW366@sirena.org.uk>
Sender: linux-leds-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, sameo@linux.intel.com, myungjoo.ham@samsung.com, dmitry.torokhov@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, a.zummo@towertech.it, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, rtc-linux@googlegroups.com, m.szyprowski@samsung.com, k.kozlowski@samsung.com
List-Id: linux-input@vger.kernel.org

Hi,

On 03/13/2014 03:09 PM, Mark Brown wrote:
> On Thu, Mar 13, 2014 at 12:55:04PM +0000, Lee Jones wrote:
>>> Is it necessary? If previous mfd driver has various i2c line, previous mfd driver
>>> initialize regmap/i2c setting on mfd driver.
>>> I'm not sure that regmap/i2c setting code move from mfd driver to each driver.
>>>
>>> Dear Lee Jones,
>>> I need your opinion about moving regmap/i2c code from mfd driver to each driver.
> 
>> I'd rather take advice from Mark on this one.
> 
> I don't really case that much; I'm having a hard time seeing it as
> particularly useful to do the refactoring but if it makes people
> happy...  Keeping things in the core would help promote reusability I
> guess but I'm not sure that's likely to actually happen with this sort
> of driver/device.
> 

If you think it's not needed, you can ignore this patch. I prepared it
due to Dmitry Torokhov suggestion. If you think it's useless it doesn't
make me unhappy :)

Best regards
Robert Baldyga
