From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: improve autorepeat initialization
Date: Tue, 13 Oct 2015 23:14:51 -0700
Message-ID: <20151014061451.GB20406@dtor-ws>
References: <1444779277-13216-1-git-send-email-pgynther@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35693 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbbJNGOy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Oct 2015 02:14:54 -0400
Received: by padcn9 with SMTP id cn9so13397909pad.2
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2015 23:14:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1444779277-13216-1-git-send-email-pgynther@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Petri Gynther <pgynther@google.com>
Cc: linux-input@vger.kernel.org

On Tue, Oct 13, 2015 at 04:34:37PM -0700, Petri Gynther wrote:
> Add new function input_enable_softrepeat() that allows drivers to
> initialize their own values for input_dev->rep[REP_DELAY] and
> input_dev->rep[REP_PERIOD], but also use the software autorepeat
> functionality from input.c.
> 
> For example, a HID driver could do:
> 
> static void xyz_input_configured(struct hid_device *hid,
>                                  struct hid_input *hidinput)
> {
>         input_enable_softrepeat(hidinput->input, 400, 100);
> }
> 
> static struct hid_driver xyz_driver = {
>         .input_configured = xyz_input_configured,
> }
> 
> Signed-off-by: Petri Gynther <pgynther@google.com>

Applied, thank you.

> ---
>  drivers/input/input.c | 25 +++++++++++++++++++------
>  include/linux/input.h |  2 ++
>  2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 5391abd..8806059 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -2045,6 +2045,23 @@ static void devm_input_device_unregister(struct device *dev, void *res)
>  }
>  
>  /**
> + * input_enable_softrepeat - enable software autorepeat
> + * @dev: input device
> + * @delay: repeat delay
> + * @period: repeat period
> + *
> + * Enable software autorepeat on the input device.
> + */
> +void input_enable_softrepeat(struct input_dev *dev, int delay, int period)
> +{
> +	dev->timer.data = (unsigned long) dev;
> +	dev->timer.function = input_repeat_key;
> +	dev->rep[REP_DELAY] = delay;
> +	dev->rep[REP_PERIOD] = period;
> +}
> +EXPORT_SYMBOL(input_enable_softrepeat);
> +
> +/**
>   * input_register_device - register device with input core
>   * @dev: device to be registered
>   *
> @@ -2108,12 +2125,8 @@ int input_register_device(struct input_dev *dev)
>  	 * If delay and period are pre-set by the driver, then autorepeating
>  	 * is handled by the driver itself and we don't do it in input.c.
>  	 */
> -	if (!dev->rep[REP_DELAY] && !dev->rep[REP_PERIOD]) {
> -		dev->timer.data = (long) dev;
> -		dev->timer.function = input_repeat_key;
> -		dev->rep[REP_DELAY] = 250;
> -		dev->rep[REP_PERIOD] = 33;
> -	}
> +	if (!dev->rep[REP_DELAY] && !dev->rep[REP_PERIOD])
> +		input_enable_softrepeat(dev, 250, 33);
>  
>  	if (!dev->getkeycode)
>  		dev->getkeycode = input_default_getkeycode;
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 82ce323..1e96769 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -469,6 +469,8 @@ int input_get_keycode(struct input_dev *dev, struct input_keymap_entry *ke);
>  int input_set_keycode(struct input_dev *dev,
>  		      const struct input_keymap_entry *ke);
>  
> +void input_enable_softrepeat(struct input_dev *dev, int delay, int period);
> +
>  extern struct class input_class;
>  
>  /**
> -- 
> 2.6.0.rc2.230.g3dd15c0
> 

-- 
Dmitry
