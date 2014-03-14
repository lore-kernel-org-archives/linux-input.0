From: Gabriel Fernandez <gabriel.fernandez@st.com>
Subject: Re: [PATCH 1/5] drivers: input: keyboard: st-keyscan: add keyscan
 driver
Date: Fri, 14 Mar 2014 11:13:17 +0100
Message-ID: <5322D63D.5030403@st.com>
References: <1393990772-9567-1-git-send-email-gabriel.fernandez@st.com>
 <1393990772-9567-2-git-send-email-gabriel.fernandez@st.com>
 <20140310114819.GO14976@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140310114819.GO14976@lee--X1>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, kernel@stlinux.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Giuseppe Condorelli <giuseppe.condorelli@st.com>, Rob Landley <rob@landley.net>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hi Lee,

On 03/10/2014 12:48 PM, Lee Jones wrote:
> Hi Gabi,
>
> Sorry for the delay. It was a hectic week last week.
>
> As promised:
>
>> This patch adds ST Keyscan driver to use the keypad hw a subset
>> of ST boards provide. Specific board setup will be put in the
>> given dt.
>>
>> Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Are you sure these are in the correct order?
ok i change the order

>> +- linux,keymap: The keymap for keys as described in the binding document
>> +  devicetree/bindings/input/matrix-keymap.txt.
>> +
>> +- keypad,num-rows: Number of row lines connected to the keypad controller.
>> +
>> +- keypad,num-columns: Number of column lines connected to the keypad
>> +  controller.
>> +
>> +- st,debounce_us: Debouncing interval time in microseconds
> I'm sure there will be a shared binding for de-bounce.
>
> If not, there certainly should be.

you want to refer to "debounce-interval" ?

>
> +Example:
> +
> +keyscan: keyscan@fe4b0000 {
> +	compatible = "st,keypad";
> Is there any way we can make this more specific to _this_ IP?
for my knowledge this IP is the same for stixxxx platform.


>
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called stm-keyscan.
>> +
>>   config KEYBOARD_SUNKBD
>>   	tristate "Sun Type 4 and Type 5 keyboard"
>>   	select SERIO
>> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
>> index a699b61..5fd020a 100644
>> --- a/drivers/input/keyboard/Makefile
>> +++ b/drivers/input/keyboard/Makefile
>> @@ -50,6 +50,7 @@ obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+= sh_keysc.o
>>   obj-$(CONFIG_KEYBOARD_SPEAR)		+= spear-keyboard.o
>>   obj-$(CONFIG_KEYBOARD_STMPE)		+= stmpe-keypad.o
>>   obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
>> +obj-$(CONFIG_KEYBOARD_ST_KEYSCAN)	+= st-keyscan.o
>>   obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
>>   obj-$(CONFIG_KEYBOARD_TC3589X)		+= tc3589x-keypad.o
>>   obj-$(CONFIG_KEYBOARD_TEGRA)		+= tegra-kbc.o
>> diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
>> new file mode 100644
>> index 0000000..606cc19
>> --- /dev/null
>> +++ b/drivers/input/keyboard/st-keyscan.c
>> @@ -0,0 +1,323 @@
>> +/*
>> + * STMicroelectronics Key Scanning driver
>> + *
>> + * Copyright (c) 2014 STMicroelectonics Ltd.
>> + * Author: Stuart Menefy <stuart.menefy@st.com>
>> + *
>> + * Based on sh_keysc.c, copyright 2008 Magnus Damm
> Did sh_keysc.c ever exist in Mainline?
i think no, i 'll suppress "Based on sh_keysc.c, copyright 2008 Magnus Damm"

>
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/input/matrix_keypad.h>
>> +
>> +#define ST_KEYSCAN_MAXKEYS 16
>> +
>> +#define KEYSCAN_CONFIG_OFF		0x000
>> +#define KEYSCAN_CONFIG_ENABLE		1
> 0x001?
>
>> +#define KEYSCAN_DEBOUNCE_TIME_OFF	0x004
>> +#define KEYSCAN_MATRIX_STATE_OFF	0x008
>> +#define KEYSCAN_MATRIX_DIM_OFF		0x00c
> Odd that these are 3 digit padded? Is there a reason for that?
no reason for the padded,  i will change that.

>> +struct keypad_platform_data {
>> +	const struct matrix_keymap_data *keymap_data;
>> +	unsigned int num_out_pads;
>> +	unsigned int num_in_pads;
>> +	unsigned int debounce_us;
>> +};
>> +
>> +struct keyscan_priv {
>> +	void __iomem *base;
>> +	int irq;
>> +	struct clk *clk;
>> +	struct input_dev *input_dev;
>> +	struct keypad_platform_data *config;
>> +	unsigned int last_state;
>> +	u32 keycodes[ST_KEYSCAN_MAXKEYS];
> Seems odd to limit this. Can't the information come from DT
> i.e. keypad,num-rows and keypad,num-columns?
>
i 'll rename 'num_out_pads' into 'n_rows' and 'num_in_pads' into 'n_cols'



> Nit: It's pretty unusual to use this for a standard error handling
> variable. Consider 'ret' or 'err' as a replacement.
>
>> +	}
>> +
>> +	of_property_read_u32(np, "st,debounce_us", &pdata->debounce_us);
> Isn't this a required property? Might be worth checking the return
> value if so.
no mandatory property, i will update the  dt binding.

>
>> +	st_kp->config = pdata;
>> +
>> +	dev_info(dev, "rows=%d col=%d debounce=%d\n",
>> +			pdata->num_out_pads,
>> +			pdata->num_in_pads,
>> +			pdata->debounce_us);
> Might be worth moving this down passed the final point of failure.
>
>> +	error = of_property_read_u32_array(np, "linux,keymap",
>> +					st_kp->keycodes, ST_KEYSCAN_MAXKEYS);
>> +	if (error) {
>> +		dev_err(dev, "failed to parse keymap\n");
>> +		return error;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init keyscan_probe(struct platform_device *pdev)
>> +{
>> +	struct keypad_platform_data *pdata =
>> +		dev_get_platdata(&pdev->dev);
> Do we really support platform data still?
no, i will remove that.

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "no I/O memory specified\n");
> +		return -ENXIO;
> +	}
> +
> +	len = resource_size(res);
> +	if (!devm_request_mem_region(dev, res->start, len, pdev->name)) {
> +		dev_err(dev, "failed to reserve I/O memory\n");
> +		return -EBUSY;
> +	}
> +
> +	st_kp->base = devm_ioremap_nocache(dev, res->start, len);
> +	if (st_kp->base == NULL) {
> +		dev_err(dev, "failed to remap I/O memory\n");
> +		return -ENXIO;
> +	}
> Replace the two above with devm_ioremap_resource().
>
> Make sure the IORESOURCE_CACHEABLE is set.
ok, we are in no cacheable use case.

>
>> +	}
>> +
>> +	error = devm_request_irq(dev, st_kp->irq, keyscan_isr, 0,
>> +				 pdev->name, pdev);
>> +	if (error) {
>> +		dev_err(dev, "failed to request IRQ\n");
>> +		return error;
>> +	}
>> +
>> +	input_dev = devm_input_allocate_device(&pdev->dev);
>> +	if (!input_dev) {
>> +		dev_err(&pdev->dev, "failed to allocate the input device\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	st_kp->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(st_kp->clk)) {
>> +		dev_err(dev, "cannot get clock");
>> +		return PTR_ERR(st_kp->clk);
>> +	}
>> +
>> +	input_dev = input_allocate_device();
>> +	if (!input_dev) {
>> +		dev_err(dev, "failed to allocate input device\n");
>> +		return -ENOMEM;
>> +	}
> Wasn't this done already?
yes, crap these lines.
>> +	st_kp->input_dev = input_dev;
>> +
>> +	input_dev->name = pdev->name;
>> +	input_dev->phys = "keyscan-keys/input0";
>> +	input_dev->dev.parent = dev;
>> +
>> +	input_dev->id.bustype = BUS_HOST;
>> +	input_dev->id.vendor = 0x0001;
>> +	input_dev->id.product = 0x0001;
>> +	input_dev->id.version = 0x0100;
> Any chance we can #define these?
i will follow Dmitry remark (omit these information)

>
>> +	if (!pdata) {
>> +		error = keypad_matrix_key_parse_dt(st_kp);
>> +		if (error)
>> +			return error;
>> +		pdata = st_kp->config;
> Is pdata used after this?
no, i will remove platform data support


Thanks
