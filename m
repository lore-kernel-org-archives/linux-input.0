From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: pwm-beeper - defer pwm config if pwm can sleep
Date: Mon, 22 Feb 2016 11:46:39 -0800
Message-ID: <20160222194639.GD26177@dtor-ws>
References: <56C4735E.6020300@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34474 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbcBVTqn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Feb 2016 14:46:43 -0500
Content-Disposition: inline
In-Reply-To: <56C4735E.6020300@gmx.at>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manfred Schlaegl <manfred.schlaegl@gmx.at>
Cc: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>, Luis de Bethencourt <luis@debethencourt.com>, Olivier Sobrie <olivier@sobrie.be>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Wed, Feb 17, 2016 at 02:19:26PM +0100, Manfred Schlaegl wrote:
> If the pwm can sleep defer actions to it using a worker.
> A similar approach was used in leds-pwm (c971ff185)
> 
> Trigger:
> On a Freescale i.MX53 based board we ran into "BUG: scheduling while
> atomic" because input_inject_event locks interrupts, but
> imx_pwm_config_v2 sleeps.
> 
> Tested on Freescale i.MX53 SoC with 4.5-rc1 and 4.1.
> 
> Unmodified applicable to
>  * 4.5-rc4
>  * 4.4.1 (stable)
>  * 4.3.5 (stable)
>  * 4.1.18 (longterm)
> 
> Modified applicable to
>  * 3.18.27 (longterm)
> 
> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@gmx.at>
> ---
>  drivers/input/misc/pwm-beeper.c | 62 +++++++++++++++++++++++++++++------------
>  1 file changed, 44 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
> index f2261ab..c160b5e 100644
> --- a/drivers/input/misc/pwm-beeper.c
> +++ b/drivers/input/misc/pwm-beeper.c
> @@ -20,21 +20,42 @@
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
>  #include <linux/slab.h>
> +#include <linux/workqueue.h>
>  
>  struct pwm_beeper {
>  	struct input_dev *input;
>  	struct pwm_device *pwm;
> +	struct work_struct work;
>  	unsigned long period;
> +	bool can_sleep;

I wonder if it is not better to always schedule work, regardless of
whether PWM may sleep or not.

Thanks.

-- 
Dmitry
