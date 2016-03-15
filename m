From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [patch] Input: synaptics-rmi4 - using logical instead of bitwise
 AND
Date: Tue, 15 Mar 2016 14:20:02 -0700
Message-ID: <56E87C82.7080105@synaptics.com>
References: <20160315071140.GF13560@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:15335 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750701AbcCOVUD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2016 17:20:03 -0400
In-Reply-To: <20160315071140.GF13560@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On 03/15/2016 12:11 AM, Dan Carpenter wrote:
> There is a typo so we have && instead of &.
>
> Fixes: ff8f83708b3e ('Input: synaptics-rmi4 - add support for 2D sensors and F11')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Andrew Duggan <aduggan@synaptics.com>

> diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
> index 77a5eb8..ec8a10d 100644
> --- a/drivers/input/rmi4/rmi_f11.c
> +++ b/drivers/input/rmi4/rmi_f11.c
> @@ -775,7 +775,7 @@ static int rmi_f11_get_query_parameters(struct rmi_device *rmi_dev,
>   	sensor_query->has_abs = !!(query_buf[0] & RMI_F11_HAS_ABS);
>   	sensor_query->has_gestures = !!(query_buf[0] & RMI_F11_HAS_GESTURES);
>   	sensor_query->has_sensitivity_adjust =
> -		!!(query_buf[0] && RMI_F11_HAS_SENSITIVITY_ADJ);
> +		!!(query_buf[0] & RMI_F11_HAS_SENSITIVITY_ADJ);
>   	sensor_query->configurable = !!(query_buf[0] & RMI_F11_CONFIGURABLE);
>   
>   	sensor_query->nr_x_electrodes =
> @@ -803,7 +803,7 @@ static int rmi_f11_get_query_parameters(struct rmi_device *rmi_dev,
>   		sensor_query->has_bending_correction =
>   			!!(query_buf[0] & RMI_F11_HAS_BENDING_CORRECTION);
>   		sensor_query->has_large_object_suppression =
> -		!!(query_buf[0] && RMI_F11_HAS_LARGE_OBJECT_SUPPRESSION);
> +			!!(query_buf[0] & RMI_F11_HAS_LARGE_OBJECT_SUPPRESSION);
>   		sensor_query->has_jitter_filter =
>   			!!(query_buf[0] & RMI_F11_HAS_JITTER_FILTER);
>   		query_size++;

