From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/7] input: cyapa: add proximity and interrupt sysfs
 interfaces support
Date: Fri, 12 Jun 2015 13:10:21 +0200
Message-ID: <20150612111021.GA24274@localhost>
References: <1434092198-13018-1-git-send-email-dudl@cypress.com>
 <1434092198-13018-6-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34131 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbbFLLK1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Jun 2015 07:10:27 -0400
Content-Disposition: inline
In-Reply-To: <1434092198-13018-6-git-send-email-dudl@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dudley Du <dudl@cypress.com>
Cc: mark.rutland@arm.com, robh+dt@kernel.org, rydberg@euromail.se, bleung@google.com, jmmahler@gmail.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dudley,

On Fri, Jun 12, 2015 at 02:56:36PM +0800, Dudley Du wrote:
> Add proximity and interrupt control interfaces in sysfs device node.
> The proximity interface is used to disable/enable proximity function in device.
> The interrupt interface is used to disbale/enable interrupt from device.

Please explain why you feel that these sysfs interfaces are needed. Why
would one want to disable interrupt for Gen6 devices? And why do we
need to enable/disable proximity function? I'd expect kernel provide the
data and clients to decide if they want to use it or not...

Thanks.

> TEST=test on Chromebook.
> 
> Signed-off-by: Dudley Du <dudl@cypress.com>
> ---
>  drivers/input/mouse/cyapa.c      | 101 +++++++++++++++++++++++++++++++++++++++
>  drivers/input/mouse/cyapa.h      |   4 ++
>  drivers/input/mouse/cyapa_gen3.c |   1 +
>  drivers/input/mouse/cyapa_gen5.c |   2 +
>  drivers/input/mouse/cyapa_gen6.c |  14 ++++++
>  5 files changed, 122 insertions(+)
> 
> diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
> index faead4d..86f2263 100644
> --- a/drivers/input/mouse/cyapa.c
> +++ b/drivers/input/mouse/cyapa.c
> @@ -594,6 +594,7 @@ static int cyapa_initialize(struct cyapa *cyapa)
>  
>  	cyapa->state = CYAPA_STATE_NO_DEVICE;
>  	cyapa->gen = CYAPA_GEN_UNKNOWN;
> +	cyapa->interrupt = true;
>  	mutex_init(&cyapa->state_sync_lock);
>  
>  	/*
> @@ -1217,12 +1218,110 @@ static ssize_t cyapa_show_mode(struct device *dev,
>  	return size;
>  }
>  
> +static ssize_t cyapa_show_interrupt(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct cyapa *cyapa = dev_get_drvdata(dev);
> +	int size;
> +	int error;
> +
> +	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
> +	if (error)
> +		return error;
> +
> +	size = scnprintf(buf, PAGE_SIZE, "%d\n", cyapa->interrupt ? 1 : 0);
> +
> +	mutex_unlock(&cyapa->state_sync_lock);
> +	return size;
> +}
> +
> +static ssize_t cyapa_interrupt_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct cyapa *cyapa = dev_get_drvdata(dev);
> +	u16 value;
> +	int error;
> +
> +	if (cyapa->gen < CYAPA_GEN6)
> +		return -EOPNOTSUPP;
> +
> +	if (kstrtou16(buf, 10, &value)) {
> +		dev_err(dev, "invalid interrupt set parameter\n");
> +		return -EINVAL;
> +	}
> +
> +	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
> +	if (error)
> +		return error;
> +
> +	if (cyapa->operational)
> +		error = cyapa->ops->set_interrupt(cyapa,
> +						  value ? true : false);
> +	else
> +		error = -EBUSY;  /* Still running in bootloader mode. */
> +
> +	mutex_unlock(&cyapa->state_sync_lock);
> +	return error < 0 ? error : count;
> +}
> +
> +static ssize_t cyapa_show_proximity(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct cyapa *cyapa = dev_get_drvdata(dev);
> +	int size;
> +	int error;
> +
> +	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
> +	if (error)
> +		return error;
> +
> +	size = scnprintf(buf, PAGE_SIZE, "%d\n", cyapa->proximity ? 1 : 0);
> +
> +	mutex_unlock(&cyapa->state_sync_lock);
> +	return size;
> +}
> +
> +static ssize_t cyapa_proximity_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct cyapa *cyapa = dev_get_drvdata(dev);
> +	u16 value;
> +	int error;
> +
> +	if (cyapa->gen < CYAPA_GEN5)
> +		return -EOPNOTSUPP;
> +
> +	if (kstrtou16(buf, 10, &value)) {
> +		dev_err(dev, "invalid set value of proximity\n");
> +		return -EINVAL;
> +	}
> +
> +	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
> +	if (error)
> +		return error;
> +
> +	if (cyapa->operational)
> +		error = cyapa->ops->set_proximity(cyapa,
> +						  value ? true : false);
> +	else
> +		error = -EBUSY;  /* Still running in bootloader mode. */
> +
> +	mutex_unlock(&cyapa->state_sync_lock);
> +	return error < 0 ? error : count;
> +}
> +
>  static DEVICE_ATTR(firmware_version, S_IRUGO, cyapa_show_fm_ver, NULL);
>  static DEVICE_ATTR(product_id, S_IRUGO, cyapa_show_product_id, NULL);
>  static DEVICE_ATTR(update_fw, S_IWUSR, NULL, cyapa_update_fw_store);
>  static DEVICE_ATTR(baseline, S_IRUGO, cyapa_show_baseline, NULL);
>  static DEVICE_ATTR(calibrate, S_IWUSR, NULL, cyapa_calibrate_store);
>  static DEVICE_ATTR(mode, S_IRUGO, cyapa_show_mode, NULL);
> +static DEVICE_ATTR(interrupt, S_IRUGO | S_IWUSR,
> +		   cyapa_show_interrupt, cyapa_interrupt_store);
> +static DEVICE_ATTR(proximity, S_IRUGO | S_IWUSR,
> +		   cyapa_show_proximity, cyapa_proximity_store);
>  
>  static struct attribute *cyapa_sysfs_entries[] = {
>  	&dev_attr_firmware_version.attr,
> @@ -1231,6 +1330,8 @@ static struct attribute *cyapa_sysfs_entries[] = {
>  	&dev_attr_baseline.attr,
>  	&dev_attr_calibrate.attr,
>  	&dev_attr_mode.attr,
> +	&dev_attr_interrupt.attr,
> +	&dev_attr_proximity.attr,
>  	NULL,
>  };
>  
> diff --git a/drivers/input/mouse/cyapa.h b/drivers/input/mouse/cyapa.h
> index cc30367..0ce66c5 100644
> --- a/drivers/input/mouse/cyapa.h
> +++ b/drivers/input/mouse/cyapa.h
> @@ -275,6 +275,7 @@ struct cyapa_dev_ops {
>  
>  	int (*set_power_mode)(struct cyapa *, u8, u16, bool);
>  
> +	int (*set_interrupt)(struct cyapa *, bool);
>  	int (*set_proximity)(struct cyapa *, bool);
>  };
>  
> @@ -365,6 +366,9 @@ struct cyapa {
>  	 */
>  	struct mutex state_sync_lock;
>  
> +	bool interrupt;
> +	bool proximity;
> +
>  	const struct cyapa_dev_ops *ops;
>  
>  	union cyapa_cmd_states cmd_states;
> diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
> index 2d077e5..41c40b5 100644
> --- a/drivers/input/mouse/cyapa_gen3.c
> +++ b/drivers/input/mouse/cyapa_gen3.c
> @@ -1244,5 +1244,6 @@ const struct cyapa_dev_ops cyapa_gen3_ops = {
>  	.sort_empty_output_data = cyapa_gen3_empty_output_data,
>  	.set_power_mode = cyapa_gen3_set_power_mode,
>  
> +	.set_interrupt = cyapa_set_not_supported,
>  	.set_proximity = cyapa_set_not_supported,
>  };
> diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
> index 5ab0cd2..c388540 100644
> --- a/drivers/input/mouse/cyapa_gen5.c
> +++ b/drivers/input/mouse/cyapa_gen5.c
> @@ -1544,6 +1544,7 @@ int cyapa_pip_set_proximity(struct cyapa *cyapa, bool enable)
>  		return error < 0 ? error : -EINVAL;
>  	}
>  
> +	cyapa->proximity = enable;
>  	return 0;
>  }
>  
> @@ -2835,5 +2836,6 @@ const struct cyapa_dev_ops cyapa_gen5_ops = {
>  	.sort_empty_output_data = cyapa_empty_pip_output_data,
>  	.set_power_mode = cyapa_gen5_set_power_mode,
>  
> +	.set_interrupt = cyapa_set_not_supported,
>  	.set_proximity = cyapa_pip_set_proximity,
>  };
> diff --git a/drivers/input/mouse/cyapa_gen6.c b/drivers/input/mouse/cyapa_gen6.c
> index 9d76715..6e18c5c 100644
> --- a/drivers/input/mouse/cyapa_gen6.c
> +++ b/drivers/input/mouse/cyapa_gen6.c
> @@ -309,9 +309,22 @@ static int cyapa_gen6_config_dev_irq(struct cyapa *cyapa, u8 cmd_code)
>  			)
>  		return error < 0 ? error : -EINVAL;
>  
> +	if (cmd_code == GEN6_ENABLE_DEV_IRQ)
> +		cyapa->interrupt = true;
> +	else if (cmd_code == GEN6_DISABLE_DEV_IRQ)
> +		cyapa->interrupt = false;
> +
>  	return 0;
>  }
>  
> +static int cyapa_gen6_set_interrupt(struct cyapa *cyapa, bool enable)
> +{
> +	if (enable)
> +		return cyapa_gen6_config_dev_irq(cyapa, GEN6_ENABLE_DEV_IRQ);
> +	else
> +		return cyapa_gen6_config_dev_irq(cyapa, GEN6_DISABLE_DEV_IRQ);
> +}
> +
>  static int cyapa_gen6_set_proximity(struct cyapa *cyapa, bool enable)
>  {
>  	int error;
> @@ -744,5 +757,6 @@ const struct cyapa_dev_ops cyapa_gen6_ops = {
>  	.sort_empty_output_data = cyapa_empty_pip_output_data,
>  	.set_power_mode = cyapa_gen6_set_power_mode,
>  
> +	.set_interrupt = cyapa_gen6_set_interrupt,
>  	.set_proximity = cyapa_gen6_set_proximity,
>  };
> -- 
> 1.9.1
> 
> 
> ---------------------------------------------------------------
> This message and any attachments may contain Cypress (or its
> subsidiaries) confidential information. If it has been received
> in error, please advise the sender and immediately delete this
> message.
> ---------------------------------------------------------------
> 

-- 
Dmitry
