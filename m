From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 14/15] Input: synaptics-rmi4 - ensure we have IRQs before
 reading status
Date: Tue, 4 Feb 2014 15:10:49 -0800
Message-ID: <52F17379.6030306@synaptics.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-4-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-5-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-6-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-7-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-8-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-9-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-10-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-11-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-12-git-send-email-courtney.cavin@sonymobile.com> <1390
 521623-6491-13-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-14-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-15-git-send-email-courtney.cavin@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:24617 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934543AbaBDXKu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Feb 2014 18:10:50 -0500
In-Reply-To: <1390521623-6491-15-git-send-email-courtney.cavin@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Courtney Cavin <courtney.cavin@sonymobile.com>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

On 01/23/2014 04:00 PM, Courtney Cavin wrote:
> Cc: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> ---
>   drivers/input/rmi4/rmi_f01.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
> index 22b57f2..06fc5bc 100644
> --- a/drivers/input/rmi4/rmi_f01.c
> +++ b/drivers/input/rmi4/rmi_f01.c
> @@ -318,13 +318,15 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>   	ctrl_base_addr += sizeof(u8);
>
>   	data->interrupt_enable_addr = ctrl_base_addr;
> -	error = rmi_read_block(rmi_dev, ctrl_base_addr,
> -				data->device_control.interrupt_enable,
> -				sizeof(u8) * (data->num_of_irq_regs));
> -	if (error < 0) {
> -		dev_err(&fn->dev,
> -			"Failed to read F01 control interrupt enable register.\n");
> -		goto error_exit;
> +	if (data->num_of_irq_regs > 0) {
> +		error = rmi_read_block(rmi_dev, ctrl_base_addr,
> +					data->device_control.interrupt_enable,
> +					sizeof(u8) * (data->num_of_irq_regs));
> +		if (error < 0) {
> +			dev_err(&fn->dev,
> +				"Failed to read F01 control interrupt enable register.\n");
> +			goto error_exit;
> +		}

If we don't know the number of IRQ registers at this point, we're 
basically screwed, as most of the control register positions will be 
known correctly.  The previously submitted IRQ counting patch ensures 
that number of IRQ registers is know by this point - if they aren't, 
then we should probably fail entirely rather than just muddling along.

>   	}
>
>   	ctrl_base_addr += data->num_of_irq_regs;
>


-- 

Christopher Heiny
Senior Staff Firmware Engineer
Synaptics Incorporated
