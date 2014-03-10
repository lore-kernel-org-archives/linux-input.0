From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH 05/05] input synaptics-rmi4: Add reflash support
Date: Mon, 10 Mar 2014 09:24:41 -0700
Message-ID: <20140310162440.GE18578@sonymobile.com>
References: <1394245795-17347-1-git-send-email-cheiny@synaptics.com>
 <1394245795-17347-5-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:17809 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752204AbaCJQWs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2014 12:22:48 -0400
Content-Disposition: inline
In-Reply-To: <1394245795-17347-5-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Sat, Mar 08, 2014 at 03:29:55AM +0100, Christopher Heiny wrote:
> Add support for reflashing V5 bootloader firmwares into
> RMI4 devices.

Throughout this driver: I'm not sure of the name 'reflash'. Maybe just
'flash(ing)'?

> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Signed-off-by: Vincent Huang <vincent.huang@tw.synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Linux Walleij <linus.walleij@linaro.org>
> Cc: David Herrmann <dh.herrmann@gmail.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> 
> ---
> 
>  drivers/input/rmi4/Kconfig         |   9 +
>  drivers/input/rmi4/Makefile        |   1 +
>  drivers/input/rmi4/rmi_bus.c       |   3 +
>  drivers/input/rmi4/rmi_driver.h    |  11 +
>  drivers/input/rmi4/rmi_fw_update.c | 961 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 985 insertions(+)
> 
> diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
> index d0c7b6e..9b88b6a 100644
> --- a/drivers/input/rmi4/Kconfig
> +++ b/drivers/input/rmi4/Kconfig
> @@ -25,6 +25,15 @@ config RMI4_DEBUG
> 
>           If unsure, say N.
> 
> +config RMI4_FWLIB

Err. LIB?

> +       bool "RMI4 Firmware Update"
> +       depends on RMI4_CORE
> +       help
> +         Say Y here to enable in-kernel firmware update capability.
> +
> +         Add support to the RMI4 core to enable reflashing of device
> +         firmware.

Please provide more description here of what someone is supposed to do
to utilize this support, and what it actually does.  The term "update"
here is generic enough to cause some confusion. 

> +
>  config RMI4_I2C
>         tristate "RMI4 I2C Support"
>         depends on RMI4_CORE && I2C
> diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
> index 5c6bad5..570ea80 100644
> --- a/drivers/input/rmi4/Makefile
> +++ b/drivers/input/rmi4/Makefile
> @@ -1,5 +1,6 @@
>  obj-$(CONFIG_RMI4_CORE) += rmi_core.o
>  rmi_core-y := rmi_bus.o rmi_driver.o rmi_f01.o
> +rmi_core-$(CONFIG_RMI4_FWLIB) += rmi_fw_update.o

Ok.  Now I'm thoroughly confused, and I haven't even gotten to the code
yet.  FWLIB => rmi_fw_update => rmi_reflash.  What are we doing again?

> 
>  # Function drivers
>  obj-$(CONFIG_RMI4_F11) += rmi_f11.o
> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> index 6e0454a..3c93d08 100644
> --- a/drivers/input/rmi4/rmi_bus.c
> +++ b/drivers/input/rmi4/rmi_bus.c
> @@ -117,6 +117,8 @@ int rmi_register_transport_device(struct rmi_transport_dev *xport)
>         if (error)
>                 goto err_put_device;
> 
> +       rmi_reflash_init(rmi_dev);
> +
>         dev_dbg(xport->dev, "%s: Registered %s as %s.\n", __func__,
>                 pdata->sensor_name, dev_name(&rmi_dev->dev));
> 
> @@ -139,6 +141,7 @@ void rmi_unregister_transport_device(struct rmi_transport_dev *xport)
>         struct rmi_device *rmi_dev = xport->rmi_dev;
> 
>         device_del(&rmi_dev->dev);
> +       rmi_reflash_cleanup(rmi_dev);
>         rmi_physical_teardown_debugfs(rmi_dev);
>         put_device(&rmi_dev->dev);
>  }
> diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
[...]
> +#ifdef CONFIG_RMI4_FWLIB
> +void rmi_reflash_init(struct rmi_device *rmi_dev);
> +void rmi_reflash_cleanup(struct rmi_device *rmi_dev);
> +#else
> +#define rmi_reflash_init(rmi_dev)
> +#define rmi_reflash_cleanup(rmi_dev)

Please use static inline functions here.  It helps the compiler tell
you when you do something wrong.

> +#endif
> 
>  #endif
> diff --git a/drivers/input/rmi4/rmi_fw_update.c b/drivers/input/rmi4/rmi_fw_update.c
[...]
> +struct rmi_reflash_data {
> +       struct rmi_device *rmi_dev;
> +       bool force;
> +       ulong busy;
> +       char name_buf[RMI_NAME_BUFFER_SIZE];
> +       char *img_name;

const?

> +       struct pdt_entry f01_pdt;
> +       struct f01_basic_properties f01_props;
> +       u8 device_status;
> +       struct pdt_entry f34_pdt;
> +       u8 bootloader_id[2];
> +       struct rmi_f34_queries f34_queries;
> +       u16 f34_status_address;
> +       struct rmi_f34_control_status f34_controls;
> +       const u8 *firmware_data;
> +       const u8 *config_data;
> +       struct work_struct reflash_work;
> +};
[...]
> +static int rmi_read_f01_status(struct rmi_reflash_data *data)
> +{
> +       int retval;
> +
> +       retval = rmi_read(data->rmi_dev, data->f01_pdt.data_base_addr,
> +                         &data->device_status);
> +       if (retval)
> +               return retval;
> +
> +       return 0;
> +}

This function is used one time, just calls rmi_read... There's no need
to wrap this read.

[...]
> +static int rmi_wait_for_idle(struct rmi_reflash_data *data, int timeout_ms)
> +{
> +       int timeout_count = ((timeout_ms * 1000) / RMI_MAX_SLEEP_TIME_US) + 1;
> +       int count = 0;
> +       struct rmi_f34_control_status *controls = &data->f34_controls;
> +       int retval;
> +
> +       do {
> +               if (count || timeout_count == 1)
> +                       usleep_range(RMI_MIN_SLEEP_TIME_US,
> +                                    RMI_MAX_SLEEP_TIME_US);
> +               retval = rmi_read_f34_controls(data);
> +               count++;
> +               if (retval)
> +                       continue;
> +               else if (IS_IDLE(controls)) {
> +                       if (dev_WARN_ONCE(&data->rmi_dev->dev,
> +                                         !data->f34_controls.program_enabled,
> +                                         "Reflash is idle but program_enabled bit isn't set.\n"
> +                                         ))
> +                               /*
> +                                * This works around a bug in certain device
> +                                * firmwares, where the idle state is reached,
> +                                * but the program_enabled bit is not yet set.
> +                                */

If it's a bug in devices, but it's ok to try again as a workaround, is
there a good reason to print a stacktrace?  Does the user care?

> +                               continue;
> +                       return 0;
> +               }
> +       } while (count < timeout_count);
> +
> +       dev_err(&data->rmi_dev->dev,
> +               "ERROR: Timeout waiting for idle status.\n");
> +       dev_err(&data->rmi_dev->dev, "Command: %#04x\n", controls->command);
> +       dev_err(&data->rmi_dev->dev, "Status:  %#04x\n", controls->status);
> +       dev_err(&data->rmi_dev->dev, "Enabled: %d\n",
> +                       controls->program_enabled);
> +       dev_err(&data->rmi_dev->dev, "Idle:    %d\n", IS_IDLE(controls));
> +       return -ETIMEDOUT;
> +}
[...]
> +static int rmi_write_f34_command(struct rmi_reflash_data *data, u8 command)
> +{
> +       int retval;
> +       struct rmi_device *rmi_dev = data->rmi_dev;
> +
> +       retval = rmi_write(rmi_dev, data->f34_status_address, command);
> +       if (retval < 0) {
> +               dev_err(&rmi_dev->dev,
> +                       "Failed to write F34 command %#04x. Code: %d.\n",
> +                       command, retval);
> +               return retval;
> +       }
> +
> +       return 0;
> +}

This function is used three times, and calls one function without any
wrapping magic.  You could easily call rmi_write in each place.

[...]
> +static void rmi_reset_device(struct rmi_reflash_data *data)

It really feels like this should have an error return.

> +{
> +       int retval;
> +       const struct rmi_device_platform_data *pdata =
> +                               rmi_get_platform_data(data->rmi_dev);
> +
> +       dev_dbg(&data->rmi_dev->dev, "Resetting...\n");
> +       retval = rmi_write(data->rmi_dev, data->f01_pdt.command_base_addr,
> +                          RMI_F01_CMD_DEVICE_RESET);
> +       if (retval < 0)
> +               dev_warn(&data->rmi_dev->dev,
> +                        "WARNING - post-flash reset failed, code: %d.\n",
> +                        retval);
> +       msleep(pdata->reset_delay_ms ?: RMI_F01_DEFAULT_RESET_DELAY_MS);
> +       dev_dbg(&data->rmi_dev->dev, "Reset completed.\n");
> +}

> +static int rmi_write_firmware(struct rmi_reflash_data *data)
> +{
> +       return rmi_write_blocks(data, (u8 *) data->firmware_data,
> +               data->f34_queries.fw_block_count, RMI_F34_WRITE_FW_BLOCK);
> +}

Called once.

> +
> +static int rmi_write_configuration(struct rmi_reflash_data *data)
> +{
> +       return rmi_write_blocks(data, (u8 *) data->config_data,
> +               data->f34_queries.config_block_count,
> +               RMI_F34_WRITE_CONFIG_BLOCK);
> +}

Called once.

> +
> +static void rmi_reflash_firmware(struct rmi_reflash_data *data)

Also feels like this should have an error return.

[...]
> +static void rmi_fw_update(struct rmi_device *rmi_dev)

Same.

> +{
[...]
> +       retval = rmi_read_f34_queries(data);
> +       if (retval) {
> +               dev_err(&rmi_dev->dev, "F34 queries failed, code = %d.\n",
> +                       retval);
> +               goto done;
> +       }
> +       if (data->img_name && strlen(data->img_name))

data->img_name && data->img_name[0] ?  No need to waste extra cycles.

> +               snprintf(firmware_name, RMI_NAME_BUFFER_SIZE,
> +                        rmi_fw_name_format, data->img_name);
> +       else if (pdata->firmware_name && strlen(pdata->firmware_name))

Same.

> +               snprintf(firmware_name, RMI_NAME_BUFFER_SIZE,
> +                        rmi_fw_name_format, pdata->firmware_name);
> +       else {
> +               if (!strlen(data->f01_props.product_id)) {

Same.

> +                       dev_err(&rmi_dev->dev, "Product ID is missing or empty - will not reflash.\n");
> +                       goto done;
> +               }
> +               snprintf(firmware_name, RMI_NAME_BUFFER_SIZE,
> +                        rmi_fw_name_format, data->f01_props.product_id);
> +       }
[...]
> +       if (rmi_go_nogo(data, header)) {
> +               dev_dbg(&rmi_dev->dev, "Go/NoGo said go.\n");
> +               rmi_free_function_list(rmi_dev);
> +               rmi_reflash_firmware(data);
> +               rmi_reset_device(data);
> +               rmi_driver_detect_functions(rmi_dev);
> +       } else
> +               dev_dbg(&rmi_dev->dev, "Go/NoGo said don't reflash.\n");

Documentation/CodingStyle says:
} else {
	...
}

[...]
> +}
[...]
> +static ssize_t rmi_reflash_force_store(struct device *dev,
> +                                      struct device_attribute *attr,
> +                                      const char *buf, size_t count)
> +{
> +       struct rmi_device *rmi_dev = to_rmi_device(dev);
> +       struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
> +       struct rmi_reflash_data *data = drv_data->reflash_data;
> +       int retval;
> +       unsigned long val;
> +
> +       if (test_and_set_bit(0, &data->busy))
> +               return -EBUSY;
> +
> +       retval = kstrtoul(buf, 10, &val);
> +       if (retval)
> +               count = retval;
> +       else
> +               data->force = !!val;

Hrm. Perhaps '42' doesn't make sense here.  Maybe add:

else if (val > 1)
	count = -EINVAL;

> +
> +       clear_bit(0, &data->busy);
> +
> +       return count;
> +}
> +
> +static ssize_t rmi_reflash_show(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       struct rmi_device *rmi_dev = to_rmi_device(dev);
> +       struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
> +       struct rmi_reflash_data *data = drv_data->reflash_data;
> +
> +       return snprintf(buf, PAGE_SIZE, "%u\n", test_bit(0, &data->busy));
> +}
> +
> +static ssize_t rmi_reflash_store(struct device *dev,
> +                                struct device_attribute *attr,
> +                                const char *buf, size_t count)
> +{
> +       int retval;
> +       unsigned long val;
> +       struct rmi_device *rmi_dev = to_rmi_device(dev);
> +       struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
> +       struct rmi_reflash_data *data = drv_data->reflash_data;
> +
> +       retval = kstrtoul(buf, 10, &val);
> +       if (retval)
> +               return retval;
> +
> +       if (test_and_set_bit(0, &data->busy))
> +               return -EBUSY;
> +
> +       if (val)
> +               /*
> +                * TODO: Here we start a work thread to go do the reflash, but
> +                * maybe we can just use request_firmware_timeout().
> +                */

Mmm.. Yes.  It would make the lifecycle of this busy bit much more
obvious.  Otherwise perhaps call request_firmware_nowait() ?  It already
does this work queue ... uh ... work for you.

> +               schedule_work(&data->reflash_work);
> +       else
> +               clear_bit(0, &data->busy);
> +
> +       return count;
> +}
[...]
> +void rmi_reflash_init(struct rmi_device *rmi_dev)
> +{
> +       int error;
> +       struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
> +       struct rmi_reflash_data *data;
> +
> +       dev_dbg(&rmi_dev->dev, "%s called.\n", __func__);
> +
> +       data = devm_kzalloc(&rmi_dev->dev, sizeof(struct rmi_reflash_data),
> +                           GFP_KERNEL);

The memory ownership here is odd.  Maybe kzalloc, and just return that
data?

> +
> +       error = sysfs_create_group(&rmi_dev->dev.kobj, &rmi_reflash_attributes);
> +       if (error) {
> +               dev_warn(&rmi_dev->dev, "Failed to create reflash sysfs attributes.\n");
> +               return;
> +       }
> +
> +       INIT_WORK(&data->reflash_work, rmi_reflash_work);
> +       data->rmi_dev = rmi_dev;
> +       drv_data->reflash_data = data;
> +}
> +
> +void rmi_reflash_cleanup(struct rmi_device *rmi_dev)
> +{
> +       struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
> +       struct rmi_reflash_data *data = drv_data->reflash_data;
> +
> +       sysfs_remove_group(&rmi_dev->dev.kobj, &rmi_reflash_attributes);
> +       devm_kfree(&rmi_dev->dev, data);

Who owns this memory again? devm_ doesn't seem right for this use-case.

> +}

-Courtney
