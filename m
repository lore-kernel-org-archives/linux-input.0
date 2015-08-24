From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [PATCH] Input: edt-ft5x06 - Switch to newer gpio framework
Date: Mon, 24 Aug 2015 17:16:15 -0500
Message-ID: <55DB97AF.5020905@ti.com>
References: <1440184112-11061-1-git-send-email-fcooper@ti.com> <20150824194113.GE22442@dtor-ws> <55DB7514.7030009@ti.com> <20150824200126.GF22442@dtor-ws> <55DB7BA4.5010905@ti.com> <55DB7D4F.4090004@ti.com> <20150824205624.GG22442@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150824205624.GG22442@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org



On 08/24/2015 03:56 PM, Dmitry Torokhov wrote:
> On Mon, Aug 24, 2015 at 03:23:43PM -0500, Franklin S Cooper Jr. wrote:
>>
>> On 08/24/2015 03:16 PM, Franklin S Cooper Jr. wrote:
>>> On 08/24/2015 03:01 PM, Dmitry Torokhov wrote:
>>>> On Mon, Aug 24, 2015 at 02:48:36PM -0500, Franklin S Cooper Jr. wrote:
>>>>> On 08/24/2015 02:41 PM, Dmitry Torokhov wrote:
>>>>>> On Fri, Aug 21, 2015 at 02:08:32PM -0500, Franklin S Cooper Jr wrote:
>>>>>>> The current/old gpio framework used doesn't properly listen to
>>>>>>> ACTIVE_LOW and ACTIVE_HIGH flags. The newer gpio framework takes into
>>>>>>> account these flags when setting gpio values.
>>>>>>>
>>>>>>> Also use gpiod_set_value_cansleep since wake and reset pins can be
>>>>>>> provided by bus based io expanders.
>>>>>>>
>>>>>>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>>>>>>> ---
>>>>>>>  .../bindings/input/touchscreen/edt-ft5x06.txt      |   4 +-
>>>>>>>  drivers/input/touchscreen/edt-ft5x06.c             | 115 +++++++--------------
>>>>>>>  include/linux/input/edt-ft5x06.h                   |   4 +-
>>>>>>>  3 files changed, 43 insertions(+), 80 deletions(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
>>>>>>> index 76db967..9330d4d 100644
>>>>>>> --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
>>>>>>> +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
>>>>>>> @@ -50,6 +50,6 @@ Example:
>>>>>>>  		pinctrl-0 = <&edt_ft5x06_pins>;
>>>>>>>  		interrupt-parent = <&gpio2>;
>>>>>>>  		interrupts = <5 0>;
>>>>>>> -		reset-gpios = <&gpio2 6 1>;
>>>>>>> -		wake-gpios = <&gpio4 9 0>;
>>>>>>> +		reset-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
>>>>>>> +		wake-gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;
>>>>>>>  	};
>>>>>>> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
>>>>>>> index 394b1de..6b128b3 100644
>>>>>>> --- a/drivers/input/touchscreen/edt-ft5x06.c
>>>>>>> +++ b/drivers/input/touchscreen/edt-ft5x06.c
>>>>>>> @@ -91,9 +91,9 @@ struct edt_ft5x06_ts_data {
>>>>>>>  	u16 num_x;
>>>>>>>  	u16 num_y;
>>>>>>>  
>>>>>>> -	int reset_pin;
>>>>>>> -	int irq_pin;
>>>>>>> -	int wake_pin;
>>>>>>> +	struct gpio_desc *reset_pin;
>>>>>>> +	struct gpio_desc *wake_pin;
>>>>>>> +	struct gpio_desc *irq_pin;
>>>>>>>  
>>>>>>>  #if defined(CONFIG_DEBUG_FS)
>>>>>>>  	struct dentry *debug_dir;
>>>>>>> @@ -755,36 +755,14 @@ edt_ft5x06_ts_teardown_debugfs(struct edt_ft5x06_ts_data *tsdata)
>>>>>>>  static int edt_ft5x06_ts_reset(struct i2c_client *client,
>>>>>>>  			struct edt_ft5x06_ts_data *tsdata)
>>>>>>>  {
>>>>>>> -	int error;
>>>>>>> -
>>>>>>> -	if (gpio_is_valid(tsdata->wake_pin)) {
>>>>>>> -		error = devm_gpio_request_one(&client->dev,
>>>>>>> -					tsdata->wake_pin, GPIOF_OUT_INIT_LOW,
>>>>>>> -					"edt-ft5x06 wake");
>>>>>>> -		if (error) {
>>>>>>> -			dev_err(&client->dev,
>>>>>>> -				"Failed to request GPIO %d as wake pin, error %d\n",
>>>>>>> -				tsdata->wake_pin, error);
>>>>>>> -			return error;
>>>>>>> -		}
>>>>>>> -
>>>>>>> +	if (tsdata->wake_pin) {
>>>>>>>  		msleep(5);
>>>>>>> -		gpio_set_value(tsdata->wake_pin, 1);
>>>>>>> +		gpiod_set_value_cansleep(tsdata->wake_pin, 1);
>>>>>>>  	}
>>>>>>> -	if (gpio_is_valid(tsdata->reset_pin)) {
>>>>>>> -		/* this pulls reset down, enabling the low active reset */
>>>>>>> -		error = devm_gpio_request_one(&client->dev,
>>>>>>> -					tsdata->reset_pin, GPIOF_OUT_INIT_LOW,
>>>>>>> -					"edt-ft5x06 reset");
>>>>>>> -		if (error) {
>>>>>>> -			dev_err(&client->dev,
>>>>>>> -				"Failed to request GPIO %d as reset pin, error %d\n",
>>>>>>> -				tsdata->reset_pin, error);
>>>>>>> -			return error;
>>>>>>> -		}
>>>>>>>  
>>>>>>> +	if (tsdata->reset_pin) {
>>>>>>>  		msleep(5);
>>>>>>> -		gpio_set_value(tsdata->reset_pin, 1);
>>>>>>> +		gpiod_set_value_cansleep(tsdata->reset_pin, 1);
>>>>>> So this leaves the reset pin active. How exactly was this tested?
>>>>> Normally if the output gpio connected to the reset pin is ACTIVE_HIGH then this will take the tsc out of reset since
>>>>> the reset pin is active low. However, I have a board that has an inverter between the gpio and reset pin. So if I leave
>>>>> the gpio as ACTIVE_HIGH then the inverter would cause the reset pin to go low which will keep it in reset. So instead
>>>>> I set the gpio to ACTIVE_LOW which gives me the expected result.
>>>> I do not really care about particular board. Assuming that polarity of
>>>> the GPIO in DTS is specified correctly the effect of:
>>>>
>>>> 	gpiod_set_value_cansleep(tsdata->reset_pin, 1);
>>>>
>>>> is reset pin being _active_, i.e. the chip is staying in reset state.
>>> Setting the reset pin to 1/high will take the tsc out of reset. Setting the pin to 0/low will put the tsc into reset mode.
> It seems you are not quite getting gpiod API. Consider:
>
> For gpios described as GPIO_ACTIVE_LOW:
>
> gpiod_set_value_cansleep(gpio, 1) => GPIO is LOW
> gpiod_set_value_cansleep(gpio, 0) => GPIO is HIGH
>
> For gpios described as GPIO_ACTIVE_HIGH:
>
> gpiod_set_value_cansleep(gpio, 1) => GPIO is HIGH
> gpiod_set_value_cansleep(gpio, 0) => GPIO is LOW
>
> IOW with gpiod API 1 means logical active and can be either HIGH or LOW,
> depending on GPIO definition in DTS.
>
>>>> By the way, both reset and wake pins are active low according to the
>>>> data sheet I found.
>>> Your right. Reset and wake are both active low. However, that part of the code is trying to get the tsc out of reset which is
>>> why its setting the value to 1. Setting the pin to 1 was being done even before my patch.
>>>
>>> What has changed was removing the below line which puts the tsc in reset.
>>>
>>> error = devm_gpio_request_one(&client->dev, tsdata->reset_pin, GPIOF_OUT_INIT_LOW,"edt-ft5x06 reset");
>>>
>>> However, the above line isn't needed since when I request the gpio I already configured it as an output
>>> with a default value of 0.
> So the old sequence resulted in GPIO going XXX->0->1 which brought the
> chip into reset and out of it. With the sequence you have, assuming
> that the GPIO is described as GPIO_ACTIVE_LOW (to match data sheet),
I'm not setting the GPIO_ACTIVE_LOW to match the datasheet. I'm setting it to ACTIVE_LOW because
of the inverter that is between the gpio and reset pin makes it "appear" as if the gpio is ACTIVE_LOW.
> we'll be getting XXX->1->0:
>
> devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_LOW) =>
> 	GPIO is *HIGH*
>
> gpiod_set_value_cansleep(gpio, 1) => GPIO is *LOW*
So everything you stated is exactly what I wanted and expected when you take into account the inverter will invert the gpio signal before
it reaches the reset pin.

So with the old sequence with the gpio being set to ACTIVE_HIGH/flags being ignored this is the result on my board with the inverter ic
between the gpio and tsc reset pin.

devm_gpio_request_one(&client->dev, tsdata->wake_pin, GPIOF_OUT_INIT_LOW, "edt-ft5x06 wake");
    devm_gpio_request_one -> 0(gpio) -> 1 (inverter ic) -> reset pin sees a high signal which takes it out of reset. Not what I wanted.

gpio_set_value(tsdata->reset_pin, 1);
    gpio_set_value -> 1(gpio)-> 0 (inverter ic) -> reset pin sees a low signal with puts it into reset. Now what I wanted. Causes probe to fail


Which is the opposite of what I want.

So my solution was to set my gpio to ACTIVE_LOW which the new gpio framework supports.

devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_LOW)
    devm_gpiod_get_optional -> 0 ->  1(ACTIVE_LOW flag detected)-> 1(gpio)-> 0(inverter ic) -> reset pin set to low. Put tsc into reset.

gpiod_set_value_cansleep(gpio, 1)
    gpiod_set_value_cansleep -> 1 -> 0(ACTIVE LOW flag detected) -> 0(gpio) -> 1 (inverter ic) -> reset pin sees a high signal. Take tsc out of reset


So the tsc driver is assuming that the reset pin is ACTIVE_LOW. I'm not changing the assumption. What
I'm changing is the behaviour of the gpio pin connected to the tsc reset pin.

So assuming that the gpio connected to tsc reset pin is ACTIVE_HIGH then the behaviour doesn't change at all especially since the previous gpio framework
ignores the ACTIVE_HIGH/ACTIVE_LOW flags.


>
>> Sorry accidentally hit reply in this thread instead of reply all. Adding back everyone removed from CC list.
> Thanks.
>
