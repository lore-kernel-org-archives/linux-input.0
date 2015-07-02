From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH 10/11] Input: synaptics-rmi4 - f11: allow the top software
 button property to be set
Date: Thu, 2 Jul 2015 10:51:15 -0700
Message-ID: <55957A13.5010408@synaptics.com>
References: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com> <1435087050-11444-11-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [192.147.44.131] ([192.147.44.131]:51242 "EHLO
	us-mx1.synaptics.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754034AbbGBRva (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Jul 2015 13:51:30 -0400
In-Reply-To: <1435087050-11444-11-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Allie Xiong <axiong@synaptics.com>
Cc: Stephen Chandler Paul <cpaul@redhat.com>, benjamin.tissoires@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Huang <vincent.huang@tw.synaptics.com>

On 06/23/2015 12:17 PM, Benjamin Tissoires wrote:
> Currently, in PS/2 we only have the PNPIds list to detect the property.
> Unfortunately, it looks like the information is not embeded in the RMI4
> protocol either, so allow the Top software buttons property to be set
> in the platform data.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---

Reviewed-by: Andrew Duggan <aduggan@synaptics.com>

>   drivers/input/rmi4/rmi_f11.c | 5 +++++
>   include/linux/rmi.h          | 3 +++
>   2 files changed, 8 insertions(+)
>
> diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
> index 77a18aa..50df7a1 100644
> --- a/drivers/input/rmi4/rmi_f11.c
> +++ b/drivers/input/rmi4/rmi_f11.c
> @@ -515,6 +515,7 @@ struct f11_2d_sensor {
>   	int pkt_size;
>   	u8 sensor_index;
>   	u32 type_a;	/* boolean but debugfs API requires u32 */
> +	bool topbuttonpad;
>   	enum rmi_f11_sensor_type sensor_type;
>   	struct input_dev *input;
>   	bool unified_input;
> @@ -1285,6 +1286,7 @@ static int rmi_f11_initialize(struct rmi_function *fn)
>   		sensor->axis_align =
>   			pdata->f11_sensor_data->axis_align;
>   		sensor->type_a = pdata->f11_sensor_data->type_a;
> +		sensor->topbuttonpad = pdata->f11_sensor_data->topbuttonpad;
>   
>   		if (sensor->sens_query.has_physical_props) {
>   			sensor->x_mm = sensor->sens_query.x_sensor_size_mm;
> @@ -1409,6 +1411,9 @@ static int rmi_f11_register_devices(struct rmi_function *fn)
>   	if (sensor->report_abs)
>   		f11_set_abs_params(fn, f11);
>   
> +	if (sensor->topbuttonpad)
> +		set_bit(INPUT_PROP_TOPBUTTONPAD, input_dev->propbit);
> +
>   	if (sensor->report_rel) {
>   		set_bit(EV_REL, input_dev->evbit);
>   		set_bit(REL_X, input_dev->relbit);
> diff --git a/include/linux/rmi.h b/include/linux/rmi.h
> index b771f41..4ffe9fe 100644
> --- a/include/linux/rmi.h
> +++ b/include/linux/rmi.h
> @@ -93,6 +93,8 @@ enum rmi_f11_sensor_type {
>    * available.
>    * @disable_report_mask - Force data to not be reported even if it is supported
>    * by the firware.
> + * @topbuttonpad - Used with the "5 buttons touchpads" found on the Lenovo 40
> + * series
>    */
>   struct rmi_f11_sensor_data {
>   	struct rmi_f11_2d_axis_alignment axis_align;
> @@ -101,6 +103,7 @@ struct rmi_f11_sensor_data {
>   	int x_mm;
>   	int y_mm;
>   	int disable_report_mask;
> +	bool topbuttonpad;
>   };
>   
>   /**

