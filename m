From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - fix debug for sensor clip
Date: Mon, 5 Dec 2016 10:04:43 -0800
Message-ID: <d019a6b8-9f9b-4d5d-bbd0-17ca2b5c2bd0@synaptics.com>
References: <1480899881-31425-1-git-send-email-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:14748 "EHLO
        us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbcLESEo (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 5 Dec 2016 13:04:44 -0500
In-Reply-To: <1480899881-31425-1-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/04/2016 05:04 PM, Nick Dyer wrote:
> The debug would only ever output zero for the clip information.
>
> Signed-off-by: Nick Dyer <nick@shmanahar.org>

Reviewed-by: Andrew Duggan <aduggan@synaptics.com>

> ---
>
>   drivers/input/rmi4/rmi_f12.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
> index 8c5360c..e35c64b 100644
> --- a/drivers/input/rmi4/rmi_f12.c
> +++ b/drivers/input/rmi4/rmi_f12.c
> @@ -71,10 +71,6 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
>   	u8 buf[15];
>   	int pitch_x = 0;
>   	int pitch_y = 0;
> -	int clip_x_low = 0;
> -	int clip_x_high = 0;
> -	int clip_y_low = 0;
> -	int clip_y_high = 0;
>   	int rx_receivers = 0;
>   	int tx_receivers = 0;
>   	int sensor_flags = 0;
> @@ -127,7 +123,8 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
>   	}
>   
>   	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: x low: %d x high: %d y low: %d y high: %d\n",
> -		__func__, clip_x_low, clip_x_high, clip_y_low, clip_y_high);
> +		__func__, sensor->axis_align.clip_x_low, sensor->axis_align.clip_x_high,
> +		sensor->axis_align.clip_y_low, sensor->axis_align.clip_y_high);
>   
>   	if (rmi_register_desc_has_subpacket(item, 3)) {
>   		rx_receivers = buf[offset];


