From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 03/04] input synaptics-rmi4: RMI4 F01 device control
Date: Sun, 29 Dec 2013 16:33:02 -0800
Message-ID: <20131230003302.GA11528@core.coreip.homeip.net>
References: <1384385972-1686-1-git-send-email-cheiny@synaptics.com>
 <1384385972-1686-4-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33728 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800Ab3L3AdG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Dec 2013 19:33:06 -0500
Received: by mail-pa0-f45.google.com with SMTP id fb1so11093617pad.4
        for <linux-input@vger.kernel.org>; Sun, 29 Dec 2013 16:33:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1384385972-1686-4-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>

Hi Chris,

On Wed, Nov 13, 2013 at 03:39:31PM -0800, Christopher Heiny wrote:
> * eliminate packed struct bitfield definitions.
> 
> * removes sysfs/debugfs from the core functionality.
> 
> * refactors register definitions into rmi_f01.h for use by external modules
> implementing sysfs/debugfs control and debug functions.
> 
> * adds query register parsing to extract the touch sensor firmare build ID.

I know you are resubmitting this piecemeal but I decided I would provide
some comments on these patches anyways...

>  
> +static void get_board_and_rev(struct rmi_function *fn,
> +			struct rmi_driver_data *driver_data)
> +{
> +	struct f01_data *data = fn->data;
> +	int retval;
> +	int board = 0, rev = 0;
> +	int i;
> +	static const char * const pattern[] = {
> +		"tm%4d-%d", "s%4d-%d", "s%4d-ver%1d", "s%4d_ver%1d"};
> +	u8 product_id[RMI_PRODUCT_ID_LENGTH+1];
> +
> +	for (i = 0; i < strlen(data->product_id); i++)
> +		product_id[i] = tolower(data->product_id[i]);
> +	product_id[i] = '\0';
> +
> +	for (i = 0; i < ARRAY_SIZE(pattern); i++) {
> +		retval = sscanf(product_id, pattern[i], &board, &rev);
> +		if (retval)
> +			break;

I think you want to rest of retval == 2 here to make sure that both
board and revision have been parsed.

I wonder though, do you really need to parse this in kernel? Where is
this data being used?

> +	}
> +
> +	/* save board and rev data in the rmi_driver_data */
> +	driver_data->board = board;
> +	driver_data->rev = rev;
> +	dev_dbg(&fn->dev, "From product ID %s, set board: %d rev: %d\n",
> +			product_id, driver_data->board, driver_data->rev);
> +}
> +
> +#define PACKAGE_ID_BYTES 4
> +#define BUILD_ID_BYTES 3
> +
>  static int rmi_f01_initialize(struct rmi_function *fn)
>  {
>  	u8 temp;
> +	int i;
>  	int error;
> -	u16 ctrl_base_addr;
> +	u16 query_addr = fn->fd.query_base_addr;
> +	u16 prod_info_addr;
> +	u8 info_buf[4];
> +	u16 ctrl_base_addr = fn->fd.control_base_addr;
>  	struct rmi_device *rmi_dev = fn->rmi_dev;
>  	struct rmi_driver_data *driver_data = dev_get_drvdata(&rmi_dev->dev);
>  	struct f01_data *data = fn->data;
>  	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
>  	u8 basic_query[RMI_F01_BASIC_QUERY_LEN];
> +	struct f01_basic_properties *props = &data->properties;
>  
>  	mutex_init(&data->control_mutex);
>  
> -	/*
> -	 * Set the configured bit and (optionally) other important stuff
> -	 * in the device control register.
> -	 */
> -	ctrl_base_addr = fn->fd.control_base_addr;
> +	/* Set the configured bit and (optionally) other important stuff
> +	 * in the device control register. */

Please use the following style for multi-line comments:

	/*
	 * This is a multi-line
	 * comment.
	 */

>  	error = rmi_read_block(rmi_dev, fn->fd.control_base_addr,
>  			&data->device_control.ctrl0,
>  			sizeof(data->device_control.ctrl0));
> @@ -978,8 +110,7 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>  		break;
>  	}
>  
> -	/*
> -	 * Sleep mode might be set as a hangover from a system crash or
> +	/* Sleep mode might be set as a hangover from a system crash or
>  	 * reboot without power cycle.  If so, clear it so the sensor
>  	 * is certain to function.
>  	 */
> @@ -990,11 +121,16 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>  		data->device_control.ctrl0 &= ~RMI_F01_CTRL0_SLEEP_MODE_MASK;
>  	}
>  
> +	/* Set this to indicate that we've initialized the sensor.  This will
> +	 * CLEAR the unconfigured bit in the status registers.  If we ever
> +	 * see unconfigured become set again, we'll know that the sensor has
> +	 * reset for some reason.
> +	 */
>  	data->device_control.ctrl0 |= RMI_F01_CRTL0_CONFIGURED_BIT;
>  
>  	error = rmi_write_block(rmi_dev, fn->fd.control_base_addr,
> -				&data->device_control.ctrl0,
> -				sizeof(data->device_control.ctrl0));
> +			&data->device_control.ctrl0,
> +			sizeof(data->device_control.ctrl0));

The old code had arguments aligned perfectly, why change that?

>  	if (error < 0) {
>  		dev_err(&fn->dev, "Failed to write F01 control.\n");
>  		return error;
> @@ -1006,14 +142,12 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>  
>  	data->interrupt_enable_addr = ctrl_base_addr;
>  	error = rmi_read_block(rmi_dev, ctrl_base_addr,
> -				data->device_control.interrupt_enable,
> -				sizeof(u8) * (data->num_of_irq_regs));
> +			data->device_control.interrupt_enable,
> +			sizeof(u8)*(data->num_of_irq_regs));

Same here. Also please keep spaces around operators.

>  	if (error < 0) {
> -		dev_err(&fn->dev,
> -			"Failed to read F01 control interrupt enable register.\n");
> +		dev_err(&fn->dev, "Failed to read F01 control interrupt enable register.\n");
>  		goto error_exit;
>  	}
> -
>  	ctrl_base_addr += data->num_of_irq_regs;
>  
>  	/* dummy read in order to clear irqs */
> @@ -1023,43 +157,226 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>  		return error;
>  	}
>  
> +	/* read queries */
>  	error = rmi_read_block(rmi_dev, fn->fd.query_base_addr,
> -			       basic_query, sizeof(basic_query));
> +				basic_query, sizeof(basic_query));
>  	if (error < 0) {
>  		dev_err(&fn->dev, "Failed to read device query registers.\n");
>  		return error;
>  	}
>  
>  	/* Now parse what we got */
> -	data->properties.manufacturer_id = basic_query[0];
> +	props->manufacturer_id = basic_query[0];
>  
> -	data->properties.has_lts = basic_query[1] & RMI_F01_QRY1_HAS_LTS;
> -	data->properties.has_adjustable_doze =
> +	props->has_lts = basic_query[1] & RMI_F01_QRY1_HAS_LTS;
> +	props->has_sensor_id =
> +			!!(basic_query[1] & RMI_F01_QRY1_HAS_SENSOR_ID);

I believe compiler will do the proper conversion to boolean for you
since the target of assignment is boolean.

> +	props->has_adjustable_doze =
>  			basic_query[1] & RMI_F01_QRY1_HAS_ADJ_DOZE;
> -	data->properties.has_adjustable_doze_holdoff =
> +	props->has_adjustable_doze_holdoff =
>  			basic_query[1] & RMI_F01_QRY1_HAS_ADJ_DOZE_HOFF;
> +	props->has_query42 = basic_query[1] & RMI_F01_QRY1_HAS_PROPS_2;
> +
> +	snprintf(props->dom, sizeof(props->dom), "20%02d/%02d/%02d",
> +		basic_query[5] & RMI_F01_QRY5_YEAR_MASK,
> +		basic_query[6] & RMI_F01_QRY6_MONTH_MASK,
> +		basic_query[7] & RMI_F01_QRY7_DAY_MASK);
> +
> +	memcpy(props->product_id, &basic_query[11], RMI_PRODUCT_ID_LENGTH);
> +	props->product_id[RMI_PRODUCT_ID_LENGTH] = '\0';
> +	query_addr += 11;
> +
> +	error = rmi_read_block(rmi_dev, query_addr, data->product_id,
> +				RMI_PRODUCT_ID_LENGTH);
> +	if (error < 0) {
> +		dev_err(&fn->dev, "Failed to read product ID.\n");
> +		return error;
> +	}
> +	data->product_id[RMI_PRODUCT_ID_LENGTH] = '\0';
> +	get_board_and_rev(fn, driver_data);
> +	dev_info(&fn->dev, "found RMI device, manufacturer: %s, product: %s, date: %s\n",
> +		 props->manufacturer_id == 1 ?
> +		 "synaptics" : "unknown", data->product_id, props->dom);

Capitalize your company name?

> +
> +	/* We'll come back and use this later, depending on some other query
> +	 * bits.
> +	 */
> +	prod_info_addr = query_addr + 6;
> +
> +	query_addr += RMI_PRODUCT_ID_LENGTH;
> +	if (props->has_lts) {
> +		error = rmi_read(rmi_dev, query_addr, info_buf);
> +		if (error < 0) {
> +			dev_err(&fn->dev, "Failed to read LTS info.\n");
> +			return error;
> +		}
> +		props->slave_asic_rows = info_buf[0] &
> +				RMI_F01_QRY21_SLAVE_ROWS_MASK;
> +		props->slave_asic_columns = (info_buf[1] &
> +				RMI_F01_QRY21_SLAVE_COLUMNS_MASK) >> 3;
> +		query_addr++;
> +	}
> +
> +	if (props->has_sensor_id) {
> +		error = rmi_read(rmi_dev, query_addr, &props->sensor_id);
> +		if (error < 0) {
> +			dev_err(&fn->dev, "Failed to read sensor ID.\n");
> +			return error;
> +		}
> +		query_addr++;
> +	}
> +
> +	/* Maybe skip a block of undefined LTS registers. */
> +	if (props->has_lts)
> +		query_addr += RMI_F01_LTS_RESERVED_SIZE;
> +
> +	if (props->has_query42) {
> +		error = rmi_read(rmi_dev, query_addr, info_buf);
> +		if (error < 0) {
> +			dev_err(&fn->dev, "Failed to read additional properties.\n");
> +			return error;
> +		}
> +		props->has_ds4_queries = info_buf[0] &
> +				RMI_F01_QRY42_DS4_QUERIES;
> +		props->has_multi_physical = info_buf[0] &
> +				RMI_F01_QRY42_MULTI_PHYS;
> +		props->has_guest = info_buf[0] & RMI_F01_QRY42_GUEST;
> +		props->has_swr = info_buf[0] & RMI_F01_QRY42_SWR;
> +		props->has_nominal_report_rate = info_buf[0] &
> +				RMI_F01_QRY42_NOMINAL_REPORT;
> +		props->has_recalibration_interval = info_buf[0] &
> +				RMI_F01_QRY42_RECAL_INTERVAL;
> +		query_addr++;
> +	}
> +
> +	if (props->has_ds4_queries) {
> +		error = rmi_read(rmi_dev, query_addr, &props->ds4_query_length);
> +		if (error < 0) {
> +			dev_err(&fn->dev, "Failed to read DS4 query length size.\n");
> +			return error;
> +		}
> +		query_addr++;
> +	}
>  
> -	snprintf(data->properties.dom, sizeof(data->properties.dom),
> -		 "20%02x%02x%02x",
> -		 basic_query[5] & RMI_F01_QRY5_YEAR_MASK,
> -		 basic_query[6] & RMI_F01_QRY6_MONTH_MASK,
> -		 basic_query[7] & RMI_F01_QRY7_DAY_MASK);
> +	for (i = 1; i <= props->ds4_query_length; i++) {
> +		u8 val;
> +		error = rmi_read(rmi_dev, query_addr, &val);
> +		query_addr++;
> +		if (error < 0) {
> +			dev_err(&fn->dev, "Failed to read F01_RMI_QUERY43.%02d, code: %d.\n",
> +				i, error);
> +			continue;
> +		}
> +		switch (i) {
> +		case 1:
> +			props->has_package_id_query = val &
> +					RMI_F01_QRY43_01_PACKAGE_ID;
> +			props->has_build_id_query = val &
> +					RMI_F01_QRY43_01_BUILD_ID;
> +			props->has_reset_query = val & RMI_F01_QRY43_01_RESET;
> +			props->has_maskrev_query = val &
> +					RMI_F01_QRY43_01_PACKAGE_ID;
> +			break;
> +		case 2:
> +			props->has_i2c_control = val & RMI_F01_QRY43_02_I2C_CTL;
> +			props->has_spi_control = val & RMI_F01_QRY43_02_SPI_CTL;
> +			props->has_attn_control = val &
> +					RMI_F01_QRY43_02_ATTN_CTL;
> +			props->has_win8_vendor_info = val &
> +					RMI_F01_QRY43_02_WIN8;
> +			props->has_timestamp = val & RMI_F01_QRY43_02_TIMESTAMP;
> +			break;
> +		case 3:
> +			props->has_tool_id_query = val &
> +					RMI_F01_QRY43_03_TOOL_ID;
> +			props->has_fw_revision_query = val &
> +					RMI_F01_QRY43_03_FW_REVISION;
> +			break;
> +		default:
> +			dev_warn(&fn->dev, "No handling for F01_RMI_QUERY43.%02d.\n",
> +				 i);
> +		}
> +	}
>  
> -	memcpy(data->properties.product_id, &basic_query[11],
> -		RMI_PRODUCT_ID_LENGTH);
> -	data->properties.product_id[RMI_PRODUCT_ID_LENGTH] = '\0';
> +	/* If present, the ASIC package ID registers are overlaid on the
> +	 * product ID. Go back to the right address (saved previously) and
> +	 * read them.
> +	 */
> +	if (props->has_package_id_query) {
> +		error = rmi_read_block(rmi_dev, prod_info_addr, info_buf,
> +				PACKAGE_ID_BYTES);
> +		if (error < 0)
> +			dev_warn(&fn->dev, "Failed to read package ID.\n");
> +		else {
> +			u16 *val = (u16 *)info_buf;
> +			data->package_id = le16_to_cpu(*val);
> +			val = (u16 *)(info_buf + 2);
> +			data->package_rev = le16_to_cpu(*val);
> +		}
> +	}
> +	prod_info_addr++;
>  
> -	data->properties.productinfo =
> -			((basic_query[2] & RMI_F01_QRY2_PRODINFO_MASK) << 7) |
> -			(basic_query[3] & RMI_F01_QRY2_PRODINFO_MASK);
> +	/* The firmware build id (if present) is similarly overlaid on product
> +	 * ID registers.  Go back again and read that data.
> +	 */
> +	if (props->has_build_id_query) {
> +		error = rmi_read_block(rmi_dev, prod_info_addr, info_buf,
> +				BUILD_ID_BYTES);
> +		if (error < 0)
> +			dev_warn(&fn->dev, "Failed to read FW build ID.\n");
> +		else {
> +			u16 *val = (u16 *)info_buf;
> +			data->build_id = le16_to_cpu(*val);

Did you try that with sparse? I do not think it will be happy here...
Something like

			data->build_id = le16_to_cpup((__le16 *)info_buf);

> +			data->build_id += info_buf[2] * 65536;
> +			dev_info(&fn->dev, "FW build ID: %#08x (%u).\n",
> +				data->build_id, data->build_id);
> +		}
> +	}
>  
> -	dev_info(&fn->dev, "found RMI device, manufacturer: %s, product: %s\n",
> -		 data->properties.manufacturer_id == 1 ?
> -							"synaptics" : "unknown",
> -		 data->properties.product_id);
> +	if (props->has_reset_query) {
> +		u8 val;
> +		error = rmi_read(rmi_dev, query_addr, &val);
> +		query_addr++;
> +		if (error < 0)
> +			dev_warn(&fn->dev, "Failed to read F01_RMI_QUERY44, code: %d.\n",
> +				error);
> +		else {
> +			props->reset_enabled = val & RMI_F01_QRY44_RST_ENABLED;
> +			props->reset_polarity = val &
> +					RMI_F01_QRY44_RST_POLARITY;
> +			props->pullup_enabled = val &
> +					RMI_F01_QRY44_PULLUP_ENABLED;
> +			props->reset_pin = (val &
> +					RMI_F01_QRY44_RST_PIN_MASK) >> 4;
> +		}
> +	}
> +
> +	if (props->has_tool_id_query) {
> +		error = rmi_read_block(rmi_dev, query_addr, props->tool_id,
> +					RMI_TOOL_ID_LENGTH);
> +		if (error < 0)
> +			dev_warn(&fn->dev, "Failed to read F01_RMI_QUERY45, code: %d.\n",
> +				 error);
> +		/* This is a so-called "packet register", so address map
> +		 * increments only by one. */
> +		query_addr++;
> +		props->tool_id[RMI_TOOL_ID_LENGTH] = '\0';
> +	}
> +
> +	if (props->has_fw_revision_query) {
> +		error = rmi_read_block(rmi_dev, query_addr, props->fw_revision,
> +					RMI_FW_REVISION_LENGTH);
> +		if (error < 0)
> +			dev_warn(&fn->dev, "Failed to read F01_RMI_QUERY46, code: %d.\n",
> +				 error);
> +		/* This is a so-called "packet register", so address map
> +		 * increments only by one. */
> +		query_addr++;
> +		props->tool_id[RMI_FW_REVISION_LENGTH] = '\0';
> +	}
>  
>  	/* read control register */
> -	if (data->properties.has_adjustable_doze) {
> +	if (props->has_adjustable_doze) {
>  		data->doze_interval_addr = ctrl_base_addr;
>  		ctrl_base_addr++;
>  
> @@ -1103,7 +420,7 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>  		}
>  	}
>  
> -	if (data->properties.has_adjustable_doze_holdoff) {
> +	if (props->has_adjustable_doze_holdoff) {
>  		data->doze_holdoff_addr = ctrl_base_addr;
>  		ctrl_base_addr++;
>  
> @@ -1133,27 +450,20 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>  		goto error_exit;
>  	}
>  
> -	driver_data->f01_bootloader_mode =
> -			RMI_F01_STATUS_BOOTLOADER(data->device_status);
> -	if (driver_data->f01_bootloader_mode)
> -		dev_warn(&rmi_dev->dev,
> -			 "WARNING: RMI4 device is in bootloader mode!\n");
> -
> -
>  	if (RMI_F01_STATUS_UNCONFIGURED(data->device_status)) {
> -		dev_err(&fn->dev,
> -			"Device was reset during configuration process, status: %#02x!\n",
> -			RMI_F01_STATUS_CODE(data->device_status));
> +		dev_err(&fn->dev, "Device reset during configuration process, status: %#02x!\n",
> +				RMI_F01_STATUS_CODE(data->device_status));
>  		error = -EINVAL;
>  		goto error_exit;
>  	}
>  
> -	error = setup_debugfs(fn);
> -	if (error)
> -		dev_warn(&fn->dev, "Failed to setup debugfs, error: %d.\n",
> -			 error);
> +	driver_data->f01_bootloader_mode =
> +		RMI_F01_STATUS_BOOTLOADER(data->device_status);
> +	if (RMI_F01_STATUS_BOOTLOADER(data->device_status))
> +		dev_warn(&rmi_dev->dev,
> +			 "WARNING: RMI4 device is in bootloader mode!\n");
>  
> -	return 0;
> +	return error;
>  
>   error_exit:
>  	kfree(data);
> @@ -1166,36 +476,33 @@ static int rmi_f01_config(struct rmi_function *fn)
>  	int retval;
>  
>  	retval = rmi_write_block(fn->rmi_dev, fn->fd.control_base_addr,
> -				 &data->device_control.ctrl0,
> -				 sizeof(data->device_control.ctrl0));
> +			&data->device_control.ctrl0,
> +			sizeof(data->device_control.ctrl0));
>  	if (retval < 0) {
>  		dev_err(&fn->dev, "Failed to write device_control.reg.\n");
>  		return retval;
>  	}
>  
>  	retval = rmi_write_block(fn->rmi_dev, data->interrupt_enable_addr,
> -				 data->device_control.interrupt_enable,
> -				 sizeof(u8) * data->num_of_irq_regs);
> +			data->device_control.interrupt_enable,
> +			sizeof(u8)*(data->num_of_irq_regs));
>  
>  	if (retval < 0) {
>  		dev_err(&fn->dev, "Failed to write interrupt enable.\n");
>  		return retval;
>  	}
> -	if (data->properties.has_lts) {
> -		retval = rmi_write_block(fn->rmi_dev, data->doze_interval_addr,
> -					 &data->device_control.doze_interval,
> -					 sizeof(u8));
> +
> +	if (data->properties.has_adjustable_doze) {
> +		retval = rmi_write(fn->rmi_dev,
> +					data->doze_interval_addr,
> +					data->device_control.doze_interval);
>  		if (retval < 0) {
>  			dev_err(&fn->dev, "Failed to write doze interval.\n");
>  			return retval;
>  		}
> -	}
> -
> -	if (data->properties.has_adjustable_doze) {
> -		retval = rmi_write_block(fn->rmi_dev,
> -					 data->wakeup_threshold_addr,
> -					 &data->device_control.wakeup_threshold,
> -					 sizeof(u8));
> +		retval = rmi_write(
> +				fn->rmi_dev, data->wakeup_threshold_addr,
> +				data->device_control.wakeup_threshold);
>  		if (retval < 0) {
>  			dev_err(&fn->dev, "Failed to write wakeup threshold.\n");
>  			return retval;
> @@ -1203,9 +510,9 @@ static int rmi_f01_config(struct rmi_function *fn)
>  	}
>  
>  	if (data->properties.has_adjustable_doze_holdoff) {
> -		retval = rmi_write_block(fn->rmi_dev, data->doze_holdoff_addr,
> -					 &data->device_control.doze_holdoff,
> -					 sizeof(u8));
> +		retval = rmi_write(fn->rmi_dev,
> +					data->doze_holdoff_addr,
> +					data->device_control.doze_holdoff);
>  		if (retval < 0) {
>  			dev_err(&fn->dev, "Failed to write doze holdoff.\n");
>  			return retval;
> @@ -1221,51 +528,40 @@ static int rmi_f01_probe(struct rmi_function *fn)
>  	int error;
>  
>  	error = rmi_f01_alloc_memory(fn, driver_data->num_of_irq_regs);
> -	if (error)
> +	if (error < 0)
>  		return error;
>  
>  	error = rmi_f01_initialize(fn);
> -	if (error)
> -		return error;
> -
> -	error = sysfs_create_group(&fn->dev.kobj, &rmi_fn_01_attr_group);
> -	if (error)
> +	if (error < 0)
>  		return error;
>  
>  	return 0;
>  }
>  
> -static void rmi_f01_remove(struct rmi_function *fn)
> -{
> -	teardown_debugfs(fn->data);
> -	sysfs_remove_group(&fn->dev.kobj, &rmi_fn_01_attr_group);
> -}
> -
>  #ifdef CONFIG_PM_SLEEP
>  static int rmi_f01_suspend(struct device *dev)
>  {
>  	struct rmi_function *fn = to_rmi_function(dev);
>  	struct rmi_device *rmi_dev = fn->rmi_dev;
>  	struct f01_data *data = fn->data;
> -	int error;
> +	int error = 0;
>  
>  	data->old_nosleep = data->device_control.ctrl0 &
> -					RMI_F01_CRTL0_NOSLEEP_BIT;
> +		RMI_F01_CRTL0_NOSLEEP_BIT;
>  	data->device_control.ctrl0 &= ~RMI_F01_CRTL0_NOSLEEP_BIT;
>  
>  	data->device_control.ctrl0 &= ~RMI_F01_CTRL0_SLEEP_MODE_MASK;
>  	data->device_control.ctrl0 |= RMI_SLEEP_MODE_SENSOR_SLEEP;
>  
>  	error = rmi_write_block(rmi_dev,
> -				fn->fd.control_base_addr,
> -				&data->device_control.ctrl0,
> -				sizeof(data->device_control.ctrl0));
> +			fn->fd.control_base_addr,
> +			 &data->device_control.ctrl0,
> +			 sizeof(data->device_control.ctrl0));
>  	if (error < 0) {
>  		dev_err(&fn->dev, "Failed to write sleep mode. Code: %d.\n",
>  			error);
>  		if (data->old_nosleep)
> -			data->device_control.ctrl0 |=
> -					RMI_F01_CRTL0_NOSLEEP_BIT;
> +			data->device_control.ctrl0 |= RMI_F01_CRTL0_NOSLEEP_BIT;
>  		data->device_control.ctrl0 &= ~RMI_F01_CTRL0_SLEEP_MODE_MASK;
>  		data->device_control.ctrl0 |= RMI_SLEEP_MODE_NORMAL;
>  		return error;
> @@ -1289,7 +585,7 @@ static int rmi_f01_resume(struct device *dev)
>  
>  	error = rmi_write_block(rmi_dev, fn->fd.control_base_addr,
>  				&data->device_control.ctrl0,
> -				sizeof(data->device_control.ctrl0));
> +			 sizeof(data->device_control.ctrl0));
>  	if (error < 0) {
>  		dev_err(&fn->dev,
>  			"Failed to restore normal operation. Code: %d.\n",
> @@ -1304,7 +600,7 @@ static int rmi_f01_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(rmi_f01_pm_ops, rmi_f01_suspend, rmi_f01_resume);
>  
>  static int rmi_f01_attention(struct rmi_function *fn,
> -			     unsigned long *irq_bits)
> +						unsigned long *irq_bits)
>  {
>  	struct rmi_device *rmi_dev = fn->rmi_dev;
>  	struct f01_data *data = fn->data;
> @@ -1317,7 +613,6 @@ static int rmi_f01_attention(struct rmi_function *fn,
>  			retval);
>  		return retval;
>  	}
> -
>  	if (RMI_F01_STATUS_UNCONFIGURED(data->device_status)) {
>  		dev_warn(&fn->dev, "Device reset detected.\n");
>  		retval = rmi_dev->driver->reset_handler(rmi_dev);
> @@ -1327,29 +622,18 @@ static int rmi_f01_attention(struct rmi_function *fn,
>  	return 0;
>  }
>  
> -static struct rmi_function_handler rmi_f01_handler = {
> +struct rmi_function_driver rmi_f01_driver = {
>  	.driver = {
>  		.name	= "rmi_f01",
>  		.pm	= &rmi_f01_pm_ops,
>  		/*
> -		 * Do not allow user unbinding F01 as it is critical
> +		 * Do not allow user unbinding of F01 as it is a critical
>  		 * function.
>  		 */
>  		.suppress_bind_attrs = true,
>  	},
> -	.func		= 0x01,
> -	.probe		= rmi_f01_probe,
> -	.remove		= rmi_f01_remove,
> -	.config		= rmi_f01_config,
> -	.attention	= rmi_f01_attention,
> +	.func      = FUNCTION_NUMBER,
> +	.probe     = rmi_f01_probe,
> +	.config    = rmi_f01_config,
> +	.attention = rmi_f01_attention,
>  };
> -
> -int __init rmi_register_f01_handler(void)
> -{
> -	return rmi_register_function_handler(&rmi_f01_handler);
> -}
> -
> -void rmi_unregister_f01_handler(void)
> -{
> -	rmi_unregister_function_handler(&rmi_f01_handler);
> -}
> diff --git a/drivers/input/rmi4/rmi_f01.h b/drivers/input/rmi4/rmi_f01.h
> new file mode 100644
> index 0000000..bfd0dcf
> --- /dev/null
> +++ b/drivers/input/rmi4/rmi_f01.h
> @@ -0,0 +1,269 @@
> +/*
> + * Copyright (c) 2012 Synaptics Incorporated
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +
> +#ifndef _RMI_F01_H
> +#define _RMI_F01_H
> +
> +#define RMI_PRODUCT_ID_LENGTH    10
> +
> +#define RMI_DATE_CODE_LENGTH      3
> +
> +/* Force a firmware reset of the sensor */
> +#define RMI_F01_CMD_DEVICE_RESET	1
> +
> +#define F01_SERIALIZATION_SIZE 7
> +
> +/* Various F01_RMI_QueryX bits */
> +
> +#define RMI_F01_QRY1_CUSTOM_MAP		(1 << 0)
> +#define RMI_F01_QRY1_NON_COMPLIANT	(1 << 1)
> +#define RMI_F01_QRY1_HAS_LTS		(1 << 2)
> +#define RMI_F01_QRY1_HAS_SENSOR_ID	(1 << 3)
> +#define RMI_F01_QRY1_HAS_CHARGER_INP	(1 << 4)
> +#define RMI_F01_QRY1_HAS_ADJ_DOZE	(1 << 5)
> +#define RMI_F01_QRY1_HAS_ADJ_DOZE_HOFF	(1 << 6)
> +#define RMI_F01_QRY1_HAS_PROPS_2	(1 << 7)
> +
> +#define RMI_F01_QRY5_YEAR_MASK		0x1f
> +#define RMI_F01_QRY6_MONTH_MASK		0x0f
> +#define RMI_F01_QRY7_DAY_MASK		0x1f
> +
> +#define RMI_F01_QRY2_PRODINFO_MASK	0x7f
> +
> +#define RMI_F01_BASIC_QUERY_LEN		21 /* From Query 00 through 20 */
> +
> +#define RMI_F01_QRY21_SLAVE_ROWS_MASK   0x07
> +#define RMI_F01_QRY21_SLAVE_COLUMNS_MASK 0x38
> +
> +#define RMI_F01_LTS_RESERVED_SIZE 19
> +
> +#define RMI_F01_QRY42_DS4_QUERIES	(1 << 0)
> +#define RMI_F01_QRY42_MULTI_PHYS	(1 << 1)
> +#define RMI_F01_QRY42_GUEST		(1 << 2)
> +#define RMI_F01_QRY42_SWR		(1 << 3)
> +#define RMI_F01_QRY42_NOMINAL_REPORT	(1 << 4)
> +#define RMI_F01_QRY42_RECAL_INTERVAL	(1 << 5)
> +
> +#define RMI_F01_QRY43_01_PACKAGE_ID     (1 << 0)
> +#define RMI_F01_QRY43_01_BUILD_ID       (1 << 1)
> +#define RMI_F01_QRY43_01_RESET          (1 << 2)
> +#define RMI_F01_QRY43_01_MASK_REV       (1 << 3)
> +
> +#define RMI_F01_QRY43_02_I2C_CTL	(1 << 0)
> +#define RMI_F01_QRY43_02_SPI_CTL	(1 << 1)
> +#define RMI_F01_QRY43_02_ATTN_CTL	(1 << 2)
> +#define RMI_F01_QRY43_02_WIN8		(1 << 3)
> +#define RMI_F01_QRY43_02_TIMESTAMP	(1 << 4)
> +
> +#define RMI_F01_QRY43_03_TOOL_ID	(1 << 0)
> +#define RMI_F01_QRY43_03_FW_REVISION	(1 << 1)
> +
> +#define RMI_F01_QRY44_RST_ENABLED	(1 << 0)
> +#define RMI_F01_QRY44_RST_POLARITY	(1 << 1)
> +#define RMI_F01_QRY44_PULLUP_ENABLED	(1 << 2)
> +#define RMI_F01_QRY44_RST_PIN_MASK	0xF0
> +
> +#define RMI_TOOL_ID_LENGTH		16
> +#define RMI_FW_REVISION_LENGTH		16
> +
> +struct f01_basic_properties {
> +	u8 manufacturer_id;
> +	bool has_lts;
> +	bool has_sensor_id;
> +	bool has_adjustable_doze;
> +	bool has_adjustable_doze_holdoff;
> +	bool has_query42;
> +	char dom[11]; /* YYYY/MM/DD + '\0' */
> +	u8 product_id[RMI_PRODUCT_ID_LENGTH + 1];
> +	u16 productinfo;
> +
> +	/* These are meaningful only if has_lts is true. */
> +	u8 slave_asic_rows;
> +	u8 slave_asic_columns;
> +
> +	/* This is meaningful only if has_sensor_id is true. */
> +	u8 sensor_id;
> +
> +	/* These are meaningful only if has_query42 is true. */
> +	bool has_ds4_queries;
> +	bool has_multi_physical;
> +	bool has_guest;
> +	bool has_swr;
> +	bool has_nominal_report_rate;
> +	bool has_recalibration_interval;
> +
> +	/* Tells how many of the Query43.xx registers are present.
> +	 */
> +	u8 ds4_query_length;
> +
> +	/* Query 43.1 */
> +	bool has_package_id_query;
> +	bool has_build_id_query;
> +	bool has_reset_query;
> +	bool has_maskrev_query;
> +
> +	/* Query 43.2 */
> +	bool has_i2c_control;
> +	bool has_spi_control;
> +	bool has_attn_control;
> +	bool has_win8_vendor_info;
> +	bool has_timestamp;
> +
> +	/* Query 43.3 */
> +	bool has_tool_id_query;
> +	bool has_fw_revision_query;
> +
> +	/* Query 44 */
> +	bool reset_enabled;
> +	bool reset_polarity;
> +	bool pullup_enabled;
> +	u8 reset_pin;
> +
> +	/* Query 45 */
> +	char tool_id[RMI_TOOL_ID_LENGTH + 1];
> +
> +	/* Query 46 */
> +	char fw_revision[RMI_FW_REVISION_LENGTH + 1];
> +};
> +
> +/** The status code field reports the most recent device status event.
> + * @no_error - should be self explanatory.
> + * @reset_occurred - no other event was seen since the last reset.
> + * @invalid_config - general device configuration has a problem.
> + * @device_failure - general device hardware failure.
> + * @config_crc - configuration failed memory self check.
> + * @firmware_crc - firmware failed memory self check.
> + * @crc_in_progress - bootloader is currently testing config and fw areas.
> + */
> +enum rmi_device_status {
> +	no_error = 0x00,
> +	reset_occurred = 0x01,
> +	invalid_config = 0x02,
> +	device_failure = 0x03,
> +	config_crc = 0x04,
> +	firmware_crc = 0x05,
> +	crc_in_progress = 0x06
> +};
> +
> +
> +/* F01 device status bits */
> +
> +/* Most recent device status event */
> +#define RMI_F01_STATUS_CODE(status)		((status) & 0x0f)
> +/* Indicates that flash programming is enabled (bootloader mode). */
> +#define RMI_F01_STATUS_BOOTLOADER(status)	(!!((status) & 0x40))
> +/* The device has lost its configuration for some reason. */
> +#define RMI_F01_STATUS_UNCONFIGURED(status)	(!!((status) & 0x80))
> +
> +
> +
> +/* Control register bits */
> +
> +/*
> +* Sleep mode controls power management on the device and affects all
> +* functions of the device.
> +*/
> +#define RMI_F01_CTRL0_SLEEP_MODE_MASK	0x03
> +
> +#define RMI_SLEEP_MODE_NORMAL		0x00
> +#define RMI_SLEEP_MODE_SENSOR_SLEEP	0x01
> +#define RMI_SLEEP_MODE_RESERVED0	0x02
> +#define RMI_SLEEP_MODE_RESERVED1	0x03
> +
> +#define RMI_IS_VALID_SLEEPMODE(mode) \
> +(mode >= RMI_SLEEP_MODE_NORMAL && mode <= RMI_SLEEP_MODE_RESERVED1)
> +
> +/*
> + * This bit disables whatever sleep mode may be selected by the sleep_mode
> + * field and forces the device to run at full power without sleeping.
> + */
> +#define RMI_F01_CRTL0_NOSLEEP_BIT	(1 << 2)
> +
> +/*
> + * When this bit is set, the touch controller employs a noise-filtering
> + * algorithm designed for use with a connected battery charger.
> + */
> +#define RMI_F01_CRTL0_CHARGER_BIT	(1 << 5)
> +
> +/*
> + * Sets the report rate for the device. The effect of this setting is
> + * highly product dependent. Check the spec sheet for your particular
> + * touch sensor.
> + */
> +#define RMI_F01_CRTL0_REPORTRATE_BIT	(1 << 6)
> +
> +/*
> + * Written by the host as an indicator that the device has been
> + * successfully configured.
> + */
> +#define RMI_F01_CRTL0_CONFIGURED_BIT	(1 << 7)
> +
> +/**
> + * @ctrl0 - see documentation in rmi_f01.h.
> + * @interrupt_enable - A mask of per-function interrupts on the touch sensor.
> + * @doze_interval - controls the interval between checks for finger presence
> + * when the touch sensor is in doze mode, in units of 10ms.
> + * @wakeup_threshold - controls the capacitance threshold at which the touch
> + * sensor will decide to wake up from that low power state.
> + * @doze_holdoff - controls how long the touch sensor waits after the last
> + * finger lifts before entering the doze state, in units of 100ms.
> + */
> +struct f01_device_control {
> +	u8 ctrl0;
> +	u8 *interrupt_enable;
> +	u8 doze_interval;
> +	u8 wakeup_threshold;
> +	u8 doze_holdoff;
> +};
> +
> +
> +/*
> + *
> + * @serialization - 7 bytes of device serialization data.  The meaning of
> + * these bytes varies from product to product, consult your product spec sheet.
> + */
> +struct f01_data {
> +	struct f01_device_control device_control;
> +	struct mutex control_mutex;
> +
> +	u8 device_status;
> +
> +	struct f01_basic_properties properties;
> +	u8 serialization[F01_SERIALIZATION_SIZE];
> +	u8 product_id[RMI_PRODUCT_ID_LENGTH+1];
> +
> +	u16 package_id;
> +	u16 package_rev;
> +	u32 build_id;
> +
> +	u16 interrupt_enable_addr;
> +	u16 doze_interval_addr;
> +	u16 wakeup_threshold_addr;
> +	u16 doze_holdoff_addr;
> +
> +	int irq_count;
> +	int num_of_irq_regs;
> +
> +#ifdef	CONFIG_PM

I think you want CONFIG_PM_SLEEP here to mirror implementation of
susped/resume methods.

> +	bool suspended;
> +	bool old_nosleep;
> +#endif
> +};
> +
> +#endif

Thanks.

-- 
Dmitry
