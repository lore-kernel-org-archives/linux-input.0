From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [PATCH] add REL_* axes support to the rotary encoder driver
Date: Tue, 14 Apr 2009 11:33:06 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909015F88F0@mi8nycmail19.Mi8.com>
References: <20090303090317.GA14246@dtor-d630.eng.vmware.com> <1236074367-23172-1-git-send-email-daniel@caiaq.de> <20090304084851.GB7394@dtor-d630.eng.vmware.com> <20090304095053.GA6098@buzzloop.caiaq.de> <BD79186B4FD85F4B8E60E381CAEE190901349B98@mi8nycmail19.Mi8.com> <20090304172054.GD12183@buzzloop.caiaq.de> <20090307170632.GA31096@buzzloop.caiaq.de> <BD79186B4FD85F4B8E60E381CAEE1909015F87BC@mi8nycmail19.Mi8.com> <20090414055052.GB4795@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og107.obsmtp.com ([64.18.1.208]:43825 "HELO
	exprod6og107.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752151AbZDNPdS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Apr 2009 11:33:18 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20090414055052.GB4795@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-input@vger.kernel.org

On Monday, April 13, 2009 10:51 PM, Daniel Mack wrote:
> On Mon, Apr 13, 2009 at 07:06:24PM -0400, H Hartley Sweeten wrote:
>> Add REL_* axes support to the rotary encoder driver.
>> 
>> The rotary encoder driver only supports returning input events
>> for ABS_* axes, this adds support for REL_* axes.  The relative
>> axis input event is reported as -1 for each counter-clockwise
>> step and +1 for each clockwise step.
>> 
>> In addition the private data structure has been rearranged and
>> modified to use less memory.
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Daniel Mack <daniel@caiaq.de>
>
> Your patch was line wrapped and did only apply with fuzz 1i againt
> the current Linus master, but apart from that ...
>
> Acked-by: Daniel Mack <daniel@caiaq.de>
>
> Thanks :)
>
> Daniel

I'll add your Acked-by and repost the patch later today.  I'll also
attach the patch to avoid the line wrapping issue.

I've been fighting with my email provider on that issue.  It appears
one of the servers they use is doing the wrapping when the message
bounces through it.  If anyone has an idea to get around that I would
appreciate the input.

Regards,
Hartley


> ---
> 
> diff --git a/Documentation/input/rotary-encoder.txt
> b/Documentation/input/rotary-encoder.txt
> index 435102a..1b90ac7 100644
> --- a/Documentation/input/rotary-encoder.txt
> +++ b/Documentation/input/rotary-encoder.txt
> @@ -67,7 +67,11 @@ data with it.
>  struct rotary_encoder_platform_data is declared in
>  include/linux/rotary-encoder.h and needs to be filled with the number
> of
>  steps the encoder has and can carry information about externally
> inverted
> -signals (because of used invertig buffer or other reasons).
> +signals (because of an inverting buffer or other reasons). The
encoder
> +can be set up to deliver input information as either an absolute or
> relative
> +axes. For absolute axes the position of the encoder rolls over
between
> zero
> +and the number of steps. For relative axes the input event returns
+/-1
> for
> +each step.
>  
>  Because GPIO to IRQ mapping is platform specific, this information
must
>  be given in seperately to the driver. See the example below.
> @@ -84,7 +88,7 @@ be given in seperately to the driver. See the
example
> below.
>  
>  static struct rotary_encoder_platform_data my_rotary_encoder_info = {
>  	.steps		= 24,
> -	.axis		= ABS_X,
> +	.axis		= ROTARY_ENCODER_ABS | ABS_X,
>  	.gpio_a		= GPIO_ROTARY_A,
>  	.gpio_b		= GPIO_ROTARY_B,
>  	.inverted_a	= 0,
> diff --git a/drivers/input/misc/rotary_encoder.c
> b/drivers/input/misc/rotary_encoder.c
> index 5bb3ab5..fff9c1c 100644
> --- a/drivers/input/misc/rotary_encoder.c
> +++ b/drivers/input/misc/rotary_encoder.c
> @@ -26,13 +26,18 @@
>  #define DRV_NAME "rotary-encoder"
>  
>  struct rotary_encoder {
> -	unsigned int irq_a;
> -	unsigned int irq_b;
> -	unsigned int pos;
> -	unsigned int armed;
> -	unsigned int dir;
> -	struct input_dev *input;
> -	struct rotary_encoder_platform_data *pdata;
> +	struct input_dev			*input;
> +	struct rotary_encoder_platform_data	*pdata;
> +
> +	unsigned int	axis;
> +	unsigned int	pos;
> +
> +	unsigned int	irq_a;
> +	unsigned int	irq_b;
> +
> +	unsigned int	abs:1;
> +	unsigned int	dir:1;
> +	unsigned int	armed:1;
>  };
>  
>  static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
> @@ -55,16 +60,29 @@ static irqreturn_t rotary_encoder_irq(int irq,
void
> *dev_id)
>  
>  		if (encoder->dir) {
>  			/* turning counter-clockwise */
> -			encoder->pos += pdata->steps;
> -			encoder->pos--;
> -			encoder->pos %= pdata->steps;
> +			if (encoder->abs) {
> +				encoder->pos += pdata->steps;
> +				encoder->pos--;
> +				encoder->pos %= pdata->steps;
> +				input_report_abs(encoder->input,
> +						encoder->axis,
> encoder->pos);
> +			} else {
> +				input_report_rel(encoder->input,
> +						encoder->axis, -1);
> +			}
>  		} else {
>  			/* turning clockwise */
> -			encoder->pos++;
> -			encoder->pos %= pdata->steps;
> +			if (encoder->abs) {
> +				encoder->pos++;
> +				encoder->pos %= pdata->steps;
> +				input_report_abs(encoder->input,
> +						encoder->axis,
> encoder->pos);
> +			} else {
> +				input_report_rel(encoder->input,
> +						encoder->axis, 1);
> +			}
>  		}
>  
> -		input_report_abs(encoder->input, pdata->axis,
> encoder->pos);
>  		input_sync(encoder->input);
>  
>  		encoder->armed = 0;
> @@ -108,14 +126,23 @@ static int __devinit rotary_encoder_probe(struct
> platform_device *pdev)
>  	encoder->pdata = pdata;
>  	encoder->irq_a = gpio_to_irq(pdata->gpio_a);
>  	encoder->irq_b = gpio_to_irq(pdata->gpio_b);
> +	encoder->abs = !!(pdata->axis & ROTARY_ENCODER_ABS);
>  
>  	/* create and register the input driver */
>  	input->name = pdev->name;
>  	input->id.bustype = BUS_HOST;
>  	input->dev.parent = &pdev->dev;
> -	input->evbit[0] = BIT_MASK(EV_ABS);
> -	input_set_abs_params(encoder->input,
> -			     pdata->axis, 0, pdata->steps, 0, 1);
> +	if (encoder->abs) {
> +		encoder->axis = pdata->axis & ABS_MAX;
> +		input->evbit[0] = BIT_MASK(EV_ABS);
> +		input->absbit[0] = BIT_MASK(encoder->axis);
> +		input_set_abs_params(encoder->input,
> +				     encoder->axis, 0, pdata->steps, 0,
> 1);
> +	} else {
> +		encoder->axis = pdata->axis & REL_MAX;
> +		input->evbit[0] = BIT_MASK(EV_REL);
> +		input->relbit[0] = BIT_MASK(encoder->axis);
> +	}
>  
>  	err = input_register_device(input);
>  	if (err) {
> diff --git a/include/linux/rotary_encoder.h
> b/include/linux/rotary_encoder.h
> index 12d63a3..ae668db 100644
> --- a/include/linux/rotary_encoder.h
> +++ b/include/linux/rotary_encoder.h
> @@ -1,6 +1,9 @@
>  #ifndef __ROTARY_ENCODER_H__
>  #define __ROTARY_ENCODER_H__
>  
> +#define ROTARY_ENCODER_REL	(0<<31)
> +#define ROTARY_ENCODER_ABS	(1<<31)
> +
>  struct rotary_encoder_platform_data {
>  	unsigned int steps;
>  	unsigned int axis; 
