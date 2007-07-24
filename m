From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC/RFT 1/5] Input: implement proper locking in input core
Date: Tue, 24 Jul 2007 01:35:54 -0400
Message-ID: <46A58FBA.5010505@garzik.org>
References: <20070724044520.913891976.dtor@insightbb.com> <20070724044858.192608314.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070724044858.192608314.dtor@insightbb.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> +static void input_repeat_key(unsigned long data)
> +{
> +	struct input_dev *dev = (void *) data;
>  
> -			change_bit(code, dev->key);
> +	spin_lock_irq(&dev->event_lock);
[...]
> +void input_inject_event(struct input_handle *handle,
> +			unsigned int type, unsigned int code, int value)
>  {
> -	struct input_dev *dev = (void *) data;
> +	struct input_dev *dev = handle->dev;
> +	struct input_handle *grab;
>  
> -	if (!test_bit(dev->repeat_key, dev->key))
> -		return;
> +	if (is_event_supported(type, dev->evbit, EV_MAX)) {
> +		spin_lock_irq(&dev->event_lock);
>  
> -	input_event(dev, EV_KEY, dev->repeat_key, 2);
> -	input_sync(dev);
> +		grab = rcu_dereference(dev->grab);
> +		if (!grab || grab == handle)
> +			input_handle_event(dev, type, code, value);
>  
> -	if (dev->rep[REP_PERIOD])
> -		mod_timer(&dev->timer, jiffies + msecs_to_jiffies(dev->rep[REP_PERIOD]));
> +		spin_unlock_irq(&dev->event_lock);
> +	}
>  }
> +EXPORT_SYMBOL(input_inject_event);
[...]
> +	spin_lock_irq(&dev->event_lock);
> +
> +	/*
> +	 * Simulate keyup events for all pressed keys so that handlers
> +	 * are not left with "stuck" keys. The driver may continue
> +	 * generate events even after we done here but they will not
> +	 * reach any handlers.
> +	 */
> +	if (is_event_supported(EV_KEY, dev->evbit, EV_MAX)) {
> +		for (code = 0; code <= KEY_MAX; code++) {
> +			if (is_event_supported(code, dev->keybit, KEY_MAX) &&
> +			    test_bit(code, dev->key)) {
> +				input_pass_event(dev, EV_KEY, code, 0);
> +			}
> +		}
> +		input_pass_event(dev, EV_SYN, SYN_REPORT, 1);
> +	}
> +
> +	list_for_each_entry(handle, &dev->h_list, d_node)
> +		handle->open = 0;
> +
> +	spin_unlock_irq(&dev->event_lock);


spin_lock_irq() should generally be avoided.

In cases like the first case -- input_repeat_key() -- you are making 
incorrect assumptions about the state of interrupts.  The other cases 
are probably ok, but in general spin_lock_irq() has a long history of 
being very fragile and quite often wrong.

Use spin_lock_irqsave() to be safe.  Definitely in input_repeat_key(), 
but I strongly recommend removing spin_lock_irq() from all your patches 
here.

	Jeff
