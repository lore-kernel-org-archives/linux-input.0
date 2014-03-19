From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 03/11] Input: synaptics-rmi4 - do not update configuration
 in rmi_f01_probe()
Date: Tue, 18 Mar 2014 17:21:26 -0700
Message-ID: <5328E306.5040405@synaptics.com>
References: <1392269277-16391-1-git-send-email-dmitry.torokhov@gmail.com> <1392269277-16391-3-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [192.147.44.131] ([192.147.44.131]:33088 "EHLO
	us-mx2.synaptics.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1756119AbaCSAVo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Mar 2014 20:21:44 -0400
In-Reply-To: <1392269277-16391-3-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Courtney Cavin <courtney.cavin@sonymobile.com>, Linux Input <linux-input@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

On 02/12/2014 09:27 PM, Dmitry Torokhov wrote:
> Do not write configuration data in probe(), we have config() for that.

I've just submitted a patch to correctly call config() after probe(). 
So this becomes...

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>

>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>   drivers/input/rmi4/rmi_f01.c | 18 ------------------
>   1 file changed, 18 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
> index 897d8ac..976aba3 100644
> --- a/drivers/input/rmi4/rmi_f01.c
> +++ b/drivers/input/rmi4/rmi_f01.c
> @@ -303,12 +303,6 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>   		if (pdata->power_management.doze_interval) {
>   			data->device_control.doze_interval =
>   				pdata->power_management.doze_interval;
> -			error = rmi_write(rmi_dev, data->doze_interval_addr,
> -					data->device_control.doze_interval);
> -			if (error < 0) {
> -				dev_err(&fn->dev, "Failed to configure F01 doze interval register.\n");
> -				return error;
> -			}
>   		} else {
>   			error = rmi_read(rmi_dev, data->doze_interval_addr,
>   					&data->device_control.doze_interval);
> @@ -324,12 +318,6 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>   		if (pdata->power_management.wakeup_threshold) {
>   			data->device_control.wakeup_threshold =
>   				pdata->power_management.wakeup_threshold;
> -			error = rmi_write(rmi_dev, data->wakeup_threshold_addr,
> -					data->device_control.wakeup_threshold);
> -			if (error < 0) {
> -				dev_err(&fn->dev, "Failed to configure F01 wakeup threshold register.\n");
> -				return error;
> -			}
>   		} else {
>   			error = rmi_read(rmi_dev, data->wakeup_threshold_addr,
>   					&data->device_control.wakeup_threshold);
> @@ -347,12 +335,6 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>   		if (pdata->power_management.doze_holdoff) {
>   			data->device_control.doze_holdoff =
>   				pdata->power_management.doze_holdoff;
> -			error = rmi_write(rmi_dev, data->doze_holdoff_addr,
> -					data->device_control.doze_holdoff);
> -			if (error < 0) {
> -				dev_err(&fn->dev, "Failed to configure F01 doze holdoff register.\n");
> -				return error;
> -			}
>   		} else {
>   			error = rmi_read(rmi_dev, data->doze_holdoff_addr,
>   					&data->device_control.doze_holdoff);
>


-- 

Christopher Heiny
Senior Staff Firmware Engineer
Synaptics Incorporated
