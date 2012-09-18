From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [patch 2/2] HID: sensors: remove some unneeded checks
Date: Tue, 18 Sep 2012 21:52:38 +0100
Message-ID: <5058DF16.20002@kernel.org>
References: <20120914065346.GE11886@elgon.mountain> <alpine.LNX.2.00.1209171259240.31149@pobox.suse.cz> <4FA419E87744DF4DAECD5BCE1214B7A919D527E5@ORSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42006 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755236Ab2IRUwm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Sep 2012 16:52:42 -0400
In-Reply-To: <4FA419E87744DF4DAECD5BCE1214B7A919D527E5@ORSMSX108.amr.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dan Carpenter <dan.carpenter@oracle.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>

I've add these both to the togreg branch of

git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

Will send onwards in a few days.

> Tested this and it works.
> 
> -----Original Message-----
> From: Jiri Kosina [mailto:jkosina@suse.cz] 
> Sent: Monday, September 17, 2012 4:00 AM
> To: Dan Carpenter
> Cc: Pandruvada, Srinivas; linux-input@vger.kernel.org; kernel-janitors@vger.kernel.org; Jonathan Cameron
> Subject: Re: [patch 2/2] HID: sensors: remove some unneeded checks
> 
> On Fri, 14 Sep 2012, Dan Carpenter wrote:
> 
>> "report_id" is unsigned so it's never less than zero.  These checks 
>> can be removed without any problem.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 
> Adding Jonathan to CC as well. Thanks.
> 
>>
>> diff --git a/drivers/hid/hid-sensor-hub.c 
>> b/drivers/hid/hid-sensor-hub.c index 0c93b10..22ec3c6 100644
>> --- a/drivers/hid/hid-sensor-hub.c
>> +++ b/drivers/hid/hid-sensor-hub.c
>> @@ -214,9 +214,6 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
>>  	struct sensor_hub_data *data =  hid_get_drvdata(hsdev->hdev);
>>  	int ret = 0;
>>  
>> -	if (report_id < 0)
>> -		return -EINVAL;
>> -
>>  	mutex_lock(&data->mutex);
>>  	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
>>  	if (!report || (field_index >=  report->maxfield)) { @@ -241,9 
>> +238,6 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
>>  	struct sensor_hub_data *data =  hid_get_drvdata(hsdev->hdev);
>>  	int ret = 0;
>>  
>> -	if (report_id < 0)
>> -		return -EINVAL;
>> -
>>  	mutex_lock(&data->mutex);
>>  	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
>>  	if (!report || (field_index >=  report->maxfield)) { @@ -271,9 
>> +265,6 @@ int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
>>  	struct hid_report *report;
>>  	int ret_val = 0;
>>  
>> -	if (report_id < 0)
>> -		return -EINVAL;
>> -
>>  	mutex_lock(&data->mutex);
>>  	memset(&data->pending, 0, sizeof(data->pending));
>>  	init_completion(&data->pending.ready);
>>
> 
> --
> Jiri Kosina
> SUSE Labs
> 
