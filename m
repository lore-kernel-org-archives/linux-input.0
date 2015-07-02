From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH 04/11] Input: synaptics-rmi4 - prevent oopses when irq
 arrives while the device is not bound
Date: Thu, 2 Jul 2015 10:50:07 -0700
Message-ID: <559579CF.9030407@synaptics.com>
References: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com> <1435087050-11444-5-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [192.147.44.131] ([192.147.44.131]:53732 "EHLO
	us-mx1.synaptics.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752928AbbGBRu3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Jul 2015 13:50:29 -0400
In-Reply-To: <1435087050-11444-5-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Allie Xiong <axiong@synaptics.com>
Cc: Stephen Chandler Paul <cpaul@redhat.com>, benjamin.tissoires@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Huang <vincent.huang@tw.synaptics.com>

On 06/23/2015 12:17 PM, Benjamin Tissoires wrote:
> If the device has been registered but is not populated, we should not
> process any incoming interrupt.
> Make sure the pointers we are following are valid.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---

Reviewed-by: Andrew Duggan <aduggan@synaptics.com>

>   drivers/input/rmi4/rmi_driver.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 2fdc7e8..fe5f2f9 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -279,6 +279,9 @@ int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
>   	struct rmi_function *entry;
>   	int error;
>   
> +	if (!data || !data->f01_container || !data->irq_status)
> +		return 0;
> +
>   	error = rmi_read_block(rmi_dev,
>   				data->f01_container->fd.data_base_addr + 1,
>   				data->irq_status, data->num_of_irq_regs);

