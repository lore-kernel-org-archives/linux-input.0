From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] goldfish: multitouch: no extra EV_SYN
Date: Fri, 26 Feb 2016 11:57:46 -0800
Message-ID: <20160226195746.GA3769@dtor-ws>
References: <20160226184908.3539.48691.stgit@localhost.localdomain>
 <20160226185007.3539.83946.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33296 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbcBZT5u (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Feb 2016 14:57:50 -0500
Received: by mail-pa0-f54.google.com with SMTP id fl4so55930638pad.0
        for <linux-input@vger.kernel.org>; Fri, 26 Feb 2016 11:57:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160226185007.3539.83946.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan <alan@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Fri, Feb 26, 2016 at 06:50:21PM +0000, Alan wrote:
> From: Lingfeng Yang <lfy@google.com>
> 
> If we send SYN_REPORT on every single multi-touch event, it breaks the
> multi-touch.
> 
> The multi-touch becomes jerky and you have to click 2-3 times to do things
> while randomly activating notification bars when not clicking.
> 
> If we suppress these SYN_REPORTS, multi-touch will work fine and the events
> will have a protocol that looks nice.
> 
> We need to register Goldfish Events as a multi-touch device by issuing
> input_mt_init_slots, otherwise input_handle_abs_event in drivers/input/input.c
> will silently drop all ABS_MT_SLOT events, causing touches of more than one
> finger to fail.
> 
> Signed-off-by: Lingfeng Yang <lfy@google.com>
> Signed-off-by: Jin Qian <jinqian@android.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>  drivers/input/keyboard/goldfish_events.c |   30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/goldfish_events.c b/drivers/input/keyboard/goldfish_events.c
> index c7e308a..c0d77b7 100644
> --- a/drivers/input/keyboard/goldfish_events.c
> +++ b/drivers/input/keyboard/goldfish_events.c
> @@ -17,6 +17,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/types.h>
>  #include <linux/input.h>
> +#include <linux/input/mt.h>
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> @@ -24,6 +25,8 @@
>  #include <linux/io.h>
>  #include <linux/acpi.h>
>  
> +#define GOLDFISH_MAX_FINGERS 5
> +
>  enum {
>  	REG_READ        = 0x00,
>  	REG_SET_PAGE    = 0x00,
> @@ -52,7 +55,23 @@ static irqreturn_t events_interrupt(int irq, void *dev_id)
>  	value = __raw_readl(edev->addr + REG_READ);
>  
>  	input_event(edev->input, type, code, value);
> -	input_sync(edev->input);
> +	/*
> +	 * Send an extra (EV_SYN, SYN_REPORT, 0x0) event
> +	 * if a key was pressed. Some keyboard device
> +	 * drivers may only send the EV_KEY event and
> +	 * not EV_SYN.

That would be error in that keyboard driver and should be fixed.

> +	 * Note that sending an extra SYN_REPORT is not
> +	 * necessary nor correct protocol with other
> +	 * devices such as touchscreens, which will send
> +	 * their own SYN_REPORT's when sufficient event
> +	 * information has been collected (e.g., for
> +	 * touchscreens, when pressure and X/Y coordinates
> +	 * have been received). Hence, we will only send
> +	 * this extra SYN_REPORT if type == EV_KEY.
> +	 */
> +	if (type == EV_KEY)
> +		input_sync(edev->input);


I'd rather we always rely on the host to send the SYN event.

> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -154,6 +173,15 @@ static int events_probe(struct platform_device *pdev)
>  
>  	input_dev->name = edev->name;
>  	input_dev->id.bustype = BUS_HOST;
> +	/*
> +	 * Set the Goldfish Device to be multi-touch.
> +	 * If we do not issue input_mt_init_slots,
> +	 * the kernel will filter out needed ABS_MT_SLOT
> +	 * events when we touch the screen in more than one place,
> +	 * preventing multi-touch with more than one finger from working.
> +	 * See drivers/input/input.c:input_handle_abs_event.
> +	 */
> +	input_mt_init_slots(input_dev, GOLDFISH_MAX_FINGERS, 0);

Can we use data retrieved by events_import_abs_params() to set up
correct number of slots? Also we need error handling. And possibly
retrieve correct properties to set pass to input_mt_init_slots()...

>  
>  	events_import_bits(edev, input_dev->evbit, EV_SYN, EV_MAX);
>  	events_import_bits(edev, input_dev->keybit, EV_KEY, KEY_MAX);
> 

Thanks.

-- 
Dmitry
