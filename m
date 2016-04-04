From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] gpiolib: handle probe deferrals better
Date: Mon, 4 Apr 2016 19:21:56 +0300
Message-ID: <570294A4.2070801@ti.com>
References: <1459511048-24084-1-git-send-email-linus.walleij@linaro.org>
 <56FE7785.1010507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <56FE7785.1010507@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, Alexander Stein <alexander.stein@systec-electronic.com>Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-input@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Guenter Roeck <linux@roeck-us.net>, bjorn.andersson@linaro.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

On 04/01/2016 04:28 PM, Grygorii Strashko wrote:
> On 04/01/2016 02:44 PM, Linus Walleij wrote:
>> The gpiolib does not currently return probe deferrals from the
>> .to_irq() hook while the GPIO drivers are being initialized.
>> Further: it keeps returning -EPROBE_DEFER for gpio[d]_get()
>> even after all builtin drivers have initialized.
>>
>> Fix this thusly:
>>
>> - Move the assignment of .to_irq() to the last step when
>>     using gpiolib_irqchip_add() so we can't get spurious calls
>>     into the .to_irq() function until all set-up is finished.
>>
>> - Put in a late_initcall_sync() to set a boolean state variable to
>>     indicate that we're not gonna defer any longer. Since deferred
>>     probe happens at late_initcall() time, using late_initcall_sync()
>>     should be fine.
>>
>> - After this point, return hard errors (-ENXIO) from both
>>     gpio[d]_get() and .to_irq().
>>
>> This way we should (at least for all drivers using GPIOLIB_IRQCHIP)
>> be getting proper deferrals from both gpio[d]_get() and .to_irq()
>> until the irqchip side is properly set up, and then proper
>> errors after all drivers should have been probed.
>>
>> This problem was first seen with gpio-keys.
>>
>> Cc: linux-input@vger.kernel.org
>> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Reported-by: Alexander Stein <alexander.stein@systec-electronic.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Alexander: please test this, you need Guether's patches too,
>> I have it all on my "fixes" branch in the GPIO git:
>> https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-gpio.git/log/?h=fixes
>>
>> Tomeu: I think you're the authority on deferred probe these days.
>> Is this the right way for a subsystem to switch from returning
>> -EPROBE_DEFER to instead returning an unrecoverable error?
>>
>> Guenther: I applied this on top of your patches, please check it
>> if you can, you're smarter than me with this stuff.
>> ---
>>    drivers/gpio/gpiolib.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
>>    1 file changed, 40 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>> index b747c76fd2b1..426a93f9d79e 100644
>> --- a/drivers/gpio/gpiolib.c
>> +++ b/drivers/gpio/gpiolib.c
>> @@ -68,7 +68,9 @@ LIST_HEAD(gpio_devices);
>>    static void gpiochip_free_hogs(struct gpio_chip *chip);
>>    static void gpiochip_irqchip_remove(struct gpio_chip *gpiochip);
>>    
>> +/* These keep the state of the library */
>>    static bool gpiolib_initialized;
>> +static bool gpiolib_builtin_ready;
>>    

[..]

>>    
>>    int gpiod_request(struct gpio_desc *desc, const char *label)
>>    {
>> -	int status = -EPROBE_DEFER;
>> +	int status;
>>    	struct gpio_device *gdev;
>>    
>>    	VALIDATE_DESC(desc);
>>    	gdev = desc->gdev;
>>    
>> +	/*
>> +	 * Defer requests until all built-in drivers have had a chance
>> +	 * to probe, then give up and return a hard error.
>> +	 */
>> +	if (!gpiolib_builtin_ready)
>> +		status = -EPROBE_DEFER;
>> +	else
>> +		status = -ENXIO;
> 
> Probably It will work right if we will let gpiochip know that
> it has irqchip companion.
> With above knowledge the gpiod_request() can return -EPROBE_DEFER while
> irqchip is not initialized. In other words:
> - driver will set HAS_IRQ flag
> - gpiolib will set gpio_chip->irqs_ready = 0 in gpiochip_add_data()
> - gpiolib will set gpio_chip->irqs_ready = 1 in gpiochip_irqchip_add()
> - gpiod_request() will do at the beginning:
>    if (HAS_IRQ && !gpio_chip->irqs_ready)
>     return  -EPROBE_DEFER
> 
> it might also required to combine
> gpiochip_irqchip_add and gpiochip_set_chained_irqchip.
> 

Below is RFC patch to prove above consent. I've had offlist 
debugging session with Alexander and He mentioned that this change
fixes boot issue for him.

Of course, there are some question to discuss:
1) [+] It should sync initialization of GPIOchip and GPIOirqchip 
2) [+] This approach requires changes in gpiolib/gpio drivers only, from other side
It will require to add fixes all over the Kernel if gpiod_to_irq() will 
start returning -EPROBE_DEFER.
3) [-] has_irq might need to be initialized by non-DT drivers
4) [-] irq_ready might need to be set manually by drivers which do not use GPIO irq
   helpers (see change in gpio-mpc8xxx.c)
4) irq_ready access synchronization on SMP? atomic?

job done with commit e6918cd 'gpiolib: handle probe deferrals better'
reverted. 

-----
>From d3d486700351d55fd242c7d9494740b0534a2081 Mon Sep 17 00:00:00 2001
From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Sat, 2 Apr 2016 14:55:31 +0300
Subject: [RFC PATCH] gpiolib: sync gpiochip and irqchip initializtion

TBD.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-mpc8xxx.c |  2 ++
 drivers/gpio/gpiolib.c      | 13 ++++++++++++-
 include/linux/gpio/driver.h |  2 ++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index 425501c..3652b44 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -368,6 +368,8 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 
 	irq_set_chained_handler_and_data(mpc8xxx_gc->irqn,
 					 mpc8xxx_gpio_irq_cascade, mpc8xxx_gc);
+
+	gc->irq_ready = true;
 	return 0;
 err:
 	iounmap(mpc8xxx_gc->regs);
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 7206553..9d24196 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -488,6 +488,11 @@ int gpiochip_add_data(struct gpio_chip *chip, void *data)
 			gdev->dev.of_node = chip->of_node;
 #endif
 	}
+
+	chip->has_irq = of_get_property(gdev->dev.of_node,
+					"interrupt-controller", NULL) ?
+					true : false;
+
 	gdev->id = ida_simple_get(&gpio_ida, 0, 0, GFP_KERNEL);
 	if (gdev->id < 0) {
 		status = gdev->id;
@@ -1092,6 +1097,9 @@ int _gpiochip_irqchip_add(struct gpio_chip *gpiochip,
 
 	acpi_gpiochip_request_interrupts(gpiochip);
 
+	if (gpiochip->has_irq)
+		gpiochip->irq_ready = true;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(_gpiochip_irqchip_add);
@@ -1335,7 +1343,10 @@ int gpiod_request(struct gpio_desc *desc, const char *label)
 	gdev = desc->gdev;
 
 	if (try_module_get(gdev->owner)) {
-		status = __gpiod_request(desc, label);
+		if (!gdev->chip->has_irq)
+			status = __gpiod_request(desc, label);
+		else if (gdev->chip->has_irq && gdev->chip->irq_ready)
+			status = __gpiod_request(desc, label);
 		if (status < 0)
 			module_put(gdev->owner);
 		else
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index bee976f..134be32 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -141,6 +141,8 @@ struct gpio_chip {
 	const char		*const *names;
 	bool			can_sleep;
 	bool			irq_not_threaded;
+	bool			has_irq;
+	bool			irq_ready;
 
 #if IS_ENABLED(CONFIG_GPIO_GENERIC)
 	unsigned long (*read_reg)(void __iomem *reg);
-- 
2.8.0



-- 
regards,
-grygorii
