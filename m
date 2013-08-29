From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/4] hid-sensor-hub: fix indentation accross the code
Date: Thu, 29 Aug 2013 17:53:08 +0300
Message-ID: <1377787988.22798.1.camel@smile>
References: <1376467631-20857-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1376467631-20857-2-git-send-email-andriy.shevchenko@linux.intel.com>
	 <52123982.5020704@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10802 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753436Ab3H2OxY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Aug 2013 10:53:24 -0400
In-Reply-To: <52123982.5020704@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>

On Mon, 2013-08-19 at 08:28 -0700, Srinivas Pandruvada wrote: 
> On 08/14/2013 01:07 AM, Andy Shevchenko wrote:
> > Patch just rearranges lines to be more compact and/or readable. Additionally it
> > converts double space to one in several places.
> >
> > There is no functional change.

Jiri, anything about this patch and the rest of the series?
It seems you applied only patch 1/4. Do you have comments?

> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >   drivers/hid/hid-sensor-hub.c | 31 +++++++++++++++----------------
> >   1 file changed, 15 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> > index ffc80cf..d0687d0 100644
> > --- a/drivers/hid/hid-sensor-hub.c
> > +++ b/drivers/hid/hid-sensor-hub.c
> > @@ -103,8 +103,7 @@ static int sensor_hub_get_physical_device_count(
> >   
> >   	list_for_each_entry(report, &report_enum->report_list, list) {
> >   		field = report->field[0];
> > -		if (report->maxfield && field &&
> > -					field->physical)
> > +		if (report->maxfield && field && field->physical)
> >   			cnt++;
> >   	}
> >   
> > @@ -192,12 +191,12 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
> >   				u32 field_index, s32 value)
> >   {
> >   	struct hid_report *report;
> > -	struct sensor_hub_data *data =  hid_get_drvdata(hsdev->hdev);
> > +	struct sensor_hub_data *data = hid_get_drvdata(hsdev->hdev);
> >   	int ret = 0;
> >   
> >   	mutex_lock(&data->mutex);
> >   	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
> > -	if (!report || (field_index >=  report->maxfield)) {
> > +	if (!report || (field_index >= report->maxfield)) {
> >   		ret = -EINVAL;
> >   		goto done_proc;
> >   	}
> > @@ -216,12 +215,12 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
> >   				u32 field_index, s32 *value)
> >   {
> >   	struct hid_report *report;
> > -	struct sensor_hub_data *data =  hid_get_drvdata(hsdev->hdev);
> > +	struct sensor_hub_data *data = hid_get_drvdata(hsdev->hdev);
> >   	int ret = 0;
> >   
> >   	mutex_lock(&data->mutex);
> >   	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
> > -	if (!report || (field_index >=  report->maxfield)) {
> > +	if (!report || (field_index >= report->maxfield)) {
> >   		ret = -EINVAL;
> >   		goto done_proc;
> >   	}
> > @@ -241,7 +240,7 @@ int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
> >   					u32 usage_id,
> >   					u32 attr_usage_id, u32 report_id)
> >   {
> > -	struct sensor_hub_data *data =  hid_get_drvdata(hsdev->hdev);
> > +	struct sensor_hub_data *data = hid_get_drvdata(hsdev->hdev);
> >   	unsigned long flags;
> >   	struct hid_report *report;
> >   	int ret_val = 0;
> > @@ -302,7 +301,7 @@ int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
> >   
> >   	/* Initialize with defaults */
> >   	info->usage_id = usage_id;
> > -	info->attrib_id =  attr_usage_id;
> > +	info->attrib_id = attr_usage_id;
> >   	info->report_id = -1;
> >   	info->index = -1;
> >   	info->units = -1;
> > @@ -333,7 +332,7 @@ int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
> >   					if (field->usage[j].hid ==
> >   					attr_usage_id &&
> >   					field->usage[j].collection_index ==
> > -					collection_index)  {
> > +					collection_index) {
> >   						sensor_hub_fill_attr_info(info,
> >   							i, report->id,
> >   							field->unit,
> > @@ -357,7 +356,7 @@ EXPORT_SYMBOL_GPL(sensor_hub_input_get_attribute_info);
> >   #ifdef CONFIG_PM
> >   static int sensor_hub_suspend(struct hid_device *hdev, pm_message_t message)
> >   {
> > -	struct sensor_hub_data *pdata =  hid_get_drvdata(hdev);
> > +	struct sensor_hub_data *pdata = hid_get_drvdata(hdev);
> >   	struct hid_sensor_hub_callbacks_list *callback;
> >   
> >   	hid_dbg(hdev, " sensor_hub_suspend\n");
> > @@ -374,7 +373,7 @@ static int sensor_hub_suspend(struct hid_device *hdev, pm_message_t message)
> >   
> >   static int sensor_hub_resume(struct hid_device *hdev)
> >   {
> > -	struct sensor_hub_data *pdata =  hid_get_drvdata(hdev);
> > +	struct sensor_hub_data *pdata = hid_get_drvdata(hdev);
> >   	struct hid_sensor_hub_callbacks_list *callback;
> >   
> >   	hid_dbg(hdev, " sensor_hub_resume\n");
> > @@ -394,6 +393,7 @@ static int sensor_hub_reset_resume(struct hid_device *hdev)
> >   	return 0;
> >   }
> >   #endif
> > +
> >   /*
> >    * Handle raw report as sent by device
> >    */
> > @@ -421,7 +421,6 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
> >   	spin_lock_irqsave(&pdata->lock, flags);
> >   
> >   	for (i = 0; i < report->maxfield; ++i) {
> > -
> >   		hid_dbg(hdev, "%d collection_index:%x hid:%x sz:%x\n",
> >   				i, report->field[i]->usage->collection_index,
> >   				report->field[i]->usage->hid,
> > @@ -434,7 +433,7 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
> >   			pdata->pending.raw_data = kmalloc(sz, GFP_ATOMIC);
> >   			if (pdata->pending.raw_data) {
> >   				memcpy(pdata->pending.raw_data, ptr, sz);
> > -				pdata->pending.raw_size  = sz;
> > +				pdata->pending.raw_size = sz;
> >   			} else
> >   				pdata->pending.raw_size = 0;
> >   			complete(&pdata->pending.ready);
> > @@ -539,7 +538,7 @@ static int sensor_hub_probe(struct hid_device *hdev,
> >   					field->physical) {
> >   			name = kasprintf(GFP_KERNEL, "HID-SENSOR-%x",
> >   						field->physical);
> > -			if (name  == NULL) {
> > +			if (name == NULL) {
> >   				hid_err(hdev, "Failed MFD device name\n");
> >   					ret = -ENOMEM;
> >   					goto err_free_names;
> > @@ -617,8 +616,8 @@ static struct hid_driver sensor_hub_driver = {
> >   	.raw_event = sensor_hub_raw_event,
> >   #ifdef CONFIG_PM
> >   	.suspend = sensor_hub_suspend,
> > -	.resume =  sensor_hub_resume,
> > -	.reset_resume =  sensor_hub_reset_resume,
> > +	.resume = sensor_hub_resume,
> > +	.reset_resume = sensor_hub_reset_resume,
> >   #endif
> >   };
> >   module_hid_driver(sensor_hub_driver);
> Agreed.
> 
> Thanks,
> Srinivas

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
