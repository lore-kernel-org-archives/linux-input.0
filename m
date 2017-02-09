From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: synaptics-rmi4 - forward upper mechanical
 buttons to PS/2 guest
Date: Thu, 9 Feb 2017 13:21:31 -0800
Message-ID: <20170209212131.GC8862@dtor-ws>
References: <20170209194911.32442-1-dmitry.torokhov@gmail.com>
 <20170209194911.32442-3-dmitry.torokhov@gmail.com>
 <20170209204808.GA25734@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34611 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753622AbdBIV2u (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Feb 2017 16:28:50 -0500
Content-Disposition: inline
In-Reply-To: <20170209204808.GA25734@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Feb 09, 2017 at 09:48:09PM +0100, Benjamin Tissoires wrote:
> On Feb 09 2017 or thereabouts, Dmitry Torokhov wrote:
> > From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > 
> > On the latest series of ThinkPads, the button events for the TrackPoint
> > are reported through the touchpad itself as opposed to the TrackPoint
> > device. In order to report these buttons properly, we need to forward
> > them to the TrackPoint device and notify psmouse to send the button
> > presses/releases.
> > 
> > Signed-off-by: Lyude Paul <thatslyude@gmail.com>
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > Patchwork-Id: 9560561
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> 
> Hi Dmitry,
> 
> thanks for the follow up on this series.
> 
> I had to add the following hunk to this patch for the buttons to
> actually be forwarded:
> 
> diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.c
> index 938d31e..3422464 100644
> --- a/drivers/input/rmi4/rmi_f30.c
> +++ b/drivers/input/rmi4/rmi_f30.c
> @@ -151,10 +151,13 @@ static int rmi_f30_attention(struct rmi_function *fn, unsigned long *irq_bits)
>                 }
>         }
>  
> -       if (f30->has_gpio)
> +       if (f30->has_gpio) {
>                 for (i = 0; i < f30->gpioled_count; i++)
>                         if (f30->gpioled_key_map[i] != KEY_RESERVED)
>                                 rmi_f30_report_button(fn, f30, i);
> +               if (f30->trackstick_buttons)
> +                       rmi_f03_commit_buttons(f30->f03);
> +       }
>  
>         return 0;
>  }
> ---
> 
> With this hunk added, I tested the series with the synaptics PS/2 path
> and SMBus on a t450s, and the i2c-hid path on a development touchpad.
> All seem to behave well:
> 
> Tested-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thank you Benjamin, I adjusted and pushed.

> 
> Cheers,
> Benjamin
> 
> >  drivers/input/rmi4/rmi_driver.h | 13 ++++++++++
> >  drivers/input/rmi4/rmi_f03.c    | 38 ++++++++++++++++++++++++++++
> >  drivers/input/rmi4/rmi_f30.c    | 55 ++++++++++++++++++++++++++++++-----------
> >  3 files changed, 91 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
> > index 6e0449cdca68..f1a2a2266022 100644
> > --- a/drivers/input/rmi4/rmi_driver.h
> > +++ b/drivers/input/rmi4/rmi_driver.h
> > @@ -107,6 +107,19 @@ int rmi_initial_reset(struct rmi_device *rmi_dev, void *ctx,
> >  
> >  const char *rmi_f01_get_product_ID(struct rmi_function *fn);
> >  
> > +#ifdef CONFIG_RMI4_F03
> > +int rmi_f03_overwrite_button(struct rmi_function *fn, unsigned int button,
> > +			     int value);
> > +void rmi_f03_commit_buttons(struct rmi_function *fn);
> > +#else
> > +static inline int rmi_f03_overwrite_button(struct rmi_function *fn,
> > +					   unsigned int button, int value)
> > +{
> > +	return 0;
> > +}
> > +static inline void rmi_f03_commit_buttons(struct rmi_function *fn) {}
> > +#endif
> > +
> >  #ifdef CONFIG_RMI4_F34
> >  int rmi_f34_create_sysfs(struct rmi_device *rmi_dev);
> >  void rmi_f34_remove_sysfs(struct rmi_device *rmi_dev);
> > diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
> > index 9a1b099b72e0..77dad045a468 100644
> > --- a/drivers/input/rmi4/rmi_f03.c
> > +++ b/drivers/input/rmi4/rmi_f03.c
> > @@ -26,15 +26,53 @@
> >  #define RMI_F03_BYTES_PER_DEVICE_SHIFT	4
> >  #define RMI_F03_QUEUE_LENGTH		0x0F
> >  
> > +#define PSMOUSE_OOB_EXTRA_BTNS		0x01
> > +
> >  struct f03_data {
> >  	struct rmi_function *fn;
> >  
> >  	struct serio *serio;
> >  
> > +	unsigned int overwrite_buttons;
> > +
> >  	u8 device_count;
> >  	u8 rx_queue_length;
> >  };
> >  
> > +int rmi_f03_overwrite_button(struct rmi_function *fn, unsigned int button,
> > +			     int value)
> > +{
> > +	struct f03_data *f03 = dev_get_drvdata(&fn->dev);
> > +	unsigned int bit;
> > +
> > +	if (button < BTN_LEFT || button > BTN_MIDDLE)
> > +		return -EINVAL;
> > +
> > +	bit = BIT(button - BTN_LEFT);
> > +
> > +	if (value)
> > +		f03->overwrite_buttons |= bit;
> > +	else
> > +		f03->overwrite_buttons &= ~bit;
> > +
> > +	return 0;
> > +}
> > +
> > +void rmi_f03_commit_buttons(struct rmi_function *fn)
> > +{
> > +	struct f03_data *f03 = dev_get_drvdata(&fn->dev);
> > +	struct serio *serio = f03->serio;
> > +
> > +	serio_pause_rx(serio);
> > +	if (serio->drv) {
> > +		serio->drv->interrupt(serio, PSMOUSE_OOB_EXTRA_BTNS,
> > +				      SERIO_OOB_DATA);
> > +		serio->drv->interrupt(serio, f03->overwrite_buttons,
> > +				      SERIO_OOB_DATA);
> > +	}
> > +	serio_continue_rx(serio);
> > +}
> > +
> >  static int rmi_f03_pt_write(struct serio *id, unsigned char val)
> >  {
> >  	struct f03_data *f03 = id->port_data;
> > diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.c
> > index c5eb4d034e84..938d31eea19a 100644
> > --- a/drivers/input/rmi4/rmi_f30.c
> > +++ b/drivers/input/rmi4/rmi_f30.c
> > @@ -48,6 +48,9 @@
> >  					+ 1				\
> >  					+ 1)
> >  
> > +#define TRACKSTICK_RANGE_START		3
> > +#define TRACKSTICK_RANGE_END		6
> > +
> >  struct rmi_f30_ctrl_data {
> >  	int address;
> >  	int length;
> > @@ -76,6 +79,9 @@ struct f30_data {
> >  	u16 *gpioled_key_map;
> >  
> >  	struct input_dev *input;
> > +
> > +	struct rmi_function *f03;
> > +	bool trackstick_buttons;
> >  };
> >  
> >  static int rmi_f30_read_control_parameters(struct rmi_function *fn,
> > @@ -100,13 +106,20 @@ static void rmi_f30_report_button(struct rmi_function *fn,
> >  {
> >  	unsigned int reg_num = button >> 3;
> >  	unsigned int bit_num = button & 0x07;
> > +	u16 key_code = f30->gpioled_key_map[button];
> >  	bool key_down = !(f30->data_regs[reg_num] & BIT(bit_num));
> >  
> > -	rmi_dbg(RMI_DEBUG_FN, &fn->dev,
> > -		"%s: call input report key (0x%04x) value (0x%02x)",
> > -		__func__, f30->gpioled_key_map[button], key_down);
> > +	if (f30->trackstick_buttons &&
> > +	    button >= TRACKSTICK_RANGE_START &&
> > +	    button <= TRACKSTICK_RANGE_END) {
> > +		rmi_f03_overwrite_button(f30->f03, key_code, key_down);
> > +	} else {
> > +		rmi_dbg(RMI_DEBUG_FN, &fn->dev,
> > +			"%s: call input report key (0x%04x) value (0x%02x)",
> > +			__func__, key_code, key_down);
> >  
> > -	input_report_key(f30->input, f30->gpioled_key_map[button], key_down);
> > +		input_report_key(f30->input, key_code, key_down);
> > +	}
> >  }
> >  
> >  static int rmi_f30_attention(struct rmi_function *fn, unsigned long *irq_bits)
> > @@ -154,6 +167,12 @@ static int rmi_f30_config(struct rmi_function *fn)
> >  				rmi_get_platform_data(fn->rmi_dev);
> >  	int error;
> >  
> > +	if (pdata->f30_data.trackstick_buttons) {
> > +		/* Try [re-]establish link to F03. */
> > +		f30->f03 = rmi_find_function(fn->rmi_dev, 0x03);
> > +		f30->trackstick_buttons = f30->f03 != NULL;
> > +	}
> > +
> >  	if (pdata->f30_data.disable) {
> >  		drv->clear_irq_bits(fn->rmi_dev, fn->irq_mask);
> >  	} else {
> > @@ -203,6 +222,8 @@ static int rmi_f30_map_gpios(struct rmi_function *fn,
> >  					rmi_get_platform_data(fn->rmi_dev);
> >  	struct input_dev *input = f30->input;
> >  	unsigned int button = BTN_LEFT;
> > +	unsigned int trackstick_button = BTN_LEFT;
> > +	bool button_mapped = false;
> >  	int i;
> >  
> >  	f30->gpioled_key_map = devm_kcalloc(&fn->dev,
> > @@ -215,19 +236,16 @@ static int rmi_f30_map_gpios(struct rmi_function *fn,
> >  	}
> >  
> >  	for (i = 0; i < f30->gpioled_count; i++) {
> > -		if (rmi_f30_is_valid_button(i, f30->ctrl)) {
> > +		if (!rmi_f30_is_valid_button(i, f30->ctrl))
> > +			continue;
> > +
> > +		if (pdata->f30_data.trackstick_buttons &&
> > +		    i >= TRACKSTICK_RANGE_START && i < TRACKSTICK_RANGE_END) {
> > +			f30->gpioled_key_map[i] = trackstick_button++;
> > +		} else if (!pdata->f30_data.buttonpad || !button_mapped) {
> >  			f30->gpioled_key_map[i] = button;
> >  			input_set_capability(input, EV_KEY, button++);
> > -
> > -			/*
> > -			 * buttonpad might be given by
> > -			 * f30->has_mech_mouse_btns, but I am
> > -			 * not sure, so use only the pdata info
> > -			 */
> > -			if (pdata->f30_data.buttonpad) {
> > -				__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> > -				break;
> > -			}
> > +			button_mapped = true;
> >  		}
> >  	}
> >  
> > @@ -235,6 +253,13 @@ static int rmi_f30_map_gpios(struct rmi_function *fn,
> >  	input->keycodesize = sizeof(f30->gpioled_key_map[0]);
> >  	input->keycodemax = f30->gpioled_count;
> >  
> > +	/*
> > +	 * Buttonpad could be also inferred from f30->has_mech_mouse_btns,
> > +	 * but I am not sure, so use only the pdata info.
> > +	 */
> > +	if (pdata->f30_data.buttonpad)
> > +		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> > +
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.11.0.483.g087da7b7c-goog
> > 

-- 
Dmitry
