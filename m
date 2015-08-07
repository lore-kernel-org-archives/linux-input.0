From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ALSA: ac97: Switch to dev_pm_ops
Date: Fri, 07 Aug 2015 10:13:48 +0200
Message-ID: <55C468BC.60500@metafoo.de>
References: <1438890129-32621-1-git-send-email-lars@metafoo.de>
 <20150806225501.GA24261@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20150806225501.GA24261@dtor-ws>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: linux-input@vger.kernel.org

On 08/07/2015 12:55 AM, Dmitry Torokhov wrote:
[...]
>>  
>> -#ifdef CONFIG_PM
>> -static int wm97xx_suspend(struct device *dev, pm_message_t state)
>> +#ifdef CONFIG_PM_SLEEP
>> +static int wm97xx_suspend(struct device *dev)
> 
> While we are changing it please drop #ifdef CONFIG_PM_SLEEP and annotate
> suspend and resume with __maybe_unused.

We know that it is used when CONFIG_PM_SLEEP is defined and we know that it
is unused CONFIG_PM_SLEEP is not defined. Marking the function as
__maybe_unused will cause the compiler to not generate a warning when the
function is really unused. Making this explicit works much better.

> 
>>  {
>>  	struct wm97xx *wm = dev_get_drvdata(dev);
>>  	u16 reg;
>> @@ -799,9 +799,11 @@ static int wm97xx_resume(struct device *dev)
>>  	return 0;
>>  }
>>  
>> +static SIMPLE_DEV_PM_OPS(wm97xx_pm_ops, wm97xx_suspend, wm97xx_resume);
> 
> Pull this out of #ifdef block and kill entire #else/endif along with
> WM97XX_PM_OPS define: SIMPLE_DEV_PM_OPS will result in an empty
> structure if CONFIG_PM_SLEEP is not set.

It will create a struct dev_pm_ops full of NULLs. That's kind of
counterproductive to removing PM related data and functions from the kernel
if PM support is no enabled.

> 
>> +#define WM97XX_PM_OPS (&wm97xx_pm_ops)
>> +
>>  #else
>> -#define wm97xx_suspend		NULL
>> -#define wm97xx_resume		NULL
>> +#define WM97XX_PM_OPS NULL
>>  #endif
[...]
