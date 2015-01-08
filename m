From: Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH v1 4/4] leds: no longer use unnamed gpios
Date: Thu, 08 Jan 2015 09:45:29 +0100
Message-ID: <54AE43A9.3020309@schinagl.nl>
References: <1420621722-7428-1-git-send-email-oliver+list@schinagl.nl> <1420621722-7428-5-git-send-email-oliver+list@schinagl.nl> <20150107235522.GA6670@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20150107235522.GA6670@dtor-ws>
Sender: linux-leds-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Olliver Schinagl <oliver+list@schinagl.nl>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Robin Gong <b38343@freescale.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Grant Likely <grant.likely@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alexander Shiyan <shc_work@mail.ru>, Jingoo Han <jg1.han@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hey Dmitry,

On 08-01-15 00:55, Dmitry Torokhov wrote:
> On Wed, Jan 07, 2015 at 10:08:42AM +0100, Olliver Schinagl wrote:
>> From: Olliver Schinagl <oliver@schinagl.nl>
>>
>> The gpio document says we should not use unnamed bindings for gpios.
>> This patch uses the 'led-' prefix to the gpios and updates code and
>> documents. Because the devm_get_gpiod_from_child() falls back to using
>> old-style unnamed gpios, we can update the code first, and update
>> dts files as time allows.
>>
>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
>> ---
>>   Documentation/devicetree/bindings/leds/leds-gpio.txt | 12 ++++++------
>>   drivers/leds/leds-gpio.c                             |  2 +-
>>   2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-gpio.txt b/Documentation/devicetree/bindings/leds/leds-gpio.txt
>> index d544cf1..2c138cc 100644
>> --- a/Documentation/devicetree/bindings/leds/leds-gpio.txt
>> +++ b/Documentation/devicetree/bindings/leds/leds-gpio.txt
>> @@ -7,7 +7,7 @@ Each LED is represented as a sub-node of the gpio-leds device.  Each
>>   node's name represents the name of the corresponding LED.
>>   
>>   LED sub-node properties:
>> -- gpios :  Should specify the LED's GPIO, see "gpios property" in
>> +- led-gpios :  Should specify the LED's GPIO, see "gpios property" in
>>     Documentation/devicetree/bindings/gpio/gpio.txt.  Active low LEDs should be
>>     indicated using flags in the GPIO specifier.
>>   - label :  (optional)
>> @@ -32,12 +32,12 @@ leds {
>>   	compatible = "gpio-leds";
>>   	hdd {
>>   		label = "IDE Activity";
>> -		gpios = <&mcu_pio 0 GPIO_ACTIVE_LOW>;
>> +		led-gpios = <&mcu_pio 0 GPIO_ACTIVE_LOW>;
>>   		linux,default-trigger = "ide-disk";
>>   	};
>>   
>>   	fault {
>> -		gpios = <&mcu_pio 1 GPIO_ACTIVE_HIGH>;
>> +		led-gpios = <&mcu_pio 1 GPIO_ACTIVE_HIGH>;
>>   		/* Keep LED on if BIOS detected hardware fault */
>>   		default-state = "keep";
>>   	};
>> @@ -46,11 +46,11 @@ leds {
>>   run-control {
>>   	compatible = "gpio-leds";
>>   	red {
>> -		gpios = <&mpc8572 6 GPIO_ACTIVE_HIHG>;
>> +		led-gpios = <&mpc8572 6 GPIO_ACTIVE_HIHG>;
>>   		default-state = "off";
>>   	};
>>   	green {
>> -		gpios = <&mpc8572 7 GPIO_ACTIVE_HIGH>;
>> +		led-gpios = <&mpc8572 7 GPIO_ACTIVE_HIGH>;
>>   		default-state = "on";
>>   	};
>>   };
>> @@ -59,7 +59,7 @@ leds {
>>   	compatible = "gpio-leds";
>>   
>>   	charger-led {
>> -		gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
>> +		led-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
>>   		linux,default-trigger = "max8903-charger-charging";
>>   		retain-state-suspended;
>>   	};
>> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
>> index 8e5af69..5b7bc84 100644
>> --- a/drivers/leds/leds-gpio.c
>> +++ b/drivers/leds/leds-gpio.c
>> @@ -184,7 +184,7 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
>>   		struct gpio_led led = {};
>>   		const char *state = NULL;
>>   
>> -		led.gpiod = devm_get_gpiod_from_child(dev, NULL, child);
>> +		led.gpiod = devm_get_gpiod_from_child(dev, "led", child);
> Would not this break existing boards using old bindings? You need to
> handle both cases: if you can't located "led-gpios" then you will have to
> try just "gpios".
Very true. I was rather even hoping we could update all bindings, I 
don't mind going through the available dts files to fix them ... But 
need to know that that's the proper way to go before doing the work ;)

Olliver
>
> Thanks.
>
