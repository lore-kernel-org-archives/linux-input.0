From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 05/11] Input: synaptics-rmi4 - remove control_mutex from
 f01_data
Date: Thu, 13 Feb 2014 15:01:50 -0800
Message-ID: <52FD4EDE.20208@synaptics.com>
References: <1392269277-16391-1-git-send-email-dmitry.torokhov@gmail.com> <1392269277-16391-5-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:35399 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbaBMXBv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Feb 2014 18:01:51 -0500
In-Reply-To: <1392269277-16391-5-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Courtney Cavin <courtney.cavin@sonymobile.com>, Linux Input <linux-input@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

On 02/12/2014 09:27 PM, Dmitry Torokhov wrote:
> It is not used by anyone.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Christopher Heiny <cheiny@synaptics.com>

> ---
>   drivers/input/rmi4/rmi_f01.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
> index 30e0b50..6f90a6c 100644
> --- a/drivers/input/rmi4/rmi_f01.c
> +++ b/drivers/input/rmi4/rmi_f01.c
> @@ -125,7 +125,6 @@ struct f01_data {
>   	struct f01_basic_properties properties;
>
>   	struct f01_device_control device_control;
> -	struct mutex control_mutex;
>
>   	u8 device_status;
>
> @@ -214,8 +213,6 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>   	struct f01_data *data = fn->data;
>   	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
>
> -	mutex_init(&data->control_mutex);
> -
>   	/*
>   	 * Set the configured bit and (optionally) other important stuff
>   	 * in the device control register.
>


-- 

Christopher Heiny
Senior Staff Firmware Engineer
Synaptics Incorporated
