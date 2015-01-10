From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/2] HID: hid-sensor-hub: Correct documentation
Date: Sat, 10 Jan 2015 22:21:36 +0000
Message-ID: <54B1A5F0.9080904@kernel.org>
References: <1420654484-6410-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1420654484-6410-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60014 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740AbbAJWVj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Jan 2015 17:21:39 -0500
In-Reply-To: <1420654484-6410-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, jkosina@suse.cz
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org

On 07/01/15 18:14, Srinivas Pandruvada wrote:
> During changes to the interface, some documentation field comments
> were missed. Added missing comments.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the togreg branch of iio.git as absence of docs is irritating
rather than a bug ;)

Thanks,
> ---
>  include/linux/hid-sensor-hub.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> index 51f7cca..4173a8f 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -33,6 +33,8 @@
>   * @units:		Measurment unit for this attribute.
>   * @unit_expo:		Exponent used in the data.
>   * @size:		Size in bytes for data size.
> + * @logical_minimum:	Logical minimum value for this attribute.
> + * @logical_maximum:	Logical maximum value for this attribute.
>   */
>  struct hid_sensor_hub_attribute_info {
>  	u32 usage_id;
> @@ -146,6 +148,7 @@ int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
>  
>  /**
>  * sensor_hub_input_attr_get_raw_value() - Synchronous read request
> +* @hsdev:	Hub device instance.
>  * @usage_id:	Attribute usage id of parent physical device as per spec
>  * @attr_usage_id:	Attribute usage id as per spec
>  * @report_id:	Report id to look for
> @@ -160,6 +163,7 @@ int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
>  			u32 attr_usage_id, u32 report_id);
>  /**
>  * sensor_hub_set_feature() - Feature set request
> +* @hsdev:	Hub device instance.
>  * @report_id:	Report id to look for
>  * @field_index:	Field index inside a report
>  * @value:	Value to set
> @@ -172,6 +176,7 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
>  
>  /**
>  * sensor_hub_get_feature() - Feature get request
> +* @hsdev:	Hub device instance.
>  * @report_id:	Report id to look for
>  * @field_index:	Field index inside a report
>  * @value:	Place holder for return value
> 

