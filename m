From: "hartleys" <hartleys@visionengravers.com>
Subject: RE: [PATCH] generic driver for rotary encoders on GPIOs
Date: Fri, 27 Feb 2009 12:13:10 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901349093@mi8nycmail19.Mi8.com>
References: <1235671228-29552-1-git-send-email-daniel@caiaq.de> <1235673764-5540-1-git-send-email-daniel@caiaq.de> <BD79186B4FD85F4B8E60E381CAEE190901348F62@mi8nycmail19.Mi8.com> <20090227064314.GB32470@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og105.obsmtp.com ([64.18.1.189]:41654 "HELO
	exprod6og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752912AbZB0RNX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2009 12:13:23 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20090227064314.GB32470@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-input@vger.kernel.org

On Thursday, February 26, 2009 11:43 PM, Daniel Mack wrote:
> On Thu, Feb 26, 2009 at 10:18:40PM -0500, hartleys wrote:
>> +static struct rotary_encoder_platform_data my_rotary_encoder_info =
{
>> +	.steps = 24,
>> +	.gpio_a = GPIO_ROTARY_A,
>> +	.gpio_b = GPIO_ROTARY_B,
>> +	.inverted_a = 0,
>> +	.inverted_b = 0,
>> +};
>> +
>> +static struct platform_device rotary_encoder_device = {
>> +	.name		= "rotary-encoder",
>> +	.id		= 0,
>> +	.num_resources	= ARRAY_SIZE(rotary_encoder_resources),
>> +	.resource	= rotary_encoder_resources,
>> +	.dev		= {
>> +		.platform_data = &my_rotary_encoder_info,
>> +	}
>> +};
>> +
>> 
>> IRQ_GPIO appears to be only defined for mach-imx and mach-pxa.
>> 
>> Why not just use the platform_data information to get the irq for
>> the gpio at runtime with gpio_to_irq()?
>
> Yes, true. But wouldn't be using the resources only and irq_to_gpio()
> be the even cleaner solution?

I really don't know which one is cleaner or the correct choice.

The new example in your updated patch will not work for a generic
solution.

+/* board support file example */
+
+#define GPIO_ROTARY_A 1
+#define GPIO_ROTARY_B 2
+
+static struct resource rotary_encoder_resources[] = {
+	[0] = {
+		.flags = IORESOURCE_IRQ,
+		.start = gpio_to_irq(GPIO_ROTARY_A)
+	},
+	[1] = {
+		.flags = IORESOURCE_IRQ,
+		.start = gpio_to_irq(GPIO_ROTARY_B)
+	}
+};

Unless gpio_to_irq() is defined as a macro that returns a constant at
compile time you will get an error similar to:

error: initializer element is not constant
error: (near initialization for 'rotary_encoder_resources[0].start')
error: initializer element is not constant
error: (near initialization for 'rotary_encoder_resources[1].start')

>> +#include <linux/rotary-encoder.h>
>> 
>> This file is missing in the patch.
>
> Will be added in the next version.

Cool.

I was able to compile and test your driver on an ep93xx based system
with a Bourns ECW1J-B24-BC0024 rotary encoder connected to the EGPIO8
and EGPIO9 pins.  But I had to make the following changes to your
original patch.

Keep gpio_a and gpio_b in the rotary_encoder_platform_data.
Removed the struct resource from the platform setup.
Following is the platform setup I used:

---

#define GPIO_ROTARY_A	EP93XX_GPIO_LINE_EGPIO8
#define GPIO_ROTARY_B	EP93XX_GPIO_LINE_EGPIO9

static struct rotary_encoder_platform_data my_rotary_encoder_info = {
	.steps		= 24,
	.gpio_a		= GPIO_ROTARY_A,
	.gpio_b		= GPIO_ROTARY_B,
	.inverted_a	= 0,
	.inverted_b	= 0,
};

static struct platform_device rotary_encoder_device = {
	.name		= "rotary-encoder",
	.id		= 0,
	.dev		= {
		.platform_data = &my_rotary_encoder_info,
	},
};

---

I also had to modified the probe routine as follows:

---

static int __devinit rotary_encoder_probe(struct platform_device *pdev)
{
	struct rotary_encoder *encoder;
-	struct resource *irq_a_res;
-	struct resource *irq_b_res;
-	unsigned long irq_flags;
	int err;

	encoder = kzalloc(sizeof(struct rotary_encoder), GFP_KERNEL);
	if (!encoder) {
		dev_err(&pdev->dev, "failed to allocate driver data\n");
		err = -ENOMEM;
		goto exit;
	}

-	irq_flags = IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE;
-	irq_a_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	irq_b_res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
	encoder->pdata = pdev->dev.platform_data;
-
-	if (!irq_a_res || !irq_b_res || !encoder->pdata) {
+	if (!encoder->pdata) {
		dev_err(&pdev->dev, "insufficient resources\n");
		err = -ENOENT;
		goto exit_free_mem;
	}

-	encoder->irq_a = irq_a_res->start;
-	encoder->irq_b = irq_b_res->start;
+	encoder->irq_a = gpio_to_irq(encoder->pdata->gpio_a);
+	encoder->irq_b = gpio_to_irq(encoder->pdata->gpio_b);

	/* create and register the input driver */
	encoder->input = input_allocate_device();
	if (!encoder->input) {
		dev_err(&pdev->dev, "failed to allocate input
device\n");
		err = -ENOMEM;
		goto exit_free_mem;
	}

	encoder->input->name = pdev->name;
	encoder->input->id.bustype = BUS_HOST;
	encoder->input->dev.parent = &pdev->dev;
	encoder->input->evbit[0] = BIT_MASK(EV_ABS);
	encoder->input->absbit[0] = BIT_MASK(ABS_X);
	input_set_abs_params(encoder->input, ABS_X, 0,
			     encoder->pdata->steps, 0, 1);
	platform_set_drvdata(pdev, encoder);

	err = input_register_device(encoder->input);
	if (err) {
		dev_err(&pdev->dev, "failed to register input
device\n");
		goto exit_free_input;
	}

	/* request the GPIOs */
	err = gpio_request(encoder->pdata->gpio_a, DRV_NAME);
	if (err) {
		dev_err(&pdev->dev, "unable to request GPIO %d\n",
			encoder->pdata->gpio_a);
		goto exit_free_input;
	}

	err = gpio_request(encoder->pdata->gpio_b, DRV_NAME);
	if (err) {
		dev_err(&pdev->dev, "unable to request GPIO %d\n",
			encoder->pdata->gpio_b);
		goto exit_free_gpio_a;
	}

	/* request the IRQs */
	err = request_irq(encoder->irq_a, &rotary_encoder_irq,
-			  irq_flags, DRV_NAME, encoder);
+			  IORESOURCE_IRQ_HIGHEDGE |
IORESOURCE_IRQ_LOWEDGE,
+			  DRV_NAME, encoder);
	if (err) {
		dev_err(&pdev->dev, "unable to request IRQ %d\n",
			encoder->irq_a);
		goto exit_free_gpio;
	}

	err = request_irq(encoder->irq_b, &rotary_encoder_irq,
-			  irq_flags, DRV_NAME, encoder);
+			  IORESOURCE_IRQ_HIGHEDGE |
IORESOURCE_IRQ_LOWEDGE,
+			  DRV_NAME, encoder);	if (err) {
		dev_err(&pdev->dev, "unable to request IRQ %d\n",
			encoder->irq_b);
		goto exit_free_irq_a;
	}

	return 0;

exit_free_irq_a:
	free_irq(encoder->irq_a, encoder);
exit_free_gpio:
	gpio_free(encoder->pdata->gpio_b);
exit_free_gpio_a:
	gpio_free(encoder->pdata->gpio_a);
exit_free_input:
	input_free_device(encoder->input);
exit_free_mem:
	kfree(encoder);
exit:
	return err;
}

Regards,
Hartley
