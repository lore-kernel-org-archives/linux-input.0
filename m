From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v3 05/10] pwm: add PWM mode to pwm_config()
Date: Thu, 22 Feb 2018 15:23:40 +0200
Message-ID: <8d0f25e6-3bbf-cbbc-7eef-abde0127f2bc@microchip.com>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
 <1519300881-8136-6-git-send-email-claudiu.beznea@microchip.com>
 <20180222130131.46fcuurp4h6dc7wb@gofer.mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180222130131.46fcuurp4h6dc7wb@gofer.mess.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sean Young <sean@mess.org>
Cc: mark.rutland@arm.com, milo.kim@ti.com, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, airlied@linux.ie, mturquette@baylibre.com, joonas.lahtinen@linux.intel.com, kamil@wypas.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, alexandre.belloni@free-electrons.com, pavel@ucw.cz, lee.jones@linaro.org, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, daniel.thompson@linaro.org, linux-samsung-soc@vger.kernel.org, shc_work@mail.ru, corbet@lwn.net, linux-doc@vger.kernel.org, linux@armlinux.org.uk, krzk@kernel.org, kgene@kernel.org, linux-input@vger.kernel.org, linux@roeck-us.net, linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, jdelvare@suse.com, b.zolnierkie@samsung.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, robh+dt@kernel.org, jacek.anaszewski@gmail.com, rodrigo.vivi@intel.com, mchehab@ke
List-Id: linux-input@vger.kernel.org



On 22.02.2018 15:01, Sean Young wrote:
> On Thu, Feb 22, 2018 at 02:01:16PM +0200, Claudiu Beznea wrote:
>> Add PWM mode to pwm_config() function. The drivers which uses pwm_config()
>> were adapted to this change.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
> 
> -snip-
> 
>> diff --git a/drivers/media/rc/ir-rx51.c b/drivers/media/rc/ir-rx51.c
>> index 49265f02e772..a971b02ea021 100644
>> --- a/drivers/media/rc/ir-rx51.c
>> +++ b/drivers/media/rc/ir-rx51.c
>> @@ -55,10 +55,13 @@ static int init_timing_params(struct ir_rx51 *ir_rx51)
>>  {
>>  	struct pwm_device *pwm = ir_rx51->pwm;
>>  	int duty, period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, ir_rx51->freq);
>> +	struct pwm_caps caps = { };
>>  
>>  	duty = DIV_ROUND_CLOSEST(ir_rx51->duty_cycle * period, 100);
>>  
>> -	pwm_config(pwm, duty, period);
>> +	pwm_get_caps(pwm->chip, pwm, &caps);
>> +
>> +	pwm_config(pwm, duty, period, BIT(ffs(caps.modes) - 1));
>>  
>>  	return 0;
>>  }
>> diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
>> index 27d0f5837a76..c630e1b450a3 100644
>> --- a/drivers/media/rc/pwm-ir-tx.c
>> +++ b/drivers/media/rc/pwm-ir-tx.c
>> @@ -61,6 +61,7 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
>>  {
>>  	struct pwm_ir *pwm_ir = dev->priv;
>>  	struct pwm_device *pwm = pwm_ir->pwm;
>> +	struct pwm_caps caps = { };
>>  	int i, duty, period;
>>  	ktime_t edge;
>>  	long delta;
>> @@ -68,7 +69,9 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
>>  	period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
>>  	duty = DIV_ROUND_CLOSEST(pwm_ir->duty_cycle * period, 100);
>>  
>> -	pwm_config(pwm, duty, period);
>> +	pwm_get_caps(pwm->chip, pwm, &caps);
>> +
>> +	pwm_config(pwm, duty, period, BIT(ffs(caps.modes) - 1));
>>  
>>  	edge = ktime_get();
>>  
> 
> The two PWM rc-core drivers need PWM_MODE(NORMAL), not the first available
> mode that the device supports. If mode normal is not supported, then probe
> should fail.
OK, thank you for your inputs. I will address this in next version.


Thank you,
Claudiu Beznea
> 
> 
> Sean
> 
