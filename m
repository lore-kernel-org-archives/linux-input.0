From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 06/18] Input: synaptics-rmi4 - Set the
 ABS_MT_TOOL_TYPE bit to report tool type
Date: Tue, 8 Nov 2016 17:03:33 -0800
Message-ID: <20161109010333.GK8719@dtor-ws>
References: <1476373872-18027-1-git-send-email-benjamin.tissoires@redhat.com>
 <1476373872-18027-7-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36010 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbcKIBDg (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2016 20:03:36 -0500
Content-Disposition: inline
In-Reply-To: <1476373872-18027-7-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Oct 13, 2016 at 05:51:00PM +0200, Benjamin Tissoires wrote:
> From: Andrew Duggan <aduggan@synaptics.com>
> 
> The rmi4 2D sensor functions report the tool type via
> input_mt_report_slot_state(), but the abs parameter bit has not been
> set so the tool type is not reported to userspace. This patch set
> the ABS_MT_TOOL_TYPE bit.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> 
> ---
> 
> new in v3
> ---
>  drivers/input/rmi4/rmi_2d_sensor.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
> index e97bd7f..0747890 100644
> --- a/drivers/input/rmi4/rmi_2d_sensor.c
> +++ b/drivers/input/rmi4/rmi_2d_sensor.c
> @@ -181,6 +181,8 @@ static void rmi_2d_sensor_set_input_params(struct rmi_2d_sensor *sensor)
>  		input_set_abs_params(input, ABS_MT_TOUCH_MAJOR,	0, 0x0f, 0, 0);
>  		input_set_abs_params(input, ABS_MT_TOUCH_MINOR,	0, 0x0f, 0, 0);
>  		input_set_abs_params(input, ABS_MT_ORIENTATION,	0, 1, 0, 0);
> +		input_set_abs_params(input, ABS_MT_TOOL_TYPE, 0, MT_TOOL_MAX,
> +					0, 0);
>  
>  		if (sensor->sensor_type == rmi_sensor_touchpad)
>  			input_flags = INPUT_MT_POINTER;
> -- 
> 2.7.4
> 

-- 
Dmitry
