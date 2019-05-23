From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND] input: adp5589: Add gpio_set_multiple interface
Date: Thu, 23 May 2019 00:18:20 -0700
Message-ID: <20190523071820.GA121292@dtor-ws>
References: <20190415122525.2576-1-bogdan.togorean@analog.com>
 <20190521083821.26540-1-bogdan.togorean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190521083821.26540-1-bogdan.togorean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bogdan Togorean <bogdan.togorean@analog.com>
Cc: linux-input@vger.kernel.org, gustavo@embeddedor.com, linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com
List-Id: linux-input@vger.kernel.org

Hi Bogdan,

On Tue, May 21, 2019 at 11:38:22AM +0300, Bogdan Togorean wrote:
> This patch implements the gpio_set_multiple interface for ADP558x chip.
> 
> Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
> ---
>  drivers/input/keyboard/adp5589-keys.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyboard/adp5589-keys.c
> index 2835fba71c33..143871bd60ef 100644
> --- a/drivers/input/keyboard/adp5589-keys.c
> +++ b/drivers/input/keyboard/adp5589-keys.c
> @@ -416,6 +416,30 @@ static void adp5589_gpio_set_value(struct gpio_chip *chip,
>  	mutex_unlock(&kpad->gpio_lock);
>  }
>  
> +static void adp5589_gpio_set_multiple(struct gpio_chip *chip,
> +				      unsigned long *mask, unsigned long *bits)
> +{
> +	struct adp5589_kpad *kpad = container_of(chip, struct adp5589_kpad, gc);
> +	u8 bank, reg_mask, reg_bits;
> +
> +	mutex_lock(&kpad->gpio_lock);
> +
> +	for (bank = 0; bank <= kpad->var->bank(kpad->var->maxgpio); bank++) {
> +		if (bank > kpad->var->bank(get_bitmask_order(*mask) - 1))
> +			break;

I wonder if we should have:

	last_gpio = min(kpad->var->maxgpio, get_bitmask_order(*mask) - 1);
	last_bank = kpad->var->bank(last_bank);
	for (bank = 0; bank <= last_bank; bank++) {
		...
	}

> +		reg_mask = mask[bank / sizeof(*mask)] >>
> +			   ((bank % sizeof(*mask)) * BITS_PER_BYTE);
> +		reg_bits = bits[bank / sizeof(*bits)] >>
> +			   ((bank % sizeof(*bits)) * BITS_PER_BYTE);

This s really hard to parse. We know that "bank" is a byte, and mask is
long, we do not have to be this roundabout it.

> +		kpad->dat_out[bank] &= ~reg_mask;
> +		kpad->dat_out[bank] |= reg_bits & reg_mask;
> +		adp5589_write(kpad->client, kpad->var->reg(ADP5589_GPO_DATA_OUT_A) + bank,
> +			      kpad->dat_out[bank]);
> +	}

However the biggest issue is that this implementation seems to ignore
the kpad->gpiomap that translates GPIO numbers as seen by gpiolib to
GPIO numbers used by the chip. You need to reshuffle the mask and bits,
and only then do the writes.

Given the complexities, does set_multiple really save anything?

Thanks.

-- 
Dmitry
