From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH v2 4/7] Input: synaptics-rmi4 - store the attn data in the
 driver
Date: Fri, 2 Dec 2016 16:34:01 -0800
Message-ID: <bbf10707-4be9-1b87-8c75-a3e930146c58@synaptics.com>
References: <1480678916-6469-1-git-send-email-benjamin.tissoires@redhat.com>
 <1480678916-6469-5-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480678916-6469-5-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Lyude Paul <thatslyude@gmail.com>, Nick Dyer <nick@shmanahar.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 12/02/2016 03:41 AM, Benjamin Tissoires wrote:
> Now that we have a proper API to set the attention data, there is
> no point in keeping it in the transport driver.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Reviewed-by: Andrew Duggan <aduggan@synaptics.com>

> ---
>
> no changes in v2
> ---
>   drivers/input/rmi4/rmi_driver.c |  5 ++---
>   drivers/input/rmi4/rmi_f03.c    | 13 +++++++------
>   drivers/input/rmi4/rmi_f11.c    | 12 ++++++------
>   drivers/input/rmi4/rmi_f12.c    | 43 +++++++++++++++++++++--------------------
>   drivers/input/rmi4/rmi_f30.c    | 11 ++++++-----
>   include/linux/rmi.h             |  5 ++---
>   6 files changed, 45 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 85062e4..05a3c4b 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -155,7 +155,7 @@ static int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
>   	if (!data)
>   		return 0;
>   
> -	if (!rmi_dev->xport->attn_data) {
> +	if (!data->attn_data.data) {
>   		error = rmi_read_block(rmi_dev,
>   				data->f01_container->fd.data_base_addr + 1,
>   				data->irq_status, data->num_of_irq_regs);
> @@ -223,8 +223,7 @@ static irqreturn_t rmi_irq_fn(int irq, void *dev_id)
>   	count = kfifo_get(&drvdata->attn_fifo, &attn_data);
>   	if (count) {
>   		*(drvdata->irq_status) = attn_data.irq_status;
> -		rmi_dev->xport->attn_data = attn_data.data;
> -		rmi_dev->xport->attn_size = attn_data.size;
> +		drvdata->attn_data = attn_data;
>   	}
>   
>   	ret = rmi_process_interrupt_requests(rmi_dev);
> diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
> index 06279cd..996dcbb 100644
> --- a/drivers/input/rmi4/rmi_f03.c
> +++ b/drivers/input/rmi4/rmi_f03.c
> @@ -166,6 +166,7 @@ static int rmi_f03_config(struct rmi_function *fn)
>   static int rmi_f03_attention(struct rmi_function *fn, unsigned long *irq_bits)
>   {
>   	struct rmi_device *rmi_dev = fn->rmi_dev;
> +	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
>   	struct f03_data *f03 = dev_get_drvdata(&fn->dev);
>   	u16 data_addr = fn->fd.data_base_addr;
>   	const u8 ob_len = f03->rx_queue_length * RMI_F03_OB_SIZE;
> @@ -176,20 +177,20 @@ static int rmi_f03_attention(struct rmi_function *fn, unsigned long *irq_bits)
>   	int i;
>   	int ret;
>   
> -	if (!rmi_dev || !rmi_dev->xport)
> +	if (!rmi_dev)
>   		return -ENODEV;
>   
> -	if (rmi_dev->xport->attn_data) {
> +	if (drvdata->attn_data.data) {
>   		/* First grab the data passed by the transport device */
> -		if (rmi_dev->xport->attn_size < ob_len) {
> +		if (drvdata->attn_data.size < ob_len) {
>   			dev_warn(&fn->dev, "F03 interrupted, but data is missing!\n");
>   			return 0;
>   		}
>   
> -		memcpy(obs, rmi_dev->xport->attn_data, ob_len);
> +		memcpy(obs, drvdata->attn_data.data, ob_len);
>   
> -		rmi_dev->xport->attn_data += ob_len;
> -		rmi_dev->xport->attn_size -= ob_len;
> +		drvdata->attn_data.data += ob_len;
> +		drvdata->attn_data.size -= ob_len;
>   	} else {
>   		/* Grab all of the data registers, and check them for data */
>   		ret = rmi_read_block(fn->rmi_dev, data_addr + RMI_F03_OB_OFFSET,
> diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
> index 44fc275..bc5e37f 100644
> --- a/drivers/input/rmi4/rmi_f11.c
> +++ b/drivers/input/rmi4/rmi_f11.c
> @@ -1284,19 +1284,19 @@ static int rmi_f11_attention(struct rmi_function *fn, unsigned long *irq_bits)
>   	int error;
>   	int valid_bytes = f11->sensor.pkt_size;
>   
> -	if (rmi_dev->xport->attn_data) {
> +	if (drvdata->attn_data.data) {
>   		/*
>   		 * The valid data in the attention report is less then
>   		 * expected. Only process the complete fingers.
>   		 */
> -		if (f11->sensor.attn_size > rmi_dev->xport->attn_size)
> -			valid_bytes = rmi_dev->xport->attn_size;
> +		if (f11->sensor.attn_size > drvdata->attn_data.size)
> +			valid_bytes = drvdata->attn_data.size;
>   		else
>   			valid_bytes = f11->sensor.attn_size;
> -		memcpy(f11->sensor.data_pkt, rmi_dev->xport->attn_data,
> +		memcpy(f11->sensor.data_pkt, drvdata->attn_data.data,
>   			valid_bytes);
> -		rmi_dev->xport->attn_data += f11->sensor.attn_size;
> -		rmi_dev->xport->attn_size -= f11->sensor.attn_size;
> +		drvdata->attn_data.data += f11->sensor.attn_size;
> +		drvdata->attn_data.size -= f11->sensor.attn_size;
>   	} else {
>   		error = rmi_read_block(rmi_dev,
>   				data_base_addr, f11->sensor.data_pkt,
> diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
> index 82a4964..8c5360c 100644
> --- a/drivers/input/rmi4/rmi_f12.c
> +++ b/drivers/input/rmi4/rmi_f12.c
> @@ -208,19 +208,20 @@ static int rmi_f12_attention(struct rmi_function *fn,
>   {
>   	int retval;
>   	struct rmi_device *rmi_dev = fn->rmi_dev;
> +	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
>   	struct f12_data *f12 = dev_get_drvdata(&fn->dev);
>   	struct rmi_2d_sensor *sensor = &f12->sensor;
>   	int valid_bytes = sensor->pkt_size;
>   
> -	if (rmi_dev->xport->attn_data) {
> -		if (sensor->attn_size > rmi_dev->xport->attn_size)
> -			valid_bytes = rmi_dev->xport->attn_size;
> +	if (drvdata->attn_data.data) {
> +		if (sensor->attn_size > drvdata->attn_data.size)
> +			valid_bytes = drvdata->attn_data.size;
>   		else
>   			valid_bytes = sensor->attn_size;
> -		memcpy(sensor->data_pkt, rmi_dev->xport->attn_data,
> +		memcpy(sensor->data_pkt, drvdata->attn_data.data,
>   			valid_bytes);
> -		rmi_dev->xport->attn_data += sensor->attn_size;
> -		rmi_dev->xport->attn_size -= sensor->attn_size;
> +		drvdata->attn_data.data += sensor->attn_size;
> +		drvdata->attn_data.size -= sensor->attn_size;
>   	} else {
>   		retval = rmi_read_block(rmi_dev, f12->data_addr,
>   					sensor->data_pkt, sensor->pkt_size);
> @@ -323,7 +324,7 @@ static int rmi_f12_probe(struct rmi_function *fn)
>   	const struct rmi_register_desc_item *item;
>   	struct rmi_2d_sensor *sensor;
>   	struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
> -	struct rmi_transport_dev *xport = rmi_dev->xport;
> +	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
>   	u16 data_offset = 0;
>   
>   	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s\n", __func__);
> @@ -422,7 +423,7 @@ static int rmi_f12_probe(struct rmi_function *fn)
>   	 * HID attention reports.
>   	 */
>   	item = rmi_get_register_desc_item(&f12->data_reg_desc, 0);
> -	if (item && !xport->attn_data)
> +	if (item && !drvdata->attn_data.data)
>   		data_offset += item->reg_size;
>   
>   	item = rmi_get_register_desc_item(&f12->data_reg_desc, 1);
> @@ -436,15 +437,15 @@ static int rmi_f12_probe(struct rmi_function *fn)
>   	}
>   
>   	item = rmi_get_register_desc_item(&f12->data_reg_desc, 2);
> -	if (item && !xport->attn_data)
> +	if (item && !drvdata->attn_data.data)
>   		data_offset += item->reg_size;
>   
>   	item = rmi_get_register_desc_item(&f12->data_reg_desc, 3);
> -	if (item && !xport->attn_data)
> +	if (item && !drvdata->attn_data.data)
>   		data_offset += item->reg_size;
>   
>   	item = rmi_get_register_desc_item(&f12->data_reg_desc, 4);
> -	if (item && !xport->attn_data)
> +	if (item && !drvdata->attn_data.data)
>   		data_offset += item->reg_size;
>   
>   	item = rmi_get_register_desc_item(&f12->data_reg_desc, 5);
> @@ -456,22 +457,22 @@ static int rmi_f12_probe(struct rmi_function *fn)
>   	}
>   
>   	item = rmi_get_register_desc_item(&f12->data_reg_desc, 6);
> -	if (item && !xport->attn_data) {
> +	if (item && !drvdata->attn_data.data) {
>   		f12->data6 = item;
>   		f12->data6_offset = data_offset;
>   		data_offset += item->reg_size;
>   	}
>   
>   	item = rmi_get_register_desc_item(&f12->data_reg_desc, 7);
> -	if (item && !xport->attn_data)
> +	if (item && !drvdata->attn_data.data)
>   		data_offset += item->reg_size;
>   
>   	item = rmi_get_register_desc_item(&f12->data_reg_desc, 8);
> -	if (item && !xport->attn_data)
> +	if (item && !drvdata->attn_data.data)
>   		data_offset += item->reg_size;
>   
>   	item = rmi_get_register_desc_item(&f12->data_reg_desc, 9);
> -	if (item && !xport->attn_data) {
> +	if (item && !drvdata->attn_data.data) {
>   		f12->data9 = item;
>   		f12->data9_offset = data_offset;
>   		data_offset += item->reg_size;
> @@ -480,27 +481,27 @@ static int rmi_f12_probe(struct rmi_function *fn)
>   	}
>   
>   	item = rmi_get_register_desc_item(&f12->data_reg_desc, 10);
> -	if (item && !xport->attn_data)
> +	if (item && !drvdata->attn_data.data)
>   		data_offset += item->reg_size;
>   
>   	item = rmi_get_register_desc_item(&f12->data_reg_desc, 11);
> -	if (item && !xport->attn_data)
> +	if (item && !drvdata->attn_data.data)
>   		data_offset += item->reg_size;
>   
>   	item = rmi_get_register_desc_item(&f12->data_reg_desc, 12);
> -	if (item && !xport->attn_data)
> +	if (item && !drvdata->attn_data.data)
>   		data_offset += item->reg_size;
>   
>   	item = rmi_get_register_desc_item(&f12->data_reg_desc, 13);
> -	if (item && !xport->attn_data)
> +	if (item && !drvdata->attn_data.data)
>   		data_offset += item->reg_size;
>   
>   	item = rmi_get_register_desc_item(&f12->data_reg_desc, 14);
> -	if (item && !xport->attn_data)
> +	if (item && !drvdata->attn_data.data)
>   		data_offset += item->reg_size;
>   
>   	item = rmi_get_register_desc_item(&f12->data_reg_desc, 15);
> -	if (item && !xport->attn_data) {
> +	if (item && !drvdata->attn_data.data) {
>   		f12->data15 = item;
>   		f12->data15_offset = data_offset;
>   		data_offset += item->reg_size;
> diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.c
> index f696137..f4b491e 100644
> --- a/drivers/input/rmi4/rmi_f30.c
> +++ b/drivers/input/rmi4/rmi_f30.c
> @@ -99,6 +99,7 @@ static int rmi_f30_attention(struct rmi_function *fn, unsigned long *irq_bits)
>   {
>   	struct f30_data *f30 = dev_get_drvdata(&fn->dev);
>   	struct rmi_device *rmi_dev = fn->rmi_dev;
> +	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
>   	int retval;
>   	int gpiled = 0;
>   	int value = 0;
> @@ -109,15 +110,15 @@ static int rmi_f30_attention(struct rmi_function *fn, unsigned long *irq_bits)
>   		return 0;
>   
>   	/* Read the gpi led data. */
> -	if (rmi_dev->xport->attn_data) {
> -		if (rmi_dev->xport->attn_size < f30->register_count) {
> +	if (drvdata->attn_data.data) {
> +		if (drvdata->attn_data.size < f30->register_count) {
>   			dev_warn(&fn->dev, "F30 interrupted, but data is missing\n");
>   			return 0;
>   		}
> -		memcpy(f30->data_regs, rmi_dev->xport->attn_data,
> +		memcpy(f30->data_regs, drvdata->attn_data.data,
>   			f30->register_count);
> -		rmi_dev->xport->attn_data += f30->register_count;
> -		rmi_dev->xport->attn_size -= f30->register_count;
> +		drvdata->attn_data.data += f30->register_count;
> +		drvdata->attn_data.size -= f30->register_count;
>   	} else {
>   		retval = rmi_read_block(rmi_dev, fn->fd.data_base_addr,
>   			f30->data_regs, f30->register_count);
> diff --git a/include/linux/rmi.h b/include/linux/rmi.h
> index 1d48656..ac910f7 100644
> --- a/include/linux/rmi.h
> +++ b/include/linux/rmi.h
> @@ -272,9 +272,6 @@ struct rmi_transport_dev {
>   	struct rmi_device_platform_data pdata;
>   
>   	struct input_dev *input;
> -
> -	void *attn_data;
> -	int attn_size;
>   };
>   
>   /**
> @@ -364,6 +361,8 @@ struct rmi_driver_data {
>   
>   	bool enabled;
>   	struct mutex enabled_mutex;
> +
> +	struct rmi4_attn_data attn_data;
>   	DECLARE_KFIFO(attn_fifo, struct rmi4_attn_data, 16);
>   };
>   
