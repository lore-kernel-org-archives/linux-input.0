From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v12 1/5] Input: goodix - add sysfs interface to dump
 config
Date: Thu, 27 Oct 2016 15:44:15 +0200
Message-ID: <1477575855.2458.19.camel@hadess.net>
References: <1473530257-7495-1-git-send-email-irina.tirdea@intel.com>
         <1473530257-7495-2-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473530257-7495-2-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org



On Sat, 2016-09-10 at 20:57 +0300, Irina Tirdea wrote:
> Goodix devices have a configuration information register area that
> specifies various parameters for the device. The configuration
> information
> has a specific format described in the Goodix datasheet. It includes
> X/Y
> resolution, maximum supported touch points, interrupt flags, various
> sesitivity factors and settings for advanced features (like gesture
> recognition).
> 
> Export a sysfs interface that would allow reading the configuration
> information. The default device configuration can be used as a
> starting
> point for creating a valid configuration firmware used by the device
> at
> init time to update its configuration.
> 
> This sysfs interface will be exported only if the gpio pins are
> properly
> initialized from ACPI/DT.

Reviewed-by: Bastien Nocera <hadess@hadess.net>

Only thing I don't like is the overly complicated bash script. I'd
really rather the code was in C, making it easier to debug, and not
rely on a fair number of external utilities.

> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> ---
>  Documentation/input/goodix.txt     | 84
> ++++++++++++++++++++++++++++++++++++++
>  drivers/input/touchscreen/goodix.c | 64 ++++++++++++++++++++++++++
> ---
>  2 files changed, 143 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/input/goodix.txt
> 
> diff --git a/Documentation/input/goodix.txt
> b/Documentation/input/goodix.txt
> new file mode 100644
> index 0000000..f9be1e2
> --- /dev/null
> +++ b/Documentation/input/goodix.txt
> @@ -0,0 +1,84 @@
> +Goodix touchscreen driver
> +=====================================
> +
> +How to update configuration firmware
> +=====================================
> +
> +Goodix touchscreen devices have a set of registers that specify
> configuration
> +information for the device. The configuration information has a
> specific format
> +described in the Goodix datasheet. It includes X/Y resolution,
> maximum
> +supported touch points, interrupt flags, various sesitivity factors
> and
> +settings for advanced features (like gesture recognition).
> +
> +The devices have an initial default configuration that can be read
> through
> +the sysfs interface (/sys/class/input/inputX/device/dump_config).
> This default
> +configuration can be used as a starting point for creating a new
> configuration
> +firmware file. At init, the driver will read the configuration
> firmware file
> +and update the device configuration.
> +
> +This configuration can be accesed only if both interrupt and reset
> gpio pins
> +are connected and properly configured through ACPI _DSD/DT
> properties.
> +
> +Below are instructions on how to generate a valid configuration
> starting from
> +the device default configuration.
> +
> +1. Dump the default configuration of the device to a file:
> +  $ cat /sys/class/input/inputX/device/dump_config >
> goodix_<model>_cfg
> +
> +2. Make the needed changes to the configuration (e.g. change
> resolution of
> +x/y axes, maximum reported touch points, switch X,Y axes, etc.). For
> more
> +details check the Goodix datasheet for format of Configuration
> Registers.
> +
> +3. Generate a valid configuration starting from  goodix_<model>_cfg.
> +After making changes, you need to recompute the checksum of the
> entire
> +configuration data, set Config_Fresh to 1 and generate the binary
> config
> +firmware image. This can be done using a helper script similar to
> the
> +one below:
> +
> +#!/bin/bash
> +
> +if [[ $# -lt 1 ]]; then
> +    echo "$0 fw_filename"
> +    exit 1
> +fi
> +
> +file_in="$1"
> +file_out_bin=${file_in}.bin
> +
> +print_val ()
> +{
> +    val="$1"
> +    printf "0x%.2x" "$val" | xxd -r -p >> ${file_out_bin}
> +}
> +
> +rm -f ${file_out_bin}
> +
> +size=`cat ${file_in} | wc -w`
> +
> +checksum=0
> +i=1
> +for val in `cat ${file_in}`; do
> +    val="0x$val"
> +    if [[ $i == $size ]]; then
> +	# Config_Fresh
> +	print_val 0x01
> +    elif [[ $i == $((size-1)) ]]; then
> +	# Config_Chksum
> +	checksum=$(( (~ checksum + 1) & 0xFF))
> +	print_val $checksum
> +    else
> +	checksum=$((checksum + val))
> +	print_val $val
> +    fi
> +    i=$((i+1))
> +done
> +
> +echo "Wrote ${file_out_bin}"
> +
> +4. Copy the binary config firmware in the appropriate location
> +(e.g. /lib/firmware), using the name goodix_<model>_cfg.bin (e.g.
> for gt911,
> +use goodix_911_cfg.bin).
> +
> +5. Check that the new firmware was successfully written to the
> device
> +after reboot. Config_Fresh is reset to 0 after a successful update
> of the
> +configuration.
> diff --git a/drivers/input/touchscreen/goodix.c
> b/drivers/input/touchscreen/goodix.c
> index 240b16f..2447b73 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -430,6 +430,40 @@ static int goodix_reset(struct goodix_ts_data
> *ts)
>  	return 0;
>  }
>  
> +static ssize_t goodix_dump_config_show(struct device *dev,
> +				       struct device_attribute
> *attr, char *buf)
> +{
> +	struct goodix_ts_data *ts = dev_get_drvdata(dev);
> +	u8 config[GOODIX_CONFIG_MAX_LENGTH];
> +	int error, count = 0, i;
> +
> +	wait_for_completion(&ts->firmware_loading_complete);
> +
> +	error = goodix_i2c_read(ts->client, GOODIX_REG_CONFIG_DATA,
> +				config, ts->cfg_len);
> +	if (error) {
> +		dev_warn(&ts->client->dev,
> +			 "Error reading config (%d)\n",  error);
> +		return error;
> +	}
> +
> +	for (i = 0; i < ts->cfg_len; i++)
> +		count += scnprintf(buf + count, PAGE_SIZE - count,
> "%02x ",
> +				   config[i]);
> +	return count;
> +}
> +
> +static DEVICE_ATTR(dump_config, S_IRUGO, goodix_dump_config_show,
> NULL);
> +
> +static struct attribute *goodix_attrs[] = {
> +	&dev_attr_dump_config.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group goodix_attr_group = {
> +	.attrs = goodix_attrs,
> +};
> +
>  /**
>   * goodix_get_gpio_config - Get GPIO config from ACPI/DT
>   *
> @@ -735,11 +769,22 @@ static int goodix_ts_probe(struct i2c_client
> *client,
>  	ts->cfg_len = goodix_get_cfg_len(ts->id);
>  
>  	if (ts->gpiod_int && ts->gpiod_rst) {
> +		error = sysfs_create_group(&client->dev.kobj,
> +					   &goodix_attr_group);
> +		if (error) {
> +			dev_err(&client->dev,
> +				"Failed to create sysfs group:
> %d\n",
> +				error);
> +			return error;
> +		}
> +
>  		/* update device config */
>  		ts->cfg_name = devm_kasprintf(&client->dev,
> GFP_KERNEL,
>  					      "goodix_%d_cfg.bin",
> ts->id);
> -		if (!ts->cfg_name)
> -			return -ENOMEM;
> +		if (!ts->cfg_name) {
> +			error = -ENOMEM;
> +			goto err_sysfs_remove_group;
> +		}
>  
>  		error = request_firmware_nowait(THIS_MODULE, true,
> ts->cfg_name,
>  						&client->dev,
> GFP_KERNEL, ts,
> @@ -748,7 +793,7 @@ static int goodix_ts_probe(struct i2c_client
> *client,
>  			dev_err(&client->dev,
>  				"Failed to invoke firmware loader:
> %d\n",
>  				error);
> -			return error;
> +			goto err_sysfs_remove_group;
>  		}
>  
>  		return 0;
> @@ -759,14 +804,23 @@ static int goodix_ts_probe(struct i2c_client
> *client,
>  	}
>  
>  	return 0;
> +
> +err_sysfs_remove_group:
> +	if (ts->gpiod_int && ts->gpiod_rst)
> +		sysfs_remove_group(&client->dev.kobj,
> &goodix_attr_group);
> +	return error;
>  }
>  
>  static int goodix_ts_remove(struct i2c_client *client)
>  {
>  	struct goodix_ts_data *ts = i2c_get_clientdata(client);
>  
> -	if (ts->gpiod_int && ts->gpiod_rst)
> -		wait_for_completion(&ts->firmware_loading_complete);
> +	if (!ts->gpiod_int || !ts->gpiod_rst)
> +		return 0;
> +
> +	wait_for_completion(&ts->firmware_loading_complete);
> +
> +	sysfs_remove_group(&client->dev.kobj, &goodix_attr_group);
>  
>  	return 0;
>  }
