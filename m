From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [v1.1] driver: input :touchscreen : Raydium I2C touch
 driver
Date: Thu, 7 Jul 2016 01:16:34 -0700
Message-ID: <20160707081634.GA13125@dtor-ws>
References: <1467877270-2673-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467877270-2673-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "jeffrey.lin" <yajohn@gmail.com>
Cc: rydberg@euromail.se, groeck@chromium.org, robh@kernel.org, jeffrey.lin@rad-ic.com, ealin.chiu@rad-ic.com, jason.yeh@rad-ic.com, KP.li@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jeffrey,

On Thu, Jul 07, 2016 at 03:41:10PM +0800, jeffrey.lin wrote:
> Add and fix below function.
> 1.Touch report points chechsum
> 2.update firmware naming decision by firmware version
> 3.fix reset pins control issue

Please split into separate patches so that each logical change is in a
separate patch. Also please use descriptive patch subjects.

> 
> Signed-off-by: jeffrey.lin <jeffrey.lin@rad-ic.com>
> ---
>  drivers/input/touchscreen/raydium_i2c_ts.c | 261 +++++++++++++++++++++++------
>  1 file changed, 213 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
> index f3076d9..fe8bff0 100644
> --- a/drivers/input/touchscreen/raydium_i2c_ts.c
> +++ b/drivers/input/touchscreen/raydium_i2c_ts.c
> @@ -34,6 +34,9 @@
>  #include <linux/slab.h>
>  #include <asm/unaligned.h>
>  
> +/* Firmware */
> +#define RAYDIUM_FW_NAME		"raydium.fw"
> +
>  /* Slave I2C mode */
>  #define RM_BOOT_BLDR		0x02
>  #define RM_BOOT_MAIN		0x03
> @@ -70,6 +73,8 @@
>  #define RM_CONTACT_WIDTH_X_POS	6
>  #define RM_CONTACT_WIDTH_Y_POS	7
>  
> +#define RM_CONTACT_CRC_OFFSET	2
> +
>  /* Bootloader relative info */
>  #define RM_BL_WRT_CMD_SIZE	3	/* bl flash wrt cmd size */
>  #define RM_BL_WRT_PKG_SIZE	32	/* bl wrt pkg size */
> @@ -78,7 +83,7 @@
>  #define RM_MAX_FW_RETRIES	30
>  #define RM_MAX_FW_SIZE		0xD000
>  
> -#define RM_POWERON_DELAY_USEC	500
> +#define RM_POWERON_DELAY_MSEC	20
>  #define RM_RESET_DELAY_MSEC	50
>  
>  enum raydium_bl_cmd {
> @@ -97,6 +102,7 @@ enum raydium_bl_ack {
>  enum raydium_boot_mode {
>  	RAYDIUM_TS_MAIN = 0,
>  	RAYDIUM_TS_BLDR,
> +	INVALID_REGION,
>  };
>  
>  /* Response to RM_CMD_DATA_BANK request */
> @@ -137,10 +143,13 @@ struct raydium_data {
>  	u32 data_bank_addr;
>  	u8 report_size;
>  	u8 contact_size;
> +	u8 pkg_size;
>  
>  	enum raydium_boot_mode boot_mode;
>  
>  	bool wake_irq_enabled;
> +
> +	char *fw_file;
>  };
>  
>  static int raydium_i2c_send(struct i2c_client *client,
> @@ -280,12 +289,14 @@ static int raydium_i2c_query_ts_info(struct raydium_data *ts)
>  		 * then the size changed (due to firmware update?) and keep
>  		 * old size instead.
>  		 */
> -		if (ts->report_data && ts->report_size != data_info.pkg_size)
> +		if (ts->report_data && ts->pkg_size != data_info.pkg_size)
>  			dev_warn(&client->dev,
>  				 "report size changes, was: %d, new: %d\n",
> -				 ts->report_size, data_info.pkg_size);
> -		else
> -			ts->report_size = data_info.pkg_size;
> +				 ts->pkg_size, data_info.pkg_size);
> +		else {
> +			ts->pkg_size = data_info.pkg_size;
> +			ts->report_size = ts->pkg_size - RM_CONTACT_CRC_OFFSET;
> +		}
>  
>  		ts->contact_size = data_info.tp_info_size;
>  		ts->data_bank_addr = le32_to_cpu(data_info.data_bank_addr);
> @@ -318,16 +329,23 @@ static int raydium_i2c_check_fw_status(struct raydium_data *ts)
>  	struct i2c_client *client = ts->client;
>  	static const u8 bl_ack = 0x62;
>  	static const u8 main_ack = 0x66;
> -	u8 buf[4];
> +	u8 buf[5];
>  	int error;
>  
>  	error = raydium_i2c_read(client, RM_CMD_BOOT_READ, buf, sizeof(buf));
>  	if (!error) {
> -		if (buf[0] == bl_ack)
> -			ts->boot_mode = RAYDIUM_TS_BLDR;
> -		else if (buf[0] == main_ack)
> +		if (buf[0] == main_ack)
>  			ts->boot_mode = RAYDIUM_TS_MAIN;
> -		return 0;
> +		else if (buf[0] == bl_ack) {
> +			ts->boot_mode = RAYDIUM_TS_BLDR;
> +			ts->info.main_ver = buf[4] >> 4;
> +			ts->info.sub_ver = buf[4] & 0x0F;
> +		} else {
> +			ts->boot_mode = INVALID_REGION;
> +			error = -EINVAL;
> +			dev_err(&client->dev,
> +				"invalid fw status: %x\n", buf[0]);
> +		}
>  	}
>  
>  	return error;
> @@ -358,13 +376,10 @@ static int raydium_i2c_initialize(struct raydium_data *ts)
>  	if (error)
>  		ts->boot_mode = RAYDIUM_TS_BLDR;
>  
> -	if (ts->boot_mode == RAYDIUM_TS_BLDR) {
> +	if (ts->boot_mode == RAYDIUM_TS_BLDR)
>  		ts->info.hw_ver = cpu_to_le32(0xffffffffUL);
> -		ts->info.main_ver = 0xff;
> -		ts->info.sub_ver = 0xff;
> -	} else {
> +	else
>  		raydium_i2c_query_ts_info(ts);
> -	}
>  
>  	return error;
>  }
> @@ -612,6 +627,17 @@ static int raydium_i2c_fw_write_page(struct i2c_client *client,
>  	return error;
>  }
>  
> +static u16 raydium_calc_chksum(u8 *buf, u16 len)

const u8 *

> +{
> +	u16 checksum = 0;
> +	u16 i;
> +
> +	for (i = 0; i < len; i++)
> +		checksum += buf[i];
> +
> +	return checksum;
> +}
> +
>  static int raydium_i2c_do_update_firmware(struct raydium_data *ts,
>  					 const struct firmware *fw)
>  {
> @@ -724,9 +750,7 @@ static int raydium_i2c_do_update_firmware(struct raydium_data *ts,
>  		return error;
>  	}
>  
> -	fw_checksum = 0;
> -	for (i = 0; i < fw->size; i++)
> -		fw_checksum += fw->data[i];
> +	fw_checksum = raydium_calc_chksum((u8 *)fw->data, fw->size);

Drop cast.

>  
>  	error = raydium_i2c_write_checksum(client, fw->size, fw_checksum);
>  	if (error)
> @@ -739,12 +763,12 @@ static int raydium_i2c_fw_update(struct raydium_data *ts)
>  {
>  	struct i2c_client *client = ts->client;
>  	const struct firmware *fw = NULL;
> -	const char *fw_file = "raydium.fw";
>  	int error;
>  
> -	error = request_firmware(&fw, fw_file, &client->dev);
> +	error = request_firmware(&fw, ts->fw_file, &client->dev);
>  	if (error) {
> -		dev_err(&client->dev, "Unable to open firmware %s\n", fw_file);
> +		dev_err(&client->dev, "Unable to open firmware %s\n",
> +			ts->fw_file);
>  		return error;
>  	}
>  
> @@ -780,15 +804,6 @@ out_enable_irq:
>  static void raydium_mt_event(struct raydium_data *ts)
>  {
>  	int i;
> -	int error;
> -
> -	error = raydium_i2c_read_message(ts->client, ts->data_bank_addr,
> -					 ts->report_data, ts->report_size);
> -	if (error) {
> -		dev_err(&ts->client->dev, "%s: failed to read data: %d\n",
> -			__func__, error);
> -		return;
> -	}
>  
>  	for (i = 0; i < ts->report_size / ts->contact_size; i++) {
>  		u8 *contact = &ts->report_data[ts->contact_size * i];
> @@ -798,33 +813,57 @@ static void raydium_mt_event(struct raydium_data *ts)
>  		input_mt_slot(ts->input, i);
>  		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, state);
>  
> -		if (!state)
> -			continue;
> -
> -		input_report_abs(ts->input, ABS_MT_POSITION_X,
> +		if (state == 0x01) {
> +			input_report_abs(ts->input, ABS_MT_POSITION_X,
>  				get_unaligned_le16(&contact[RM_CONTACT_X_POS]));
> -		input_report_abs(ts->input, ABS_MT_POSITION_Y,
> +			input_report_abs(ts->input, ABS_MT_POSITION_Y,
>  				get_unaligned_le16(&contact[RM_CONTACT_Y_POS]));
> -		input_report_abs(ts->input, ABS_MT_PRESSURE,
> -				contact[RM_CONTACT_PRESSURE_POS]);
> +			input_report_abs(ts->input, ABS_MT_PRESSURE,
> +					contact[RM_CONTACT_PRESSURE_POS]);
>  
> -		wx = contact[RM_CONTACT_WIDTH_X_POS];
> -		wy = contact[RM_CONTACT_WIDTH_Y_POS];
> +			wx = contact[RM_CONTACT_WIDTH_X_POS];
> +			wy = contact[RM_CONTACT_WIDTH_Y_POS];
>  
> -		input_report_abs(ts->input, ABS_MT_TOUCH_MAJOR, max(wx, wy));
> -		input_report_abs(ts->input, ABS_MT_TOUCH_MINOR, min(wx, wy));
> +			input_report_abs(ts->input, ABS_MT_TOUCH_MAJOR,
> +				max(wx, wy));
> +			input_report_abs(ts->input, ABS_MT_TOUCH_MINOR,
> +				min(wx, wy));
> +		}
>  	}
>  
>  	input_mt_sync_frame(ts->input);
>  	input_sync(ts->input);
>  }
>  
> +static void raydium_i2c_event(struct raydium_data *ts)
> +{
> +	__le16 fw_crc;

No, it is not __le16. get_unaligned_le16() converts to native CPU
endianness. Please install sparse tool and check your changes with it
like this:

make C=2 CF=-D__CHECK_ENDIAN__ drivers/input/touchscreen/raydium_ts.o

> +	u16 calc_crc = raydium_calc_chksum(ts->report_data, ts->report_size);
> +
> +	fw_crc = get_unaligned_le16(&ts->report_data[ts->report_size]);
> +
> +	if (unlikely(fw_crc != calc_crc))
> +		dev_warn(&ts->client->dev,
> +			 "%s: invalid packet crc %04x &. %04x\n",
> +			 __func__, calc_crc, fw_crc);
> +	else
> +		raydium_mt_event(ts);
> +}
> +
>  static irqreturn_t raydium_i2c_irq(int irq, void *_dev)
>  {
>  	struct raydium_data *ts = _dev;
> +	int error;
>  
> -	if (ts->boot_mode != RAYDIUM_TS_BLDR)
> -		raydium_mt_event(ts);
> +	if (ts->boot_mode == RAYDIUM_TS_MAIN) {
> +		error = raydium_i2c_read_message(ts->client, ts->data_bank_addr,
> +				 ts->report_data, ts->pkg_size);
> +		if (error) {

No need for curly braces here.

> +			dev_err(&ts->client->dev, "%s: failed to read data: %d\n",
> +				__func__, error);
> +		} else
> +			raydium_i2c_event(ts);
> +	}
>  
>  	return IRQ_HANDLED;
>  }
> @@ -900,11 +939,127 @@ static ssize_t raydium_i2c_calibrate_store(struct device *dev,
>  	return error ?: count;
>  }
>  
> +static int raydium_update_file_name(struct device *dev, char **file_name,
> +				const char *buf, size_t count)
> +{
> +	char *new_file_name;
> +
> +	/* Simple sanity check */
> +	if (count > 64) {
> +		dev_warn(dev, "File name too long\n");
> +		return -EINVAL;
> +	}
> +
> +	new_file_name = devm_kmalloc(dev, count + 1, GFP_KERNEL);

devm API should only be used in probe paths.

Also, why is this needed at all?

> +	if (!new_file_name)
> +		return -ENOMEM;
> +
> +	memcpy(new_file_name, buf, count + 1);
> +
> +	/* Echo into the sysfs entry may append newline at the end of buf */
> +	if (new_file_name[count - 1] == '\n')
> +		count--;
> +
> +	new_file_name[count] = '\0';
> +
> +	if (*file_name)
> +		devm_kfree(dev, *file_name);
> +
> +	*file_name = new_file_name;
> +
> +	return 0;
> +}
> +
> +static ssize_t raydium_fw_file_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct raydium_data *ts = i2c_get_clientdata(client);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", ts->fw_file);
> +}
> +
> +static ssize_t raydium_fw_file_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct raydium_data *ts = i2c_get_clientdata(client);
> +	int ret;
> +
> +	ret = raydium_update_file_name(dev, &ts->fw_file, buf, count);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t raydium_rdreg_acc_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct raydium_data *ts = i2c_get_clientdata(client);
> +	int error;
> +	u64 param;
> +	__le32 addr;
> +	u16 len;
> +
> +	error = kstrtou64(buf, 16, &param);
> +	if (error < 0)
> +		return -EINVAL;
> +
> +	error = mutex_lock_interruptible(&ts->sysfs_mutex);
> +	if (error)
> +		return error;
> +
> +	disable_irq(client->irq);
> +
> +	addr = param >> 32;
> +	len = param & 0x0000FFFF;
> +
> +	error = raydium_i2c_read_message(ts->client,
> +		 le32_to_cpu(addr), (u8 *)buf, len);
> +
> +	enable_irq(client->irq);
> +
> +	mutex_unlock(&ts->sysfs_mutex);
> +	return error ?: count;
> +}
> +
> +static ssize_t raydium_wrtreg_acc_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct raydium_data *ts = i2c_get_clientdata(client);
> +	int error;
> +	u64 param;
> +	__le32 addr;
> +	u32 val;
> +
> +	error = kstrtou64(buf, 16, &param);
> +	if (error < 0)
> +		return -EINVAL;
> +
> +	addr = param >> 32;
> +	val = param & 0xFFFFFFFF;
> +
> +	error = raydium_i2c_send_message(ts->client, addr,
> +					 &val, sizeof(val));
> +
> +	return error ?: count;
> +}

Why do we need this? I'd rather you use /dev/i2c* if you need raw access
to the registers.

> +
>  static DEVICE_ATTR(fw_version, S_IRUGO, raydium_i2c_fw_ver_show, NULL);
>  static DEVICE_ATTR(hw_version, S_IRUGO, raydium_i2c_hw_ver_show, NULL);
>  static DEVICE_ATTR(boot_mode, S_IRUGO, raydium_i2c_boot_mode_show, NULL);
>  static DEVICE_ATTR(update_fw, S_IWUSR, NULL, raydium_i2c_update_fw_store);
>  static DEVICE_ATTR(calibrate, S_IWUSR, NULL, raydium_i2c_calibrate_store);
> +static DEVICE_ATTR(fw_file, S_IRUGO | S_IWUSR, raydium_fw_file_show,
> +		   raydium_fw_file_store);
> +static DEVICE_ATTR(wrt_reg, S_IWUSR, NULL, raydium_wrtreg_acc_store);
> +static DEVICE_ATTR(read_reg, S_IWUSR, NULL, raydium_rdreg_acc_store);
>  
>  static struct attribute *raydium_i2c_attributes[] = {
>  	&dev_attr_update_fw.attr,
> @@ -912,6 +1067,9 @@ static struct attribute *raydium_i2c_attributes[] = {
>  	&dev_attr_fw_version.attr,
>  	&dev_attr_hw_version.attr,
>  	&dev_attr_calibrate.attr,
> +	&dev_attr_fw_file.attr,
> +	&dev_attr_wrt_reg.attr,
> +	&dev_attr_read_reg.attr,
>  	NULL
>  };
>  
> @@ -933,7 +1091,7 @@ static int raydium_i2c_power_on(struct raydium_data *ts)
>  	if (!ts->reset_gpio)
>  		return 0;
>  
> -	gpiod_set_value_cansleep(ts->reset_gpio, 1);
> +	gpiod_set_value_cansleep(ts->reset_gpio, 0);

No, this is not correct. 1 means "active", 0 means "inactive". Here you
want to enter reset state, so gpio should be active.

Make sure you specify right polarity in your DTS.

>  
>  	error = regulator_enable(ts->avdd);
>  	if (error) {
> @@ -950,10 +1108,10 @@ static int raydium_i2c_power_on(struct raydium_data *ts)
>  		goto release_reset_gpio;
>  	}
>  
> -	udelay(RM_POWERON_DELAY_USEC);
> +	msleep(RM_POWERON_DELAY_MSEC);
>  
>  release_reset_gpio:
> -	gpiod_set_value_cansleep(ts->reset_gpio, 0);
> +	gpiod_set_value_cansleep(ts->reset_gpio, 1);
>  
>  	if (error)
>  		return error;
> @@ -968,7 +1126,6 @@ static void raydium_i2c_power_off(void *_data)
>  	struct raydium_data *ts = _data;
>  
>  	if (ts->reset_gpio) {
> -		gpiod_set_value_cansleep(ts->reset_gpio, 1);
>  		regulator_disable(ts->vccio);
>  		regulator_disable(ts->avdd);
>  	}
> @@ -1043,6 +1200,14 @@ static int raydium_i2c_probe(struct i2c_client *client,
>  		return -ENXIO;
>  	}
>  
> +	error = raydium_update_file_name(&client->dev, &ts->fw_file,
> +			RAYDIUM_FW_NAME, strlen(RAYDIUM_FW_NAME));
> +	if (error) {
> +		dev_err(&client->dev, "failed to set firmware file name: %d\n",
> +			error);
> +		return error;
> +	}
> +
>  	error = raydium_i2c_initialize(ts);
>  	if (error) {
>  		dev_err(&client->dev, "failed to initialize: %d\n", error);
> @@ -1050,7 +1215,7 @@ static int raydium_i2c_probe(struct i2c_client *client,
>  	}
>  
>  	ts->report_data = devm_kmalloc(&client->dev,
> -				       ts->report_size, GFP_KERNEL);
> +				       ts->pkg_size, GFP_KERNEL);
>  	if (!ts->report_data)
>  		return -ENOMEM;
>  
> -- 
> 2.1.2
> 

Thanks.

-- 
Dmitry
