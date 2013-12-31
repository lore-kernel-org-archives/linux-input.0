From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 03/04] input synaptics-rmi4: RMI4 F01 device control
Date: Mon, 30 Dec 2013 16:26:43 -0800
Message-ID: <52C20F43.9000108@synaptics.com>
References: <1384385972-1686-1-git-send-email-cheiny@synaptics.com> <1384385972-1686-4-git-send-email-cheiny@synaptics.com> <20131230003302.GA11528@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:43290 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289Ab3LaA0o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Dec 2013 19:26:44 -0500
In-Reply-To: <20131230003302.GA11528@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>

On 12/29/2013 04:33 PM, Dmitry Torokhov wrote:
> Hi Chris,
>
> On Wed, Nov 13, 2013 at 03:39:31PM -0800, Christopher Heiny wrote:
>> * eliminate packed struct bitfield definitions.
>>
>> * removes sysfs/debugfs from the core functionality.
>>
>> * refactors register definitions into rmi_f01.h for use by external modules
>> implementing sysfs/debugfs control and debug functions.
>>
>> * adds query register parsing to extract the touch sensor firmare build ID.
>
> I know you are resubmitting this piecemeal but I decided I would provide
> some comments on these patches anyways...

Thanks - we appreciate the input a lot!
>
>>
>> +static void get_board_and_rev(struct rmi_function *fn,
>> +			struct rmi_driver_data *driver_data)
>> +{
>> +	struct f01_data *data = fn->data;
>> +	int retval;
>> +	int board = 0, rev = 0;
>> +	int i;
>> +	static const char * const pattern[] = {
>> +		"tm%4d-%d", "s%4d-%d", "s%4d-ver%1d", "s%4d_ver%1d"};
>> +	u8 product_id[RMI_PRODUCT_ID_LENGTH+1];
>> +
>> +	for (i = 0; i < strlen(data->product_id); i++)
>> +		product_id[i] = tolower(data->product_id[i]);
>> +	product_id[i] = '\0';
>> +
>> +	for (i = 0; i < ARRAY_SIZE(pattern); i++) {
>> +		retval = sscanf(product_id, pattern[i], &board, &rev);
>> +		if (retval)
>> +			break;
>
> I think you want to rest of retval == 2 here to make sure that both
> board and revision have been parsed.
>
> I wonder though, do you really need to parse this in kernel? Where is
> this data being used?

This data was used in setting some of the input subsystem parameters in 
some code that got excised.  This function is unlikely to return in 
future patches.

>
>> +	}
>> +
>> +	/* save board and rev data in the rmi_driver_data */
>> +	driver_data->board = board;
>> +	driver_data->rev = rev;
>> +	dev_dbg(&fn->dev, "From product ID %s, set board: %d rev: %d\n",
>> +			product_id, driver_data->board, driver_data->rev);
>> +}
>> +
>> +#define PACKAGE_ID_BYTES 4
>> +#define BUILD_ID_BYTES 3
>> +
>>   static int rmi_f01_initialize(struct rmi_function *fn)
>>   {
>>   	u8 temp;
>> +	int i;
>>   	int error;
>> -	u16 ctrl_base_addr;
>> +	u16 query_addr = fn->fd.query_base_addr;
>> +	u16 prod_info_addr;
>> +	u8 info_buf[4];
>> +	u16 ctrl_base_addr = fn->fd.control_base_addr;
>>   	struct rmi_device *rmi_dev = fn->rmi_dev;
>>   	struct rmi_driver_data *driver_data = dev_get_drvdata(&rmi_dev->dev);
>>   	struct f01_data *data = fn->data;
>>   	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
>>   	u8 basic_query[RMI_F01_BASIC_QUERY_LEN];
>> +	struct f01_basic_properties *props = &data->properties;
>>
>>   	mutex_init(&data->control_mutex);
>>
>> -	/*
>> -	 * Set the configured bit and (optionally) other important stuff
>> -	 * in the device control register.
>> -	 */
>> -	ctrl_base_addr = fn->fd.control_base_addr;
>> +	/* Set the configured bit and (optionally) other important stuff
>> +	 * in the device control register. */
>
> Please use the following style for multi-line comments:
>
> 	/*
> 	 * This is a multi-line
> 	 * comment.
> 	 */

Will do.

>
>>   	error = rmi_read_block(rmi_dev, fn->fd.control_base_addr,
>>   			&data->device_control.ctrl0,
>>   			sizeof(data->device_control.ctrl0));
>> @@ -978,8 +110,7 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>>   		break;
>>   	}
>>
>> -	/*
>> -	 * Sleep mode might be set as a hangover from a system crash or
>> +	/* Sleep mode might be set as a hangover from a system crash or
>>   	 * reboot without power cycle.  If so, clear it so the sensor
>>   	 * is certain to function.
>>   	 */
>> @@ -990,11 +121,16 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>>   		data->device_control.ctrl0 &= ~RMI_F01_CTRL0_SLEEP_MODE_MASK;
>>   	}
>>
>> +	/* Set this to indicate that we've initialized the sensor.  This will
>> +	 * CLEAR the unconfigured bit in the status registers.  If we ever
>> +	 * see unconfigured become set again, we'll know that the sensor has
>> +	 * reset for some reason.
>> +	 */
>>   	data->device_control.ctrl0 |= RMI_F01_CRTL0_CONFIGURED_BIT;
>>
>>   	error = rmi_write_block(rmi_dev, fn->fd.control_base_addr,
>> -				&data->device_control.ctrl0,
>> -				sizeof(data->device_control.ctrl0));
>> +			&data->device_control.ctrl0,
>> +			sizeof(data->device_control.ctrl0));
>
> The old code had arguments aligned perfectly, why change that?

I think it's an artifact of some code refactoring that was later backed out.

>
>>   	if (error < 0) {
>>   		dev_err(&fn->dev, "Failed to write F01 control.\n");
>>   		return error;
>> @@ -1006,14 +142,12 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>>
>>   	data->interrupt_enable_addr = ctrl_base_addr;
>>   	error = rmi_read_block(rmi_dev, ctrl_base_addr,
>> -				data->device_control.interrupt_enable,
>> -				sizeof(u8) * (data->num_of_irq_regs));
>> +			data->device_control.interrupt_enable,
>> +			sizeof(u8)*(data->num_of_irq_regs));
>
> Same here. Also please keep spaces around operators.

Will do.  I'm surprised checkpatch didn't complain about that in this case.

>
>>   	if (error < 0) {
>> -		dev_err(&fn->dev,
>> -			"Failed to read F01 control interrupt enable register.\n");
>> +		dev_err(&fn->dev, "Failed to read F01 control interrupt enable register.\n");
>>   		goto error_exit;
>>   	}
>> -
>>   	ctrl_base_addr += data->num_of_irq_regs;
>>
>>   	/* dummy read in order to clear irqs */
>> @@ -1023,43 +157,226 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>>   		return error;
>>   	}
>>
>> +	/* read queries */
>>   	error = rmi_read_block(rmi_dev, fn->fd.query_base_addr,
>> -			       basic_query, sizeof(basic_query));
>> +				basic_query, sizeof(basic_query));
>>   	if (error < 0) {
>>   		dev_err(&fn->dev, "Failed to read device query registers.\n");
>>   		return error;
>>   	}
>>
>>   	/* Now parse what we got */
>> -	data->properties.manufacturer_id = basic_query[0];
>> +	props->manufacturer_id = basic_query[0];
>>
>> -	data->properties.has_lts = basic_query[1] & RMI_F01_QRY1_HAS_LTS;
>> -	data->properties.has_adjustable_doze =
>> +	props->has_lts = basic_query[1] & RMI_F01_QRY1_HAS_LTS;
>> +	props->has_sensor_id =
>> +			!!(basic_query[1] & RMI_F01_QRY1_HAS_SENSOR_ID);
>
> I believe compiler will do the proper conversion to boolean for you
> since the target of assignment is boolean.

OK.

>
>> +	props->has_adjustable_doze =
>>   			basic_query[1] & RMI_F01_QRY1_HAS_ADJ_DOZE;
>> -	data->properties.has_adjustable_doze_holdoff =
>> +	props->has_adjustable_doze_holdoff =
>>   			basic_query[1] & RMI_F01_QRY1_HAS_ADJ_DOZE_HOFF;
>> +	props->has_query42 = basic_query[1] & RMI_F01_QRY1_HAS_PROPS_2;
>> +
>> +	snprintf(props->dom, sizeof(props->dom), "20%02d/%02d/%02d",
>> +		basic_query[5] & RMI_F01_QRY5_YEAR_MASK,
>> +		basic_query[6] & RMI_F01_QRY6_MONTH_MASK,
>> +		basic_query[7] & RMI_F01_QRY7_DAY_MASK);
>> +
>> +	memcpy(props->product_id, &basic_query[11], RMI_PRODUCT_ID_LENGTH);
>> +	props->product_id[RMI_PRODUCT_ID_LENGTH] = '\0';
>> +	query_addr += 11;
>> +
>> +	error = rmi_read_block(rmi_dev, query_addr, data->product_id,
>> +				RMI_PRODUCT_ID_LENGTH);
>> +	if (error < 0) {
>> +		dev_err(&fn->dev, "Failed to read product ID.\n");
>> +		return error;
>> +	}
>> +	data->product_id[RMI_PRODUCT_ID_LENGTH] = '\0';
>> +	get_board_and_rev(fn, driver_data);
>> +	dev_info(&fn->dev, "found RMI device, manufacturer: %s, product: %s, date: %s\n",
>> +		 props->manufacturer_id == 1 ?
>> +		 "synaptics" : "unknown", data->product_id, props->dom);
>
> Capitalize your company name?

OK.

[snip]

>>
>> -	data->properties.productinfo =
>> -			((basic_query[2] & RMI_F01_QRY2_PRODINFO_MASK) << 7) |
>> -			(basic_query[3] & RMI_F01_QRY2_PRODINFO_MASK);
>> +	/* The firmware build id (if present) is similarly overlaid on product
>> +	 * ID registers.  Go back again and read that data.
>> +	 */
>> +	if (props->has_build_id_query) {
>> +		error = rmi_read_block(rmi_dev, prod_info_addr, info_buf,
>> +				BUILD_ID_BYTES);
>> +		if (error < 0)
>> +			dev_warn(&fn->dev, "Failed to read FW build ID.\n");
>> +		else {
>> +			u16 *val = (u16 *)info_buf;
>> +			data->build_id = le16_to_cpu(*val);
>
> Did you try that with sparse? I do not think it will be happy here...
> Something like
>
> 			data->build_id = le16_to_cpup((__le16 *)info_buf);

Hmmmm.  I didn't see any sparse complaints originally, but maybe we 
didn't have the right flags set.  We'll check on this.


>
>> +			data->build_id += info_buf[2] * 65536;
>> +			dev_info(&fn->dev, "FW build ID: %#08x (%u).\n",
>> +				data->build_id, data->build_id);
>> +		}
>> +	}
>>

[snip]

>> +
>> +/*
>> + *
>> + * @serialization - 7 bytes of device serialization data.  The meaning of
>> + * these bytes varies from product to product, consult your product spec sheet.
>> + */
>> +struct f01_data {
>> +	struct f01_device_control device_control;
>> +	struct mutex control_mutex;
>> +
>> +	u8 device_status;
>> +
>> +	struct f01_basic_properties properties;
>> +	u8 serialization[F01_SERIALIZATION_SIZE];
>> +	u8 product_id[RMI_PRODUCT_ID_LENGTH+1];
>> +
>> +	u16 package_id;
>> +	u16 package_rev;
>> +	u32 build_id;
>> +
>> +	u16 interrupt_enable_addr;
>> +	u16 doze_interval_addr;
>> +	u16 wakeup_threshold_addr;
>> +	u16 doze_holdoff_addr;
>> +
>> +	int irq_count;
>> +	int num_of_irq_regs;
>> +
>> +#ifdef	CONFIG_PM
>
> I think you want CONFIG_PM_SLEEP here to mirror implementation of
> susped/resume methods.

OK.
