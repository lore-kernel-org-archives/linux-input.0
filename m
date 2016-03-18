From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics-rmi4: Remove check of Non-NULL array
Date: Thu, 17 Mar 2016 17:10:59 -0700
Message-ID: <20160318001059.GC21461@dtor-ws>
References: <1458002101-4681-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35356 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967113AbcCRALK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Mar 2016 20:11:10 -0400
Content-Disposition: inline
In-Reply-To: <1458002101-4681-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>

On Mon, Mar 14, 2016 at 05:35:01PM -0700, Andrew Duggan wrote:
> Originally the irq_mask member of rmi_function was a pointer. Then it was
> switched to being a zero length array. However, the checks for a NULL
> pointer where not removed.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Applied, thank you.

> ---
>  drivers/input/rmi4/rmi_driver.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index da38f0a..faa295e 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -126,7 +126,7 @@ static void process_one_interrupt(struct rmi_driver_data *data,
>  		return;
>  
>  	fh = to_rmi_function_handler(fn->dev.driver);
> -	if (fn->irq_mask && fh->attention) {
> +	if (fh->attention) {
>  		bitmap_and(data->fn_irq_bits, data->irq_status, fn->irq_mask,
>  				data->irq_count);
>  		if (!bitmap_empty(data->fn_irq_bits, data->irq_count))
> @@ -172,8 +172,7 @@ int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
>  	 * use irq_chip.
>  	 */
>  	list_for_each_entry(entry, &data->function_list, node)
> -		if (entry->irq_mask)
> -			process_one_interrupt(data, entry);
> +		process_one_interrupt(data, entry);
>  
>  	if (data->input)
>  		input_sync(data->input);
> -- 
> 2.5.0
> 

-- 
Dmitry
