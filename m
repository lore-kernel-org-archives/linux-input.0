From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 05/18] Input: synaptics-rmi4 - Add support for
 controlling dribble packets in F12
Date: Tue, 8 Nov 2016 17:02:31 -0800
Message-ID: <20161109010231.GJ8719@dtor-ws>
References: <1476373872-18027-1-git-send-email-benjamin.tissoires@redhat.com>
 <1476373872-18027-6-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33327 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbcKIBCf (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2016 20:02:35 -0500
Content-Disposition: inline
In-Reply-To: <1476373872-18027-6-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Oct 13, 2016 at 05:50:59PM +0200, Benjamin Tissoires wrote:
> From: Andrew Duggan <aduggan@synaptics.com>
> 
> Implements reading and setting the dribble bit in F12's control registers.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> 
> ---
> 
> new in v3
> ---
>  drivers/input/rmi4/rmi_f12.c | 73 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
> index 767ac79..f79a785 100644
> --- a/drivers/input/rmi4/rmi_f12.c
> +++ b/drivers/input/rmi4/rmi_f12.c
> @@ -31,6 +31,7 @@ enum rmi_f12_object_type {
>  struct f12_data {
>  	struct rmi_2d_sensor sensor;
>  	struct rmi_2d_sensor_platform_data sensor_pdata;
> +	bool has_dribble;
>  
>  	u16 data_addr;
>  
> @@ -239,12 +240,79 @@ static int rmi_f12_attention(struct rmi_function *fn,
>  	return 0;
>  }
>  
> +static int rmi_f12_write_control_regs(struct rmi_function *fn)
> +{
> +	int ret;
> +	const struct rmi_register_desc_item *item;
> +	struct rmi_device *rmi_dev = fn->rmi_dev;
> +	struct f12_data *f12 = dev_get_drvdata(&fn->dev);
> +	int control_size;
> +	char buf[3];
> +	u16 control_offset = 0;
> +	u8 subpacket_offset = 0;
> +
> +	if (f12->has_dribble
> +	    && (f12->sensor.dribble != RMI_REG_STATE_DEFAULT)) {
> +		item = rmi_get_register_desc_item(&f12->control_reg_desc, 20);
> +		if (item) {
> +			control_offset = rmi_register_desc_calc_reg_offset(
> +						&f12->control_reg_desc, 20);
> +
> +			/*
> +			 * The byte containing the EnableDribble bit will be
> +			 * in either byte 0 or byte 2 of control 20. Depending
> +			 * on the existence of subpacket 0. If control 20 is
> +			 * larger then 3 bytes, just read the first 3.
> +			 */
> +			if (item->reg_size >= 3)
> +				control_size = 3;
> +			else
> +				control_size = item->reg_size;

Changed to
			control_size = min(item->reg_size, 3UL);

> +
> +			ret = rmi_read_block(rmi_dev, fn->fd.control_base_addr
> +					+ control_offset, buf, control_size);
> +			if (ret)
> +				return ret;
> +
> +			if (rmi_register_desc_has_subpacket(item, 0))
> +				subpacket_offset += 1;
> +
> +			switch (f12->sensor.dribble) {
> +			case RMI_REG_STATE_OFF:
> +				buf[subpacket_offset] &= ~BIT(2);
> +				break;
> +			case RMI_REG_STATE_ON:
> +				buf[subpacket_offset] |= BIT(2);
> +				break;
> +			case RMI_REG_STATE_DEFAULT:
> +			default:
> +				break;
> +			}
> +
> +			ret = rmi_write_block(rmi_dev,
> +				fn->fd.control_base_addr + control_offset,
> +				buf, control_size);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +
> +}
> +
>  static int rmi_f12_config(struct rmi_function *fn)
>  {
>  	struct rmi_driver *drv = fn->rmi_dev->driver;
> +	int ret;
>  
>  	drv->set_irq_bits(fn->rmi_dev, fn->irq_mask);
>  
> +	ret = rmi_f12_write_control_regs(fn);
> +	if (ret)
> +		dev_warn(&fn->dev,
> +			"Failed to write F12 control registers: %d\n", ret);
> +
>  	return 0;
>  }
>  
> @@ -271,7 +339,7 @@ static int rmi_f12_probe(struct rmi_function *fn)
>  	}
>  	++query_addr;
>  
> -	if (!(buf & 0x1)) {
> +	if (!(buf & BIT(0))) {
>  		dev_err(&fn->dev,
>  			"Behavior of F12 without register descriptors is undefined.\n");
>  		return -ENODEV;
> @@ -281,6 +349,8 @@ static int rmi_f12_probe(struct rmi_function *fn)
>  	if (!f12)
>  		return -ENOMEM;
>  
> +	f12->has_dribble = !!(buf & BIT(3));
> +
>  	if (fn->dev.of_node) {
>  		ret = rmi_2d_sensor_of_probe(&fn->dev, &f12->sensor_pdata);
>  		if (ret)
> @@ -329,6 +399,7 @@ static int rmi_f12_probe(struct rmi_function *fn)
>  
>  	sensor->x_mm = f12->sensor_pdata.x_mm;
>  	sensor->y_mm = f12->sensor_pdata.y_mm;
> +	sensor->dribble = f12->sensor_pdata.dribble;
>  
>  	if (sensor->sensor_type == rmi_sensor_default)
>  		sensor->sensor_type =
> -- 
> 2.7.4
> 

-- 
Dmitry
