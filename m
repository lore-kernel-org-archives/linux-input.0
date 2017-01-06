From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: drv260x - Add capability of playing custom
 waveform
Date: Fri, 6 Jan 2017 12:15:50 -0800
Message-ID: <20170106201550.GA16763@dtor-ws>
References: <1481689739-1815-1-git-send-email-jkwang@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35477 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdAFUPy (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 6 Jan 2017 15:15:54 -0500
Received: by mail-pf0-f194.google.com with SMTP id f144so1465687pfa.2
        for <linux-input@vger.kernel.org>; Fri, 06 Jan 2017 12:15:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1481689739-1815-1-git-send-email-jkwang@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingkui Wang <jkwang@google.com>
Cc: linux-input@vger.kernel.org, Dan Murphy <dmurphy@ti.com>

Hi Jingkui,

On Tue, Dec 13, 2016 at 08:28:59PM -0800, Jingkui Wang wrote:
> When the device does not contain ROM library (device: drv2605,
> drv2605l), it contains a RAM (device:drv2604, drv2605l) and support
> playing custom defined waveform. This change implement the custom
> waveform playback by adding a input device for those device and allowing
> user to upload custom wave from through ff_custom. Waveform will loaded
> to ram and later played by user.
> 
> Signed-off-by: Jingkui Wang <jkwang@google.com>
> ---
>  drivers/input/misc/drv260x.c | 426 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 395 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> index 885c140..880421a 100644
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c
> @@ -62,7 +62,10 @@
>  #define DRV260X_LRA_LOOP_PERIOD	0x20
>  #define DRV260X_VBAT_MON		0x21
>  #define DRV260X_LRA_RES_PERIOD	0x22
> -#define DRV260X_MAX_REG			0x23
> +#define DRV260X_RAM_ADDR_UB		0xfd
> +#define DRV260X_RAM_ADDR_LB		0xfe
> +#define DRV260X_RAM_DATA		0xff
> +#define DRV260X_MAX_REG			0xff
>  
>  #define DRV260X_GO_BIT				0x01
>  
> @@ -174,12 +177,70 @@
>  #define DRV260X_AUTOCAL_TIME_500MS		(2 << 4)
>  #define DRV260X_AUTOCAL_TIME_1000MS		(3 << 4)
>  
> +/* For custom effect device */
> +#define DRV260X_MAX_EFFECT_NUM			10
> +#define DRV260X_MAX_WF_LEN			20
> +
> +/**
> + * struct drv260x_wf_header -
> + * @start_addr_upper - upper byte of start address
> + * @start_addr_lower - lower byte of start address
> + * @effect_size - size of the effect
> + * @waveform_repeats - waveform repeat time
> + **/
> +struct __attribute__((__packed__)) drv260x_wf_header {

I do not think you want attribute here and not after structure
definition. GCC attribute rules are weird.

> +	unsigned int start_addr_upper : 8;
> +	unsigned int start_addr_lower : 8;
> +	unsigned int effect_size : 5;
> +	unsigned int waveform_repeats : 3;

Is this how hardware expects to see the data? Unfortunately this will
break on big endian arches because order of bitfields is different. You
are better off not using bitfields if possible, or do #ifdef
__BIG_ENDIAN_BITFIELD.

> +};
> +
> +/**
> + * struct drv260x_wf_data -
> + * @voltage - voltage for this time period
> + * @ramp - linear ramp between this time period and next time period
> + * @time - time for this voltage
> + **/
> +struct __attribute__((__packed__)) drv260x_wf_data {
> +	unsigned int voltage : 7;
> +	unsigned int ramp : 1;
> +	unsigned int time : 8;
> +};
> +
> +/**
> + * struct drv260x_wf
> + * @header - header for the waveform
> + * @data - data for the waveform
> + **/
> +struct drv260x_wf {
> +	struct drv260x_wf_header header;
> +	struct drv260x_wf_data data[DRV260X_MAX_WF_LEN];
> +};
> +
> +/**
> + * struct drv260x_work_params -
> + * @param_lock - Spinlock to write/read param
> + * @upload_wf - Param for the upload job
> + * @playback_wf_id - Id for the playback job
> + * @rtp_magnitude - Param for the rtp job
> + **/
> +struct drv260x_work_params {
> +	spinlock_t param_lock;
> +	struct drv260x_wf upload_wf[DRV260X_MAX_EFFECT_NUM];
> +	int playback_wf_id;
> +	u32 rtp_magnitude;
> +};
> +
>  /**
>   * struct drv260x_data -
> - * @input_dev - Pointer to the input device
> + * @rtp_input_dev - Pointer to the real time playback input device
> + * @wfp_input_dev - Pointer to the waveform playback input device

Do we really need 2 separate devices? It would be great if we combined
them together. Otherwise how doe sthis work if I try to use both devices
simultaneously?

>   * @client - Pointer to the I2C client
>   * @regmap - Register map of the device
> - * @work - Work item used to off load the enable/disable of the vibration
> + * @work_params - Used to pass the parameter for the works
> + * @rtp_work - Work item used to off load the enable/disable of the vibration
> + * @wfp_upload_work - Work item used to upload custom waveform
> + * @wfp_playback_work - Work item used to playback custom waveform
>   * @enable_gpio - Pointer to the gpio used for enable/disabling
>   * @regulator - Pointer to the regulator for the IC
>   * @magnitude - Magnitude of the vibration event
> @@ -189,10 +250,14 @@
>   * @overdriver_voltage - The over drive voltage of the actuator
>  **/
>  struct drv260x_data {
> -	struct input_dev *input_dev;
> +	struct input_dev *rtp_input_dev;
> +	struct input_dev *wfp_input_dev;
>  	struct i2c_client *client;
>  	struct regmap *regmap;
> -	struct work_struct work;
> +	struct drv260x_work_params work_params;
> +	struct work_struct rtp_work;
> +	struct work_struct wfp_upload_work;
> +	struct work_struct wfp_playback_work;
>  	struct gpio_desc *enable_gpio;
>  	struct regulator *regulator;
>  	u32 magnitude;
> @@ -238,6 +303,9 @@ static const struct reg_default drv260x_reg_defs[] = {
>  	{ DRV260X_LRA_LOOP_PERIOD, 0x33 },
>  	{ DRV260X_VBAT_MON, 0x00 },
>  	{ DRV260X_LRA_RES_PERIOD, 0x00 },
> +	{ DRV260X_RAM_ADDR_UB, 0x00 },
> +	{ DRV260X_RAM_ADDR_LB, 0x00 },
> +	{ DRV260X_RAM_DATA, 0x00 },
>  };
>  
>  #define DRV260X_DEF_RATED_VOLT		0x90
> @@ -254,10 +322,18 @@ static int drv260x_calculate_voltage(unsigned int voltage)
>  	return (voltage * 255 / 5600);
>  }
>  
> -static void drv260x_worker(struct work_struct *work)
> +static void drv260x_rtp_worker(struct work_struct *work)
>  {
> -	struct drv260x_data *haptics = container_of(work, struct drv260x_data, work);
> +	struct drv260x_data *haptics = container_of(work,
> +						struct drv260x_data,
> +						rtp_work);
>  	int error;
> +	u32 magnitude;
> +
> +	spin_lock_irq(&haptics->work_params.param_lock);
> +	magnitude = haptics->work_params.rtp_magnitude;
> +	haptics->work_params.rtp_magnitude = 0;
> +	spin_unlock_irq(&haptics->work_params.param_lock);
>  
>  	gpiod_set_value(haptics->enable_gpio, 1);
>  	/* Data sheet says to wait 250us before trying to communicate */
> @@ -270,38 +346,44 @@ static void drv260x_worker(struct work_struct *work)
>  			"Failed to write set mode: %d\n", error);
>  	} else {
>  		error = regmap_write(haptics->regmap,
> -				     DRV260X_RT_PB_IN, haptics->magnitude);
> +				     DRV260X_RT_PB_IN, magnitude);
>  		if (error)
>  			dev_err(&haptics->client->dev,
>  				"Failed to set magnitude: %d\n", error);
>  	}
>  }
>  
> -static int drv260x_haptics_play(struct input_dev *input, void *data,
> +static int drv260x_rtp_play(struct input_dev *input, void *data,
>  				struct ff_effect *effect)
>  {
> +	unsigned long spinlock_flag;
> +	u32 magnitude;
>  	struct drv260x_data *haptics = input_get_drvdata(input);
>  
>  	haptics->mode = DRV260X_LRA_NO_CAL_MODE;
>  
>  	if (effect->u.rumble.strong_magnitude > 0)
> -		haptics->magnitude = effect->u.rumble.strong_magnitude;
> +		magnitude = effect->u.rumble.strong_magnitude;
>  	else if (effect->u.rumble.weak_magnitude > 0)
> -		haptics->magnitude = effect->u.rumble.weak_magnitude;
> +		magnitude = effect->u.rumble.weak_magnitude;
>  	else
> -		haptics->magnitude = 0;
> +		magnitude = 0;
>  
> -	schedule_work(&haptics->work);
> +	spin_lock_irqsave(&haptics->work_params.param_lock, spinlock_flag);
> +	haptics->work_params.rtp_magnitude = magnitude;
> +	spin_unlock_irqrestore(&haptics->work_params.param_lock, spinlock_flag);
> +
> +	schedule_work(&haptics->rtp_work);
>  
>  	return 0;
>  }
>  
> -static void drv260x_close(struct input_dev *input)
> +static void drv260x_rtp_close(struct input_dev *input)
>  {
>  	struct drv260x_data *haptics = input_get_drvdata(input);
>  	int error;
>  
> -	cancel_work_sync(&haptics->work);
> +	cancel_work_sync(&haptics->rtp_work);
>  
>  	error = regmap_write(haptics->regmap, DRV260X_MODE, DRV260X_STANDBY);
>  	if (error)
> @@ -311,6 +393,215 @@ static void drv260x_close(struct input_dev *input)
>  	gpiod_set_value(haptics->enable_gpio, 0);
>  }
>  
> +static inline int drv260x_set_ram_addr(struct drv260x_data *haptics,
> +					unsigned int addr)
> +{
> +	int error;
> +	u8 addr_h, addr_l;
> +
> +	addr_h = (addr & 0xff00) >> 8;
> +	addr_l = addr & 0xff;
> +
> +	error = regmap_write(haptics->regmap, DRV260X_RAM_ADDR_UB, addr_h);
> +	if (error)
> +		return error;
> +
> +	error = regmap_write(haptics->regmap,
> +				DRV260X_RAM_ADDR_LB, addr_l);
> +	if (error)
> +		return error;
> +
> +	return 0;
> +}
> +
> +static int drv260x_write_ram(struct drv260x_data *haptics,
> +				unsigned int addr, int len, const void *data)
> +{
> +	int error;
> +	const u8 *data_byte = data;
> +
> +	drv260x_set_ram_addr(haptics, addr);
> +
> +	while (len > 0) {
> +		error = regmap_write(haptics->regmap,
> +					DRV260X_RAM_DATA, *data_byte++);
> +		if (error) {
> +			dev_err(&haptics->client->dev,
> +				"Failed to write register %x\n",
> +				DRV260X_RAM_DATA);
> +			return error;
> +		}
> +		--len;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline int get_header_addr(int effect_id)
> +{
> +	/* as datasheet header start from ram address 1 */
> +	return 1 + sizeof(struct drv260x_wf_header) * effect_id;
> +}
> +
> +static inline int get_wf_addr(int effect_id)
> +{
> +	/* waveform data start after last header */
> +	return get_header_addr(DRV260X_MAX_EFFECT_NUM) +
> +				effect_id *
> +				sizeof(struct drv260x_wf_data) *
> +				DRV260X_MAX_WF_LEN;
> +}
> +
> +static void drv260x_upload_worker(struct work_struct *work)
> +{
> +	int i, wf_start_addr;
> +	struct drv260x_wf wf;
> +	struct drv260x_data *haptics = container_of(work,
> +						struct drv260x_data,
> +						wfp_upload_work);
> +
> +	spin_lock_irq(&haptics->work_params.param_lock);
> +	for (i = 0; i < DRV260X_MAX_EFFECT_NUM; i++) {
> +		if (haptics->work_params.upload_wf[i].header.effect_size) {
> +			wf = haptics->work_params.upload_wf[i];
> +			haptics->work_params.
> +				upload_wf[i].header.effect_size = 0;
> +			break;
> +		}
> +	}
> +	spin_unlock_irq(&haptics->work_params.param_lock);
> +
> +	if (i == DRV260X_MAX_EFFECT_NUM)
> +		goto error_out;
> +
> +	if (wf.header.effect_size > DRV260X_MAX_WF_LEN)
> +		goto error_out;
> +
> +	wf_start_addr = get_wf_addr(i);
> +	wf.header.start_addr_upper = (u8) ((wf_start_addr & 0xff00) >> 8);
> +	wf.header.start_addr_lower = (u8) wf_start_addr & 0xff;
> +
> +	/* write header */
> +	if (drv260x_write_ram(haptics,
> +				get_header_addr(i),
> +				sizeof(struct drv260x_wf_header),
> +				&wf.header))
> +		goto error_out;
> +
> +	/* write waveform */
> +	if (drv260x_write_ram(haptics,
> +				wf_start_addr,
> +				sizeof(wf.data),
> +				&wf.data))
> +		goto error_out;
> +
> +	return;
> +error_out:
> +	dev_err(&haptics->client->dev, "Fail to upload effect");
> +
> +}
> +
> +static int drv260x_upload_effect(struct input_dev *dev,
> +				 struct ff_effect *effect,
> +				 struct ff_effect *old)
> +{
> +	unsigned long spinlock_flag;
> +	int error;
> +	struct drv260x_wf wf;
> +	struct drv260x_data *haptics = input_get_drvdata(dev);
> +
> +	error = copy_from_user(&wf, effect->u.periodic.custom_data, sizeof(wf));
> +

Extra empty line.

> +	if (error)
> +		return -EINVAL;

Why EINVAL and nor EFAULT?

> +
> +	/* effect size is wf data_len * 2 since every seg is 2 bytes */
> +	if (wf.header.effect_size >
> +		sizeof(struct drv260x_wf_data) * DRV260X_MAX_WF_LEN)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&haptics->work_params.param_lock, spinlock_flag);
> +	haptics->work_params.upload_wf[effect->id] = wf;
> +	spin_unlock_irqrestore(&haptics->work_params.param_lock, spinlock_flag);
> +
> +	schedule_work(&haptics->wfp_upload_work);

Why do you use work to write effect? You can sleep in this function.
That is why you can do copy_from_user() here.


> +	return 0;
> +}
> +
> +static void drv260x_playback_worker(struct work_struct *work)
> +{
> +	int error, wf_id;
> +	struct drv260x_data *haptics = container_of(work,
> +						struct drv260x_data,
> +						wfp_playback_work);
> +
> +	spin_lock_irq(&haptics->work_params.param_lock);
> +	wf_id = haptics->work_params.playback_wf_id;
> +	spin_unlock_irq(&haptics->work_params.param_lock);

I'd do "wf_id = READ_ONCE(haptics->work_params.playback_wf_id);"
and dropped spinlock.


> +
> +	/*
> +	 * Setup Mode
> +	 * The waveform is triggered internally by go bit
> +	 */
> +	error = regmap_write(haptics->regmap,
> +				DRV260X_MODE, DRV260X_INTERNAL_TRIGGER);
> +	if (error)
> +		goto error_out;
> +
> +	/*
> +	 * Setup sequencer
> +	 * The device will play starting from seq_1 and end when it meet id = 0
> +	 */
> +	error = regmap_write(haptics->regmap,
> +				DRV260X_WV_SEQ_1, wf_id);
> +	if (error)
> +		goto error_out;
> +
> +	error = regmap_write(haptics->regmap,
> +				DRV260X_WV_SEQ_2, 0);
> +	if (error)
> +		goto error_out;
> +
> +	/*
> +	 * GO bit triggers the waveform playback
> +	 */
> +	error = regmap_write(haptics->regmap,
> +				DRV260X_GO, DRV260X_GO_BIT);
> +	if (error)
> +		goto error_out;
> +
> +	return;
> +error_out:
> +	dev_err(&haptics->client->dev, "playback fail to write reg\n");
> +}
> +
> +static int drv260x_playback(struct input_dev *dev,
> +				int effect_id,
> +				int value)
> +{
> +	unsigned long spinlock_flag;
> +	struct drv260x_data *haptics = input_get_drvdata(dev);
> +
> +	spin_lock_irqsave(&haptics->work_params.param_lock, spinlock_flag);
> +	/*
> +	 * effect_id of input subsystem start from 0 while
> +	 * waveform id of the device start from 1
> +	 */
> +	haptics->work_params.playback_wf_id = effect_id + 1;

Can you upload and play several effects?

> +	spin_unlock_irqrestore(&haptics->work_params.param_lock, spinlock_flag);
> +	schedule_work(&haptics->wfp_playback_work);
> +
> +	return 0;
> +}
> +
> +static void drv260x_wfp_device_close(struct input_dev *input)
> +{
> +	struct drv260x_data *haptics = input_get_drvdata(input);
> +
> +	cancel_work_sync(&haptics->wfp_upload_work);
> +	cancel_work_sync(&haptics->wfp_playback_work);
> +}
> +
>  static const struct reg_sequence drv260x_lra_cal_regs[] = {
>  	{ DRV260X_MODE, DRV260X_AUTO_CAL },
>  	{ DRV260X_CTRL3, DRV260X_NG_THRESH_2 },
> @@ -466,6 +757,65 @@ static const struct regmap_config drv260x_regmap_config = {
>  	.cache_type = REGCACHE_NONE,
>  };
>  
> +static int drv260x_ram_init(struct drv260x_data *haptics)
> +{
> +	int error;
> +
> +	/*
> +	 * According to the device spec, the first byte of the ram should
> +	 * be zero. This is done by first set the UB and LB of ram addr reg,
> +	 * then write 0 to ram_data reg.
> +	 */
> +	drv260x_set_ram_addr(haptics, 0);
> +
> +	error = regmap_write(haptics->regmap,
> +				DRV260X_RAM_DATA, 0);
> +	if (error)
> +		return error;
> +
> +	return 0;
> +}
> +
> +static int drv260x_wfp_device_init(struct i2c_client *client,
> +					struct drv260x_data *haptics)
> +{
> +	int error;
> +	struct input_dev *input_dev;
> +	struct ff_device *ff;
> +
> +	input_dev = devm_input_allocate_device(&client->dev);
> +	if (!input_dev)
> +		return -ENOMEM;
> +
> +	input_dev->name = "drv260x custom waveform";
> +
> +	input_dev->close = drv260x_wfp_device_close;
> +	input_set_drvdata(input_dev, haptics);
> +
> +	set_bit(FF_CUSTOM, input_dev->ffbit);
> +	set_bit(FF_PERIODIC, input_dev->ffbit);
> +
> +	error = input_ff_create(input_dev, DRV260X_MAX_EFFECT_NUM);
> +	if (error)
> +		return error;
> +
> +	ff = input_dev->ff;
> +	ff->upload = drv260x_upload_effect;
> +	ff->playback = drv260x_playback;
> +	error = input_register_device(input_dev);
> +	if (error)
> +		return error;
> +
> +	haptics->wfp_input_dev = input_dev;
> +	INIT_WORK(&haptics->wfp_upload_work, drv260x_upload_worker);
> +	INIT_WORK(&haptics->wfp_playback_work, drv260x_playback_worker);
> +
> +	if (drv260x_ram_init(haptics))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int drv260x_read_device_property(struct device *dev,
>  			    struct drv260x_data *haptics)
>  {
> @@ -558,26 +908,27 @@ static int drv260x_probe(struct i2c_client *client,
>  	if (IS_ERR(haptics->enable_gpio))
>  		return PTR_ERR(haptics->enable_gpio);
>  
> -	haptics->input_dev = devm_input_allocate_device(&client->dev);
> -	if (!haptics->input_dev) {
> +	haptics->rtp_input_dev = devm_input_allocate_device(&client->dev);
> +	if (!haptics->rtp_input_dev) {
>  		dev_err(&client->dev, "Failed to allocate input device\n");
>  		return -ENOMEM;
>  	}
>  
> -	haptics->input_dev->name = "drv260x:haptics";
> -	haptics->input_dev->close = drv260x_close;
> -	input_set_drvdata(haptics->input_dev, haptics);
> -	input_set_capability(haptics->input_dev, EV_FF, FF_RUMBLE);
> +	haptics->rtp_input_dev->name = "drv260x:haptics";
> +	haptics->rtp_input_dev->close = drv260x_rtp_close;
> +	input_set_drvdata(haptics->rtp_input_dev, haptics);
> +	input_set_capability(haptics->rtp_input_dev, EV_FF, FF_RUMBLE);
>  
> -	error = input_ff_create_memless(haptics->input_dev, NULL,
> -					drv260x_haptics_play);
> +	error = input_ff_create_memless(haptics->rtp_input_dev, NULL,
> +					drv260x_rtp_play);
>  	if (error) {
>  		dev_err(&client->dev, "input_ff_create() failed: %d\n",
>  			error);
>  		return error;
>  	}
>  
> -	INIT_WORK(&haptics->work, drv260x_worker);
> +	spin_lock_init(&haptics->work_params.param_lock);
> +	INIT_WORK(&haptics->rtp_work, drv260x_rtp_worker);
>  
>  	haptics->client = client;
>  	i2c_set_clientdata(client, haptics);
> @@ -596,13 +947,26 @@ static int drv260x_probe(struct i2c_client *client,
>  		return error;
>  	}
>  
> -	error = input_register_device(haptics->input_dev);
> +	error = input_register_device(haptics->rtp_input_dev);
>  	if (error) {
>  		dev_err(&client->dev, "couldn't register input device: %d\n",
>  			error);
>  		return error;
>  	}
>  
> +	/*
> +	 * For drv260x device, if there is no pre-loaded library, it should
> +	 * support custom waveform
> +	 */
> +	if (haptics->library == DRV260X_LIB_EMPTY) {
> +		error = drv260x_wfp_device_init(client, haptics);
> +		if (error) {
> +			dev_err(&client->dev,
> +				"fail to init waveform playback device: %d\n",
> +				error);
> +			return error;
> +		}
> +	}
>  	return 0;
>  }
>  
> @@ -611,9 +975,9 @@ static int __maybe_unused drv260x_suspend(struct device *dev)
>  	struct drv260x_data *haptics = dev_get_drvdata(dev);
>  	int ret = 0;
>  
> -	mutex_lock(&haptics->input_dev->mutex);
> +	mutex_lock(&haptics->rtp_input_dev->mutex);
>  
> -	if (haptics->input_dev->users) {
> +	if (haptics->rtp_input_dev->users) {

What about 2nd device here?

>  		ret = regmap_update_bits(haptics->regmap,
>  					 DRV260X_MODE,
>  					 DRV260X_STANDBY_MASK,
> @@ -634,7 +998,7 @@ static int __maybe_unused drv260x_suspend(struct device *dev)
>  		}
>  	}
>  out:
> -	mutex_unlock(&haptics->input_dev->mutex);
> +	mutex_unlock(&haptics->rtp_input_dev->mutex);
>  	return ret;
>  }
>  
> @@ -643,9 +1007,9 @@ static int __maybe_unused drv260x_resume(struct device *dev)
>  	struct drv260x_data *haptics = dev_get_drvdata(dev);
>  	int ret = 0;
>  
> -	mutex_lock(&haptics->input_dev->mutex);
> +	mutex_lock(&haptics->rtp_input_dev->mutex);
>  
> -	if (haptics->input_dev->users) {
> +	if (haptics->rtp_input_dev->users) {
>  		ret = regulator_enable(haptics->regulator);
>  		if (ret) {
>  			dev_err(dev, "Failed to enable regulator\n");
> @@ -665,7 +1029,7 @@ static int __maybe_unused drv260x_resume(struct device *dev)
>  	}
>  
>  out:
> -	mutex_unlock(&haptics->input_dev->mutex);
> +	mutex_unlock(&haptics->rtp_input_dev->mutex);
>  	return ret;
>  }
>  
> -- 
> 2.6.6
> 

Thanks.

-- 
Dmitry
