From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: [patch 2/2] HID: sensors: remove some unneeded checks
Date: Mon, 17 Sep 2012 15:21:37 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A919D527E5@ORSMSX108.amr.corp.intel.com>
References: <20120914065346.GE11886@elgon.mountain>
 <alpine.LNX.2.00.1209171259240.31149@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16180 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755163Ab2IQPVj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 11:21:39 -0400
In-Reply-To: <alpine.LNX.2.00.1209171259240.31149@pobox.suse.cz>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Jonathan Cameron <jic23@cam.ac.uk>

Tested this and it works.

-----Original Message-----
From: Jiri Kosina [mailto:jkosina@suse.cz] 
Sent: Monday, September 17, 2012 4:00 AM
To: Dan Carpenter
Cc: Pandruvada, Srinivas; linux-input@vger.kernel.org; kernel-janitors@vger.kernel.org; Jonathan Cameron
Subject: Re: [patch 2/2] HID: sensors: remove some unneeded checks

On Fri, 14 Sep 2012, Dan Carpenter wrote:

> "report_id" is unsigned so it's never less than zero.  These checks 
> can be removed without any problem.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Adding Jonathan to CC as well. Thanks.

> 
> diff --git a/drivers/hid/hid-sensor-hub.c 
> b/drivers/hid/hid-sensor-hub.c index 0c93b10..22ec3c6 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -214,9 +214,6 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
>  	struct sensor_hub_data *data =  hid_get_drvdata(hsdev->hdev);
>  	int ret = 0;
>  
> -	if (report_id < 0)
> -		return -EINVAL;
> -
>  	mutex_lock(&data->mutex);
>  	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
>  	if (!report || (field_index >=  report->maxfield)) { @@ -241,9 
> +238,6 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
>  	struct sensor_hub_data *data =  hid_get_drvdata(hsdev->hdev);
>  	int ret = 0;
>  
> -	if (report_id < 0)
> -		return -EINVAL;
> -
>  	mutex_lock(&data->mutex);
>  	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
>  	if (!report || (field_index >=  report->maxfield)) { @@ -271,9 
> +265,6 @@ int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
>  	struct hid_report *report;
>  	int ret_val = 0;
>  
> -	if (report_id < 0)
> -		return -EINVAL;
> -
>  	mutex_lock(&data->mutex);
>  	memset(&data->pending, 0, sizeof(data->pending));
>  	init_completion(&data->pending.ready);
> 

--
Jiri Kosina
SUSE Labs
