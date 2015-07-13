From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] atkbd: add basic debounce support
Date: Mon, 13 Jul 2015 10:20:53 -0700
Message-ID: <20150713172053.GE5039@dtor-ws>
References: <1436772972-26919-1-git-send-email-gavinli@thegavinli.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37683 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbbGMRU6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 13:20:58 -0400
Received: by igbpg9 with SMTP id pg9so8052712igb.0
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 10:20:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436772972-26919-1-git-send-email-gavinli@thegavinli.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gavin Li <gavinli@thegavinli.com>
Cc: linux-input@vger.kernel.org, Gavin Li <git@thegavinli.com>

Hi Gavin,

On Mon, Jul 13, 2015 at 12:36:12AM -0700, Gavin Li wrote:
> From: Gavin Li <git@thegavinli.com>
> 
> For physically quirky or otherwise poor keyboards.

It would be nice to know what keyboards have this issue? It is
widespread problem or just a single unit misbehaving?

Thanks.

> ---
>  drivers/input/keyboard/atkbd.c | 69 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 54 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> index 387c51f..b1ff62d 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -28,6 +28,7 @@
>  #include <linux/libps2.h>
>  #include <linux/mutex.h>
>  #include <linux/dmi.h>
> +#include <linux/timekeeping.h>
>  
>  #define DRIVER_DESC	"AT and PS/2 keyboard driver"
>  
> @@ -67,6 +68,10 @@ static bool atkbd_terminal;
>  module_param_named(terminal, atkbd_terminal, bool, 0);
>  MODULE_PARM_DESC(terminal, "Enable break codes on an IBM Terminal keyboard connected via AT/PS2");
>  
> +static int atkbd_debounce;
> +module_param_named(debounce, atkbd_debounce, int, 0);
> +MODULE_PARM_DESC(debounce, "Milliseconds to debounce successive keys");
> +
>  /*
>   * Scancode to keycode tables. These are just the default setting, and
>   * are loadable via a userland utility.
> @@ -218,6 +223,7 @@ struct atkbd {
>  	bool softraw;
>  	bool scroll;
>  	bool enabled;
> +	ktime_t debounce_ktime;
>  
>  	/* Accessed only from interrupt */
>  	unsigned char emul;
> @@ -227,6 +233,9 @@ struct atkbd {
>  	unsigned int last;
>  	unsigned long time;
>  	unsigned long err_count;
> +	bool is_debouncing;
> +	unsigned short last_debounce_code;
> +	ktime_t last_debounce_expiration;
>  
>  	struct delayed_work event_work;
>  	unsigned long event_jiffies;
> @@ -375,7 +384,7 @@ static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
>  	struct atkbd *atkbd = serio_get_drvdata(serio);
>  	struct input_dev *dev = atkbd->dev;
>  	unsigned int code = data;
> -	int scroll = 0, hscroll = 0, click = -1;
> +	int scroll = 0, hscroll = 0, keypress = 0, click = -1;
>  	int value;
>  	unsigned short keycode;
>  
> @@ -456,23 +465,9 @@ static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
>  
>  	keycode = atkbd->keycode[code];
>  
> -	if (!(atkbd->release && test_bit(code, atkbd->force_release_mask)))
> -		if (keycode != ATKBD_KEY_NULL)
> -			input_event(dev, EV_MSC, MSC_SCAN, code);
> -
>  	switch (keycode) {
>  	case ATKBD_KEY_NULL:
> -		break;
>  	case ATKBD_KEY_UNKNOWN:
> -		dev_warn(&serio->dev,
> -			 "Unknown key %s (%s set %d, code %#x on %s).\n",
> -			 atkbd->release ? "released" : "pressed",
> -			 atkbd->translated ? "translated" : "raw",
> -			 atkbd->set, code, serio->phys);
> -		dev_warn(&serio->dev,
> -			 "Use 'setkeycodes %s%02x <keycode>' to make it known.\n",
> -			 code & 0x80 ? "e0" : "", code & 0x7f);
> -		input_sync(dev);
>  		break;
>  	case ATKBD_SCR_1:
>  		scroll = 1;
> @@ -496,6 +491,7 @@ static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
>  		hscroll = 1;
>  		break;
>  	default:
> +		keypress = 1;
>  		if (atkbd->release) {
>  			value = 0;
>  			atkbd->last = 0;
> @@ -507,7 +503,49 @@ static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
>  			atkbd->last = code;
>  			atkbd->time = jiffies + msecs_to_jiffies(dev->rep[REP_DELAY]) / 2;
>  		}
> +	}
> +
> +	if (keypress) {
> +		if (atkbd->is_debouncing && code == atkbd->last_debounce_code) {
> +			/* ignore debounced release/repeat event */
> +			if (value == 0) {
> +				atkbd->is_debouncing = false;
> +				atkbd->release = false;
> +			}
> +			goto out;
> +		}
> +		if (!atkbd->is_debouncing && value == 1) {
> +			ktime_t now = ktime_get();
> +			if (code == atkbd->last_debounce_code &&
> +					ktime_before(now, atkbd->last_debounce_expiration)) {
> +				/* debounce the press event */
> +				dev_dbg(&serio->dev, "Debounced scan code %#x.\n", code);
> +				atkbd->is_debouncing = !test_bit(code, atkbd->force_release_mask);
> +				goto out;
> +			} else {
> +				atkbd->last_debounce_code = code;
> +				atkbd->last_debounce_expiration = ktime_add(now, atkbd->debounce_ktime);
> +			}
> +		}
> +	}
> +
> +	if (keycode != ATKBD_KEY_NULL)
> +		if (!(atkbd->release && test_bit(code, atkbd->force_release_mask)))
> +			input_event(dev, EV_MSC, MSC_SCAN, code);
> +
> +	if (keycode == ATKBD_KEY_UNKNOWN) {
> +		dev_warn(&serio->dev,
> +			 "Unknown key %s (%s set %d, code %#x on %s).\n",
> +			 atkbd->release ? "released" : "pressed",
> +			 atkbd->translated ? "translated" : "raw",
> +			 atkbd->set, code, serio->phys);
> +		dev_warn(&serio->dev,
> +			 "Use 'setkeycodes %s%02x <keycode>' to make it known.\n",
> +			 code & 0x80 ? "e0" : "", code & 0x7f);
> +		input_sync(dev);
> +	}
>  
> +	if (keypress) {
>  		input_event(dev, EV_KEY, keycode, value);
>  		input_sync(dev);
>  
> @@ -1161,6 +1199,7 @@ static int atkbd_connect(struct serio *serio, struct serio_driver *drv)
>  	atkbd->softraw = atkbd_softraw;
>  	atkbd->softrepeat = atkbd_softrepeat;
>  	atkbd->scroll = atkbd_scroll;
> +	atkbd->debounce_ktime = ms_to_ktime(max(atkbd_debounce, 0));
>  
>  	if (atkbd->softrepeat)
>  		atkbd->softraw = true;
> -- 
> 2.4.5
> 

-- 
Dmitry
