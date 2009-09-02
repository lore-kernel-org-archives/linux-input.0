From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/2] add ad714x input driver for
	button/scrollwhell/slider/touchpad
Date: Tue, 1 Sep 2009 18:51:30 -0700
Message-ID: <200909011851.31383.david-b@pacbell.net>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com>
	<1251777330-16994-2-git-send-email-21cnbao@gmail.com>
	<1251777330-16994-3-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1251777330-16994-3-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dtor-JGs/UdohzUI@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Monday 31 August 2009, Barry Song wrote:
> +
> +#define AD714x_SPI_ADDR        0x1C
> +#define AD714x_SPI_ADDR_SHFT   11
> +#define AD714x_SPI_READ        1
> +#define AD714x_SPI_READ_SHFT   10

Confusing; it is not an address but a fixed bit pattern
flagging command words.  Be less opaque; maybe

  #define AD714x_CMD_PREFIX       0xe000   /* bits 15:11 */
  #define AD714x_READ             BIT(10)


> +#if defined(CONFIG_INPUT_AD714X_SPI)
> +#define bus_device		struct spi_device
> +#elif defined(CONFIG_INPUT_AD714X_I2C)
> +#define bus_device		struct i2c_client
> +#else
> +#error Communication method needs to be selected (I2C or SPI)
> +#endif

Best to allow both interfaces in the same kernel, for build
tests and kernels that can run on more than one board.

The way that works in some contexts is to record

	struct device *dev;

(or somesuch) in the driver state struct and use it pretty much
everywhere (including dev_* messaging!) except bus-related code
which uses to_i2c_client() or to_spi_device() to get the right
pointer view.

And the (missing) Kconfig would depend on "SPI || I2C"; and this
driver would register (and unregister) either or both driver
facets depending on which were possible.  (Someone might even
provide stubs for the I2C=n or SPI=n cases, to let such drivers
avoid #ifdeffery.  Someday.)


> +	pr_debug("slider %d absolute position:%d\n", idx, sw->abs_pos);

You should use the dev_*() functions not pr_*().


> +#define RIGHT_END_POINT_DETECTION_LEVEL			750
> +#define LEFT_RIGHT_END_POINT_DEAVTIVALION_LEVEL		850
> +#define TOP_END_POINT_DETECTION_LEVEL			550
> +#define BOTTOM_END_POINT_DETECTION_LEVEL		950
> +#define TOP_BOTTOM_END_POINT_DEAVTIVALION_LEVEL		700
> +static int touchpad_check_endpoint(struct ad714x_chip *ad714x, int idx)
> +{

Here and elsewhere:  whitespace between CPP directives and
the Real Code (tm), please...


> +#define MAX_DEVICE_NUM 8
> +static int __devinit ad714x_probe(struct ad714x_chip *ad714x)
> +{
> +	int ret = 0;
> +	struct input_dev *input[MAX_DEVICE_NUM];
> +
> +	struct ad714x_driver_data *drv_data = NULL;
> +
> +	struct ad714x_button_plat *bt_plat   = ad714x->hw->button;
> +	struct ad714x_slider_plat *sd_plat   = ad714x->hw->slider;
> +	struct ad714x_wheel_plat *wl_plat    = ad714x->hw->wheel;
> +	struct ad714x_touchpad_plat *tp_plat = ad714x->hw->touchpad;
> +
> +	struct ad714x_button_drv *bt_drv   = NULL;
> +	struct ad714x_slider_drv *sd_drv   = NULL;
> +	struct ad714x_wheel_drv *wl_drv    = NULL;
> +	struct ad714x_touchpad_drv *tp_drv = NULL;
> +
> +	int alloc_idx = 0, reg_idx = 0;
> +	int i;
> +
> +	ret = ad714x_hw_detect(ad714x);
> +	if (ret)
> +		goto det_err;
> +
> +	/*
> +	 * Allocate and register AD714x input device
> +	 */
> +
> +	drv_data = kzalloc(sizeof(struct ad714x_driver_data), GFP_KERNEL);

drv_data is not an input device.


> +	if (!drv_data) {
> +		dev_err(&ad714x->bus->dev,
> +			"Can't allocate memory for ad714x driver info\n");
> +		ret = -ENOMEM;
> +		goto fail_alloc_reg;
> +	}
> +	ad714x->sw = drv_data;
> +
> +	/* a slider uses one input_dev instance */
> +	if (ad714x->hw->slider_num > 0) {
> +		sd_drv = kzalloc(sizeof(struct ad714x_slider_drv) *
> +				ad714x->hw->slider_num, GFP_KERNEL);
> +		if (!sd_drv) {
> +			dev_err(&ad714x->bus->dev,
> +				"Can't allocate memory for slider info\n");
> +			ret = -ENOMEM;
> +			goto fail_alloc_reg;
> +		}
> +
> +		for (i = 0; i < ad714x->hw->slider_num; i++) {
> +			input[alloc_idx] = input_allocate_device();
> +			if (!input[alloc_idx]) {
> +				dev_err(&ad714x->bus->dev,
> +				"Can't allocate input device %d\n", alloc_idx);
> +				ret = -ENOMEM;
> +				goto fail_alloc_reg;
> +			}
> +			alloc_idx++;
> +
> +			__set_bit(EV_ABS, input[alloc_idx-1]->evbit);
> +			__set_bit(ABS_X, input[alloc_idx-1]->absbit);
> +			__set_bit(ABS_PRESSURE, input[alloc_idx-1]->absbit);
> +			input_set_abs_params(input[alloc_idx-1], ABS_X, 0,
> +					sd_plat->max_coord, 0, 0);
> +			input_set_abs_params(input[alloc_idx-1], ABS_PRESSURE,
> +				0, 1, 0, 0);
> +
> +			input[alloc_idx-1]->id.bustype = BUS_I2C;

This could be SPI instead... and there are some fields you
forgot to set.  Like the ones putting this into the device tree
in the right spot, and some identifiers...

Take that bus type code as an input param to this function.


> +
> +			ret = input_register_device(input[reg_idx]);
> +			if (ret) {
> +				dev_err(&ad714x->bus->dev,
> +				"Failed to register AD714x input device!\n");
> +				goto fail_alloc_reg;
> +			}
> +			reg_idx++;
> +
> +			sd_drv[i].input = input[alloc_idx-1];
> +			ad714x->sw->slider = sd_drv;
> +		}
> +	}
> +
> +	/* a wheel uses one input_dev instance */
> +	if (ad714x->hw->wheel_num > 0) {
> +		wl_drv = kzalloc(sizeof(struct ad714x_wheel_drv) *
> +				ad714x->hw->wheel_num, GFP_KERNEL);
> +		if (!wl_drv) {
> +			dev_err(&ad714x->bus->dev,
> +				"Can't allocate memory for wheel info\n");
> +			ret = -ENOMEM;
> +			goto fail_alloc_reg;
> +		}
> +
> +		for (i = 0; i < ad714x->hw->wheel_num; i++) {
> +			input[alloc_idx] = input_allocate_device();
> +			if (!input[alloc_idx]) {
> +				dev_err(&ad714x->bus->dev,
> +				"Can't allocate input device %d\n", alloc_idx);
> +				ret = -ENOMEM;
> +				goto fail_alloc_reg;
> +			}
> +			alloc_idx++;
> +
> +			__set_bit(EV_ABS, input[alloc_idx-1]->evbit);
> +			__set_bit(ABS_WHEEL, input[alloc_idx-1]->absbit);
> +			__set_bit(ABS_PRESSURE, input[alloc_idx-1]->absbit);
> +			input_set_abs_params(input[alloc_idx-1], ABS_WHEEL, 0,
> +					wl_plat->max_coord, 0, 0);
> +			input_set_abs_params(input[alloc_idx-1], ABS_PRESSURE,
> +				0, 1, 0, 0);
> +
> +			input[alloc_idx-1]->id.bustype = BUS_I2C;

Same as above:  it's not necessarily I2C, and there are important
fields left uninitialized.  Probably worth abstracting that setup
into some kind of helper.


> +
> +			ret = input_register_device(input[reg_idx]);
> +			if (ret) {
> +				dev_err(&ad714x->bus->dev,
> +				"Failed to register AD714x input device!\n");
> +				goto fail_alloc_reg;
> +			}
> +			reg_idx++;
> +
> +			wl_drv[i].input = input[alloc_idx-1];
> +			ad714x->sw->wheel = wl_drv;
> +		}
> +	}
> +
> +	/* a touchpad uses one input_dev instance */
> +	if (ad714x->hw->touchpad_num > 0) {
> +		tp_drv = kzalloc(sizeof(struct ad714x_touchpad_drv) *
> +				ad714x->hw->touchpad_num, GFP_KERNEL);
> +		if (!tp_drv) {
> +			dev_err(&ad714x->bus->dev,
> +				"Can't allocate memory for touchpad info\n");
> +			ret = -ENOMEM;
> +			goto fail_alloc_reg;
> +		}
> +
> +		for (i = 0; i < ad714x->hw->touchpad_num; i++) {
> +			input[alloc_idx] = input_allocate_device();
> +			if (!input[alloc_idx]) {
> +				dev_err(&ad714x->bus->dev,
> +					"Can't allocate input device %d\n",
> +					alloc_idx);
> +				ret = -ENOMEM;
> +				goto fail_alloc_reg;
> +			}
> +			alloc_idx++;
> +
> +			__set_bit(EV_ABS, input[alloc_idx-1]->evbit);
> +			__set_bit(ABS_X, input[alloc_idx-1]->absbit);
> +			__set_bit(ABS_Y, input[alloc_idx-1]->absbit);
> +			__set_bit(ABS_PRESSURE, input[alloc_idx-1]->absbit);
> +			input_set_abs_params(input[alloc_idx-1], ABS_X, 0,
> +					tp_plat->x_max_coord, 0, 0);
> +			input_set_abs_params(input[alloc_idx-1], ABS_Y, 0,
> +					tp_plat->y_max_coord, 0, 0);
> +			input_set_abs_params(input[alloc_idx-1], ABS_PRESSURE,
> +				0, 1, 0, 0);
> +
> +			input[alloc_idx-1]->id.bustype = BUS_I2C;

Again with the I2C-only and incomplete setup...


> +
> +			ret = input_register_device(input[reg_idx]);
> +			if (ret) {
> +				dev_err(&ad714x->bus->dev,
> +				"Failed to register AD714x input device!\n");
> +				goto fail_alloc_reg;
> +			}
> +			reg_idx++;
> +
> +			tp_drv[i].input = input[alloc_idx-1];
> +			ad714x->sw->touchpad = tp_drv;
> +		}
> +	}
> +
> +	/* all buttons use one input node */
> +	if (ad714x->hw->button_num > 0) {
> +		bt_drv = kzalloc(sizeof(struct ad714x_button_drv) *
> +				ad714x->hw->button_num, GFP_KERNEL);
> +		if (!bt_drv) {
> +			dev_err(&ad714x->bus->dev,
> +				"Can't allocate memory for button info\n");
> +			ret = -ENOMEM;
> +			goto fail_alloc_reg;
> +		}
> +
> +		input[alloc_idx] = input_allocate_device();
> +		if (!input[alloc_idx]) {
> +			dev_err(&ad714x->bus->dev,
> +					"Can't allocate input device %d\n",
> +					alloc_idx);
> +			ret = -ENOMEM;
> +			goto fail_alloc_reg;
> +		}
> +		alloc_idx++;
> +
> +		__set_bit(EV_KEY, input[alloc_idx-1]->evbit);
> +		for (i = 0; i < ad714x->hw->button_num; i++) {
> +			__set_bit(bt_plat[i].keycode,
> +				input[alloc_idx-1]->keybit);
> +		}
> +
> +		input[alloc_idx-1]->id.bustype = BUS_I2C;

... and again ...


> +
> +		ret = input_register_device(input[reg_idx]);
> +		if (ret) {
> +			dev_err(&ad714x->bus->dev,
> +				"Failed to register AD714x input device!\n");
> +			goto fail_alloc_reg;
> +		}
> +		reg_idx++;
> +
> +		for (i = 0; i < ad714x->hw->button_num; i++)
> +			bt_drv[i].input = input[alloc_idx-1];
> +		ad714x->sw->button = bt_drv;
> +	}
> +
> +	/* initilize and request sw/hw resources */
> +
> +	ad714x_hw_init(ad714x);
> +	mutex_init(&ad714x->mutex);
> +
> +	if (ad714x->bus->irq > 0) {
> +		ret = request_threaded_irq(ad714x->bus->irq, ad714x_interrupt,
> +				ad714x_interrupt_thread, IRQF_TRIGGER_FALLING,
> +				"ad714x_captouch", ad714x);
> +		if (ret) {
> +			dev_err(&ad714x->bus->dev, "Can't allocate irq %d\n",
> +					ad714x->bus->irq);
> +			goto fail_irq;
> +		}
> +	} else
> +		dev_warn(&ad714x->bus->dev, "IRQ not configured!\n");
> +
> +	return 0;
> +
> +fail_irq:
> +fail_alloc_reg:
> +	for (i = 0; i < reg_idx; i++)
> +		input_unregister_device(input[i]);
> +	for (i = 0; i < alloc_idx; i++)
> +		input_free_device(input[i]);
> +	kfree(bt_drv); /* kfree(NULL) is safe check is not required */
> +	kfree(sd_drv);
> +	kfree(wl_drv);
> +	kfree(tp_drv);
> +	kfree(drv_data);
> +det_err:
> +	return ret;
> +}
> +
> +
> +static const struct i2c_device_id ad714x_id[] = {
> +	{ "ad714x_captouch", 0 },

Plain old "ad714x" please.  Though it might be
better to see "ad7147" and "ad7142" separately;
this doesn't work for the ad7143 and ad7148 too,
does it?  Do you know if it will work for as-yet
undefined (I think) ad714[014569] chips?


> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ad714x_id);
